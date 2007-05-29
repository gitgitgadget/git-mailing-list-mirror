From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Mon, 28 May 2007 20:47:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705282031280.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
 <87sl9hw0o0.fsf@rho.meyering.net>
 <7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 29 05:47:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HssgZ-0000Pg-7J
	for gcvg-git@gmane.org; Tue, 29 May 2007 05:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbXE2Drk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 23:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbXE2Drk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 23:47:40 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:56608 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753306AbXE2Drj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 23:47:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4T3l4FU028045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 20:47:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4T3l1FX026366;
	Mon, 28 May 2007 20:47:01 -0700
In-Reply-To: <7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-4.586 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48665>



On Mon, 28 May 2007, Junio C Hamano wrote:
> 
> I think something like this instead might be more palatable.
> 
> diff --git a/write_or_die.c b/write_or_die.c
> index 5c4bc85..fadfcaa 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -41,8 +41,8 @@ int write_in_full(int fd, const void *buf, size_t count)
>  void write_or_die(int fd, const void *buf, size_t count)
>  {
>  	if (write_in_full(fd, buf, count) < 0) {
> -		if (errno == EPIPE)
> -			exit(0);
> - 		die("write error (%s)", strerror(errno));
> +		if (errno != EPIPE)
> +			die("write error (%s)", strerror(errno));
> +		exit(1);
>  	}
>  }

It's certainly less annoying, but I don't actually think it's *correct*.

I think the current behaviour is simply _superior_.

Think about what happens whenever somebody does

	git cmd | head

and then you want to see whether the end result was successful or not.

What would the error code from the "git cmd" thing mean?

I claim that exiting with SUCCESS is actually the rigt thing to do for the 
git command in question. It did what it was asked for.

And more importantly, considering that a pipe is of indeterminate size, 
what happens if it actuall yonly had 15 lines to be printed out. Guess 
what? If it writes them fast enough, they'll go into the pipe, and "head" 
will exit only after the write, and we'll never even *know* that the last 
five lines were ignored, ie there won't be a EPIPE at all.

In other words, even Jim's example of

	git log | sync

will actually *succeed* even with Jim's patch, if the output fit in the 
kernel pipe buffer, and the "git log" command ran quickly enough that 
"sync" took longer (which is not at all unlikely).

So EPIPE really _is_ special: because when you write to a pipe, there's no 
guarantee that you'll get it at all, so whenever you get an EPIPE you 
should ask yourself:

 - what would I have done if the data had fit in the 64kB kernel buffer?

 - should I really return a different error message or complain just 
   because I just happened to notice that the reader went away _this_ 
   time, even if I might not notice it next time?

In other words, the "exit(0)" is actually _more_ consistent than 
"exit(1)", because exiting with an error message or with an error return 
is going to depend on luck and timing.

For example, I just did a

	strace git show | sync

on my kernel archive, and strace shows me that I had:

	...
	write(1, "commit c420bc9f09a0926b708c3edb2"..., 736) = 736
	exit_group(0)

the first three times I tried it, and then

	write(1, "commit c420bc9f09a0926b708c3edb2"..., 736) = -1 EPIPE (Broken pipe)
	--- SIGPIPE (Broken pipe) @ 0 (0) ---
	+++ killed by SIGPIPE +++

the fourth time.

What should we learn from this? 

 - a shell that talks about SIGPIPE is going to be universally *hated*, 
   because it's really a total crap-shoot. Even with something like 
   "sync", that doesn't read a single byte from the input, most of the 
   time I didn't actually get EPIPE/SIGPIPE at all!

 - by exactly the same token, considering "EPIPE" as anything else than a 
   "success" is always just going to lead you to random behaviour.

So what _should_ you do for EPIPE?

Here's what EPIPE _really_ means:

 - you might as well consider the write a success, but the reader isn't 
   actually interested, so rather than go on, you might as well stop 
   early.

Notice how I very carefull avoided the word "error" anywhere. Because it's 
really not an error. The reader already got everything it wanted. So EPIPE 
should generally be seen as an "early success" rather than as a "failure".

		Linus
