From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] receive-pack: update $GIT_DIR/info before auto garbage collection
Date: Tue,  4 Feb 2014 13:52:44 +0700
Message-ID: <1391496765-29564-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jugg@hotmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 07:53:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAZsp-0006uk-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 07:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbaBDGw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 01:52:58 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56808 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaBDGw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 01:52:57 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so7779752pde.6
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 22:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kZitfsStXunssOSTtqv0knTTCtxw6L8B1OFvy0PzNCc=;
        b=A4C+9fAvbE0RiqOj6Y2uWR882fEFUex6kae3pYLkoSuTuY7ppkXKxHKR/YB77SxhzV
         DKKRUvAJ5fCefq/RpvRVDame55nVHvUsYl5z1ThLdTLTtyVuiEhWWDseykejEfrgcukf
         Go/A0S4l2ZAwTo/dTOSPF7ajY0IHhxYC5hwfsLbVhA9w62zYP2U/PZgOXtrdOOy2dta4
         BcqNVzdHJZAexJsgHMbJ374426EtnxmG6G4gL0FyRmDZdgk/Pi7ddH/lk48Lg/HGVpvA
         t1Mrtk6OQYbfo9Le3Zw2WfPf4tDYVfKjStpyayzX3M8fpxgMNgfJkIlgfi2kTZ+z/BXX
         UOZQ==
X-Received: by 10.68.133.163 with SMTP id pd3mr7407263pbb.166.1391496776765;
        Mon, 03 Feb 2014 22:52:56 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id n6sm36424681pbj.22.2014.02.03.22.52.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 22:52:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Feb 2014 13:52:53 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CACsJy8B0WKfxSYBSgRZQYz6_h+S9pGd03A=rrWM0_twRdKvyZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241513>

Auto gc could take a long time, and it's optional. "git push" user
should be allowed to stop the program if they don't want to wait. Move
server update step before auto gc. So we're ready to die any time
since auto gc is kicked off.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..82e2f76 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1208,6 +1208,8 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
 			report(commands, unpack_status);
 		run_receive_hook(commands, "post-receive", 1);
 		run_update_post_hook(commands);
+		if (auto_update_server_info)
+			update_server_info(0);
 		if (auto_gc) {
 			const char *argv_gc_auto[] =3D {
 				"gc", "--auto", "--quiet", NULL,
@@ -1215,8 +1217,6 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
 			int opt =3D RUN_GIT_CMD | RUN_COMMAND_STDOUT_TO_STDERR;
 			run_command_v_opt(argv_gc_auto, opt);
 		}
-		if (auto_update_server_info)
-			update_server_info(0);
 		clear_shallow_info(&si);
 	}
 	if (use_sideband)
--=20
1.8.5.2.240.g8478abd
