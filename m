From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/25] test: put tests for handling of bad ref names in one
 place
Date: Tue, 14 Oct 2014 17:53:48 -0700
Message-ID: <20141015005348.GW32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:54:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCqi-0003qx-4L
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbaJOAxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:53:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34233 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:53:51 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so225475pac.35
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=j2ZJobf4boRSCbtHtXd/QM9HR0vbwXxwJ7Cu5hB7G64=;
        b=ZzxdPUB40L2XOKUq6NCfG22T2JXci3TVMF4JoSG1kHVV66GHWRYfnawM/jtCZCKLaT
         qNkgC2U4xnxlbxVe5dkWBgmWCLAtVn53KIuCJQPqpfkqZEtmcc7SZhdn03v7PBFJdLKp
         tgcoWYYaJ4kQJhM6wml2jTWSNrXNmOKrxxVfs1lXdu4IOUyqRtXYJ7Zpj5VBeG7A3P2M
         mdtVprkVlt8UnTJIZHEMeUqmVLfGlPea0esPvSy7WE3A+gI6wMihL5aDgNOlsvLBHFHn
         2zpg4/Gq0Y2FZfBI/UgQ7u9WOgpMRRS0by55ebehTs6yIU9S5E9mzGizCJD9E3vfMU35
         bbVw==
X-Received: by 10.70.17.129 with SMTP id o1mr9205858pdd.10.1413334431488;
        Tue, 14 Oct 2014 17:53:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id v10sm15288825pbs.64.2014.10.14.17.53.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:53:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 25 Sep 2014 15:02:39 -0700

There's no straightforward way to grep for all tests dealing with
invalid refs.  Put them in a single test script so it is easy to see
what functionality has not been exercised with bad ref names yet.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1400-update-ref.sh   | 44 --------------------------
 t/t1430-bad-ref-name.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9300-fast-import.sh  | 30 ------------------
 3 files changed, 84 insertions(+), 74 deletions(-)
 create mode 100755 t/t1430-bad-ref-name.sh

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7c8c41a..7b4707b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -136,14 +136,6 @@ test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
 	test_path_is_missing .git/refs/heads/ref-to-bad
 '
 
-test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
-	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
-	test_path_is_file .git/refs/heads/badname &&
-	git update-ref --no-deref -d refs/heads/badname &&
-	test_path_is_missing .git/refs/heads/badname
-'
-
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
@@ -408,12 +400,6 @@ test_expect_success 'stdin fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin fails create with bad ref name' '
-	echo "create ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -432,12 +418,6 @@ test_expect_success 'stdin fails update with no ref' '
 	grep "fatal: update: missing <ref>" err
 '
 
-test_expect_success 'stdin fails update with bad ref name' '
-	echo "update ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -456,12 +436,6 @@ test_expect_success 'stdin fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin fails delete with bad ref name' '
-	echo "delete ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -734,12 +708,6 @@ test_expect_success 'stdin -z fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails create with bad ref name' '
-	printf $F "create ~a " "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a " err
-'
-
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
@@ -764,12 +732,6 @@ test_expect_success 'stdin -z fails update with too few args' '
 	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
-test_expect_success 'stdin -z fails update with bad ref name' '
-	printf $F "update ~a" "$m" "" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
@@ -802,12 +764,6 @@ test_expect_success 'stdin -z fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails delete with bad ref name' '
-	printf $F "delete ~a" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
new file mode 100755
index 0000000..c7b19b0
--- /dev/null
+++ b/t/t1430-bad-ref-name.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='Test handling of ref names that check-ref-format rejects'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit one
+'
+
+test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit .badbranchname
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit bad[branch]name
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
+	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_path_is_file .git/refs/heads/badname &&
+	git update-ref --no-deref -d refs/heads/badname &&
+	test_path_is_missing .git/refs/heads/badname
+'
+
+test_expect_success 'update-ref --stdin fails create with bad ref name' '
+	echo "create ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails update with bad ref name' '
+	echo "update ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails delete with bad ref name' '
+	echo "delete ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails create with bad ref name' '
+	printf "%s\0" "create ~a " refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a " err
+'
+
+test_expect_success 'update-ref --stdin -z fails update with bad ref name' '
+	printf "%s\0" "update ~a" refs/heads/master "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
+	printf "%s\0" "delete ~a" refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_done
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 8df0445..37c2d63 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -347,36 +347,6 @@ test_expect_success 'B: fail on invalid blob sha1' '
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
-commit .badbranchname
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
-commit bad[branch]name
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
 commit TEMP_TAG
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
2.1.0.rc2.206.gedb03e5
