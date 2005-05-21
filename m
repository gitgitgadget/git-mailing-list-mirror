From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Fri, 20 May 2005 20:47:20 -0700
Message-ID: <7vd5rlp7ef.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
	<Pine.LNX.4.58.0505202019330.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 05:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZKx3-0005bK-Fg
	for gcvg-git@gmane.org; Sat, 21 May 2005 05:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVEUDrs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 23:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEUDrr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 23:47:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35308 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261652AbVEUDrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 23:47:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521034722.NMGB20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 23:47:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505202019330.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 20 May 2005 20:20:49 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Diff heler _should_ not get confused, but maybe it currently
does.  If that is the case, I would consider that a bug (my
bad).

... goes back to the Linus tip for a while and comes back ...

Yup.  It says a change line containing tree is not something it
recognizes.  Sorry, there is a bug there (and another bug that
partially hides that bug).

I'm doing major rewrite of the diff-core right now but even
after that, diff helper _should_ just ignore trees.

In the meantime, this patch should fix it.  And this should be
the right fix even after the "major rewrite" I am doing now.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - linus: [PATCH] delta creation
# + (working tree)
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -20,7 +20,8 @@ static int parse_oneside_change(const ch
 		cp++;
 	}
 	*mode = m;
-	if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
+	if (strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6) &&
+	    strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
 		return -1;
 	cp += 6;
 	if (get_sha1_hex(cp, sha1))
@@ -44,11 +45,13 @@ static int parse_diff_raw_output(const c
 		diff_unmerge(cp + 1);
 		break;
 	case '+':
-		parse_oneside_change(cp, &new_mode, new_sha1, path);
+		if (parse_oneside_change(cp, &new_mode, new_sha1, path))
+			return -1;
 		diff_addremove('+', new_mode, new_sha1, path, NULL);
 		break;
 	case '-':
-		parse_oneside_change(cp, &old_mode, old_sha1, path);
+		if (parse_oneside_change(cp, &old_mode, old_sha1, path))
+			return -1;
 		diff_addremove('-', old_mode, old_sha1, path, NULL);
 		break;
 	case '*':
@@ -64,7 +67,8 @@ static int parse_diff_raw_output(const c
 			new_mode = (new_mode << 3) | (ch - '0');
 			cp++;
 		}
-		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6))
+		if (strncmp(cp, "\tblob\t", 6) && strncmp(cp, " blob ", 6) &&
+		    (strncmp(cp, "\ttree\t", 6) && strncmp(cp, " tree ", 6)))
 			return -1;
 		cp += 6;
 		if (get_sha1_hex(cp, old_sha1))



