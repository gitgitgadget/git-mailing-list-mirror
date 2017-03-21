Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC352095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755695AbdCUA4o (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59791 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755658AbdCUA4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF2D77FDE7;
        Mon, 20 Mar 2017 20:56:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sdrL
        Rtwknvh7Yr1TV2xtcwjas6g=; b=A13XdkkLv4eoIlCwF8lYfqzLacnH3uNlL5LZ
        ILPMjQIE+EleMzQjKVjEQCP7GWB/uWFocg1QGlundCQuzOJ7BU3bw4fC3RBNkikU
        gniY7PhR+jkDZwSyK9vN1q2vealG42Hmf0SZmVJGACYmWqSXZkZIQ8W0ykZEYPxl
        wbaYFEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7FE67FDE6;
        Mon, 20 Mar 2017 20:56:31 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A60F7FDE3;
        Mon, 20 Mar 2017 20:56:30 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 5/5] t1400: use test_when_finished for cleanup
Date:   Mon, 20 Mar 2017 20:56:16 -0400
Message-Id: <20170321005616.31324-6-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
References: <20170321005616.31324-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 38DCFABE-0DD1-11E7-B616-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=sdrLRtwknvh7Yr1TV2xtcwjas6g=;
 b=0ZgH36MXLMAkbtvgVHX7SeXuFfqp0rFSfMdKWaNM0B/EH3PU/69tOuQzDcTPCJna+zeGw6NMhjan68ozIa26VGXki4NOeFe7q+vNZzDR/ptSp3NEIQFo0lv0DpZqGxQL4hJcajm1ohYVCtaD6kW2o+ZzVtN3mNiOSvYB4q7ba68=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move cleanup lines that occur after test blocks into
test_when_finished calls within the test bodies.  Don't move cleanup
lines that seem to be related to mutiple tests rather than a single
test.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t1400-update-ref.sh | 81 ++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9e7e0227e..a23cd7b57 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -48,24 +48,24 @@ test_expect_success "fail to delete $m with stale ref" '
 	test $B = "$(cat .git/$m)"
 '
 test_expect_success "delete $m" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref -d $m $B &&
 	test_path_is_missing .git/$m
 '
-rm -f .git/$m
 
-test_expect_success "delete $m without oldvalue verification" "
+test_expect_success "delete $m without oldvalue verification" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref $m $A &&
-	test $A = \$(cat .git/$m) &&
+	test $A = $(cat .git/$m) &&
 	git update-ref -d $m &&
 	test_path_is_missing .git/$m
-"
-rm -f .git/$m
+'
 
-test_expect_success \
-	"fail to create $n" \
-	"touch .git/$n_dir &&
-	 test_must_fail git update-ref $n $A"
-rm -f .git/$n_dir
+test_expect_success "fail to create $n" '
+	test_when_finished "rm -f .git/$n_dir" &&
+	touch .git/$n_dir &&
+	test_must_fail git update-ref $n $A
+'
 
 test_expect_success \
 	"create $m (by HEAD)" \
@@ -80,28 +80,28 @@ test_expect_success "fail to delete $m (by HEAD) with stale ref" '
 	test $B = $(cat .git/$m)
 '
 test_expect_success "delete $m (by HEAD)" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref -d HEAD $B &&
 	test_path_is_missing .git/$m
 '
-rm -f .git/$m
 
 test_expect_success "deleting current branch adds message to HEAD's log" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-$m -d $m &&
 	test_path_is_missing .git/$m &&
 	grep "delete-$m$" .git/logs/HEAD
 '
-rm -f .git/$m
 
 test_expect_success "deleting by HEAD adds message to HEAD's log" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-by-head -d HEAD &&
 	test_path_is_missing .git/$m &&
 	grep "delete-by-head$" .git/logs/HEAD
 '
-rm -f .git/$m
 
 test_expect_success 'update-ref does not create reflogs by default' '
 	test_when_finished "git update-ref -d $outside" &&
@@ -188,20 +188,21 @@ test_expect_success \
 	"git update-ref HEAD $B $A &&
 	 test $B"' = $(cat .git/'"$m"')'
 test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
