X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 16:04:50 -0800
Message-ID: <7v3b889ysd.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net> <ek6glc$pn$1@sea.gmane.org>
	<7vslg9axzv.fsf@assigned-by-dhcp.cox.net> <ek7v61$k89$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 00:05:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ek7v61$k89$1@sea.gmane.org> (Salikh Zakirov's message of "Sat,
	25 Nov 2006 02:28:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32248>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnl2O-00072x-6z for gcvg-git@gmane.org; Sat, 25 Nov
 2006 01:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934382AbWKYAEw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 19:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934473AbWKYAEw
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 19:04:52 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23946 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S934382AbWKYAEw
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 19:04:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125000451.WJQP9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 19:04:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qo4z1V00H1kojtg0000000; Fri, 24 Nov 2006
 19:04:59 -0500
To: Salikh Zakirov <salikh@gmail.com>
Sender: git-owner@vger.kernel.org

Salikh Zakirov <salikh@gmail.com> writes:

> I think that remote matching semantics is confusing, and the following change
> would make understanding easier.

Hmm.  I think this is somewhat wrong.

Have you tested the patch with repositories with existing refs?

You do not seem to check if that fabricated matched_dst exists
on the other side, so matched_dst lacks "where was this ref
initially" information (aka old_sha1), if I am reading your
patch correctly.  Wouldn't that mean that you would confuse the
fast-forward check logic?

One setup I have that would be broken with this change is that
the remote end has refs/heads/up/obsd and no refs/heads/obsd,
and local end has refs/heads/obsd.  This is to work on
portability fix for OpenBSD.  With the current git-push, I think

	git push $remote_openbsd_box obsd

would correctly update the remote refs/heads/up/obsd with the
local tip of the obsd branch, so that then I can ssh into the
remote and say "git merge up/obsd" to continue on that OpenBSD
machine from where I left off on the local, non-OpenBSD machine.

I am not sure if people would mind breaking existing setups like
this.

By the way, there are other glitches with the current git-push
(rather, git-send-pack) that we need to tighten.  For example:

	git push $remote HEAD~6

does not error out as it should.  'HEAD~6' is expanded to
'HEAD~6:HEAD~6'; its left hand side is valid (6 revs before the
tip is used to update the remote side) but its right hand side
is not checked for validity ("HEAD~6" is not a valid refname)
and creates .git/HEAD~6 at the remote end which is completely
bogus.
