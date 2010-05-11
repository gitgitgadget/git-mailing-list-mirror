From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Wed, 12 May 2010 01:20:23 +0800
Message-ID: <1273598423-3156-1-git-send-email-rctay89@gmail.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 11 19:28:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBtGE-0002n1-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 19:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0EKR2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 13:28:42 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:64532 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab0EKR2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 13:28:41 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2010 13:28:41 EDT
Received: by ewy8 with SMTP id 8so1441243ewy.28
        for <git@vger.kernel.org>; Tue, 11 May 2010 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M5sviQl02HMy4Fb3AduNnI3jwnQCTl+vSRF8RfP82x4=;
        b=xZNU6/5sMliGFJuGbHivZK1MpoOd3S/FBiRGz7ju2qua3lMi+tGrC5fPUFk5cLdPcc
         htmshCpZcvHu93pS6NGEf3QeWuf7UrFX/Q9nnH7afHapZLOl2fLxsZFl5rDP+fqCzD81
         g+BAHmDsOq1tqvfFEBtzat1KfaYpzaK9H/ccI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XPPTlK3cW8UZRauMY0RL71V3s1XhA4kRjSGsHm8pv6SF3o80WlVvjkU6OK0qT4L4hR
         RhxHuB1NnJTO2rTP8o4ksDGthZOG9sQjRqyKCQmJFEZVaOK/6RX810ub7jGHYdECiXmJ
         wEYixv9tH9Ne7TPn/Gsno8f0GqPC/U4unB9wc=
Received: by 10.213.91.76 with SMTP id l12mr2599020ebm.47.1273598454782;
        Tue, 11 May 2010 10:20:54 -0700 (PDT)
Received: from localhost.localdomain (cm37.zeta153.maxonline.com.sg [116.87.153.37])
        by mx.google.com with ESMTPS id 16sm3265950ewy.3.2010.05.11.10.20.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 10:20:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146902>

After 9c00de5 (ls-remote: fall-back to default remotes when no remote
specified), when no repository is specified, ls-remote may use
the URL/remote in the config "branch.<name>.remote" or the remote
"origin"; it may not be immediately obvious to the user which was used.

In such cases, print a simple "From <URL>" line to indicate which
repository was used. This message is similar to git-fetch's, and is
printed to stderr to avoid breaking existing scripts that depend on
ls-remote's output behaviour.

It can also be disabled with -q/--quiet.

Modify tests related to falling back on default remotes to check for
this as well, and add a test to check for suppression of the message.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  The sole difference from the previous patch is the use of test_cmp
  instead of grep in the tests.

 builtin/ls-remote.c  |   10 +++++++++-
 t/t5512-ls-remote.sh |   24 ++++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 8ee91eb..34480cf 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@

 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [<repository> [<refs>...]]";
+"                     [-q|--quiet] [<repository> [<refs>...]]";

 /*
  * Is there one among the list of patterns that match the tail part
@@ -34,6 +34,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	const char *dest = NULL;
 	int nongit;
 	unsigned flags = 0;
+	int quiet = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;

@@ -67,6 +68,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				flags |= REF_NORMAL;
 				continue;
 			}
+			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
+				quiet = 1;
+				continue;
+			}
 			usage(ls_remote_usage);
 		}
 		dest = arg;
@@ -99,6 +104,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	ref = transport_get_remote_refs(transport);
 	if (transport_disconnect(transport))
 		return 1;
+
+	if (!dest && !quiet)
+		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
 		if (!check_ref_type(ref, flags))
 			continue;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 3cf1b3d..d191235 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -57,12 +57,24 @@ test_expect_success 'dies when no remote specified and no default remotes found'

 test_expect_success 'use "origin" when no remote specified' '

-	git remote add origin "$(pwd)/.git" &&
-	git ls-remote >actual &&
+	URL="$(pwd)/.git" &&
+	echo "From $URL" >exp_err &&
+
+	git remote add origin "$URL" &&
+	git ls-remote 2>actual_err >actual &&
+
+	test_cmp exp_err actual_err &&
 	test_cmp expected.all actual

 '

+test_expect_success 'suppress "From <url>" with -q' '
+
+	git ls-remote -q 2>actual_err &&
+	test_must_fail test_cmp exp_err actual_err
+
+'
+
 test_expect_success 'use branch.<name>.remote if possible' '

 	#
@@ -78,10 +90,14 @@ test_expect_success 'use branch.<name>.remote if possible' '
 		git show-ref	| sed -e "s/ /	/"
 	) >exp &&

-	git remote add other other.git &&
+	URL="other.git" &&
+	echo "From $URL" >exp_err &&
+
+	git remote add other $URL &&
 	git config branch.master.remote other &&

-	git ls-remote >actual &&
+	git ls-remote 2>actual_err >actual &&
+	test_cmp exp_err actual_err &&
 	test_cmp exp actual

 '
--
1.7.1.189.g07419
