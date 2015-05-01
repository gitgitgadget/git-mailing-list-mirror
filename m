From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v2 3/3] git help: group common commands by theme
Date: Sat, 02 May 2015 01:12:18 +0200
Message-ID: <55440852.4000500@gmail.com>
References: <554405D5.9080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 01:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoK6c-0000dC-IF
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 01:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbbEAXMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 19:12:22 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34775 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbEAXMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 19:12:21 -0400
Received: by wgso17 with SMTP id o17so102408762wgs.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=qZkMT4zs1web8VlPf8DGfGMKadVOXd6M8xBUWO5aPig=;
        b=QR3mcCjlXXVv6VgRuUXJuCr9iGc6C1S2iTnoeqf+lgzKkweFGBRPJ6RiQGoYALi1Y+
         jcNuITI16p0kkSPZjnVe0ngxPS0rt6Hrh08auaEJlx2xHSNeF1ct91A2g24e3zza0Vmu
         07SnPWWvuiOxKPWYBgImu9cOQU3IQxM9XXpRUPABRuHS7FXDisnZdcSrc0h/pcqYwOeb
         p1RkrQ1vPbNeE/z12I5NGPQ99ReuNgLdUWS/4kOLamHXTlcmbnwg4YC3o6njn2vwB4t9
         c7dg4V0QDDEeIja6KtTnlkWkMC2KHxRDu1+jNQcljRLSjsZcbWN2hq9WgQlI0Na7lu8u
         fiwA==
X-Received: by 10.180.95.10 with SMTP id dg10mr601258wib.41.1430521940636;
        Fri, 01 May 2015 16:12:20 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id l6sm9424161wjz.4.2015.05.01.16.12.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 16:12:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <554405D5.9080702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268200>

help.c - group common commands by theme

Use qsort to sort the common_cmds array by group name,
then print those common commands, skipping a line between each group.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>

---
  help.c | 21 +++++++++++++++++++++
  1 file changed, 21 insertions(+)

diff --git a/help.c b/help.c
index 2072a87..2169a59 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,38 @@ void list_commands(unsigned int colopts,
      }
  }

+/* sort the command name struct by group name */
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+    struct cmdname_help *cmd1 =3D (struct cmdname_help*) elem1;
+    struct cmdname_help *cmd2 =3D (struct cmdname_help*) elem2;
+
+    return strcmp(cmd1->group, cmd2->group);
+}
+
  void list_common_cmds_help(void)
  {
      int i, longest =3D 0;
+    char *current_grp =3D NULL;

      for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
          if (longest < strlen(common_cmds[i].name))
              longest =3D strlen(common_cmds[i].name);
      }

+    /* sort common commands by group (i.e, beginner's relevance) */
+    qsort(common_cmds, ARRAY_SIZE(common_cmds),
+        sizeof(struct cmdname_help), cmd_group_cmp);
+
      puts(_("The most commonly used git commands are:"));
      for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+
+        /* skip a line each time we encounter a new command group */
+        if (current_grp !=3D NULL && strcmp(common_cmds[i].group,=20
current_grp))
+            printf("\n");
+
+        current_grp =3D common_cmds[i].group;
+
          printf("   %s   ", common_cmds[i].name);
          mput_char(' ', longest - strlen(common_cmds[i].name));
          puts(_(common_cmds[i].help));
--=20
2.4.0
