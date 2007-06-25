From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] fast-import.c: detect fclose- and fflush-induced write failure
Date: Mon, 25 Jun 2007 16:33:47 +0200
Message-ID: <87vedcumr8.fsf@rho.meyering.net>
References: <87abuoxtio.fsf@rho.meyering.net>
	<20070625141206.GC32223@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pdX-0002L7-Mx
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbXFYOdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbXFYOdt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:33:49 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55176 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915AbXFYOdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:33:49 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 098D15A341
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:33:48 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DBC542F587; Mon, 25 Jun 2007 16:33:47 +0200 (CEST)
In-Reply-To: <20070625141206.GC32223@spearce.org> (Shawn O. Pearce's message of "Mon\, 25 Jun 2007 10\:12\:06 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50901>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jim Meyering <jim@meyering.net> wrote:
>> There are potentially ignored write errors in fast-import.c.
> ...
>> diff --git a/fast-import.c b/fast-import.c
>> @@ -793,7 +793,9 @@ static void end_packfile(void)
>>  					fprintf(pack_edges, " %s", sha1_to_hex(t->sha1));
>>  			}
>>  			fputc('\n', pack_edges);
>> -			fflush(pack_edges);
>> +			if (fflush(pack_edges))
>> +				die("failed to write pack-edges file: %s",
>> +				    strerror(errno));
>
> Hmm.  That's a valid bug, if the disk is full we might not
> be able to flush.

Or if the disk is corrupted.

> But that linewrapping looks pretty ugly.

I agree.
Blame the 8-columns per indentation-level vs 80-col-max guideline.
Besides, the existing indentation level was already pretty deep there.
From the looks of the line just a few above that one, I wonder if the
80-col-max guideline applies to git.

>> +static int
>> +close_stream(FILE *stream)
>> +{
>> +	int prev_fail = (ferror(stream) != 0);
>> +	int fclose_fail = (fclose(stream) != 0);
>> +
>> +	if (prev_fail || fclose_fail) {
>> +		if (! fclose_fail)
>> +			errno = 0;
>> +		return EOF;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void
>> +close_wstream_or_die(FILE *stream, const char *file_name)
>> +{
>> +	if (close_stream(stream)) {
>> +		if (errno == 0)
>> +			die ("%s: write failed: %s", file_name, strerror(errno));
>
> Don't you mean "if (errno != 0)" here?  Right now you are printing
> "No Error" when there is no error and tossing the errno when there
> is an error.

Rats.  You're right.
Thanks.  But as I mentioned, close_wstream_or_die is probably not
code that should remain (at least not in its current form) in any case.

>> @@ -1369,7 +1396,18 @@ static void dump_marks(void)
>>  	}
>>
>>  	dump_marks_helper(f, 0, marks);
>> -	fclose(f);
>> +	if (close_stream(f) != 0) {
>
> What about just "if (close_stream(f)) {" ?

Sure.
I use both styles, best to be consistent.

>> +		int close_errno = errno;
>> +		rollback_lock_file(&mark_lock);
>> +		failure |=
>> +		  (close_errno == 0
>> +		   ? error("Failed to write temporary marks file %s.lock",
>> +			   mark_file)
>> +		   : error("Failed to write temporary marks file %s.lock: %s",
>> +			   mark_file, strerror(close_errno)));
>
> Ugh.  The ternary operator has many uses, but using it to decide
> which error() function you are going to call and have both cases
> bit-wise or a -1 into failure is not one of them.  This would be
> a lot cleaner if the ternary operator wasn't abused here.

Of course.  That's why I proposed to use an error-reporting
function that interpolates an errno value.

> And looking at this code I'm now wondering about the code above
> for close_stream().  If it returns EOF but doesn't supply a valid
> errno its because you tossed the errno that was available when you
> did the fclose().  So I'd actually say the close_stream() is bad;

No.  You seem to be misreading close_stream.
Between the calls to ferror and fclose, errno is not useful.
It's when fclose succeeds yet ferror indicates there was
a preceding error that it sets errno = 0.
And it does that solely because there is already no
guarantee that errno is valid (read ferror's man page),
and this at least makes it so a close_stream caller
does not accidentally use an invalid errno value.

> if we have an error and we're going to explain there was an error
> we should explain what the error was.
>
>> @@ -2015,6 +2053,7 @@ static const char fast_import_usage[] =
>>  int main(int argc, const char **argv)
>>  {
>>  	int i, show_stats = 1;
>> +	const char *pack_edges_file = NULL;
>
> This is only ever used in the "--export-pack-edges=" arm of the
> option parser.  It should be local to that block, not to the
> entire function.

Um.  No.
Oh, I see you "got it" below.

>> @@ -2052,10 +2091,13 @@ int main(int argc, const char **argv)
>>  			mark_file = a + 15;
>>  		else if (!prefixcmp(a, "--export-pack-edges=")) {
>>  			if (pack_edges)
>> -				fclose(pack_edges);
>> -			pack_edges = fopen(a + 20, "a");
>> +				close_wstream_or_die(pack_edges,
>> +						     pack_edges_file);
>
> Oh, I see, its actually being reused to issue an error that we
> couldn't close the prior file.  The more that I look at this we
> probably should just die() if we get a second arg with this option.
> What does it mean to give --export-pack-edges twice?  Apparently
> under the current code it means use the last one, but I'm not sure
> that's sane.

Nor am I.

My first cut at this patch changed it so that there was only one
fclose, and everything was handled *outside* the arg-parsing loop.
But then I noticed that one could use a combination of --import-marks=...
and --export-pack-edges= (with more than one of each) to do what
I presume the original author must have thought was something useful.

IMHO, if it's appropriate to rewrite this code, that should be done
separately from detecting write failure.

Thanks for the feedback.

I'll be happy to redo the patch, once there is consensus on what
it should look like.
