From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v9 5/5] help: respect new common command grouping
Date: Wed, 20 May 2015 21:23:01 +0200
Message-ID: <1432149781-24596-6-git-send-email-sebastien.guimmara@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:23:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9ad-0002cG-P0
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbbETTXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:23:30 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35290 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbbETTX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:23:28 -0400
Received: by wgfl8 with SMTP id l8so63262064wgf.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9wbObG1mwj90pmLnayz6B17wqBaCfpTrgqzcO8jAOc0=;
        b=zGko65RnDt1cFKF/aTDeyyX/4zJG95w7MJKkvgecMq1/3nctK1Zht1XWn3R2sg6nVm
         cE3+RhvbY1m+mkEqzQQQeDNTeely9cAxLc7zK+nsPfcDEfgwQtmnyAA15/g/UHfYQ0Id
         fQSKOv5byI0C8xnbvO/mAceFzm8bWT7ykzSdH1nS1fT0cloMbH+JpAe3mq25m8hAGHk2
         Db14hUG2LoHYd9RwPmLOxjXOxz460V2zip/s2rNLz/Nj+Uf2M/Eey1R4RHNjXcgdxbXO
         u7xANaVgNRzqb61tFz1ZskAZbdQdHOXkMq8Q0OgMmvnZ6NWSDRSfmSICdEq//o604LNW
         f2sQ==
X-Received: by 10.180.14.135 with SMTP id p7mr44459642wic.8.1432149807472;
        Wed, 20 May 2015 12:23:27 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bm9sm28320276wjc.21.2015.05.20.12.23.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 12:23:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269501>

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
concepts or each other. Revise the output to explain their relationship
with the typical Git workflow:

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize [...]

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   reset      Reset current HEAD to the specified state

examine the history and state (see also: git help revisions)
   log        Show commit logs
   status     Show the working tree status

   [...]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 2072a87..8f72051 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+static int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 =3D elem1;
+	const struct cmdname_help *e2 =3D elem2;
+
+	if (e1->group < e2->group)
+		return -1;
+	if (e1->group > e2->group)
+		return 1;
+	return strcmp(e1->name, e2->name);
+}
+
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
+	int current_grp =3D -1;
=20
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest =3D strlen(common_cmds[i].name);
 	}
=20
-	puts(_("The most commonly used git commands are:"));
+	qsort(common_cmds, ARRAY_SIZE(common_cmds),
+		sizeof(common_cmds[0]), cmd_group_cmp);
+
+	puts(_("These are common Git commands used in various situations:"));
+
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (common_cmds[i].group !=3D current_grp) {
+			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
+			current_grp =3D common_cmds[i].group;
+		}
+
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
--=20
2.4.0.GIT
