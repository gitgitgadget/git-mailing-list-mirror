From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] update-index: add --swap to swap index and worktree content
Date: Fri, 12 Aug 2011 21:07:38 +0700
Message-ID: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 16:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrsOu-0002tq-7C
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 16:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab1HLOHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 10:07:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65287 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab1HLOHq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 10:07:46 -0400
Received: by pzk37 with SMTP id 37so1212454pzk.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=s9XVaS50xvPXyg822mGo7FPueJQttP8HwpXFSydMc+E=;
        b=soVvDsenz3MVQJlPKJd5P2p2FBEWzUEtGr04a/SnhK4aE2Fr7Qlj7r7EPcjGP5IeGa
         YX4UDXXud1tdMsGui9xdlwykNjF9XOA4PgrF4AnRPsCc+1G3BUDQO5+KQ+xqo0U9Ssup
         TWrIv6IWROh7j5KZsuQE48k7sDwgE+HVwlmvw=
Received: by 10.143.158.9 with SMTP id k9mr544962wfo.73.1313158066133;
        Fri, 12 Aug 2011 07:07:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.208.228])
        by mx.google.com with ESMTPS id s9sm2583984pbk.34.2011.08.12.07.07.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 07:07:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 12 Aug 2011 21:07:39 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179229>

Sometimes "git add -p" with "e" to edit the patch does not satisfy me.
What I want is a quick way to modify index content without changing
worktree, then I can continue adding more hunks to the index.

With this option, I can swap index out for a quick edit, then swap it i=
n
again.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Not sure if anybody has the same needs, enough to polish it and make
 it to master.

 builtin/update-index.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..b96065a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -22,6 +22,7 @@
 static int allow_add;
 static int allow_remove;
 static int allow_replace;
+static int swap_entry;
 static int info_only;
 static int force_remove;
 static int verbose;
@@ -104,6 +105,19 @@ static int add_one_path(struct cache_entry *old, c=
onst char *path, int len, stru
 		free(ce);
 		return -1;
 	}
+	if (swap_entry) {
+		struct checkout state;
+		if (allow_add || allow_remove)
+			die("--add, --replace and --swap do not play together");
+		memset(&state, 0, sizeof(state));
+		state.force =3D 1;
+		state.not_new =3D 1;
+		if (add_cache_entry(ce, 0))
+			return error("%s: cannot add to the index", path);
+		if (checkout_entry(old, &state, NULL))
+			return error("%s: cannot swap", path);
+		return 0;
+	}
 	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
@@ -727,6 +741,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			"let files replace directories and vice-versa", 1),
 		OPT_SET_INT(0, "remove", &allow_remove,
 			"notice files missing from worktree", 1),
+		OPT_SET_INT(0, "swap", &swap_entry,
+			"swap the content of index and worktree", 1),
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			"refresh even if index contains unmerged entries",
 			REFRESH_UNMERGED),
--=20
1.7.4.74.g639db
