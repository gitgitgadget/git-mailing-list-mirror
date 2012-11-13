From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 1/3] Fix relative submodule setup of submodule tests
Date: Tue, 13 Nov 2012 09:34:28 +0100
Message-ID: <20121113083428.GB38188@book.hvoigt.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com> <20121108185643.GN15560@sigill.intra.peff.net> <20121109184225.GA1190@book.hvoigt.net> <20121113083233.GA38188@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Issues <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYBxH-0004jG-IB
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 09:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab2KMIee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 03:34:34 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:54917 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2KMIed (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 03:34:33 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TYBx0-000595-BM; Tue, 13 Nov 2012 09:34:30 +0100
Content-Disposition: inline
In-Reply-To: <20121113083233.GA38188@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209587>

If a remote is configured in a superproject relative submodule urls
should be relative to that remote. Since we have a bug in relative
path calculation for superproject paths that contain a "/." using
../submodule was accepted here. We are going to fix this behavior so
we first need to correct these tests.

Later tests expect the submodules origin to be in a directory underneath
the tests root. Lets remove the origin from super (which points directly
at the tests root directory) to keep these tests expectations.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7403-submodule-sync.sh    | 2 ++
 t/t7406-submodule-update.sh  | 2 ++
 t/t7407-submodule-foreach.sh | 2 ++
 t/t7506-status-submodule.sh  | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 524d5c1..b310a58 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -18,6 +18,8 @@ test_expect_success setup '
 	git clone . super &&
 	git clone super submodule &&
 	(cd super &&
+	 # relative submodule urls relate to this folder not the remotes
+	 git remote rm origin &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 1542653..f3628c9 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -32,6 +32,8 @@ test_expect_success 'setup a submodule tree' '
 	git clone super merging &&
 	git clone super none &&
 	(cd super &&
+	 # relative submodule urls relate to this folder not the remotes
+	 git remote rm origin &&
 	 git submodule add ../submodule submodule &&
 	 test_tick &&
 	 git commit -m "submodule" &&
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9b69fe2..99956a6 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -21,6 +21,8 @@ test_expect_success 'setup a submodule tree' '
 	git clone super submodule &&
 	(
 		cd super &&
+		# relative submodule urls relate to this folder not the remotes
+		git remote rm origin &&
 		git submodule add ../submodule sub1 &&
 		git submodule add ../submodule sub2 &&
 		git submodule add ../submodule sub3 &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34d..9021b1a 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -203,6 +203,8 @@ test_expect_success 'status with merge conflict in .gitmodules' '
 	test_create_repo_with_commit sub2 &&
 	(
 		cd super &&
+		# relative submodule urls relate to this folder not the remotes
+		git remote rm origin &&
 		prev=$(git rev-parse HEAD) &&
 		git checkout -b add_sub1 &&
 		git submodule add ../sub1 &&
-- 
1.8.0.3.gaed4666
