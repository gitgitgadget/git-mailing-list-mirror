From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: fix ref selection in --single-branch --branch=xxx
Date: Fri, 22 Jun 2012 16:35:47 +0700
Message-ID: <1340357747-31711-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 11:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si0Hh-0004xH-La
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761900Ab2FVJgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 05:36:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56705 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761877Ab2FVJgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:36:03 -0400
Received: by pbbrp8 with SMTP id rp8so3327100pbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rSmnUP9c0wtYIXdwOC8/0BQSf/1knz5hYHsymJ0oWqM=;
        b=z/D9htSw/B/odVmGRi4hypRLQMOlWeQ2E7Fc/P9xkg41gsBOnS64/YqGlzW2RToLpA
         yMF4T2PS3xfeUNqAsoYmepIku03xrIb2IqJ8jE4McmBhkZle6z6a0xblNr8RdwuwGTOC
         NjWRinbQo1a9jS1k6w65thUcJoVjCtGQejVuI9A4FDI85oYUQ7XXlGBqKG+VgLWEHEIy
         f5YQ0R2h+fSqN7ttY5iCM5s/DCkitWX3kQWRffjABlLTlQbKnf/tyDD5xa5wFsAdSAI/
         9aLH8k4I9LMIgBieRYuR17NuEtojJA03eR6+uBrDvb4yDokkHiIOQ94LxMb1SSzM5KVx
         ZQCA==
Received: by 10.68.138.166 with SMTP id qr6mr8618233pbb.43.1340357762389;
        Fri, 22 Jun 2012 02:36:02 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id tq4sm16241952pbc.11.2012.06.22.02.35.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 02:36:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 22 Jun 2012 16:35:48 +0700
X-Mailer: git-send-email 1.7.11.rc1.185.g281ad67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200432>

 - do not fetch HEAD
 - do not also fetch refs following "xxx"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Tue, Jun 12, 2012 at 4:14 AM, Jeff King <peff@peff.net> wrote:
 > [1] It looks like "--single-branch" does not actually work, and stil=
l
 >    fetches master. I think this is a bug in the implementation of
 >    single-branch (it looks like it fetches HEAD unconditionally).
 >    +cc Duy.

 Yep, my bad.

 builtin/clone.c       | 7 +++++--
 t/t5500-fetch-pack.sh | 7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7f3b982..d3b7fdc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -433,8 +433,11 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
=20
 		if (!option_branch)
 			remote_head =3D guess_remote_head(head, refs, 0);
-		else
-			remote_head =3D find_remote_branch(refs, option_branch);
+		else {
+			local_refs =3D NULL;
+			tail =3D &local_refs;
+			remote_head =3D copy_ref(find_remote_branch(refs, option_branch));
+		}
=20
 		if (!remote_head && option_branch)
 			warning(_("Could not find remote branch %s to clone."),
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1d1ca98..e80a2af 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -125,6 +125,11 @@ test_expect_success 'single branch object count' '
 	test_cmp expected count.singlebranch
 '
=20
+test_expect_success 'single given branch clone' '
+	git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
+	test_must_fail git --git-dir=3Dbranch-a/.git rev-parse origin/B
+'
+
 test_expect_success 'clone shallow' '
 	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
@@ -276,7 +281,7 @@ test_expect_success 'clone shallow with --branch' '
 '
=20
 test_expect_success 'clone shallow object count' '
-	echo "in-pack: 12" > count3.expected &&
+	echo "in-pack: 6" > count3.expected &&
 	GIT_DIR=3Dshallow3/.git git count-objects -v |
 		grep "^in-pack" > count3.actual &&
 	test_cmp count3.expected count3.actual
--=20
1.7.11.rc1.185.g281ad67
