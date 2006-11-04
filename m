X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-apply?
Date: Sat, 04 Nov 2006 01:49:39 -0800
Message-ID: <7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
References: <20061104072349.GA19667@cubit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 09:50:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061104072349.GA19667@cubit> (Kevin Shanahan's message of "Sat,
	4 Nov 2006 17:53:49 +1030")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30912>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgI9r-0008Ub-RS for gcvg-git@gmane.org; Sat, 04 Nov
 2006 10:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965092AbWKDJtl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWKDJtl
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 04:49:41 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43741 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S965092AbWKDJtk
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 04:49:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104094939.DUDA22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 04:49:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iZpH1V0081kojtg0000000 Sat, 04 Nov 2006
 04:49:18 -0500
To: Kevin Shanahan <kmshanah@disenchant.net>
Sender: git-owner@vger.kernel.org

Kevin Shanahan <kmshanah@disenchant.net> writes:

> #!/bin/sh
>
> mkdir a b repo
> echo foo > b/foo
> diff -urN a b > test.diff

It is *very* surprising that this issue did not come up earlier,
given that we used to use GNU diff internally to generate our
own diff.

If you cat the test.diff file, you will see "a/foo" and "b/foo",
not "/dev/null".

The problem appears that GNU diff _never_ uses "--- /dev/null"
or "+++ /dev/null" to indicate creation or deletion of the file,
but the "traditional patch parser" builtin-apply has assumed
that is what the traditional diff output from day one.  Where we
got that idea is mystery to me (this is Linus's code), but I
suspect it is what other SCMs did.

With the GNU diff output, the only way to guess it is a file
creation patch is to notice that the patch has only a single
hunk that inserts into -0,0 (this tests that the file is
originally empty), and it is followed by a HT and the UNIX epoch
(i.e. 1970-01-01 00:00:00 GMT) timestamp in localtime + offset
format (the latter is a guess to tell creation from modification
to a file that was originally empty).  This means that we do not
have a way to tell if it was a file that had UNIX epoch
timestamp that was modified or if this is a creation.

Having to parse the localtime + offset and compare it with UNIX
epoch is already crazy, but the saddest part is that this is
quite GNU diff specific right now, and I'd rather not to require
the trailing HT + timestamp (which is now being written down in
new POSIX) to the "traditional patch" input format.

Probably a reasonable compromise is to treat a non-git patch
(i.e. the ones that does not begin with "diff --git") that
touches an empty file as a file creation patch, but I need to
look at the code to see how much damage such a change needs to
cause.  If I remember collectly it wants to decide if it is a
creation patch or modification patch upfront, so it may not be 
as trivial as it sounds.  We'll see.
