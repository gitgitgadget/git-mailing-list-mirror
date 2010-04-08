From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3] ls-remote: fall-back to default remotes when no remote specified
Date: Fri,  9 Apr 2010 01:21:13 +0800
Message-ID: <1270747273-1504-1-git-send-email-rctay89@gmail.com>
References: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 19:21:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzvQ7-00063M-TS
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 19:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab0DHRVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 13:21:30 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62390 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0DHRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 13:21:29 -0400
Received: by bwz1 with SMTP id 1so1966336bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6GVmWW20wViXB3WkL8aRt5hAFGl//DSeFruXvQayb0c=;
        b=CmKGpit9UxOKOnvNFYMEbYllfa7nkdm3gQU+KQn7HacPCynCaZ4o1VBXleCZexk4oT
         VR0qmvAhaS9JCG9Zeyhf/bMiDIy8Rx9zbxwuhc1LXNamm3SSmX+fysyl6XXF5Qw//O3k
         aDU/pWhgI+GAH8TyMwam1i/Cnewv4xBxhomQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HS2ttvFdB59Th9eE2HWuSg9eH+1lYvjaY0pjm8dlUkpbJ1HBhyhPmgAa0RT7ea5QWO
         Bz/X/VvK6Qh4ACqPTftd1V/fDP+mwWLBS5Pu4kdK4+gsAHgM9xuD7I6+HW7ITjciz1cg
         oaKCzF2zqNR/yBujBfCCdW6w7WMnJ0KTqISG8=
Received: by 10.204.32.77 with SMTP id b13mr477231bkd.113.1270747286580;
        Thu, 08 Apr 2010 10:21:26 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id d5sm1998102bkd.19.2010.04.08.10.21.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 10:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144366>

Instead of breaking execution when no remote (as specified in the
variable dest) is specified when git-ls-remote is invoked, continue on
and let remote_get() handle it.

This way, we are able to use the default remotes (eg. "origin",
branch.<name>.remote), as git-fetch, git-push, and other users of
remote_get(), do.

If no suitable remote is found, exit with a message describing the
issue, instead of just the usage text, as we do previously.

Add several tests to check that git-ls-remote handles the
no-remote-specified situation.

Also add a test that "git ls-remote <pattern>" does not work; we are
unable to guess the remote in that situation, as are git-fetch and
git-push.

In that test, we are testing for messages coming from two separate
processes, but we should be OK, because the second message is triggered
by closing the fd which must happen after the first message is printed.
(analysis by Jeff King.)

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/ls-remote.c  |   11 ++++++---
 t/t5512-ls-remote.sh |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 70f5622..6c738c9 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -4,7 +4,8 @@
 #include "remote.h"
 
 static const char ls_remote_usage[] =
-"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>] <repository> <refs>...";
+       "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
+"                     [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -73,9 +74,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!dest)
-		usage(ls_remote_usage);
-
 	if (argv[i]) {
 		int j;
 		pattern = xcalloc(sizeof(const char *), argc - i + 1);
@@ -87,6 +85,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		}
 	}
 	remote = remote_get(dest);
+	if (!remote) {
+		if (dest)
+			die("bad repository '%s'", dest);
+		die("No remote configured to list refs from.");
+	}
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
 	transport = transport_get(remote, NULL);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 1dd8eed..3cf1b3d 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -49,4 +49,62 @@ test_expect_success 'ls-remote self' '
 
 '
 
+test_expect_success 'dies when no remote specified and no default remotes found' '
+
+	test_must_fail git ls-remote
+
+'
+
+test_expect_success 'use "origin" when no remote specified' '
+
+	git remote add origin "$(pwd)/.git" &&
+	git ls-remote >actual &&
+	test_cmp expected.all actual
+
+'
+
+test_expect_success 'use branch.<name>.remote if possible' '
+
+	#
+	# Test that we are indeed using branch.<name>.remote, not "origin", even
+	# though the "origin" remote has been set.
+	#
+
+	# setup a new remote to differentiate from "origin"
+	git clone . other.git &&
+	(
+		cd other.git &&
+		echo "$(git rev-parse HEAD)	HEAD"
+		git show-ref	| sed -e "s/ /	/"
+	) >exp &&
+
+	git remote add other other.git &&
+	git config branch.master.remote other &&
+
+	git ls-remote >actual &&
+	test_cmp exp actual
+
+'
+
+cat >exp <<EOF
+fatal: 'refs*master' does not appear to be a git repository
+fatal: The remote end hung up unexpectedly
+EOF
+test_expect_success 'confuses pattern as remote when no remote specified' '
+	#
+	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
+	# confuses <pattern> for <remote>. Although ugly, this behaviour is akin
+	# to the confusion of refspecs for remotes by git-fetch and git-push,
+	# eg:
+	#
+	#   $ git fetch branch
+	#
+
+	# We could just as easily have used "master"; the "*" emphasizes its
+	# role as a pattern.
+	test_must_fail git ls-remote refs*master >actual 2>&1 &&
+	test_cmp exp actual
+
+'
+
 test_done
-- 
1.7.0.97.g1372c
