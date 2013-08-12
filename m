From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4] push: respect --no-thin
Date: Mon, 12 Aug 2013 20:55:55 +0700
Message-ID: <1376315755-28930-1-git-send-email-pclouds@gmail.com>
References: <1376211178-17444-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 12 15:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8saq-0000Od-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 15:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab3HLNzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 09:55:21 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48914 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420Ab3HLNzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 09:55:17 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so7591537pad.33
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VCx2XvK1x6dTsNk6e7d8WAw/XNYr+UZ08uzcHziYwVM=;
        b=ESZ8WhORCiLvU3R7CLNq6cXRSECilYsC5DXDfxBf8CHwONiCMbVWAE6ekaZ5pwRd2z
         5R57ieqXYuebryICZdxFZZdUxEcWgI8oWSr1dUnx7bKUepYIQ8koPBoNTh1cnWRFUTr9
         zLi5kfKiDzZLoCD3rVdnII0FZu8WC8nV/CLE2RVzuGOo3kuT84WtYKQg9lssuuLEqMeN
         PlytySkPHP6sJgRauy/NUZmoFFcrL07OHWvZLY0Y7GQEoSXzhGucC8YJjrxys/Df9C0f
         fg5MsgUtv4dsVeGhgYZXTjA1wb9gkkuv8VBuq5/JH+s/aCDH9kdeuYGnTFnjXk51ob5T
         0g3Q==
X-Received: by 10.68.34.97 with SMTP id y1mr24602341pbi.198.1376315716759;
        Mon, 12 Aug 2013 06:55:16 -0700 (PDT)
Received: from lanh ([115.73.219.243])
        by mx.google.com with ESMTPSA id w8sm40232219paj.4.2013.08.12.06.55.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 06:55:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 12 Aug 2013 20:56:00 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1376211178-17444-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232193>

- From the beginning of push.c in 755225d, 2006-04-29, "thin" option
  was enabled by default but could be turned off with --no-thin.

- Then Shawn changed the default to 0 in favor of saving server
  resources in a4503a1, 2007-09-09. --no-thin worked great.

- One day later, in 9b28851 Daniel extracted some code from push.c to
  create transport.c. He (probably accidentally) flipped the default
  value from 0 to 1 in transport_get().

=46rom then on --no-thin is effectively no-op because git-push still
expects the default value to be false and only calls
transport_set_option() when "thin" variable in push.c is true (which
is unnecessary). Correct the code to respect --no-thin by calling
transport_set_option() in both cases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v4 elaborates a bit on the story of "thin" variable in push.c and
 renames receive-pack --no-thin to --reject-thin-pack-for-testing.

 builtin/push.c         |  5 ++---
 builtin/receive-pack.c |  8 +++++++-
 t/t5516-fetch-push.sh  | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

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
index e3eb5fc..fc6d53a 100644
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
+			if (!strcmp(arg, "--reject-thin-pack-for-testing")) {
+				fix_thin =3D 0;
+				continue;
+			}
=20
 			usage(receive_pack_usage);
 		}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4691d51..99c32d7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1172,4 +1172,21 @@ test_expect_success 'push --follow-tag only push=
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
+	rcvpck=3D"git receive-pack --reject-thin-pack-for-testing" &&
+	git push --no-thin --receive-pack=3D"$rcvpck" no-thin/.git refs/heads=
/master:refs/heads/foo
+'
+
 test_done
--=20
1.8.2.83.gc99314b
