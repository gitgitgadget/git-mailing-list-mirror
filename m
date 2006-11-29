X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug in "git blame -C"
Date: Tue, 28 Nov 2006 21:48:00 -0800
Message-ID: <7vu00iu7lb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611282013430.3395@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 05:48:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32616>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpIIk-0002zE-5j for gcvg-git@gmane.org; Wed, 29 Nov
 2006 06:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934034AbWK2FsF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 00:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934176AbWK2FsE
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 00:48:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28593 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S934034AbWK2FsC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 00:48:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129054802.HDQX20330.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 00:48:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sVnU1V02Y1kojtg0000000; Wed, 29 Nov 2006
 00:47:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So this shows two problems:
>
>  - the line numbers that "git blame -C" shows are the current line numbers 
>    only, not the line numbers it came from in the version it shows. That 
>    makes them useless. We _know_ the current linenumbers. What we want to 
>    know is what they were in the commit that they came from.
>
>    So right now, the line number information that "git blame -C" shows is 
>    just the same thing we could have gotten by doing a "cat -n file".

Please use -f -n, which gives the origin filename and origin linenumber.

f9c03ba7 sha1_file.c   22 (Junio  2006-11-28 21:10:50 -0800   22) #endif
f9c03ba7 sha1_file.c   23 (Junio  2006-11-28 21:10:50 -0800   23) #endif
f9c03ba7 sha1_file.c   24 (Junio  2006-11-28 21:10:50 -0800   24) 
f9c03ba7 git.c         21 (Junio  2006-11-28 21:10:50 -0800   25) static v..
f9c03ba7 git.c         22 (Junio  2006-11-28 21:10:50 -0800   26) {
f9c03ba7 git.c         23 (Junio  2006-11-28 21:10:50 -0800   27) 	co..
f9c03ba7 git.c         24 (Junio  2006-11-28 21:10:50 -0800   28) 	ch..
f9c03ba7 git.c         25 (Junio  2006-11-28 21:10:50 -0800   29) 	in..

>  - "git blame -C" has apparently decided that it doesn't need to show 
>    filenames that things came from, because they all came from the same 
>    commit, but that's not a logical thing to compare. "same commit" does 
>    not mean "same filename", so not showing the filename makes no sense.

This is definitely a bug, and I am sorry to have sent you to a
wild goose chase (a root commit corner case that did not exist).

I am not sure how often you would want the origin line-number,
and I think it is debatable if we should turn show-number on in
this case, but we should definitely turn show-name on when two
paths are involved; that's what -C is about.

For that matter, I do not think the line number in the final
revision is interesting at all; they are there for hysterical
raisins only (I know pickaxe imitated blame which inherited it
from annotate).

Something like this?

diff --git a/builtin-blame.c b/builtin-blame.c
index 066dee7..eee0b90 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1344,29 +1344,30 @@ static void output(struct scoreboard *sb, int option)
 {
 	struct blame_entry *ent;
 
-	if (option & OUTPUT_PORCELAIN) {
-		for (ent = sb->ent; ent; ent = ent->next) {
-			struct blame_entry *oth;
-			struct origin *suspect = ent->suspect;
-			struct commit *commit = suspect->commit;
-			if (commit->object.flags & MORE_THAN_ONE_PATH)
+	for (ent = sb->ent; ent; ent = ent->next) {
+		struct blame_entry *oth;
+		struct origin *suspect = ent->suspect;
+		struct commit *commit = suspect->commit;
+
+		if (strcmp(suspect->path, sb->path) &&
+		    !(option & OUTPUT_PORCELAIN))
+			option |= OUTPUT_SHOW_NAME | OUTPUT_SHOW_NUMBER;
+		if (commit->object.flags & MORE_THAN_ONE_PATH)
+			continue;
+		for (oth = ent->next; oth; oth = oth->next) {
+			if ((oth->suspect->commit != commit) ||
+			    !strcmp(oth->suspect->path, suspect->path))
 				continue;
-			for (oth = ent->next; oth; oth = oth->next) {
-				if ((oth->suspect->commit != commit) ||
-				    !strcmp(oth->suspect->path, suspect->path))
-					continue;
-				commit->object.flags |= MORE_THAN_ONE_PATH;
-				break;
-			}
+			commit->object.flags |= MORE_THAN_ONE_PATH;
+			break;
 		}
 	}
 
 	for (ent = sb->ent; ent; ent = ent->next) {
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent);
-		else {
+		else
 			emit_other(sb, ent, option);
-		}
 	}
 }
 
@@ -1438,8 +1439,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			if (strcmp(suspect->path, sb->path))
-				*option |= OUTPUT_SHOW_NAME;
 			num = strlen(suspect->path);
 			if (longest_file < num)
 				longest_file = num;
