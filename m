X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-apply?
Date: Sat, 04 Nov 2006 02:15:55 -0800
Message-ID: <7vu01f34bo.fsf@assigned-by-dhcp.cox.net>
References: <20061104072349.GA19667@cubit>
	<7v8xir4k3w.fsf@assigned-by-dhcp.cox.net>
	<7v4ptf4jmj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 10:16:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v4ptf4jmj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 04 Nov 2006 02:00:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30915>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgIZD-00054k-IW for gcvg-git@gmane.org; Sat, 04 Nov
 2006 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965213AbWKDKP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 05:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWKDKP4
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 05:15:56 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1476 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S965213AbWKDKP4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 05:15:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104101555.EEJR22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sat, 4
 Nov 2006 05:15:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iaFZ1V01g1kojtg0000000 Sat, 04 Nov 2006
 05:15:34 -0500
To: Kevin Shanahan <kmshanah@disenchant.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> *BLUSH*  A prime example of "you should not speak before
> thinking".
>
> Please forget everything I said.  The patch parsing is just fine
> with or without "/dev/null".  This must be a recent breakage
> around write_out_one_result().  Will take a look.


Actually it was a small problem in the patch parsing code.  Can
you give this a try?

---
diff --git a/builtin-apply.c b/builtin-apply.c
index 11397f5..db7cdce 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1043,10 +1043,14 @@ static int parse_single_patch(char *line
 		 * then not having oldlines means the patch is creation,
 		 * and not having newlines means the patch is deletion.
 		 */
-		if (patch->is_new < 0 && !oldlines)
+		if (patch->is_new < 0 && !oldlines) {
 			patch->is_new = 1;
-		if (patch->is_delete < 0 && !newlines)
+			patch->old_name = NULL;
+		}
+		if (patch->is_delete < 0 && !newlines) {
 			patch->is_delete = 1;
+			patch->new_name = NULL;
+		}
 	}
 
 	if (0 < patch->is_new && oldlines)
