From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] verify-tag: allow to verify signed blob objects
Date: Wed, 15 Jun 2016 13:51:54 +0200
Message-ID: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 13:52:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD9MX-000304-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 13:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbcFOLv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 07:51:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54932 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752958AbcFOLv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 07:51:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C0DDD21C9F;
	Wed, 15 Jun 2016 07:51:55 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 15 Jun 2016 07:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=Vo1UuWQGW/Mrk/Jd2VC+6d9PogY=; b=JjdsKo4PLkANdvlVVi13GM67I6W/
	TuXXncOISx12TRmxQirpbL9mpG+MOv3I7uNBspqiCU4R3Vzu7C2kglOwvzYZQCJ/
	D4VKrrjPIGHjie0EEglLYWi58+Bgc3YkfZvapkghfizFbXeobIQs/B3/KIUuZh4J
	4ZnjGUIAWZX9N+g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Vo1UuWQGW/Mrk/Jd2VC+6d9Pog
	Y=; b=NtzoEnoMRu2Q59I6Zaou/oqldqtBfvJyMhSt9wsNlkycEU44CV8XscjjEd
	oVGAv4oSS7DkiQBFmT4aICbhM+PiuoHb18JZPN2xrK+OJmDJaRyKefJmy44Egws8
	PdApKw9X1jAR0PveQk93sBBLIzj3eMNLNVCekmqtEl/OF9f0c=
X-Sasl-enc: cClVYYLtOY9jgVOgSsjrCEdyyCYaSL5Tu0Myzhq/8N9E 1465991515
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3E252CCDA6;
	Wed, 15 Jun 2016 07:51:55 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.382.g87fd384
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297366>

Currently, there is no easy way to verify push certificates. They have
the same structure as signed tags: "attached detached signatures", that
is: the concatenation of the signed material and its detached signature.

Introduce a `--blob` option to verify-tag so that it allows to verify
tags and blobs.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The first outcome of my long announced project to describe our signature
formats in Documentation/technical.... (progress underway)

In fact, that whole area is in need of refactoring: gpg related bits are
all over the place, including tag.c. The proposed patch neither improves
nor worsens the situation in that respect. But, since we make it
unnecessarily hard to verify signatures (git cat-file | gpg --verify fails)
it's only fair to provide a tool for pre-receive hook writers.

 Documentation/git-verify-tag.txt | 4 ++++
 builtin/verify-tag.c             | 1 +
 gpg-interface.h                  | 1 +
 t/t5534-push-signed.sh           | 3 ++-
 tag.c                            | 2 +-
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index d590edc..2e5cf4d 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -20,6 +20,10 @@ OPTIONS
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
+--blob::
+	Allow to verify signed blob objects (in addition to tag objects), such as the
+	objects containing a push certificate.
+
 -v::
 --verbose::
 	Print the contents of the tag object before validating it.
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 99f8148..19d26b0 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -33,6 +33,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
+		OPT_BIT(0, "blob", &flags, N_("allow to verify blob objects"), GPG_VERIFY_BLOB),
 		OPT_END()
 	};
 
diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..a3cbfc3 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_BLOB		4
 
 struct signature_check {
 	char *payload;
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index ecb8d44..de4d38b 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -94,7 +94,8 @@ test_expect_success GPG 'signed push sends push certificate' '
 	# record the push certificate
 	if test -n "${GIT_PUSH_CERT-}"
 	then
-		git cat-file blob $GIT_PUSH_CERT >../push-cert
+		git cat-file blob $GIT_PUSH_CERT >../push-cert &&
+		git verify-tag --blob $GIT_PUSH_CERT
 	fi &&
 
 	cat >../push-cert-status <<E_O_F
diff --git a/tag.c b/tag.c
index d1dcd18..d5f090b 100644
--- a/tag.c
+++ b/tag.c
@@ -39,7 +39,7 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
 	int ret;
 
 	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
+	if ((type != OBJ_TAG) && ((type != OBJ_BLOB) || !(flags & GPG_VERIFY_BLOB)))
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
 				name_to_report :
-- 
2.9.0.382.g87fd384
