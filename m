From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/3] branch: suggest how to undo a --set-upstream when given one branch
Date: Tue, 10 Jul 2012 18:53:00 +0200
Message-ID: <1341939181-8962-3-git-send-email-cmn@elego.de>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 18:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sodg6-0003pl-V5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 18:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab2GJQwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 12:52:43 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56652 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431Ab2GJQwm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 12:52:42 -0400
Received: from centaur.lab.cmartin.tk (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 6CE5E4614B;
	Tue, 10 Jul 2012 18:52:38 +0200 (CEST)
Received: (nullmailer pid 9004 invoked by uid 1000);
	Tue, 10 Jul 2012 16:53:01 -0000
X-Mailer: git-send-email 1.7.10.2.1.g8c77c3c
In-Reply-To: <1341939181-8962-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201260>

This interface is error prone, and a better one (--set-upstream-to)
exists. Suggest how to fix a --set-upstream invocation in case the
user only gives one argument, which makes it likely that he meant to
do the opposite, like with

    git branch --set-upstream origin/master

when they meant one of

    git branch --set-upstream origin/master master
    git branch --set-upstream-to origin/master

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/branch.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index c886fc0..5551227 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -864,10 +864,32 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 		   info and making sure new_upstream is correct */
 		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRAN=
CH_TRACK_OVERRIDE);
 	} else if (argc > 0 && argc <=3D 2) {
+		struct branch *branch =3D branch_get(argv[0]);
+		const char *old_upstream =3D NULL;
+		int branch_existed =3D 0;
+
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
+
+		/* Save what argv[0] was pointing to so we can give
+		   the --set-upstream-to hint */
+		if (branch_has_merge_config(branch))
+		  old_upstream =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0)=
;
+
+		branch_existed =3D ref_exists(branch->refname);
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
 			      force_create, reflog, 0, quiet, track);
+
+		if (argc =3D=3D 1) {
+			printf("If you wanted to make '%s' track '%s', do this:\n", head, a=
rgv[0]);
+			if (branch_existed)
+				printf(" $ git branch --set-upstream '%s' '%s'\n", argv[0], old_up=
stream);
+			else
+				printf(" $ git branch -d '%s'\n", argv[0]);
+
+			printf(" $ git branch --set-upstream-to '%s'\n", argv[0]);
+		}
+
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
--=20
1.7.10.2.1.g8c77c3c
