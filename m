From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problems with binary patches (pull) and spaces in filenames (gitk)
Date: Wed, 09 Nov 2005 14:36:09 -0800
Message-ID: <7v8xvxbg9y.fsf@assigned-by-dhcp.cox.net>
References: <20051109213730.GA23052@ebar091.ebar.dtu.dk>
	<7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZyYu-0001kE-Tz
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 23:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbVKIWgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbVKIWgN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 17:36:13 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25829 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751054AbVKIWgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 17:36:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109223519.HIOF776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 17:35:19 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 Nov 2005 14:09:41 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11427>

Junio C Hamano <junkio@cox.net> writes:

> Hmm.  Perhaps a suboption to git-apply --stat to tell it not to
> barf is helpful?  In the meantime, could you pull with -n flag?

Would this help?

-- >8 -- cut here -- >8 --
[PATCH] git-apply: do not barf on binary diff when not applying.

Instead, just mark the patch as binary, and keep going when
doing --stat and --summary.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/apply.c b/apply.c
index 3e53b34..6d756f7 100644
--- a/apply.c
+++ b/apply.c
@@ -53,7 +53,7 @@ struct fragment {
 struct patch {
 	char *new_name, *old_name, *def_name;
 	unsigned int old_mode, new_mode;
-	int is_rename, is_copy, is_new, is_delete;
+	int is_rename, is_copy, is_new, is_delete, is_binary;
 	int lines_added, lines_deleted;
 	int score;
 	struct fragment *fragments;
@@ -890,8 +890,18 @@ static int parse_chunk(char *buffer, uns
 
 	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
 
-	if (!patchsize && !metadata_changes(patch))
-		die("patch with only garbage at line %d", linenr);
+	if (!patchsize && !metadata_changes(patch)) {
+		static const char binhdr[] = "Binary files ";
+
+		if (sizeof(binhdr) - 1 < size - offset - hdrsize &&
+		    !memcmp(binhdr, buffer + hdrsize, sizeof(binhdr)-1))
+			patch->is_binary = 1;
+
+		if (patch->is_binary && !apply)
+			;
+		else
+			die("patch with only garbage at line %d", linenr);
+	}
 
 	return offset + hdrsize + patchsize;
 }
@@ -949,9 +959,12 @@ static void show_stats(struct patch *pat
 		add = (add * max + max_change / 2) / max_change;
 		del = total - add;
 	}
-	printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
-		len, name, patch->lines_added + patch->lines_deleted,
-		add, pluses, del, minuses);
+	if (patch->is_binary)
+		printf(" %s%-*s |  Bin\n", prefix, len, name);
+	else
+		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
+		       len, name, patch->lines_added + patch->lines_deleted,
+		       add, pluses, del, minuses);
 	if (qname)
 		free(qname);
 }