+	test_when_finished "rm -f .git/$m" &&
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
 	test_path_is_missing .git/$m
 '
-rm -f .git/$m
 
 cp -f .git/HEAD .git/HEAD.orig
 test_expect_success "delete symref without dereference" '
+	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	git update-ref --no-deref -d HEAD &&
 	test_path_is_missing .git/HEAD
 '
-cp -f .git/HEAD.orig .git/HEAD
 
 test_expect_success "delete symref without dereference when the referred ref is packed" '
+	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	echo foo >foo.c &&
 	git add foo.c &&
 	git commit -m foo &&
@@ -209,7 +210,7 @@ test_expect_success "delete symref without dereference when the referred ref is
 	git update-ref --no-deref -d HEAD &&
 	test_path_is_missing .git/HEAD
 '
-cp -f .git/HEAD.orig .git/HEAD
+
 git update-ref -d $m
 
 test_expect_success 'update-ref -d is not confused by self-reference' '
@@ -241,10 +242,10 @@ test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
-test_expect_success "(not) prior created .git/$m" "
+test_expect_success "(not) prior created .git/$m" '
+	test_when_finished "rm -f .git/$m" &&
 	test_path_is_missing .git/$m
-"
-rm -f .git/$m
+'
 
 test_expect_success \
 	"create HEAD" \
@@ -252,10 +253,10 @@ test_expect_success \
 test_expect_success '(not) change HEAD with wrong SHA1' "
 	test_must_fail git update-ref HEAD $B $Z
 "
-test_expect_success "(not) changed .git/$m" "
-	! test $B"' = $(cat .git/'"$m"')
+test_expect_success "(not) changed .git/$m" '
+	test_when_finished "rm -f .git/$m" &&
+	! test $B = $(cat .git/$m)
 '
-rm -f .git/$m
 
 rm -f .git/logs/refs/heads/master
 test_expect_success \
@@ -309,10 +310,10 @@ $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creati
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
 $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
 EOF
-test_expect_success \
-	"verifying $m's log (logged by touch)" \
-	"test_cmp expect .git/logs/$m"
-rm -rf .git/$m .git/logs expect
+test_expect_success "verifying $m's log (logged by touch)" '
+	test_when_finished "rm -rf .git/$m .git/logs expect" &&
+	test_cmp expect .git/logs/$m
+'
 
 test_expect_success \
 	"create $m (logged by config)" \
@@ -340,8 +341,8 @@ $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
 EOF
 test_expect_success \
 	"verifying $m's log (logged by config)" \
-	'test_cmp expect .git/logs/$m'
-rm -f .git/$m .git/logs/$m expect
+	'test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
+	 test_cmp expect .git/logs/$m'
 
 git update-ref $m $D
 cat >.git/logs/$m <<EOF
@@ -357,55 +358,55 @@ gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
 test_expect_success \
 	'Query "master@{May 25 2005}" (before history)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	"Query master@{2005-05-25} (before history)" \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify master@{2005-05-25} >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 echo test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
 	 test '"$A"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	 test '"$B"' = $(cat o) &&
 	 test "warning: Log for ref '"$m has gap after $gd"'." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
 	 test '"$Z"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:43:00}" (exact end of history)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
 	 test '"$E"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-28}" (past end of history)' \
-	'rm -f o e &&
+	'test_when_finished "rm -f o e" &&
 	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	 test '"$D"' = $(cat o) &&
 	 test "warning: Log for ref '"$m unexpectedly ended on $ld"'." = "$(cat e)"'
@@ -415,7 +416,8 @@ rm -f .git/$m .git/logs/$m expect
 
 test_expect_success \
     'creating initial files' \
-    'echo TEST >F &&
+    'test_when_finished rm -f M &&
+     echo TEST >F &&
      git add F &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
@@ -433,8 +435,7 @@ test_expect_success \
 	 echo $h_TEST >.git/MERGE_HEAD &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:45" git commit -F M &&
-	 h_MERGED=$(git rev-parse --verify HEAD) &&
-	 rm -f M'
+	 h_MERGED=$(git rev-parse --verify HEAD)'
 
 cat >expect <<EOF
 $Z $h_TEST $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	commit (initial): add
-- 
2.12.0

