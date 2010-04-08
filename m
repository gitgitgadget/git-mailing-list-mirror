From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 (resend)] ls-remote: fall-back to default remotes when no remote specified
Date: Thu,  8 Apr 2010 15:07:07 +0800
Message-ID: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzlpn-0006lv-QI
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab0DHHHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:07:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:10264 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0DHHHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:07:21 -0400
Received: by qw-out-2122.google.com with SMTP id 8so691792qwh.37
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yYHclTRM0z/HULjJ8d5BRJCVolNUOk/yWSGpRl9ufPs=;
        b=rmN6f11hRmamPeqhcuw1eawhOJQVoXM2uv5k25wlbAUdR+kpvcCvgLAX8yMS0qqNF/
         jyvdiT3S6E8LijFZmFo4dLLEbxEZNOHZjIUvBXpxUBFffvhdShKpRXw2ehpOvYkQDAiQ
         eTTskMrh/C+68fj9eFgL7vNvw4IqK1G2+B35U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l4NiXfYarHWzdb2uW9yDZuWJ5jKjW7yJfaiUwoxUQTJsGzsEzb4Plbnl29gYYwJf9R
         NZB1luOISck7KUAB617zTBP1/S9wIB8zbfyNugn+3BQG8KZZ/B2f9BrCyxoFricdzeGr
         6nsRzYSPh7cFgb+mqXaZPXkEYwICUjcNSTeTU=
Received: by 10.229.189.212 with SMTP id df20mr195097qcb.21.1270710440693;
        Thu, 08 Apr 2010 00:07:20 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id y41sm8946328qce.11.2010.04.08.00.07.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 00:07:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144337>

Instead of breaking execution when no remote (as specified in the
variable dest) is specified when git-ls-remote is invoked, continue on
and let remote_get() handle it; if no suitable remote was found, then
exit with the usage text, as we do previously.

That way, we are able to use the default remotes (eg. "origin",
branch.<name>.remote), as git-fetch, git-push, and other users of
remote_get(), do.

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
 builtin/ls-remote.c  |    5 ++---
 t/t5512-ls-remote.sh |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 70f5622..efde78b 100644
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
+		usage(ls_remote_usage);
 	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
 	transport = transport_get(remote, NULL);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 1dd8eed..341c79b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -49,4 +49,53 @@ test_expect_success 'ls-remote self' '
 
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
+	# Remove "origin" so that we know that ls-remote is not using it.
+	#
+	# Ideally, we should test that branch.<name>.remote takes precedence
+	# over "origin", but that is another matter altogether.
+	#
+	git remote rm origin &&
+	git config branch.master.remote self &&
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
