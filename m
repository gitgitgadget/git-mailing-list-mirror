From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't fflush(stdout) when it's not helpful
Date: Fri, 29 Jun 2007 21:24:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706292114350.8675@woody.linux-foundation.org>
References: <20070626171127.GA28810@thunk.org>
 <alpine.LFD.0.98.0706261024210.8675@woody.linux-foundation.org>
 <20070628190406.GC29279@thunk.org> <20070628213451.GB22455@coredump.intra.peff.net>
 <20070628235319.GD29279@thunk.org> <20070629010507.GL12721@planck.djpig.de>
 <20070629034838.GF29279@thunk.org> <20070629063819.GA23138@coredump.intra.peff.net>
 <7vmyyjgrxk.fsf@assigned-by-dhcp.pobox.com>
 <alpine.LFD.0.98.0706290851480.8675@woody.linux-foundation.org>
 <20070629174046.GC16268@thunk.org> <alpine.LFD.0.98.0706291641590.8675@woody.linux-foundation.org>
 <7vlke2dw6w.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 06:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4UWV-000834-JB
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 06:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbXF3EZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 00:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXF3EZP
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 00:25:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51006 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714AbXF3EZN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2007 00:25:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5U4OlOn021849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Jun 2007 21:24:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5U4Of0L010638;
	Fri, 29 Jun 2007 21:24:41 -0700
In-Reply-To: <7vlke2dw6w.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-4.634 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51191>



On Fri, 29 Jun 2007, Junio C Hamano wrote:
> 
> Do you mean this part?
> 
> +	/* Somebody closed stdout? */
> +	if (fstat(fileno(stdout), &st))
> +		return 0;
> +	/* Ignore write errors for pipes and sockets.. */
> +	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
> +		return 0;
> +
> +	/* Check for ENOSPC and EIO errors.. */
> +	if (ferror(stdout))
> +		die("write failure on standard output");
> +	if (fflush(stdout) || fclose(stdout))
> +		die("write failure on standard output: %s", strerror(errno));
> +
> +	return 0;
> +}
> 
> I was planning to push this out to 'master' this weekend.

I think that code is fine, but switching the order around could probably 
make it less likely that stdio loses the errno for us. 

So doing the last part in a different order, and making it say

	/* Check for ENOSPC and EIO errors.. */
	if (fflush(stdout))
		die("write failure on standard output: %s", strerror(errno));
	if (ferror(stdout))
		die("unknown write failure on standard output");
	if (fclose(stdout))
		die("close failed on standard output: %s", strerror(errno));
	return 0;

may recover at least non-transient errors.

It's still not perfect. As I've been harping on, stdio simply isn't very 
good for error reporting. For example, if an IO error happened, you'd want 
to see EIO, wouldn't you? And yes, that's what the kernel would return. 
However, with buffered stdio (and flushing outside of our control), what 
would likely happen is that some intermediate error return _does_ return 
EIO, but then the kernel might decide to re-mount the filesystem read-only 
due to the error, and the actual *report* for us might be

	"write failure on standard output: read-only filesystem"

which lost the EIO. 

But even worse, if the output happened to be buffer-aligned, stdio will 
have thrown the error out entirely, and the "fflush()" will return 0, and 
then we end up with that "unknown write failure" after all.

Or we might have had a ENOSPC at some point, but removed a temp-file, and 
the final fflush() doesn't error out at all, so now the incomplete write 
got done (with one or more buffer chunks missing), and we get "unknown 
write failure" again, because we again lost the ENOSPC.

So you basically cannot get "perfect" with stdio. It's impossible. But the 
above re-ordering will at least get you _closer_, and *most* of the time 
you'll get exactly the error you'd expect.

(I'm not a huge fan of "most of the time it works", but that's stdio for 
you).

		Linus
