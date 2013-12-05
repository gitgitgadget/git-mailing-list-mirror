From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t5551: test fetch.c:backfill_tags() code
Date: Thu,  5 Dec 2013 10:34:00 +0700
Message-ID: <1386214440-16560-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 04:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoPcy-0001Zx-1f
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 04:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab3LED3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 22:29:20 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39183 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab3LED3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 22:29:19 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so24921314pbc.35
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 19:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=eI3KM/7jME3lObw/RTxnjh5YfDTmWPKn7us5fQke1ds=;
        b=TG4YYiEdWjKE3o5nM6QSIMeQwYBJhB8l5k5ZksWNVxjqzjjM4pxpFZ21f/KazT/L+O
         CknVSWEHrsetusTTvax27ZnyCS6m3Rav5OTfyFuUl16y7RDdOQZ/IrqI4OFwZ+x+/RpG
         kLitopjzyXWHcuG5KwBtQwDGrtJHE4zmk16oklQ5BCgwnH6F94ZMYInbez3T1ziv8p/+
         euA/PVQ9lVbKrjtQ42loMETMQ0gx8Iw3mOnqEm5WCbf/R4XRKzHKp+vbkx/tRGHdd+2D
         LqHrsrL+FCdhasusde6sCRJPfqk8LcNwrZGVRjSf7L8lTwAAAOZpgnRpze/acqN2FXod
         dHPg==
X-Received: by 10.68.136.34 with SMTP id px2mr49175352pbb.113.1386214157933;
        Wed, 04 Dec 2013 19:29:17 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id oj6sm162330276pab.9.2013.12.04.19.29.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 19:29:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 10:34:01 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238842>

This makes sure the second fetch with transport helper code path is
exercised in the test suite.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This should catch the problem by aa/transport-non-positive-depth-only.
 The GIT_TEST_BACKFILL_TAGS is bad but I don't know any sure way to
 verify it, assuming the shallow code may change in future and stop
 triggering backfill_tags().

 builtin/fetch.c       |  2 ++
 t/t5551-http-fetch.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5647055..2496ad2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -750,6 +750,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
=20
 static void backfill_tags(struct transport *transport, struct ref *ref=
_map)
 {
+	if (getenv("GIT_TEST_BACKFILL_TAGS"))
+		fprintf(stderr, "backfill_tags executed\n");
 	if (transport->cannot_reuse) {
 		gsecondary =3D prepare_transport(transport->remote);
 		transport =3D gsecondary;
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 1b71bb5..7eeb043 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -181,6 +181,22 @@ test_expect_success 'create namespaced refs' '
 		symbolic-ref refs/namespaces/ns/HEAD refs/namespaces/ns/refs/heads/m=
aster
 '
=20
+test_expect_success 'trigger backfill_tags() over smart-http' '
+	git tag -m two tag-two &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git push public master tag-two &&
+	git rev-parse master tag-two >expected &&
+	(
+	git init shallow &&
+	cd shallow &&
+	GIT_TEST_BACKFILL_TAGS=3D1 git fetch --depth=3D2 $HTTPD_URL/smart/rep=
o.git master:foo 2>err &&
+	grep "backfill_tags executed" err &&
+	git rev-parse foo tag-two >../actual
+	) &&
+	test_cmp expected actual
+'
+
 test_expect_success 'smart clone respects namespace' '
 	git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
 	echo namespaced >expect &&
--=20
1.8.5.1.25.g8667982
