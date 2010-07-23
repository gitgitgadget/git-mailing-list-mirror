From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 06/13] notes.c: Use two newlines (instead of one) when
 concatenating notes
Date: Fri, 23 Jul 2010 12:14:57 +0200
Message-ID: <1279880104-29796-7-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIV-0001FC-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab0GWKPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477Ab0GWKPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:17 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G9U9TBM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:11 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id EA1BB1EA5545_C496BAEB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id B1D3C1EA3721_C496BAEF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:10 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151520>

When using combine_notes_concatenate() to concatenate notes, it currently
ensures exactly one newline character between the given notes. However,
when using builtin/notes.c:create_note() to concatenate notes (e.g. by
'git notes append'), it adds a newline character to the trailing newline
of the preceding notes object, thus resulting in _two_ newlines (aka. a
blank line) separating contents of the two notes.

This patch brings combine_notes_concatenate() into consistency with
builtin/notes.c:create_note(), by ensuring exactly _two_ newline characters
between concatenated notes.

The patch also changes a few notes-related selftests accordingly.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c                       |    7 ++++---
 t/t3301-notes.sh              |    4 ++++
 t/t3303-notes-subtrees.sh     |    1 +
 t/t3404-rebase-interactive.sh |    1 +
 t/t9301-fast-import-notes.sh  |    5 +++++
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index 4f3d094..28afe2c 100644
--- a/notes.c
+++ b/notes.c
@@ -814,16 +814,17 @@ int combine_notes_concatenate(unsigned char *cur_sha1,
 		return 0;
 	}
 
-	/* we will separate the notes by a newline anyway */
+	/* we will separate the notes by two newlines anyway */
 	if (cur_msg[cur_len - 1] == '\n')
 		cur_len--;
 
 	/* concatenate cur_msg and new_msg into buf */
-	buf_len = cur_len + 1 + new_len;
+	buf_len = cur_len + 2 + new_len;
 	buf = (char *) xmalloc(buf_len);
 	memcpy(buf, cur_msg, cur_len);
 	buf[cur_len] = '\n';
-	memcpy(buf + cur_len + 1, new_msg, new_len);
+	buf[cur_len + 1] = '\n';
+	memcpy(buf + cur_len + 2, new_msg, new_len);
 	free(cur_msg);
 	free(new_msg);
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1d82f79..4bf4e52 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -955,6 +955,7 @@ Date:   Thu Apr 7 15:27:13 2005 -0700
 
 Notes (other):
     a fresh note
+$whitespace
     another fresh note
 EOF
 
@@ -976,8 +977,11 @@ Date:   Thu Apr 7 15:27:13 2005 -0700
 
 Notes (other):
     a fresh note
+$whitespace
     another fresh note
+$whitespace
     append 1
+$whitespace
     append 2
 EOF
 
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d571708..704aee8 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -173,6 +173,7 @@ verify_concatenated_notes () {
 	while [ $i -gt 0 ]; do
 		echo "    commit #$i" &&
 		echo "    first note for commit #$i" &&
+		echo "    " &&
 		echo "    second note for commit #$i" &&
 		i=$(($i-1));
 	done > expect &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47ca88f..4b004bc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -593,6 +593,7 @@ test_expect_success 'rebase -i can copy notes' '
 
 cat >expect <<EOF
 an earlier note
+
 a note
 EOF
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index a5c99d8..7cf8cd8 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -255,13 +255,18 @@ EOF
 
 INPUT_END
 
+whitespace="    "
+
 cat >expect <<EXPECT_END
     fourth commit
     pre-prefix of note for fourth commit
+$whitespace
     prefix of note for fourth commit
+$whitespace
     third note for fourth commit
     third commit
     prefix of note for third commit
+$whitespace
     third note for third commit
     second commit
     third note for second commit
-- 
1.7.2.220.gea1d3
