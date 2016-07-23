Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62846203E6
	for <e@80x24.org>; Sat, 23 Jul 2016 04:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbcGWE0Y (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 00:26:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37186 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbcGWE0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 00:26:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B6C203E4;
	Sat, 23 Jul 2016 04:26:17 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Eric Wong <e@80x24.org>, Clemens Buchacher <drizzd@aon.at>,
	Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] git svn: migrate tests to use lib-httpd
Date:	Sat, 23 Jul 2016 04:26:08 +0000
Message-Id: <20160723042608.27489-3-e@80x24.org>
In-Reply-To: <20160723042608.27489-1-e@80x24.org>
References: <20160723042608.27489-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This allows us to use common test infrastructure and parallelize
the tests.  For now, GIT_SVN_TEST_HTTPD=true needs to be set to
enable the SVN HTTP tests because we reuse the same test cases
for both file:// and http:// SVN repositories.  SVN_HTTPD_PORT
is no longer honored.

Tested under Apache 2.2 and 2.4 on Debian 7.x (wheezy) and
8.x (jessie), respectively.

Cc: Clemens Buchacher <drizzd@aon.at>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 t/lib-git-svn.sh                              | 91 +++++----------------------
 t/lib-httpd.sh                                |  8 ++-
 t/lib-httpd/apache.conf                       |  4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |  7 ++-
 t/t9118-git-svn-funky-branch-names.sh         |  2 +-
 t/t9120-git-svn-clone-with-percent-escapes.sh |  2 +-
 t/t9142-git-svn-shallow-clone.sh              |  2 +-
 7 files changed, 30 insertions(+), 86 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index fb88232..688313e 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -65,81 +65,22 @@ svn_cmd () {
 	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
 }
 
-prepare_httpd () {
-	for d in \
-		"$SVN_HTTPD_PATH" \
-		/usr/sbin/apache2 \
-		/usr/sbin/httpd \
-	; do
-		if test -f "$d"
-		then
-			SVN_HTTPD_PATH="$d"
-			break
-		fi
-	done
-	if test -z "$SVN_HTTPD_PATH"
-	then
-		echo >&2 '*** error: Apache not found'
-		return 1
-	fi
-	for d in \
-		"$SVN_HTTPD_MODULE_PATH" \
-		/usr/lib/apache2/modules \
-		/usr/libexec/apache2 \
-	; do
-		if test -d "$d"
-		then
-			SVN_HTTPD_MODULE_PATH="$d"
-			break
-		fi
-	done
-	if test -z "$SVN_HTTPD_MODULE_PATH"
-	then
-		echo >&2 '*** error: Apache module dir not found'
-		return 1
-	fi
-	if test ! -f "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
-	then
-		echo >&2 '*** error: Apache module "mod_dav_svn" not found'
-		return 1
-	fi
-
-	repo_base_path="${1-svn}"
-	mkdir "$GIT_DIR"/logs
-
-	cat > "$GIT_DIR/httpd.conf" <<EOF
-ServerName "git svn test"
-ServerRoot "$GIT_DIR"
-DocumentRoot "$GIT_DIR"
-PidFile "$GIT_DIR/httpd.pid"
-LockFile logs/accept.lock
-Listen 127.0.0.1:$SVN_HTTPD_PORT
-LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
-LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
-<Location /$repo_base_path>
-	DAV svn
-	SVNPath "$rawsvnrepo"
-</Location>
-EOF
-}
-
-start_httpd () {
-	if test -z "$SVN_HTTPD_PORT"
-	then
-		echo >&2 'SVN_HTTPD_PORT is not defined!'
-		return
-	fi
-
-	prepare_httpd "$1" || return 1
-
-	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k start
-	svnrepo="http://127.0.0.1:$SVN_HTTPD_PORT/$repo_base_path"
-}
-
-stop_httpd () {
-	test -z "$SVN_HTTPD_PORT" && return
-	test ! -f "$GIT_DIR/httpd.conf" && return
-	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
+maybe_start_httpd () {
+	loc=${1-svn}
+
+	test_tristate GIT_SVN_TEST_HTTPD
+	case $GIT_SVN_TEST_HTTPD in
+	true)
+		. "$TEST_DIRECTORY"/lib-httpd.sh
+		LIB_HTTPD_SVN="$loc"
+		start_httpd
+		;;
+	*)
+		stop_httpd () {
+			: noop
+		}
+		;;
+	esac
 }
 
 convert_to_rev_db () {
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index ac2cbee..435a374 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -24,7 +24,7 @@
 #    LIB_HTTPD_MODULE_PATH       web server modules path
 #    LIB_HTTPD_PORT              listening port
 #    LIB_HTTPD_DAV               enable DAV
-#    LIB_HTTPD_SVN               enable SVN
+#    LIB_HTTPD_SVN               enable SVN at given location (e.g. "svn")
 #    LIB_HTTPD_SSL               enable SSL
 #
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
@@ -162,8 +162,10 @@ prepare_httpd() {
 		if test -n "$LIB_HTTPD_SVN"
 		then
 			HTTPD_PARA="$HTTPD_PARA -DSVN"
-			rawsvnrepo="$HTTPD_ROOT_PATH/svnrepo"
-			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/svn"
+			LIB_HTTPD_SVNPATH="$rawsvnrepo"
+			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/"
+			svnrepo="$svnrepo$LIB_HTTPD_SVN"
+			export LIB_HTTPD_SVN LIB_HTTPD_SVNPATH
 		fi
 	fi
 }
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 018a83a..c3e6313 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -208,8 +208,8 @@ RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
 <IfDefine SVN>
 	LoadModule dav_svn_module modules/mod_dav_svn.so
 
-	<Location /svn>
+	<Location /${LIB_HTTPD_SVN}>
 		DAV svn
-		SVNPath svnrepo
+		SVNPath "${LIB_HTTPD_SVNPATH}"
 	</Location>
 </IfDefine>
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index a87d3d3..64bb495 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -8,9 +8,10 @@ test_description='git svn dcommit can commit renames of files with ugly names'
 . ./lib-git-svn.sh
 
 test_expect_success 'load repository with strange names' '
-	svnadmin load -q "$rawsvnrepo" < "$TEST_DIRECTORY"/t9115/funky-names.dump &&
-	start_httpd gtk+
-	'
+	svnadmin load -q "$rawsvnrepo" <"$TEST_DIRECTORY"/t9115/funky-names.dump
+'
+
+maybe_start_httpd gtk+
 
 test_expect_success 'init and fetch repository' '
 	git svn init "$svnrepo" &&
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index ecb1fed..41a0266 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup svnrepo' '
 			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/not-a@{0}reflog@" &&
-	start_httpd
+	maybe_start_httpd
 	'
 
 # SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index 59465b1..b28a174 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup svnrepo' '
 	svn_cmd cp -m "tag" "$svnrepo/pr ject/trunk" \
 	  "$svnrepo/pr ject/tags/v1" &&
 	rm -rf project &&
-	start_httpd
+	maybe_start_httpd
 '
 
 test_expect_success 'test clone with percent escapes' '
diff --git a/t/t9142-git-svn-shallow-clone.sh b/t/t9142-git-svn-shallow-clone.sh
index e21ee5f..9ee23be 100755
--- a/t/t9142-git-svn-shallow-clone.sh
+++ b/t/t9142-git-svn-shallow-clone.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup test repository' '
 		svn_cmd add foo &&
 		svn_cmd commit -m "add foo"
 	) &&
-	start_httpd
+	maybe_start_httpd
 '
 
 test_expect_success 'clone trunk with "-r HEAD"' '
-- 
EW

