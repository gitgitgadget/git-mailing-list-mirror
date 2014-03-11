From: =?UTF-8?q?Pawe=C5=82=20Wawruch?= <pawlo@aleg.pl>
Subject: [PATCH v3] install_branch_config: simplify verbose diagnostic logic
Date: Tue, 11 Mar 2014 14:26:52 +0100
Message-ID: <1394544412-28409-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 14:27:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNMi6-0001qy-3b
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 14:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbaCKN1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 09:27:05 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33208 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaCKN1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 09:27:01 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so3755421eek.27
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=1je/+Jxsydr5n5QYkw45xa87qjHGGpzAjtN4F7Je/Gw=;
        b=XNNCDXvLtAZ5Ud0OItmhd09GeI4X2M/rPkBN/vhK6eJc0mB5fmaxYyGpZ7wphSBZMq
         42FloOs09Eb9uwQmYj4oJGL+fggFpoIP1WsYGcMtJrG8BBRJy9sy/sLsIjSQrDCTIgZp
         6Iz49sB6TzuK3hbQ2XTd3LtJiCYvBlNQaduF63IlW32lUEb2SG3eR+0Oo+USMzsjR5ap
         9C0Bs52TTYmBkdLDlIeymBnmZiqEFs3xx7huDTdt8HzjPlzRqH2D5+3M3UxaiTEFgfQb
         zbQWR9+KCKVztq7OkPEuX3h+b4kc17b8zxp4kN4qk9SRgIIDkq9z/2pCfzrW6Bl2z16y
         qhbA==
X-Received: by 10.15.55.193 with SMTP id v41mr3758464eew.80.1394544420183;
        Tue, 11 Mar 2014 06:27:00 -0700 (PDT)
Received: from endymion.pwifi-studets.pw.edu.pl ([194.29.130.10])
        by mx.google.com with ESMTPSA id 46sm57545241ees.4.2014.03.11.06.26.58
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 06:26:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243865>

Replace the chain of if statements with table of strings.

Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
---
I changed the commit message. Logic of table has changed. To make it mo=
re
clear I added three dimensions of the table.=20

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243502
[2]: http://thread.gmane.org/gmane.comp.version-control.git/243849

 branch.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..741551a 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,21 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 	int remote_is_branch =3D starts_with(remote, "refs/heads/");
 	struct strbuf key =3D STRBUF_INIT;
 	int rebasing =3D should_setup_rebase(origin);
+	const char *message[][2][2] =3D {{{
+			N_("Branch %s set up to track remote branch %s from %s by rebasing.=
"),
+			N_("Branch %s set up to track remote branch %s from %s."),
+		},{
+			N_("Branch %s set up to track local branch %s by rebasing."),
+			N_("Branch %s set up to track local branch %s."),
+		}},{{
+			N_("Branch %s set up to track remote ref %s by rebasing."),
+			N_("Branch %s set up to track remote ref %s."),
+		},{
+			N_("Branch %s set up to track local ref %s by rebasing."),
+			N_("Branch %s set up to track local ref %s.")
+	}}};
+	const char *name =3D remote_is_branch ? remote : shortname;
+	int message_number;
=20
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -77,29 +92,12 @@ void install_branch_config(int flag, const char *lo=
cal, const char *origin, cons
 	strbuf_release(&key);
=20
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasin=
g.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
+		if (origin && remote_is_branch)
+			printf_ln(_(messages[!remote_is_branch][!origin][!rebasing]),
+				local, name, origin);
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			printf_ln(_(messages[!remote_is_branch][!origin][!rebasing]),
+				local, name);
 	}
 }
=20
--=20
1.8.3.2
