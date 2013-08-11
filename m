From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] push: respect --no-thin
Date: Sun, 11 Aug 2013 15:52:58 +0700
Message-ID: <1376211178-17444-1-git-send-email-pclouds@gmail.com>
References: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 11 10:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8RNw-0002x0-GX
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 10:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab3HKIwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 04:52:20 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55397 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab3HKIwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 04:52:19 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so5808156pbc.8
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/CzjbAVXQQN915tFAjQmkNfEEvoOTeC8Q158GJydiew=;
        b=urKGEdLcsjpChFStU1GtCmPeU2fJTCGCSZP9i8bhMsxzWOB5j7FUDRTQFFcDQYxmRO
         Kh4kBuo503KUe8Of4BeBwkfdBdq3c4zjg1EmzcDuTcnO3yuprgB8iIIIc95goQSsoqoO
         PVG+JFtS6y1KwpgbADtEaSQMJ48iDpqbZLV4Xf+pjcsImQ57Y/YmuCe2OTKu6toG/MzE
         1sTIQ86qj93Nq9xZtbv01uOaS8WXstSpqmRhnuJ3Odfc4K6Chf0/VzpZEXW990hPEVFi
         +NjEB/m2hgcxmeWWhMK3IgvJFgqNriOEsQCEaS8jUZznxay46oIlIiDGEBes5PbdOxKC
         GU7Q==
X-Received: by 10.68.211.194 with SMTP id ne2mr19509142pbc.40.1376211138526;
        Sun, 11 Aug 2013 01:52:18 -0700 (PDT)
Received: from lanh ([115.73.219.243])
        by mx.google.com with ESMTPSA id kd1sm32835462pab.20.2013.08.11.01.52.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 01:52:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 11 Aug 2013 15:53:01 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232129>

Over the time the default value for --thin has been switched between
on and off. As of now it's always on, even if --no-thin is given.
Correct the code to respect --no-thin.

receive-pack learns about --no-thin only for testing purposes, hence
no document update.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v3 gets rid of seq in the test.

 builtin/push.c         |  5 ++---
 builtin/receive-pack.c |  8 +++++++-
 t/t5516-fetch-push.sh  | 16 ++++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 04f0eaf..333a1fb 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -15,7 +15,7 @@ static const char * const push_usage[] =3D {
 	NULL,
 };
=20
-static int thin;
+static int thin =3D 1;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
@@ -313,8 +313,7 @@ static int push_with_options(struct transport *tran=
sport, int flags)
 	if (receivepack)
 		transport_set_option(transport,
 				     TRANS_OPT_RECEIVEPACK, receivepack);
-	if (thin)
-		transport_set_option(transport, TRANS_OPT_THIN, "yes");
+	transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
=20
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..da60817 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -38,6 +38,7 @@ static int quiet;
 static int prefer_ofs_delta =3D 1;
 static int auto_update_server_info;
 static int auto_gc =3D 1;
+static int fix_thin =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
@@ -869,7 +870,8 @@ static const char *unpack(int err_fd)
 		keeper[i++] =3D "--stdin";
 		if (fsck_objects)
 			keeper[i++] =3D "--strict";
-		keeper[i++] =3D "--fix-thin";
+		if (fix_thin)
+			keeper[i++] =3D "--fix-thin";
 		keeper[i++] =3D hdr_arg;
 		keeper[i++] =3D keep_arg;
 		keeper[i++] =3D NULL;
@@ -975,6 +977,10 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 				stateless_rpc =3D 1;
 				continue;
 			}
+			if (!strcmp(arg, "--no-thin")) {
+				fix_thin =3D 0;
+				continue;
+			}
=20
 			usage(receive_pack_usage);
 		}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4691d51..3cfd1cd 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1172,4 +1172,20 @@ test_expect_success 'push --follow-tag only push=
es relevant tags' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'push --no-thin must produce non-thin pack' '
+	cat >>path1 <<\EOF &&
+keep base version of path1 big enough, compared to the new changes
+later, in order to pass size heuristics in
+builtin/pack-objects.c:try_delta()
+EOF
+	git commit -am initial &&
+	git init no-thin &&
+	git --git-dir=3Dno-thin/.git config receive.unpacklimit 0 &&
+	git push no-thin/.git refs/heads/master:refs/heads/foo &&
+	echo modified >> path1 &&
+	git commit -am modified &&
+	git repack -adf &&
+	git push --no-thin --receive-pack=3D"git receive-pack --no-thin" no-t=
hin/.git refs/heads/master:refs/heads/foo
+'
+
 test_done
--=20
1.8.2.83.gc99314b
