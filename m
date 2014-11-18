From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/1] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Tue, 18 Nov 2014 14:50:24 +0100
Message-ID: <1416318624-23048-2-git-send-email-mhagger@alum.mit.edu>
References: <1416318624-23048-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 14:51:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqjBk-0001ad-BX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 14:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbaKRNvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 08:51:20 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51361 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbaKRNvU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 08:51:20 -0500
X-AuditID: 1207440f-f792a6d000001284-f8-546b4ecd90bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 25.1D.04740.DCE4B645; Tue, 18 Nov 2014 08:51:09 -0500 (EST)
Received: from michael.fritz.box (p5DDB3D42.dip0.t-ipconnect.de [93.219.61.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAIDoRUe004896
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 18 Nov 2014 08:51:07 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416318624-23048-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1D3rlx1icHOpqkXXlW4mi4beK8wW
	T+beZbZY+O8ou8X/HQtYLG6vmM9ssb8pyWJN9w4mizNvGhktOju+Mjpwefx9/4HJY+esu+we
	x461Mns8fNXF7nHxkrLH4gdeHp83yXncfraNxaN5ynnWAM4obpukxJKy4Mz0PH27BO6MOQdb
	mAoWClQ8uNPI3sDYz9vFyMkhIWAicXTbGlYIW0ziwr31bF2MXBxCApcZJU5duc4E4RxnkpjW
	sYYZpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbNAG7PEictHGUESwgIhEp+e9YM1sAioShxZdQOo
	iIODV8BFYu5OfxBTQkBOYus6b5AKTgFXiY9TLjOChIWAKro/qkxg5F3AyLCKUS4xpzRXNzcx
	M6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyRM+Xcwdq2XOcQowMGoxMObMDUrRIg1say4MvcQ
	oyQHk5Iob5BPdogQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5z3UDlvCmJlVWpRfkwKWkOFiVx
	XvUl6n5CAumJJanZqakFqUUwWRkODiUJ3vu+QEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JS
	ixJLSzLiQXERXwyMDJAUD9BeLmAyEOItLkjMBYpCtJ5iVJQS510EMlcAJJFRmgc3FpZ8XjGK
	A30pzPsOpIoHmLjgul8BDWYCGjxnQybI4JJEhJRUAyNjzdXLt119yu+/3ejWzHhj09ym//+X
	HLWx+d+b3eXNmXIy43BhmoHTkQgPFbX4K5qZAdM5Vi+/c1FlUpXL24urV3WE5vOY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since time immemorial, the test of whether to set "core.filemode" has
been done by trying to toggle the u+x bit on $GIT_DIR/config and then
testing whether the change "took". I find it somewhat odd to use the
config file for this test, but whatever.

The test code didn't set the u+x bit back to its original state
itself, instead relying on the subsequent call to git_config_set() to
re-write the config file with correct permissions.

But ever since

    daa22c6f8d config: preserve config file permissions on edits (2014-05-06)

git_config_set() copies the permissions from the old config file to
the new one. This is a good change in and of itself, but it interacts
badly with create_default_files()'s sloppiness, causing "git init" to
leave the executable bit set on $GIT_DIR/config.

So change create_default_files() to reset the permissions on
$GIT_DIR/config after its test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 3 ++-
 t/t0001-init.sh   | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 56f85e2..a6d58fd 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -254,7 +254,8 @@ static int create_default_files(const char *template_path)
 		struct stat st2;
 		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
-				st1.st_mode != st2.st_mode);
+				st1.st_mode != st2.st_mode &&
+				!chmod(path, st1.st_mode));
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e62c0ff..7de8d85 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -12,6 +12,13 @@ check_config () {
 		echo "expected a directory $1, a file $1/config and $1/refs"
 		return 1
 	fi
+
+	if test_have_prereq POSIXPERM && test -x "$1/config"
+	then
+		echo "$1/config is executable?"
+		return 1
+	fi
+
 	bare=$(cd "$1" && git config --bool core.bare)
 	worktree=$(cd "$1" && git config core.worktree) ||
 	worktree=unset
-- 
2.1.3
