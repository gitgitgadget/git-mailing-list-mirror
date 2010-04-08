From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu,  8 Apr 2010 11:58:03 +0800
Message-ID: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 05:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzitb-0008Gs-Pm
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 05:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab0DHD7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 23:59:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:63022 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0DHD7B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 23:59:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so650613qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BM6nu6MYFbPClDBe9SKQAVfT7+P91cfh/Yn0VdCw+oQ=;
        b=iqJPplNkm3o1B4Actn4DzTh7NNM7PtKgr20a02K0daYgAXo4seCuf1tTF0sQM7JP/8
         7USjhcOhaUzeySROxPoboykfSDLVmHcrraEW0Mws3TjU5HumnYm2G5jEpoy8JQS/bdAU
         SKkquTcnVLla4xXokzV1gV2PZoF8k/J8lvOCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M3j48ZlMG+UFFt/+K0e+4Be8fXHAdu4e3SHlA77ROE5t/XIJfr6jxjbSw6DM5uF5/w
         yLbb8u34ej4oKjdpSAO7yCsFg2EmLsN9X/wfL5eJTIaQWFpC+0+2BDQlZ0rU3JRyz6BT
         TnFPrZIR6NiS42MQZX/5WS7G5rp4BTHAQs+bY=
Received: by 10.229.217.206 with SMTP id hn14mr826969qcb.70.1270699140734;
        Wed, 07 Apr 2010 20:59:00 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id f5sm8768815qcg.20.2010.04.07.20.58.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 20:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144309>

Instead of breaking execution when no remote (as specified in the
variable dest) is specified when git-ls-remote is invoked, continue on
and let remote_get() handle it.

That way, we are able to use the default remote (by default, "origin"),
as git-fetch, git-push, and others, do.

While we're at it, die with a more interesting message ("Where do you
want to..."), as git-fetch does, instead of the plain usage help.

Add several tests to check that git-ls-remote handles the
no-remote-specified situation.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/ls-remote.c  |    5 ++---
 t/t5512-ls-remote.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 70f5622..dfada83 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -73,9 +73,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!dest)
-		usage(ls_remote_usage);
-
 	if (argv[i]) {
 		int j;
 		pattern = xcalloc(sizeof(const char *), argc - i + 1);
@@ -87,6 +84,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 	remote = remote_get(dest);
+	if (!remote)
+		die("Where do you want to list from today?");
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
 	transport = transport_get(remote, NULL);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 1dd8eed..e19429b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -49,4 +49,41 @@ test_expect_success 'ls-remote self' '
 
 '
 
+cat >exp <<EOF
+fatal: Where do you want to list from today?
+EOF
+test_expect_success 'dies with message when no remote specified and no default remote found' '
+
+	!(git ls-remote >actual 2>&1) &&
+	test_cmp exp actual
+
+'
+
+test_expect_success 'defaults to "origin" when no remote specified' '
+
+	git remote add origin "$(pwd)/.git"
+	git ls-remote >actual &&
+	test_cmp expected.all actual
+
+'
+
+cat >exp <<EOF
+fatal: 'refs*master' does not appear to be a git repository
+fatal: The remote end hung up unexpectedly
+EOF
+test_expect_success 'confuses pattern as remote when no remote specified' '
+	#
+	# Although ugly, this behaviour is akin to the confusion of refspecs for
+	# remotes by git-fetch and git-push, eg:
+	#
+	#   $ git fetch branch
+	#
+
+	# We could just as easily have used "master"; the "*" emphasizes its
+	# role as a pattern.
+	!(git ls-remote refs*master >actual 2>&1) &&
+	test_cmp exp actual
+
+'
+
 test_done
-- 
1.7.0.97.g1372c
