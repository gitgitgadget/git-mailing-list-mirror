Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852CC352A1
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020822522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 20:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBHUoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 15:44:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40317 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgBHUoK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 15:44:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so2882215ljo.7
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 12:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0rF2g35Iz7OdlO6RWoH9FQsT53aRfjYymMhOSLYwgo=;
        b=dZcF5rk8u64aOuntn25PBGSM3VcKZJUSzRUxqStPb39KNCYTr8mcPmN+COQvKqJ6bo
         NfYrQnfWQEzUD0M8ZcyZOC+Qa+CS/2BtuoQ7+jct6es4QuHaOEWG3E6Fy8/OnFoZjdOc
         KcDDVhmX1jdrhPnWBJ0YXe3bv+27QgY72z7RM+zD4Rk4s2XRHJ752NqIUQM0WxGN4F2i
         UyEFKDWm8w3eE7RIrlBaGPdvfXvDnBnUOCWykWPp09y2YC5BK0yFox24/CYUh096AKg7
         jYnwVyL0D+oOzSa+YVlCJB8GLT56r62WRWRLrYZXgYAdqwziIUrLMdSedvcJyVB7Z25a
         mrXA==
X-Gm-Message-State: APjAAAWYWT1dDK7eB73EOEEI7McEpuvGFkwa3nxtAcvPW9aGlwhUDopf
        GKPl3AJXVyrJPSQzNks7r74=
X-Google-Smtp-Source: APXvYqyhI6R8sFKR3S5gDlRKTF9A49q4wMimmjRTzBSe5lzcm1FQSyr7h7YNZ/Wt+vEVYnXu3wbUow==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr3531275ljg.129.1581194648526;
        Sat, 08 Feb 2020 12:44:08 -0800 (PST)
Received: from beta.herland (160.37-191-159.fiber.lynet.no. [37.191.159.160])
        by smtp.gmail.com with ESMTPSA id g15sm3614080ljl.10.2020.02.08.12.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 12:44:08 -0800 (PST)
From:   Johan Herland <johan@herland.net>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, Johan Herland <johan@herland.net>
Subject: [PATCH v2 1/2] t3305: check notes fanout more carefully and robustly
Date:   Sat,  8 Feb 2020 21:44:03 +0100
Message-Id: <20200208204404.5531-2-johan@herland.net>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200208204404.5531-1-johan@herland.net>
References: <20200208204404.5531-1-johan@herland.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In short, before this patch, this test script:
 - creates many notes
 - verifies that all notes in the notes tree has a fanout of 1
 - removes most notes
 - verifies that the notes in the notes tree now has a fanout of 0

The fanout verification only happened twice: after creating all the
notes, and after removing most of them.

This patch strengthens the test by checking the fanout after _each_
added/removed note: We assert that the switch from fanout 0 -> 1
happens exactly once while adding notes (and that the switch pervades
the entire notes tree). Likewise, we assert that the switch from
fanout 1 -> 0 happens exactly once while removing notes.

Additionally, we decrease the number of notes left after removal,
from 50 to 15 notes, in order to ensure that fanout 1 -> 0 transition
keeps happening regardless of external factors[1].

[1]: Currently (with the SHA1 hash function and the deterministic
object ids of the test environment) the fanout heuristic in the notes
code happens to switch from 0 -> 1 at 109 notes, and from 1 -> 0 at
59 notes. However, changing the hash function or other external
factors will vary these numbers, and the latter may - in theory - go
as low as 15. For more details, please see the discussion at
https://public-inbox.org/git/20200125230035.136348-4-sandals@crustytoothpaste.net/

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3305-notes-fanout.sh | 101 ++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 831f83d211..402057c83a 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -4,6 +4,32 @@ test_description='Test that adding/removing many notes triggers automatic fanout
 
 . ./test-lib.sh
 
+path_has_fanout() {
+	path=$1 &&
+	fanout=$2 &&
+	after_last_slash=$((40 - $fanout * 2)) &&
+	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
+}
+
+touched_one_note_with_fanout() {
+	notes_commit=$1 &&
+	modification=$2 &&  # 'A' for addition, 'D' for deletion
+	fanout=$3 &&
+	diff=$(git diff-tree --no-commit-id --name-status --root -r $notes_commit) &&
+	path=$(echo $diff | sed -e "s/^$modification[\t ]//") &&
+	path_has_fanout "$path" $fanout;
+}
+
+all_notes_have_fanout() {
+	notes_commit=$1 &&
+	fanout=$2 &&
+	git ls-tree -r --name-only $notes_commit 2>/dev/null |
+	while read path
+	do
+		path_has_fanout $path $fanout || return 1
+	done
+}
+
 test_expect_success 'creating many notes with git-notes' '
 	num_notes=300 &&
 	i=0 &&
