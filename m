X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug in "git blame -C"
Date: Tue, 28 Nov 2006 22:21:05 -0800
Message-ID: <7vmz6au626.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611282013430.3395@woody.osdl.org>
	<7vu00iu7lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 06:21:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vu00iu7lb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 28 Nov 2006 21:48:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32617>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpIot-0001es-VK for gcvg-git@gmane.org; Wed, 29 Nov
 2006 07:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934422AbWK2GVI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 01:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934488AbWK2GVI
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 01:21:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41953 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S934422AbWK2GVH
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 01:21:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129062106.QUWT9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 01:21:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sWLa1V0041kojtg0000000; Wed, 29 Nov 2006
 01:20:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>>  - "git blame -C" has apparently decided that it doesn't need to show 
>>    filenames that things came from, because they all came from the same 
>>    commit, but that's not a logical thing to compare. "same commit" does 
>>    not mean "same filename", so not showing the filename makes no sense.
>
> This is definitely a bug,

A replacement patch that should be much cleaner and to the
point.

---

diff --git a/builtin-blame.c b/builtin-blame.c
index 066dee7..4090a80 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1435,11 +1435,12 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		struct commit_info ci;
 		int num;
 
+		if (strcmp(suspect->path, sb->path))
+			*option |= OUTPUT_SHOW_NAME | OUTPUT_SHOW_NUMBER;
+
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			if (strcmp(suspect->path, sb->path))
-				*option |= OUTPUT_SHOW_NAME;
 			num = strlen(suspect->path);
 			if (longest_file < num)
 				longest_file = num;
