From: =?UTF-8?q?Pawe=C5=82=20Wawruch?= <pawlo@aleg.pl>
Subject: [PATCH v5] install_branch_config: simplify verbose messages logic
Date: Thu, 13 Mar 2014 00:47:45 +0100
Message-ID: <1394668065-14629-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 00:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNszu-00023o-8h
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbaCLXzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 19:55:31 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:65032 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaCLXzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 19:55:31 -0400
Received: by mail-ea0-f172.google.com with SMTP id l9so160914eaj.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 16:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qxbiatNQCtG5OYNMlCX2GL3MtzZex4P/nea1heKuQik=;
        b=zdYx97qaIi834SN+BjOiVH/0vmjAIwAB/w6FCQTtcUUK2Re9kTIr0qDGPlztjp/Qqc
         UStON1UxxdqYT16nlOerJOcW/+/Rl9b9BmurYwCvXjTaJlKumWCBZNzGjYp2rA+251xa
         jPK1Ba5h0faC8tUziXcQkjFGyg5UPkY2GKDXtqZfcC4EjMVvS/Dz1jyYwB3rRCe+KLMZ
         /5X12FWB7A+sXD2AbcwU/CHYorkC6bMdMbKmEANzLIquOYH4IhPxF/TCY656W7E9dOMc
         ygSAL9bqaSrUStLUULkk0n+6zs9jvt76p4X97hd0HeewRbEN5LJQYiKECKPHDlzqF+FQ
         NAfg==
X-Received: by 10.14.106.193 with SMTP id m41mr318804eeg.62.1394668071831;
        Wed, 12 Mar 2014 16:47:51 -0700 (PDT)
Received: from endymion.chello.pl (89-74-49-157.dynamic.chello.pl. [89.74.49.157])
        by mx.google.com with ESMTPSA id m42sm1571525eex.21.2014.03.12.16.47.50
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 16:47:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244011>

Replace the chain of if statements with table of strings.

Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
---
Thanks to Eric Sunshine and Junio C Hamano.
Simplified printing logic. The name moved to a table.

v4: http://thread.gmane.org/gmane.comp.version-control.git/243914
v3: http://thread.gmane.org/gmane.comp.version-control.git/243865
v2: http://thread.gmane.org/gmane.comp.version-control.git/243849
v1: http://thread.gmane.org/gmane.comp.version-control.git/243502

 branch.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..c17817c 100644
--- a/branch.c
+++ b/branch.c
@@ -53,6 +53,20 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 	int remote_is_branch =3D starts_with(remote, "refs/heads/");
 	struct strbuf key =3D STRBUF_INIT;
 	int rebasing =3D should_setup_rebase(origin);
+	const char *message[][2][2] =3D {{{
+		N_("Branch %s set up to track remote branch %s from %s by rebasing."=
),
+		N_("Branch %s set up to track remote branch %s from %s."),
+		},{
+		N_("Branch %s set up to track local branch %s by rebasing."),
+		N_("Branch %s set up to track local branch %s."),
+		}},{{
+		N_("Branch %s set up to track remote ref %s by rebasing."),
+		N_("Branch %s set up to track remote ref %s."),
+		},{
+		N_("Branch %s set up to track local ref %s by rebasing."),
+		N_("Branch %s set up to track local ref %s.")
+	}}};
+	const char *name[] =3D {remote, shortname};
=20
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -76,31 +90,9 @@ void install_branch_config(int flag, const char *loc=
al, const char *origin, cons
 	}
 	strbuf_release(&key);
=20
-	if (flag & BRANCH_CONFIG_VERBOSE) {
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
-		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
-	}
+	if (flag & BRANCH_CONFIG_VERBOSE)
+		printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
+				local, name[!remote_is_branch], origin);
 }
=20
 /*
--=20
1.8.3.2
