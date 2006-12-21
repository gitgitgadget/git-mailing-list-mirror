From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: Thu, 21 Dec 2006 12:38:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211231000.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1703042654-1166701097=:19693"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 12:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMFl-0001LC-5z
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWLULiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbWLULiT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:38:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:50725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964942AbWLULiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:38:18 -0500
Received: (qmail invoked by alias); 21 Dec 2006 11:38:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 21 Dec 2006 12:38:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35056>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1703042654-1166701097=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 20 Dec 2006, Junio C Hamano wrote:

>    Nicolas Pitre (4):
>       make patch_delta() error cases a bit more verbose
>       make git a bit less cryptic on fetch errors
>       index-pack usage of mmap() is unacceptably slower on many OSes
>          other than Linux

I assume that this line is indented manually, but ...

>       clarify some error messages wrt unknown object types
> 
>    Robert Fitzsimons (1):
>       gitweb: Show '...' links in "summary" view only if there are more items

this is not, in spite of being longer than 76 characters (Do I remember 
correctly that this supposed to be the maximum length for lines in 
emails?).

FWIW, I hacked a half-serious patch to wrap the lines automatically:

-- snipsnap --
[FWOT] shortlog: wrap long lines

If a oneline is longer than 76 characters, wrap it and indent with
9 instead of 6 spaces.

For the heck of it, assume UTF-8, and fall back to single-byte
encodings when finding that it cannot be UTF-8. (Not that it makes
a difference if you stick to ASCII.)
---
 builtin-shortlog.c  |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t4201-shortlog.sh |   44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index edb4042..be5691e 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -276,6 +276,64 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 
 }
 
+/* Wrap the text, if necessary. */
+static void print_oneline(const char *oneline, int indent, int indent2, int len)
+{
+	int i, count, count_utf8, last_space = -1, assume_utf8 = 1;
+
+	count = count_utf8 = 0;
+
+	for (;;) {
+		unsigned char c = (unsigned char)oneline[count++];
+		if (!c || isspace(c)) {
+			int cur = indent
+				+ (assume_utf8 ? count_utf8 : count - 1);
+			if (cur < len || last_space < 0) {
+//printf("(%d)", cur);
+				if (last_space > 0)
+					putchar(' ');
+				else
+					for (i = 0; i < indent; i++)
+						putchar(' ');
+				for (i = last_space + 1; i < count - 1; i++)
+					putchar(oneline[i]);
+				if (!c) {
+					putchar('\n');
+					return;
+				}
+				last_space = count - 1;
+				count_utf8++;
+			} else {
+				putchar('\n');
+				for (oneline += last_space + 1;
+						isspace(*oneline); oneline++)
+					; /* do nothing */
+				indent = indent2;
+				last_space = -1;
+				count = count_utf8 = 0;
+			}
+			continue;
+		}
+		if (assume_utf8 && c > 0x7f) {
+			int multi_byte_count = 1;
+			if ((c & 0xe0) == 0xc0)
+				multi_byte_count = 2;
+			else if ((c & 0xf0) == 0xe0)
+				multi_byte_count = 3;
+			else if ((c & 0xf8) == 0xf0)
+				multi_byte_count = 4;
+			else
+				assume_utf8 = 0;
+			for (i = 0; i < multi_byte_count - 1; i++)
+				if (!oneline[count + i])
+					assume_utf8 = 0;
+			if (assume_utf8)
+				count += multi_byte_count - 1;
+		}
+		count_utf8++;
+	}
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -321,7 +379,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		} else {
 			printf("%s (%d):\n", list.items[i].path, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--)
-				printf("      %s\n", onelines->items[j].path);
+				print_oneline(onelines->items[j].path,
+					6, 9, 76);
 			printf("\n");
 		}
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
new file mode 100644
index 0000000..86a2295
--- /dev/null
+++ b/t/t4201-shortlog.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+#
+
+test_description='git-shortlog
+'
+
+. ./test-lib.sh
+
+echo 1 > a1
+git add a1
+tree=$(git write-tree)
+commit=$((echo "Test"; echo) | git commit-tree $tree)
+git update-ref HEAD $commit 
+
+echo 2 > a1
+git commit -m "This is a very, very long first line for the commit message to see if it is wrapped correctly" a1
+
+# test if the wrapping is still valid when replacing all i's by treble clefs.
+echo 3 > a1
+git commit -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\360\235\204\236')" a1
+
+# now fsck up the utf8
+echo 4 > a1
+git commit -m "$(echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" | sed "s/i/1234/g" | tr 1234 '\370\235\204\236')" a1
+
+git shortlog HEAD > out
+
+cat > expect << EOF
+A U Thor (4):
+      Test
+      This is a very, very long first line for the commit message to see if
+         it is wrapped correctly
+      Thð„žs ð„žs a very, very long fð„žrst lð„žne for the commð„žt message to see ð„žf
+         ð„žt ð„žs wrapped correctly
+      Thø„žs ø„žs a very, very long fø„žrst lø„žne for the commø„žt
+         message to see ø„žf ø„žt ø„žs wrapped correctly
+
+EOF
+
+test_expect_success 'shortlog wrapping' 'diff -u expect out'
+
+test_done
-- 
1.4.4.3.g610c-dirty

---1148973799-1703042654-1166701097=:19693--
