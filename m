X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 02:35:09 -0800
Message-ID: <7vd57b3jc2.fsf@assigned-by-dhcp.cox.net>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	<7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
	<20061125064901.GB4528@spearce.org> <ek9078$m2j$1@sea.gmane.org>
	<20061125085731.GG4528@spearce.org>
	<8c5c35580611250116h466e3649p2630ee6641b6e6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 10:35:30 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8c5c35580611250116h466e3649p2630ee6641b6e6f4@mail.gmail.com>
	(Lars Hjemli's message of "Sat, 25 Nov 2006 10:16:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32278>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnusV-0006iE-CQ for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966403AbWKYKfN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966417AbWKYKfN
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:35:13 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25532 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S966403AbWKYKfL
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:35:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125103510.ZZYC18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 05:35:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qybJ1V00K1kojtg0000000; Sat, 25 Nov 2006
 05:35:19 -0500
To: "Lars Hjemli" <lh@elementstorage.no>
Sender: git-owner@vger.kernel.org

"Lars Hjemli" <lh@elementstorage.no> writes:

> Is it ok to put
>
> static int log_ref_write(struct ref_lock *lock,
> 	const unsigned char *sha1, const char *msg)
>
> into refs.h?

I think a cleaner implementation that does not have such a
layering violation would involve defining rename_refs()
interface in refs.c, next to the delete_ref() that exists there.

The division of labor would be for builtin-branch.c to make sure
both oldname and newname are branch names, and rename_refs() to
rename the reflog (if exists) and the ref at the same time.  To
deal with D/F conflicts sanely, I suspect it would involve a
call to rename(2) to move the reflog to a temporary location,
perhaps $GIT_DIR/.tmp-renamed-log, deletion of the old ref by
calling delete_ref(), and then another rename(2) to move that
temporary one to its final location, followed by the usual "ref
creation dance" of calling lock_any_ref_for_update() and
write_ref_sha1().

Side note:

If we do not mind losing the reflog of oldname, then "delete and
then create" would be sufficient, but that is not the case.

Unlike "git does not track individual files so we do not record
renames" mantra, branches, and more in general, refs, have
meaningful identity (at least locally), and unlike the file
contents, the "contents" of a ref does not migrate _partially_
from ref to ref.  It would make sense to keep track of renames
for them.
