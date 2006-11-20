X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 03:28:54 -0800
Message-ID: <7vfyce2w7d.fsf@assigned-by-dhcp.cox.net>
References: <200611201157.23680.litvinov2004@gmail.com>
	<200611200951.05529.andyparkins@gmail.com>
	<7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
	<200611201022.10656.andyparkins@gmail.com>
	<7virha4cnm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 11:29:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31906>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm7Kd-0003Rc-Gw for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756727AbWKTL24 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756806AbWKTL24
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:28:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5281 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1756727AbWKTL2z
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:28:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120112854.PROT4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 06:28:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ozUS1V0011kojtg0000000; Mon, 20 Nov 2006
 06:28:26 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> There are a few things we need to be careful about rename/copy.
>...
>  - Copies are only picked up from files that were changed in the
>    same change (i.e. splitting major part of original file and
>    moving it to somewhere else, while leaving a skelton in the
>    original file).  "harder" is needed if the copy original was
>    untouched, as you found out.
>
> The last one is a compromise between performance and thoroughness,
> and the "harder" is one knob to tweak its behaviour.

If people are well disciplined, code refactoring (which can
trigger rename/copy detection) tend to affect both source and
destination files at the same time, so many times -C finds what
you want without --find-copies-harder.

But sometimes the source stays the same and you literally have
duplicate (with possibly some modifications) in the new
destination.  Finding exact copy is cheap (diffcore-rename has a
double loop that first finds exact copies without similarity
estimation which is very cheap, and then goes on to open blobs
and does its similarity magic for destinations whose origin is
still unknown) but copy/rename with edit is not, and "harder"
variant feeds _everything_ from the older tree as a candidate of
copy source, so it is very expensive for huge projects.

> In the kernel archive, 
>
> 	git show -C ad2f931d
>
> tells us that:
>
>  - drivers/i2c/chips/Kconfig lost major part of it and only
>    skeletal part of the original remains in it;
>
>  - major part of it went to drivers/hwmon/Kconfig;
>
> The story is similar to the Makefile next door.

Having said all that, I think the rename/copy as a wholesale
operation on one file is an uninteresting special case.  The
generic case that happens far more often in practice is the
lines moving around across files, and the new "git blame" gives
you better picture to answer "where the heck did this come from"
question.

For example,

	git blame -f -n -C 'ad2f931d^!' -- drivers/hwmon/Kconfig

on the same commit would show that many of its lines came from
i2c/chips/Kconfig but not all of them.

There are quite a few other things I should probably mention for
new people on the list about rename/copy/break heuristics but it
is getting late so I'd defer it to some other time.
