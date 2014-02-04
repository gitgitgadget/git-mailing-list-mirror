From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 2/2] receive-pack: hint that the user can stop "git push" at auto gc time
Date: Tue,  4 Feb 2014 13:52:45 +0700
Message-ID: <1391496765-29564-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
 <1391496765-29564-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jugg@hotmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 07:53:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAZsw-0006yy-SS
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 07:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbaBDGxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 01:53:22 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58213 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaBDGxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 01:53:04 -0500
Received: by mail-pd0-f180.google.com with SMTP id x10so7876661pdj.11
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 22:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9J1SgjsuL1AvKzL6I0EISrvRqEllLvF8mTXd7FDezHM=;
        b=XTJhDPDuMeU1Ufa0xVlFAdAKGAX3NacBXPhsNsdzt6v9378FGjTd8xNEimmW4P7dQ9
         OAGs+8o5eAEJqDOoD70Wj8eBl6358x+TMEr+UY1zwKZJNYmSnXid0baCXGnj2UD1G+rv
         L+pkG/dZwSG+tLEpe4H+Lu3UDqqVSXjHI9L7aiEvq365MiBLlLZVHz3ncsCYadI36SfK
         UE1djB5Z1DaCSkx7hmOEV/t+kBBXGcetq9L2HcdVuXJQSpqYVn1+jVeQRbNBNOFlEgJZ
         dK6Fp7/vZn6RBn5SrHtgl1P7VchJe6vr/UQLnmceYkicmM6YkB0BXaBzX5fNJhDzBySV
         XJbg==
X-Received: by 10.68.245.200 with SMTP id xq8mr41796707pbc.21.1391496783559;
        Mon, 03 Feb 2014 22:53:03 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id rb6sm27161622pbb.41.2014.02.03.22.53.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 22:53:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Feb 2014 13:53:01 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391496765-29564-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241514>

Housekeeping jobs like auto gc generally should not get in the way.
Users who are pushing may not want to wait until auto gc is done on
the server. Give a hint for those users that it's safe now to break
"git push" and stop waiting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This bandage patch may be a good compromise between running auto gc
 and not annoying users much.
=20
 If I'm not mistaken, when ^C on "git push" this way, gc will still be
 running until it needs to print something out (which it should not
 normally because of --quiet). The user won't see gc errors, but the
 user generally can't do much anyway.

 builtin/gc.c           | 9 ++++++++-
 builtin/receive-pack.c | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..592271a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -253,6 +253,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	int auto_gc =3D 0;
 	int quiet =3D 0;
 	int force =3D 0;
+	int break_ok =3D 0;
 	const char *name;
 	pid_t pid;
=20
@@ -263,6 +264,8 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increas=
ed runtime)")),
 		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
+		OPT_HIDDEN_BOOL(0, "break-ok", &break_ok,
+				"hint that it is ok to stop the program"),
 		OPT_BOOL(0, "force", &force, N_("force running gc even if there may =
be another gc running")),
 		OPT_END()
 	};
@@ -301,7 +304,11 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		if (!quiet)
+		if (break_ok)
+			fprintf(stderr,
+				_("Auto packing the repository for optimum performance.\n"
+				  "It is safe to stop the program with Ctrl-C.\n"));
+		else if (!quiet)
 			fprintf(stderr,
 					_("Auto packing the repository for optimum performance. You may a=
lso\n"
 					"run \"git gc\" manually. See "
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 82e2f76..68d16e0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1212,7 +1212,7 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
 			update_server_info(0);
 		if (auto_gc) {
 			const char *argv_gc_auto[] =3D {
-				"gc", "--auto", "--quiet", NULL,
+				"gc", "--auto", "--quiet", "--break-ok", NULL,
 			};
 			int opt =3D RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
 			run_command_v_opt(argv_gc_auto, opt);
--=20
1.8.5.2.240.g8478abd
