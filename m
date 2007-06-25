From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import.c: detect fclose- and fflush-induced write failure
Date: Mon, 25 Jun 2007 10:12:06 -0400
Message-ID: <20070625141206.GC32223@spearce.org>
References: <87abuoxtio.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pIb-0004hb-A8
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbXFYOML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXFYOML
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:12:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37499 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbXFYOMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:12:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I2pIR-0000aL-SP; Mon, 25 Jun 2007 10:12:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A89CA20FBAE; Mon, 25 Jun 2007 10:12:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87abuoxtio.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50899>

Jim Meyering <jim@meyering.net> wrote:
> There are potentially ignored write errors in fast-import.c.
...
> diff --git a/fast-import.c b/fast-import.c
> @@ -793,7 +793,9 @@ static void end_packfile(void)
>  					fprintf(pack_edges, " %s", sha1_to_hex(t->sha1));
>  			}
>  			fputc('\n', pack_edges);
> -			fflush(pack_edges);
> +			if (fflush(pack_edges))
> +				die("failed to write pack-edges file: %s",
> +				    strerror(errno));

Hmm.  That's a valid bug, if the disk is full we might not
be able to flush.  But that linewrapping looks pretty ugly.
 
> +static int
> +close_stream(FILE *stream)
> +{
> +	int prev_fail = (ferror(stream) != 0);
> +	int fclose_fail = (fclose(stream) != 0);
> +
> +	if (prev_fail || fclose_fail) {
> +		if (! fclose_fail)
> +			errno = 0;
> +		return EOF;
> +	}
> +	return 0;
> +}
> +
> +static void
> +close_wstream_or_die(FILE *stream, const char *file_name)
> +{
> +	if (close_stream(stream)) {
> +		if (errno == 0)
> +			die ("%s: write failed: %s", file_name, strerror(errno));

Don't you mean "if (errno != 0)" here?  Right now you are printing
"No Error" when there is no error and tossing the errno when there
is an error.

> @@ -1369,7 +1396,18 @@ static void dump_marks(void)
>  	}
> 
>  	dump_marks_helper(f, 0, marks);
> -	fclose(f);
> +	if (close_stream(f) != 0) {

What about just "if (close_stream(f)) {" ?

> +		int close_errno = errno;
> +		rollback_lock_file(&mark_lock);
> +		failure |=
> +		  (close_errno == 0
> +		   ? error("Failed to write temporary marks file %s.lock",
> +			   mark_file)
> +		   : error("Failed to write temporary marks file %s.lock: %s",
> +			   mark_file, strerror(close_errno)));

Ugh.  The ternary operator has many uses, but using it to decide
which error() function you are going to call and have both cases
bit-wise or a -1 into failure is not one of them.  This would be
a lot cleaner if the ternary operator wasn't abused here.

And looking at this code I'm now wondering about the code above
for close_stream().  If it returns EOF but doesn't supply a valid
errno its because you tossed the errno that was available when you
did the fclose().  So I'd actually say the close_stream() is bad;
if we have an error and we're going to explain there was an error
we should explain what the error was.

> @@ -2015,6 +2053,7 @@ static const char fast_import_usage[] =
>  int main(int argc, const char **argv)
>  {
>  	int i, show_stats = 1;
> +	const char *pack_edges_file = NULL;

This is only ever used in the "--export-pack-edges=" arm of the
option parser.  It should be local to that block, not to the
entire function.

> @@ -2052,10 +2091,13 @@ int main(int argc, const char **argv)
>  			mark_file = a + 15;
>  		else if (!prefixcmp(a, "--export-pack-edges=")) {
>  			if (pack_edges)
> -				fclose(pack_edges);
> -			pack_edges = fopen(a + 20, "a");
> +				close_wstream_or_die(pack_edges,
> +						     pack_edges_file);

Oh, I see, its actually being reused to issue an error that we
couldn't close the prior file.  The more that I look at this we
probably should just die() if we get a second arg with this option.
What does it mean to give --export-pack-edges twice?  Apparently
under the current code it means use the last one, but I'm not sure
that's sane.

-- 
Shawn.
