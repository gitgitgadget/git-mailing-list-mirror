From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 03/11] Add more testcases to test fast-import of notes
Date: Wed, 02 Dec 2009 03:09:35 +0100
Message-ID: <1259719783-4674-4-git-send-email-johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFefo-0005bM-LH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbZLBCKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbZLBCKP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:10:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61703 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754466AbZLBCKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:10:09 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU0004GD613PL70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:15 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:15 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1259719783-4674-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134286>

This patch adds testcases verifying correct behaviour in several scenarios
regarding fast-import of notes:
- using a mixture of 'N' and 'M' commands
- updating existing notes
- concatenation of notes
- 'deleteall' also removes notes
- fanout schemes is added/removed when needed
- git-fast-import's branch unload/reload preserves notes

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t9301-fast-import-notes.sh |  578 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 578 insertions(+), 0 deletions(-)
 create mode 100755 t/t9301-fast-import-notes.sh

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
new file mode 100755
index 0000000..5a08a76
--- /dev/null
+++ b/t/t9301-fast-import-notes.sh
@@ -0,0 +1,578 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Johan Herland
+#
+
+test_description='test git fast-import of notes objects'
+. ./test-lib.sh
+
+
+test_tick
+cat >input <<INPUT_END
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+first commit
+COMMIT
+
+M 644 inline foo
+data <<EOF
+file foo in first commit
+EOF
+
+M 755 inline bar
+data <<EOF
+file bar in first commit
+EOF
+
+M 644 inline baz/xyzzy
+data <<EOF
+file baz/xyzzy in first commit
+EOF
+
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+second commit
+COMMIT
+
+M 644 inline foo
+data <<EOF
+file foo in second commit
+EOF
+
+M 755 inline baz/xyzzy
+data <<EOF
+file baz/xyzzy in second commit
+EOF
+
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+third commit
+COMMIT
+
+M 644 inline foo
+data <<EOF
+file foo in third commit
+EOF
+
+commit refs/heads/master
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+fourth commit
+COMMIT
+
+M 755 inline bar
+data <<EOF
+file bar in fourth commit
+EOF
+
+INPUT_END
+
+test_expect_success 'set up master branch' '
+
+	git fast-import <input &&
+	git whatchanged master
+'
+
+commit4=$(git rev-parse refs/heads/master)
+commit3=$(git rev-parse "$commit4^")
+commit2=$(git rev-parse "$commit4~2")
+commit1=$(git rev-parse "$commit4~3")
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+first notes commit
+COMMIT
+
+M 644 inline $commit1
+data <<EOF
+first note for first commit
+EOF
+
+M 755 inline $commit2
+data <<EOF
+first note for second commit
+EOF
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    third commit
+    second commit
+    first note for second commit
+    first commit
+    first note for first commit
+EXPECT_END
+
+test_expect_success 'add notes with simple M command' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+second notes commit
+COMMIT
+
+from refs/notes/test^0
+N inline $commit3
+data <<EOF
+first note for third commit
+EOF
+
+N inline $commit4
+data <<EOF
+first note for fourth commit
+EOF
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    first note for fourth commit
+    third commit
+    first note for third commit
+    second commit
+    first note for second commit
+    first commit
+    first note for first commit
+EXPECT_END
+
+test_expect_success 'add notes with simple N command' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+third notes commit
+COMMIT
+
+from refs/notes/test^0
+N inline $commit1
+data <<EOF
+second note for first commit
+EOF
+
+N inline $commit2
+data <<EOF
+second note for second commit
+EOF
+
+N inline $commit3
+data <<EOF
+second note for third commit
+EOF
+
+N inline $commit4
+data <<EOF
+second note for fourth commit
+EOF
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    second note for fourth commit
+    third commit
+    second note for third commit
+    second commit
+    second note for second commit
+    first commit
+    second note for first commit
+EXPECT_END
+
+test_expect_success 'update existing notes with N command' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+fourth notes commit
+COMMIT
+
+from refs/notes/test^0
+M 644 inline $(echo "$commit3" | sed "s|^..|&/|")
+data <<EOF
+prefix of note for third commit
+EOF
+
+M 644 inline $(echo "$commit4" | sed "s|^..|&/|")
+data <<EOF
+prefix of note for fourth commit
+EOF
+
+M 644 inline $(echo "$commit4" | sed "s|^\(..\)\(..\)|\1/\2/|")
+data <<EOF
+pre-prefix of note for fourth commit
+EOF
+
+N inline $commit1
+data <<EOF
+third note for first commit
+EOF
+
+N inline $commit2
+data <<EOF
+third note for second commit
+EOF
+
+N inline $commit3
+data <<EOF
+third note for third commit
+EOF
+
+N inline $commit4
+data <<EOF
+third note for fourth commit
+EOF
+
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    pre-prefix of note for fourth commit
+    prefix of note for fourth commit
+    third note for fourth commit
+    third commit
+    prefix of note for third commit
+    third note for third commit
+    second commit
+    third note for second commit
+    first commit
+    third note for first commit
+EXPECT_END
+
+test_expect_success 'add concatentation notes with M command' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+fifth notes commit
+COMMIT
+
+from refs/notes/test^0
+deleteall
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    third commit
+    second commit
+    first commit
+EXPECT_END
+
+test_expect_success 'verify that deleteall also removes notes' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/test
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+sixth notes commit
+COMMIT
+
+from refs/notes/test^0
+M 644 inline $commit1
+data <<EOF
+third note for first commit
+EOF
+
+M 644 inline $commit3
+data <<EOF
+third note for third commit
+EOF
+
+N inline $commit1
+data <<EOF
+fourth note for first commit
+EOF
+
+N inline $commit3
+data <<EOF
+fourth note for third commit
+EOF
+
+INPUT_END
+
+cat >expect <<EXPECT_END
+    fourth commit
+    third commit
+    fourth note for third commit
+    second commit
+    first commit
+    fourth note for first commit
+EXPECT_END
+
+test_expect_success 'verify that N commands override M commands' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+# Write fast-import commands to create the given number of commits
+fast_import_commits () {
+	my_ref=$1
+	my_num_commits=$2
+	my_append_to_file=$3
+	my_i=0
+	while test $my_i -lt $my_num_commits
+	do
+		my_i=$(($my_i + 1))
+		test_tick
+		cat >>"$my_append_to_file" <<INPUT_END
+commit $my_ref
+mark :$my_i
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+commit #$my_i
+COMMIT
+
+M 644 inline file
+data <<EOF
+file contents in commit #$my_i
+EOF
+
+INPUT_END
+	done
+}
+
+# Write fast-import commands to create the given number of notes annotating
+# the commits created by fast_import_commits()
+fast_import_notes () {
+	my_notes_ref=$1
+	my_num_commits=$2
+	my_append_to_file=$3
+	my_note_append=$4
+	test_tick
+	cat >>"$my_append_to_file" <<INPUT_END
+commit $my_notes_ref
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+committing $my_num_commits notes
+COMMIT
+
+INPUT_END
+
+	my_i=0
+	while test $my_i -lt $my_num_commits
+	do
+		my_i=$(($my_i + 1))
+		cat >>"$my_append_to_file" <<INPUT_END
+N inline :$my_i
+data <<EOF
+note for commit #$my_i$my_note_append
+EOF
+
+INPUT_END
+	done
+}
+
+
+rm input expect
+num_commits=400
+# Create lots of commits
+fast_import_commits "refs/heads/many_commits" $num_commits input
+# Create one note per above commit
+fast_import_notes "refs/notes/many_notes" $num_commits input
+# Finally create the expected output from all these notes and commits
+i=$num_commits
+while test $i -gt 0
+do
+	cat >>expect <<EXPECT_END
+    commit #$i
+    note for commit #$i
+EXPECT_END
+	i=$(($i - 1))
+done
+
+test_expect_success 'add lots of commits and notes' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/many_notes git log refs/heads/many_commits |
+	    grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'verify that lots of notes trigger a fanout scheme' '
+
+	# None of the entries in the top-level notes tree should be a full SHA1
+	git cat-file -p refs/notes/many_notes: |
+	while read mode type sha1 path
+	do
+		path_len=$(expr length "$path") &&
+		if test $path_len -ge 40
+		then
+			return 1
+		fi
+	done
+
+'
+
+commit1=$(git rev-parse "refs/heads/many_commits")
+commit2=$(git rev-parse "$commit1^")
+commit3=$(git rev-parse "$commit2^")
+commit4=$(git rev-parse "$commit3^")
+
+test_tick
+cat >input <<INPUT_END
+commit refs/notes/many_notes
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+replacing many notes with few notes
+COMMIT
+
+from refs/notes/many_notes^0
+deleteall
+N inline $commit1
+data <<EOF
+note for commit #$num_commits
+EOF
+
+N inline $commit2
+data <<EOF
+note for commit #$(($num_commits - 1))
+EOF
+
+N inline $commit3
+data <<EOF
+note for commit #$(($num_commits - 2))
+EOF
+
+N inline $commit4
+data <<EOF
+note for commit #$(($num_commits - 3))
+EOF
+
+INPUT_END
+
+i=$num_commits
+rm expect
+while test $i -gt 0
+do
+	cat >>expect <<EXPECT_END
+    commit #$i
+EXPECT_END
+	if test $i -gt $(($num_commits - 4))
+	then
+		cat >>expect <<EXPECT_END
+    note for commit #$i
+EXPECT_END
+	fi
+	i=$(($i - 1))
+done
+
+test_expect_success 'remove lots of notes' '
+
+	git fast-import <input &&
+	GIT_NOTES_REF=refs/notes/many_notes git log refs/heads/many_commits |
+	    grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'verify that removing notes trigger fanout consolidation' '
+
+	# All entries in the top-level notes tree should be a full SHA1
+	git cat-file -p refs/notes/many_notes: |
+	while read mode type sha1 path
+	do
+		path_len=$(expr length "$path") &&
+		if test $path_len -ne 40
+		then
+			return 1
+		fi
+	done
+
+'
+
+rm input expect
+num_notes_refs=10
+num_commits=16
+some_commits=8
+# Create commits
+fast_import_commits "refs/heads/more_commits" $num_commits input
+# Create one note per above commit per notes ref
+i=0
+while test $i -lt $num_notes_refs
+do
+	i=$(($i + 1))
+	fast_import_notes "refs/notes/more_notes_$i" $num_commits input
+done
+# Trigger branch reloading in git-fast-import by repeating the note creation
+i=0
+while test $i -lt $num_notes_refs
+do
+	i=$(($i + 1))
+	fast_import_notes "refs/notes/more_notes_$i" $some_commits input " (2)"
+done
+# Finally create the expected output from the notes in refs/notes/more_notes_1
+i=$num_commits
+while test $i -gt 0
+do
+	note_data="note for commit #$i"
+	if test $i -le $some_commits
+	then
+		note_data="$note_data (2)"
+	fi
+	cat >>expect <<EXPECT_END
+    commit #$i
+    $note_data
+EXPECT_END
+	i=$(($i - 1))
+done
+
+test_expect_success "add notes to $num_commits commits in each of $num_notes_refs refs" '
+
+	git fast-import --active-branches=5 <input &&
+	GIT_NOTES_REF=refs/notes/more_notes_1 git log refs/heads/more_commits |
+	    grep "^    " > actual &&
+	test_cmp expect actual
+
+'
+
+test_done
-- 
1.6.5.3.433.g11067
