From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout: verify new branch name's validity early
Date: Tue, 28 Aug 2012 09:29:41 +0700
Message-ID: <1346120981-27234-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=E4=B9=99=E9=85=B8=E9=8B=B0?= <ch3cooli@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 04:30:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6BZG-0006Uz-0h
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 04:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002Ab2H1CaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 22:30:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42513 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab2H1CaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 22:30:04 -0400
Received: by pbbrr13 with SMTP id rr13so8489731pbb.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4OAq+LUYc4HNNDT4QsHEebiMdFRNqyCAzXRQnPaEanY=;
        b=ZtM+W6NZ/eIBRLDE1OG8i1rO8kVR6CamRlujHq/+E5y+F6pFijo83DSfbTiwg7wHgE
         DlvjKh8KAXWjbgudfLa5Rr/ECv6t2mBKCvdgTNj8UeRK7FLJNFZVMNSmVk6VMj6GKXkj
         msIDg/dj9rhub2uh+ZRy9erScDiTSzTVU5nKTWw7mi4czvHNIyYG+W5Y6T/JIlCzh59P
         v31gbdL85CYnjq224CLl0koGuVzztc1oWuCeVSqOH+sdEtGkdDryWS8olMzA6KyJGTT7
         2uj7kC2hff2Btgdzq0aAmJBjffp0Ov96EueyLZxlCP9dT05Q29Y0o7GbMnf6qjCf2Kn7
         SQ5A==
Received: by 10.68.130.67 with SMTP id oc3mr38383922pbb.18.1346121003167;
        Mon, 27 Aug 2012 19:30:03 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qo8sm15961228pbb.19.2012.08.27.19.29.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 19:30:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Aug 2012 09:29:42 +0700
X-Mailer: git-send-email 1.7.12.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204397>

If the new branch name to -b/-B happens to be missing, the next
argument may be mistaken as branch name and no longer recognized by
checkout as argument. This may lead to confusing error messages.

By checking branch name early and printing out the invalid name, users
may realize they forgot to specify branch name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Tue, Aug 28, 2012 at 12:03 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
 > Ideally you would want
 >
 >         fatal: "-t" is not an acceptable name for a branch
 >
 > in this case; if it is cumbersome to arrange, at the very least,
 >
 >         updating paths is incompatible with checking out the branch =
"-t".
 >
 > would be clearer.

 Fair enough. It turns out we do check branch name's validity. It's
 just too late.

 builtin/checkout.c         | 20 ++++++++++----------
 t/t2018-checkout-branch.sh |  5 +++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d812219..03b0f25 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1049,6 +1049,16 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	if (opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED)
 		opts.track =3D git_branch_track;
=20
+	if (opts.new_branch) {
+		struct strbuf buf =3D STRBUF_INIT;
+
+		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &buf=
,
+							     !!opts.new_branch_force,
+							     !!opts.new_branch_force);
+
+		strbuf_release(&buf);
+	}
+
 	if (argc) {
 		const char **pathspec =3D get_pathspec(prefix, argv);
=20
@@ -1079,16 +1089,6 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	if (patch_mode)
 		return interactive_checkout(new.name, NULL, &opts);
=20
-	if (opts.new_branch) {
-		struct strbuf buf =3D STRBUF_INIT;
-
-		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &buf=
,
-							     !!opts.new_branch_force,
-							     !!opts.new_branch_force);
-
-		strbuf_release(&buf);
-	}
-
 	if (new.name && !new.commit) {
 		die(_("Cannot switch branch to a non-commit."));
 	}
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2741262..48ab6a2 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,4 +198,9 @@ test_expect_success 'checkout -B to the current bra=
nch works' '
 	test_dirty_mergeable
 '
=20
+test_expect_success 'checkout -b checks branch validitity early' '
+	test_must_fail git checkout -b -t origin/master 2>err &&
+	grep "not a valid branch name" err
+'
+
 test_done
--=20
1.7.12.rc2
