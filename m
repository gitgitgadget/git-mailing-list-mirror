From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] ls-remote: fall-back to default remotes when no remote specified
Date: Thu,  8 Apr 2010 15:05:03 +0800
Message-ID: <1270710303-7828-1-git-send-email-rctay89@gmail.com>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzlns-0005wr-Re
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468Ab0DHHFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:05:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56445 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758430Ab0DHHFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:05:22 -0400
Received: by vws13 with SMTP id 13so929537vws.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 00:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o8fsTgJ7oK4V9u7u5BXM0hUl4eDeb+mDV0PAgIikVOY=;
        b=kfZp4oluEHhRhAYuU4hmacIfBcXYy0M13IcaVcZe2BbBWOx91wQJN9dpw6d/Am1Tdd
         Io6niWj8yNnj3hmsR5/isQLakal9JwxIj8UP2NtKAQwOT4nLJd9a7THrxyPHpuc7eQpH
         DR054ryfjMFxZKXQtIbRXWB1Sdn9CpHMG/q7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VoCiDA9Afp+yPRLQdb5RtQGr2i99TZSrJlMgy5Vn9F2WBdsJ0yZtNOpHk+Zl0iiRuD
         /1NUPDkNCIrTFAzaWXd3JXaFNPpUk/Idpe604J6c24jvmka3r1oTfHjzJ387+JyqXoNn
         ct78qG3+2XIIv20Mh1+xZJ1d/pSVjP7uVzU/Q=
Received: by 10.220.126.166 with SMTP id c38mr5015671vcs.169.1270710320934;
        Thu, 08 Apr 2010 00:05:20 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 28sm47852662vws.6.2010.04.08.00.05.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 00:05:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144335>

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
 t/t5512-ls-remote.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

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
index 1dd8eed..34dca0f 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -49,4 +49,36 @@ test_expect_success 'ls-remote self' '
 
 '
 
+cat >exp <<EOF
+fatal: Where do you want to list from today?
+EOF
+test_expect_success 'dies with message when no remote specified and no default remote found' '
+
+	test_must_fail git ls-remote >actual 2>&1 &&
+	test_cmp exp actual
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
+	# over "origin".
+	#
+	git remote rm origin &&
+	git config branch.master.remote self &&
+	git ls-remote >actual &&
+	test_cmp expected.all actual
+
+'
+
 test_done
-- 
1.7.0.97.g1372c