@@ -20,7 +46,7 @@ test_expect_success 'creating many notes with git-notes' '
 
 test_expect_success 'many notes created correctly with git-notes' '
 	git log | grep "^    " > output &&
-	i=300 &&
+	i=$num_notes &&
 	while test $i -gt 0
 	do
 		echo "    commit #$i" &&
@@ -30,34 +56,46 @@ test_expect_success 'many notes created correctly with git-notes' '
 	test_cmp expect output
 '
 
-test_expect_success 'many notes created with git-notes triggers fanout' '
-	# Expect entire notes tree to have a fanout == 1
-	git ls-tree -r --name-only refs/notes/commits |
-	while read path
+test_expect_success 'stable fanout 0 is followed by stable fanout 1' '
+	i=$num_notes &&
+	fanout=0 &&
+	while test $i -gt 0
 	do
-		echo $path | grep "^../[0-9a-f]*$" || {
-			echo "Invalid path \"$path\"" &&
-			return 1;
-		}
-	done
+		i=$(($i - 1)) &&
+		if touched_one_note_with_fanout refs/notes/commits~$i A $fanout
+		then
+			continue
+		elif test $fanout -eq 0
+		then
+			fanout=1 &&
+			if all_notes_have_fanout refs/notes/commits~$i $fanout
+			then
+				echo "Fanout 0 -> 1 at refs/notes/commits~$i" &&
+				continue
+			fi
+		fi &&
+		echo "Failed fanout=$fanout check at refs/notes/commits~$i" &&
+		git ls-tree -r --name-only refs/notes/commits~$i &&
+		return 1
+	done &&
+	all_notes_have_fanout refs/notes/commits 1
 '
 
 test_expect_success 'deleting most notes with git-notes' '
-	num_notes=250 &&
+	remove_notes=285 &&
 	i=0 &&
 	git rev-list HEAD |
-	while test $i -lt $num_notes && read sha1
+	while test $i -lt $remove_notes && read sha1
 	do
 		i=$(($i + 1)) &&
 		test_tick &&
-		git notes remove "$sha1" ||
-		exit 1
+		git notes remove "$sha1" 2>/dev/null || return 1
 	done
 '
 
 test_expect_success 'most notes deleted correctly with git-notes' '
-	git log HEAD~250 | grep "^    " > output &&
-	i=50 &&
+	git log HEAD~$remove_notes | grep "^    " > output &&
+	i=$(($num_notes - $remove_notes)) &&
 	while test $i -gt 0
 	do
 		echo "    commit #$i" &&
@@ -67,16 +105,29 @@ test_expect_success 'most notes deleted correctly with git-notes' '
 	test_cmp expect output
 '
 
-test_expect_success 'deleting most notes triggers fanout consolidation' '
-	# Expect entire notes tree to have a fanout == 0
-	git ls-tree -r --name-only refs/notes/commits |
-	while read path
+test_expect_success 'stable fanout 1 is followed by stable fanout 0' '
+	i=$remove_notes &&
+	fanout=1 &&
+	while test $i -gt 0
 	do
-		echo $path | grep -v "^../.*" || {
-			echo "Invalid path \"$path\"" &&
-			return 1;
-		}
-	done
+		i=$(($i - 1)) &&
+		if touched_one_note_with_fanout refs/notes/commits~$i D $fanout
+		then
+			continue
+		elif test $fanout -eq 1
+		then
+			fanout=0 &&
+			if all_notes_have_fanout refs/notes/commits~$i $fanout
+			then
+				echo "Fanout 1 -> 0 at refs/notes/commits~$i" &&
+				continue
+			fi
+		fi &&
+		echo "Failed fanout=$fanout check at refs/notes/commits~$i" &&
+		git ls-tree -r --name-only refs/notes/commits~$i &&
+		return 1
+	done &&
+	all_notes_have_fanout refs/notes/commits 0
 '
 
 test_done
-- 
2.23.1

