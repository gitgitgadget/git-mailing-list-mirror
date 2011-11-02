From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] branch -m: handle no arg properly
Date: Wed,  2 Nov 2011 23:01:38 +0800
Message-ID: <1320246098-6912-1-git-send-email-rctay89@gmail.com>
References: <4EB153B4.6070404@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>,
	"Junio C. Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 16:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLcK9-0001lk-6x
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 16:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab1KBPBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 11:01:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47864 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181Ab1KBPBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 11:01:48 -0400
Received: by gyb13 with SMTP id 13so213026gyb.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Kkj2OxbPrdB2xI/HGVKYffaZtnBUYuNRcRlnvYIs3x8=;
        b=ZRDS7XbtO3qBX3MDQQSs/hfcs6XNs3Ax8JUpzZsi4vB825OpovoKRNIFo4wEeWH8RD
         Xg3tAvc5huLDFrwd/hEWi+JVThOcEV1oeWFBCNmmHlvJE7QMoMIQU5Aq9IJsZ/fimJyf
         4eL1gSu+CCfSHXCi1geo3mq/9qtApaIAuggHQ=
Received: by 10.146.160.10 with SMTP id i10mr1216897yae.11.1320246107811;
        Wed, 02 Nov 2011 08:01:47 -0700 (PDT)
Received: from localhost (nusnet-18-60.dynip.nus.edu.sg. [137.132.18.60])
        by mx.google.com with ESMTPS id l27sm7946995ani.21.2011.11.02.08.01.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 08:01:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.dirty
In-Reply-To: <4EB153B4.6070404@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184635>

Modify the option parsing heuristic to handle all -m (rename) cases,
including the no-arg case. Previously, this "fell through" to the argc
<=3D 2 case.

Add a regression test in t3200-branch.sh while we're at it.

Reported-by: Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/branch.c  |   13 ++++++++-----
 t/t3200-branch.sh |    4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 009b713..ebda8e7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -719,11 +719,14 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev,
 				      with_commit, argv);
-	else if (rename && (argc =3D=3D 1))
-		rename_branch(head, argv[0], rename > 1);
-	else if (rename && (argc =3D=3D 2))
-		rename_branch(argv[0], argv[1], rename > 1);
-	else if (argc <=3D 2) {
+	else if (rename) {
+		if (argc =3D=3D 1)
+			rename_branch(head, argv[0], rename > 1);
+		else if (argc =3D=3D 2)
+			rename_branch(argv[0], argv[1], rename > 1);
+		else
+			die(_("new branch not specified for -m|--move"));
+	} else if (argc <=3D 2) {
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 2f5eada..78587fe 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -75,6 +75,10 @@ test_expect_success \
         git branch l'
=20
 test_expect_success \
+    'git branch -m with no arg fails' \
+       'test_must_fail git branch -m'
+
+test_expect_success \
     'git branch -m m m/m should work' \
        'git branch -l m &&
         git branch -m m m/m &&
--=20
1.7.7.1.599.g03eec
