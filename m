From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 3/3] git help: group common commands by theme
Date: Mon,  4 May 2015 22:28:10 +0200
Message-ID: <13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 22:28:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpMyo-0001tE-7V
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbbEDU2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 16:28:36 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33552 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbEDU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:28:32 -0400
Received: by wief7 with SMTP id f7so85799952wie.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xS1PvsKy+sSCVHu8OHTrdS4bz4UYRJ/IJSfMlLJLkJg=;
        b=WAhGuivsJvpx40iJEXDRNXCYlE/PyIhe0YtiMZTSoXRf8qO7SXJHR0QRjIsxPvcm4R
         Iz+takY1iZGXYZ4v6ZxJcpgndlQaJxeSadCpPUEldDoxQH5mQniH4zYRM+lbXPlh53iU
         4MSjMozsdUHgY/r2160cQTn1kblKAEQlcVLQxUb4tY/UmCyvhrK++zYdVh+V2zdrkYea
         LXZEpr501AmGCPP0p7V/WRybY+vCj5hVcBMheaBzh5MkzATsKihq5LD7Pth2gi9lrKn1
         6zdmZ+8YPjl44dVrbrN+RFdQ4KyprIjZrxtUiWBzo474kifx9uHwEkc3fGj2u3loSc6U
         9ydw==
X-Received: by 10.194.60.43 with SMTP id e11mr46021449wjr.36.1430771311057;
        Mon, 04 May 2015 13:28:31 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id xb3sm22164354wjc.38.2015.05.04.13.28.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 13:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268349>

'git help' shows common commands in alphabetical order:

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   [...]

without any indication of how commands relate to high-level
concepts or each other. Revise the output to group commands by
concept, like this:

The most commonly used git commands are:

   * starting a working area:
      clone      Clone a repository into a new directory
      init       Create an empty Git repository or reinitialize an exis=
ting one

   * working on the current change:
      add        Add file contents to the index
      reset      Reset current HEAD to the specified state
      [...]

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 2072a87..c8b0bb6 100644
--- a/help.c
+++ b/help.c
@@ -218,18 +218,44 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+	int group1, group2;
+
+	group1 =3D ((struct cmdname_help *) elem1)->group;
+	group2 =3D ((struct cmdname_help *) elem2)->group;
+
+	if (group1 =3D=3D group2)
+		return 0;
+	if (group1 > group2)
+		return 1;
+	else
+		return -1;
+}
+
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
+	unsigned char current_grp =3D -1;
=20
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest =3D strlen(common_cmds[i].name);
 	}
=20
+	qsort(common_cmds, ARRAY_SIZE(common_cmds),
+		sizeof(common_cmds[0]), cmd_group_cmp);
+
 	puts(_("The most commonly used git commands are:"));
+
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
+		if (common_cmds[i].group !=3D current_grp) {
+			printf("\n   * %s:\n", _(common_cmd_groups[common_cmds[i].group]));
+		}
+
+		current_grp =3D common_cmds[i].group;
+
+		printf("      %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
 	}
--=20
2.4.0
