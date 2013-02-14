From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] clone: suggest index version 4 when the index is bigger than 512 KiB
Date: Thu, 14 Feb 2013 20:34:03 +0700
Message-ID: <1360848843-12092-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 14:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ywY-0004Eo-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 14:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934545Ab3BNNdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 08:33:19 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:34865 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079Ab3BNNdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 08:33:18 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1088449dak.34
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=6zFq9voiMvPtj2UCvolMT9U4oECjGWk1mlBbMdfJ2MQ=;
        b=y8TNIBMocaL5cCrOl7quHVrk1zuEQZyHFuvn+dhZOyfnLuZrIWcwmvwFSAk2aHgfXU
         vWEBUFmuodWJMH0aBHDiONuQSKHiuaJ6llNNmpEZwP1quLDgFe4Y4kBpPlut5PC3kBko
         zflbH254qW+v8c11+N+DATNmcqDgVN5+VG05k65w9hQy/LWPeH/FbuFQqfLIrdmBus2K
         wmRXc0SbU9ny3rMRgp+aaSuKvioPqxpBqjxOqInOicjNR52u3DUkkCp3ZUSpBVmMYomx
         z7hBJjoj4/gfnJhjrxMvhY9iXlIec7Zc1l9H7zFkefPgngKPR3M1xtDv+gremzdnOaK0
         lxwA==
X-Received: by 10.68.208.70 with SMTP id mc6mr3983750pbc.27.1360848797833;
        Thu, 14 Feb 2013 05:33:17 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id m3sm90116732pav.4.2013.02.14.05.33.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Feb 2013 05:33:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 14 Feb 2013 20:34:04 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216307>

I just realized that many of my big repos are still on index v2 while
v4 should reduce its size significantly (3.8M -> 2.9M for linux-2.6
and 25M -> 14M for webkit, for example). I wanted to propose index v4
as the new default version, because I guess that not many people
outside git@vger are aware of it, but perhaps this approach is less
drastic. It only suggest index v4 when the index size after clone hits
512K limit.

I have 170 git repositories (most of them Gnome projects) and only big
ones exceed the limit: webkit, linux-2.6, libreoffice-core, wine
(530K), gentoo-x86. Gimp and banshee are close (510K and 321K). The
rest barely hits 256K. So this hint won't show up often. On second
thought, maybe we should lower it down to 300K to show more often and
raise awareness on index v4 :)

Something I should have done in this patch too, is state that index v4
is only supported since vXXX, that git clients older than that will
not work. But maybe just put that in update-index man page and refer
there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index e0aaf13..7cd1b60 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -543,6 +543,7 @@ static int checkout(void)
 	struct tree *tree;
 	struct tree_desc t;
 	int err =3D 0, fd;
+	struct stat st;
=20
 	if (option_no_checkout)
 		return 0;
@@ -591,6 +592,15 @@ static int checkout(void)
 	if (!err && option_recursive)
 		err =3D run_command_v_opt(argv_submodule, RUN_GIT_CMD);
=20
+	if (!err &&
+	    !stat(git_path("index"), &st) &&
+	    st.st_size > 512 * 1024)
+		advise(_("Your index is quite large (%d KiB).\n"
+			 "You may want to update to index version 4 to reduce its size,\n"
+			"as large index files may affect performance, using the command:\n"
+			 "  git update-index --index-version 4"),
+		       st.st_size / 1024);
+
 	return err;
 }
=20
--=20
1.8.1.2.536.gf441e6d
