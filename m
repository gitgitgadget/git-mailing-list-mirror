From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Mon, 28 May 2007 09:32:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
 <87sl9hw0o0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 28 18:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsi9o-0006gH-Ku
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbXE1Qcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758651AbXE1Qcu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:32:50 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:42814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757468AbXE1Qct (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 12:32:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4SGW73b006527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 09:32:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4SGW6uG016844;
	Mon, 28 May 2007 09:32:06 -0700
In-Reply-To: <87sl9hw0o0.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.53 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48623>



On Mon, 28 May 2007, Jim Meyering wrote:
> 
> I suspect that git's special treatment of EPIPE was a shoot-the-messenger
> reaction to the work-around (trap '' PIPE) required to avoid diagnostics
> from porcelain being interpreted by what would now be a 2-year-old
> version of bash.

No. You don't seem to realize. That was the *default* behaviour of bash.

For all I know, it might _still_ be the default behaviour.

The only reason not everybody ever even noticed, was that most 
distributions were clueful enough to have figured out that it was broken, 
and configured bash separately. But "most" does not mean "all", and I had 
this problem on powerpc, and others had it on Debian, I htink  (might have 
been slackware). I think RH and SuSE had both fixed it explicitly.

> diff --git a/write_or_die.c b/write_or_die.c
> index 5c4bc85..fadfcaa 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -41,8 +41,6 @@ int write_in_full(int fd, const void *buf, size_t count)
>  void write_or_die(int fd, const void *buf, size_t count)
>  {
>  	if (write_in_full(fd, buf, count) < 0) {
> -		if (errno == EPIPE)
> -			exit(0);
>  		die("write error (%s)", strerror(errno));

Nack. Nack. NACK.

I think this patch is fundamentally WRONG. This fragment is just a prime 
example of why the whole patch is crap. The old code was correct, and you 
broke it.

		Linus
