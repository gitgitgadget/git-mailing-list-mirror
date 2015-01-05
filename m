From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv0 3/4] fast-import: Support adding notes to non-commits
Date: Mon,  5 Jan 2015 04:39:37 +0100
Message-ID: <1420429178-20336-3-git-send-email-johan@herland.net>
References: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
 <1420429178-20336-1-git-send-email-johan@herland.net>
Cc: Git mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 04:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7yWh-0002T6-03
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbbAEDkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 22:40:08 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:43349 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbbAEDkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:40:06 -0500
Received: by mail-la0-f44.google.com with SMTP id gd6so17835921lab.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=68U5V47CKo6AAcR8prObe+y6hP2qgQja0FYZ7aCjjV8=;
        b=H5+2fivRjGo4rcb7AesphlH0BubHB69ANdhRu3kMVG7pqVIr0PRFHUb0aD7QSSc8oL
         dgEbKz+jLiYE6Ht3z+3utediXkDb2ZDE0LUg33VGpIjFI6naT0/DDv6BfabMWqYo5KWV
         tMX/gheODoPJNbk/+ViQqGyjTqyqn7OJNE7xdEcQJcn9STozyLODcGfgSsSOwJbEWmoi
         0BN7vywqNif0zIRl7iKAfs7WUkfzj6+X4QcePd3U2j3RRu4J+/ssC9UJ5v3rNJhFF951
         /uMMb23JiAza4Ih3lOapFFjch4o3c/65Aw81fFugVaMB0a99fXngpFDClMKz2Ifue6HW
         luaQ==
X-Received: by 10.152.29.193 with SMTP id m1mr89573586lah.84.1420429204796;
        Sun, 04 Jan 2015 19:40:04 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ya4sm4239978lbb.32.2015.01.04.19.40.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jan 2015 19:40:03 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1420429178-20336-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262011>

"git notes" allows adding notes to non-commit objects, but fast-import
restricts the 'notemodify' command to only add notes for commit objects.
Remove that silly restriction from fast-import.

Suggested-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c                | 12 ++++------
 t/t9301-fast-import-notes.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index aa7b64e..b6df00b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2498,16 +2498,12 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(commit_mark);
-		if (commit_oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		hashcpy(commit_sha1, commit_oe->idx.sha1);
 	} else if (!get_sha1(p, commit_sha1)) {
-		unsigned long size;
-		char *buf = read_object_with_reference(commit_sha1,
-			commit_type, &size, commit_sha1);
-		if (!buf || size < 46)
-			die("Not a valid commit: %s", p);
-		free(buf);
+		if (!find_object(commit_sha1)) {
+			if (sha1_object_info(commit_sha1, NULL) < 0)
+				die("Not a valid object: %s", p);
+		}
 	} else
 		die("Invalid ref name or SHA1 expression: %s", p);
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 83acf68..b8ff673 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -679,4 +679,60 @@ test_expect_success "add notes to $num_commits commits in each of $num_notes_ref
 
 '
 
+tree4=$(git rev-parse refs/heads/master^{tree})
+blob4=$(git rev-parse refs/heads/master:bar)
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/noncommits
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+adding notes to non-commits
+COMMIT
+
+N inline $tree4
+data <<EOF
+note for tree object
+EOF
+
+N inline $blob4
+data <<EOF
+note for blob object
+EOF
+
+INPUT_END
+
+test_expect_success 'add notes to non-commits' "
+
+	git fast-import <input &&
+	echo 'note for tree object' >expect &&
+	git notes --ref noncommits show $tree4 >actual &&
+	test_cmp expect actual &&
+	echo 'note for blob object' >expect &&
+	git notes --ref noncommits show $blob4 >actual &&
+	test_cmp expect actual
+
+"
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/nonobjects
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+adding notes to non-objects MUST FAIL
+COMMIT
+
+N inline deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
+data <<EOF
+note for missing object
+EOF
+
+INPUT_END
+
+test_expect_success 'cannot add notes to non-objects' "
+
+	test_must_fail git fast-import <input
+
+"
+
 test_done
-- 
2.1.1.392.g062cc5d
