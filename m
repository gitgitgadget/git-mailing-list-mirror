From: =?UTF-8?q?Pawe=C5=82=20Wawruch?= <pawlo@aleg.pl>
Subject: [PATHv2] branch.c:install_branch_config():Simplify code generating verbose message.
Date: Tue, 11 Mar 2014 09:40:07 +0100
Message-ID: <1394527207-23065-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 09:40:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNIEf-0004cE-E0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 09:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbaCKIkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 04:40:23 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:42588 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaCKIkU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 04:40:20 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so3606072eei.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=IPGlVhmWthHGFOdIFYvGw8M0Ibn1fwCv7eRZmX8QRBQ=;
        b=PZ127aA1VPwRn9qoZqxqJEfN3xbFUtlbe3OGi1cqLqkt9yN9PqKz895eq2ZzxD3qwz
         GCzd0rmut5XUDy1tVG8BVzDdXCAQtcCIF3jmP3eDJE/l1pH43BKYVSOEGpXKDRG2UxNf
         Qd6BsnOiEdSHnP6qycYZgXBJYCRgzWNb0UvdcdpLXPVqvCvDCGLiX0qxJ995tox+3UYZ
         73t/tu3UD/FFvKmEYg6hb2Y4ewyJUANOd4s/LUkrQxvaJ7UxNoOYiEY7HXdBTWBIqCm0
         BVggCQojl0NwjPA/8G4a+Q3qf8AZclAA2+Vg5eNYD8xXMAHaUjuCBkN58OmM5qotS22E
         KIFQ==
X-Received: by 10.15.27.200 with SMTP id p48mr789167eeu.105.1394527219298;
        Tue, 11 Mar 2014 01:40:19 -0700 (PDT)
Received: from endymion.chello.pl (89-74-49-157.dynamic.chello.pl. [89.74.49.157])
        by mx.google.com with ESMTPSA id x6sm54978562eew.20.2014.03.11.01.40.18
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 01:40:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243849>

Simplify the long if chain in install_branch_config().

There is a long chain of if statements. The code can be more clear.
Replace the chain with table of strings. New approach is more
compact.

Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
---
 branch.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..8d3b219 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,18 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 	int remote_is_branch =3D starts_with(remote, "refs/heads/");
 	struct strbuf key =3D STRBUF_INIT;
 	int rebasing =3D should_setup_rebase(origin);
+	const char *messages[] =3D {
+		N_("Branch %s set up to track remote branch %s from %s by rebasing."=
),
+		N_("Branch %s set up to track remote branch %s from %s."),
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track local branch %s."),
+		N_("Branch %s set up to track remote ref %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s."),
+		N_("Branch %s set up to track local ref %s by rebasing."),
+		N_("Branch %s set up to track local ref %s.")
+	};
+	const char *name =3D remote_is_branch ? remote : shortname;
+	int message_number;
=20
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -77,29 +89,13 @@ void install_branch_config(int flag, const char *lo=
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
+		message_number =3D (!!rebasing) + 2 * (!!origin) + 4 * (!!remote_is_=
branch);
+		assert(message_number < ARRAY_SIZE(messages));
+
+		if (message_number < 2)
+			printf_ln(messages[message_number], local, name, origin);
 		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+			printf_ln(messages[message_number], local, name);
 	}
 }
=20
--=20
1.8.3.2
