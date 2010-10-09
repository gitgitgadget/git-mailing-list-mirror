From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 08/21] notes.c: Use two newlines (instead of one) when concatenating notes
Date: Sat,  9 Oct 2010 03:11:28 +0200
Message-ID: <1286586701-3586-9-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Nzw-0002nk-SA
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760094Ab0JIBNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:13:11 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63654 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:13:10 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nzp-0001bt-1u; Sat, 09 Oct 2010 03:13:09 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158557>

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
index c4203ce..a7a901a 100644
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
index 9f03ce6..9ed70dc 100755
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
1.7.3.1.104.g92b87a
