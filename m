From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] ls-remote: print URL when no repo is specified
Date: Sun,  9 May 2010 22:42:20 +0800
Message-ID: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 09 16:44:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB7jm-0000t5-8q
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 16:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab0EIOmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 10:42:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48882 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0EIOmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 10:42:39 -0400
Received: by pva18 with SMTP id 18so1268544pva.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FshrWgrFdZTr4YCKtORsltAExFzdP81hhCamNDxGO/E=;
        b=itkhnB0DTgWvjR8aOCtL9wI/Is/DKDqUTI7JgHSTZKXD4asn0hxruybpv7lRnzUmyu
         Il1AfnBwxIWlyOZaw2Qe6IcmQZt43YFQYsEE5mZu3cvHWLJz23B9xEvwSjE8c4mxFk5x
         MTN17oE81c35f2GP/rSezWMrbH0KUgDMzTEoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RabhQEQgTZBZQYg87V0GAOzi3SKrzYh5noLY5EiqHA8nlVB3IpsiuDw8KrGExgph7j
         liieMPNMOche8rChixfdwJgW6yD5seXEkwoYZNSNelwcaoDBI0+v7Y8Azicq4yFD+/Vp
         L1tyeN86ppTSzbIc8/7t6N29e2ilckoPbJsBs=
Received: by 10.115.86.38 with SMTP id o38mr2088282wal.170.1273416158282;
        Sun, 09 May 2010 07:42:38 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id c22sm20533881wam.6.2010.05.09.07.42.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 07:42:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146726>

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

  This is a logical follow-up to the "optional repo" form of ls-remote
  feature. Myself, I was using the "no-repo" form of ls-remote and
  sometimes wondered where it was listing remotes from.

  Johnathan, do you think the tests involved might have any cross-
  platform issues?

 builtin/ls-remote.c  |   10 +++++++++-
 t/t5512-ls-remote.sh |   19 +++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

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
index 3cf1b3d..8508df8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -57,12 +57,21 @@ test_expect_success 'dies when no remote specified and no default remotes found'

 test_expect_success 'use "origin" when no remote specified' '

-	git remote add origin "$(pwd)/.git" &&
-	git ls-remote >actual &&
+	URL="$(pwd)/.git" &&
+	git remote add origin "$URL" &&
+	git ls-remote 2>actual_err >actual &&
+	grep "From $URL" actual_err &&
 	test_cmp expected.all actual

 '

+test_expect_success 'suppress "From <url>" with -q' '
+
+	git ls-remote -q 2>actual_err &&
+	test_must_fail grep "From $URL" actual_err
+
+'
+
 test_expect_success 'use branch.<name>.remote if possible' '

 	#
@@ -78,10 +87,12 @@ test_expect_success 'use branch.<name>.remote if possible' '
 		git show-ref	| sed -e "s/ /	/"
 	) >exp &&

-	git remote add other other.git &&
+	URL="other.git" &&
+	git remote add other $URL &&
 	git config branch.master.remote other &&

-	git ls-remote >actual &&
+	git ls-remote 2>actual_err >actual &&
+	grep "From $URL" actual_err &&
 	test_cmp exp actual

 '
--
1.7.1.189.g07419
