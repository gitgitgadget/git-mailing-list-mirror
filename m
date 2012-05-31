From: Travis P <git@castle.fastmail.fm>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Thu, 31 May 2012 08:39:42 -0500
Message-ID: <1338471582.12573.140661083191693.32060E78@webmail.messagingengine.com>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
 <20120531012908.GD5488@sigill.intra.peff.net>
 <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 15:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5bQ-0007Pp-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099Ab2EaNjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 09:39:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50372 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757840Ab2EaNjn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:39:43 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8D1462110D;
	Thu, 31 May 2012 09:39:42 -0400 (EDT)
Received: from web5.nyi.mail.srv.osa ([10.202.2.215])
  by compute2.internal (MEProxy); Thu, 31 May 2012 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=smtpout; bh=5dtpwm1vcwA7VvlEQWwut7evrFM=; b=R1T
	znQpqGe3t4mI2EDflU5b8JsaJvh7ggxYvmZiDsAV/KrpF4SeqnKy0yNhQym1Edgz
	qiQRb1jlwADJ3TEYKDisCF/+y9is47Kk1KpTqb/J2iB0tztT9VGTC0H3tlNo6x4h
	x4KVEntHmpnf9V2gSjOlb5GUdyNJ6NYnLkNt3p1w=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 6B76A4C0F46; Thu, 31 May 2012 09:39:42 -0400 (EDT)
X-Sasl-Enc: Cuaz9ooJ/qUMW85XJS7cFWStwKJsfLgKWDeGxGKlxeAV 1338471582
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198897>


On Wed, May 30, 2012, at 11:22 PM, Junio C Hamano wrote:
> 
> A more likely failure case is when fd 0, 1 and 2 are _closed_.
> 
> I vaguely recall we once saw a failure report for that particular
> case, and then audited the code several years ago, but I do not
> offhand know if we have regressed over time.

Thanks all for your suggestions about where to look.  I've been doing
some more experiments, and I see that Junio's comment is very relevant.

Here's what I learned this morning: it appears to work when I don't
close STDIN.

    #close $_ for *STDIN, *STDOUT, *STDERR; # What I was doing. Fails.
    close $_ for *STDOUT, *STDERR;  # Tried this, it works.
    *STDOUT = $log_fh;
    *STDERR = $log_fh;

Jeff King wrote:
> Could it be not related to a terminal at all, but that
> there is a problem writing to the original stdout?

Writing to stdout, stderr are both fine.  I've been doing
  print STDOUT "Stdout test.\n";
  print STDERR "Stderr test.\n";
right before the git commands to ensure that STDOUT, STDERR are hooked
up fine to the log file.

But, you gave me a hint that led to an error message.

In a test rig where I've been looking at this just now, I was using
backticks and losing
a message to stderr:
 'cd /local/test_web; git pull --ff-only | cat'   rc=0 out={{}}
 'cd /local/test_web; git pull --ff-only 2>&1 | cat'   rc=0 out={{fatal:
 The remote end hung up unexpectedly
 
Note however:  despite the "fatal", I am seeing rc=0 and I was observing
my working
copy update as expected, so I wasn't looking for error output.

> 1. We check isatty(2) to enable progress reporting by default. You can
> use --no-progress to disable this.

I don't see "--no-progress" making any difference.

>  2. We check isatty(1) for starting a pager, auto-selecting color, and
>    in recent versions of git, for column support. But none of those
>    things should be in use by git-pull anyway.

Ahh, this could be it:  when the pull does receive an output and I'm
running
the command in the shell, I get output with a "+-" where the plus is
green
and the minus red.  So, I think that git may be trying to check whether
color
 (and columns?) is supported to output.  However, it appears that this
 check
is sensitive to stdin being connected (based on test mentioned earlier
here),
which is surprising.

Is the code that calls isatty, calling it on all 3 descriptors, even
when
STDIN is not relevant?

>  3. Merge was changed recently to open an editor when we have a
>     terminal. That can be changed by setting GIT_MERGE_AUTOEDIT=no in
>     the environment. However, since you pass --ff-only, we shouldn't be
>     running merge at all.

Yes, I tried the env switch just to be sure, and this doesn't appear
relevant.

-Travis
