From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 1/3] hash-object: support --stdin-paths with --no-filters
Date: Wed,  3 Mar 2010 21:10:21 +0100
Message-ID: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Cc: normalperson@yhbt.net, dpotapov@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmuud-0004JP-Aq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab0CCULP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:11:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:9882 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab0CCULN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:11:13 -0500
Received: by ey-out-2122.google.com with SMTP id 25so322778eya.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E4pF5tsKSsOv3dsddCkyIfbcHkk1P5cNA6+qpp21sXQ=;
        b=X2cI2IIy9qcd8J07wTEKD828TM33F8c8W2+GZkoQIGr/9MVhqqDBVtw4m6MJdUM/4F
         5MxO5klYolvMifilSJe/Y3oO32egYLu1/NAl0Z+t1nBlGJGzLy3zaUJs+cahHzlvVHjh
         Ch9kb9xDcysFXOBunW8sAJ8Bl2BoZTniZ6KXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uc6ZXQGOMdVb/BWbeo/ktJMBbZgcrfgh020JuphxJ38k8wZnA6JNOJbd1vz+jvLJtk
         F2/C5w+ulpx1B+3GaVuu9xet3DD9Vz+RovxqTnJniTb96lnkWdn0pMOU/6kgcIto2bD4
         6sViUp9h6Hb6/khSu4aSP3/q1QK5ZCnSa/9hs=
Received: by 10.213.24.28 with SMTP id t28mr2554153ebb.88.1267647071166;
        Wed, 03 Mar 2010 12:11:11 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 14sm4001510ewy.2.2010.03.03.12.11.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 12:11:10 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.141.gc5984a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141468>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Documentation/git-hash-object.txt |    2 +-
 builtin-hash-object.c             |    8 ++++----
 t/t1007-hash-object.sh            |   18 ++++++++++++++----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 479fce4..6904739 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
-'git hash-object' [-t <type>] [-w] --stdin-paths < <list-of-paths>
+'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
 
 DESCRIPTION
 -----------
diff --git a/builtin-hash-object.c b/builtin-hash-object.c
index 6a5f5b5..080af1a 100644
--- a/builtin-hash-object.c
+++ b/builtin-hash-object.c
@@ -33,6 +33,8 @@ static void hash_object(const char *path, const char *type, int write_object,
 	hash_fd(fd, type, write_object, vpath);
 }
 
+static int no_filters;
+
 static void hash_stdin_paths(const char *type, int write_objects)
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
@@ -44,7 +46,8 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type, write_objects, buf.buf);
+		hash_object(buf.buf, type, write_objects,
+		    no_filters ? NULL : buf.buf);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -60,7 +63,6 @@ static const char *type;
 static int write_object;
 static int hashstdin;
 static int stdin_paths;
-static int no_filters;
 static const char *vpath;
 
 static const struct option hash_object_options[] = {
@@ -100,8 +102,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			errstr = "Can't specify files with --stdin-paths";
 		else if (vpath)
 			errstr = "Can't use --stdin-paths with --path";
-		else if (no_filters)
-			errstr = "Can't use --stdin-paths with --no-filters";
 	}
 	else {
 		if (hashstdin > 1)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index fd98e44..dd32432 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -65,10 +65,6 @@ test_expect_success "Can't use --path with --stdin-paths" '
 	echo example | test_must_fail git hash-object --stdin-paths --path=foo
 '
 
-test_expect_success "Can't use --stdin-paths with --no-filters" '
-	echo example | test_must_fail git hash-object --stdin-paths --no-filters
-'
-
 test_expect_success "Can't use --path with --no-filters" '
 	test_must_fail git hash-object --no-filters --path=foo
 '
@@ -141,6 +137,20 @@ test_expect_success 'check that --no-filters option works' '
 	git config --unset core.autocrlf
 '
 
+test_expect_success 'check that --no-filters option works with --stdin-paths' '
+	echo fooQ | tr Q "\\015" >file0 &&
+	cp file0 file1 &&
+	echo "file0 -crlf" >.gitattributes &&
+	echo "file1 crlf" >>.gitattributes &&
+	git config core.autocrlf true &&
+	file0_sha=$(git hash-object file0) &&
+	file1_sha=$(git hash-object file1) &&
+	test "$file0_sha" != "$file1_sha" &&
+	nofilters_file1=$(echo "file1" | git hash-object --stdin-paths --no-filters) &&
+	test "$file0_sha" = "$nofilters_file1" &&
+	git config --unset core.autocrlf
+'
+
 pop_repo
 
 for args in "-w --stdin" "--stdin -w"; do
-- 
1.7.0.1.141.gc5984a
