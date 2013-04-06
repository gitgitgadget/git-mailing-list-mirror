From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: activate graplog extension for hg_log()
Date: Sat,  6 Apr 2013 18:50:52 +0200
Message-ID: <1365267052-2604-1-git-send-email-apelisse@gmail.com>
References: <CAMP44s1RhMR4vkUqbOOqQ+VAHVQgO8SCrBSSGNjCD-buGnb10g@mail.gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWX6-0001D7-Fw
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab3DFQvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:51:10 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:61488 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3DFQvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:51:09 -0400
Received: by mail-we0-f170.google.com with SMTP id z2so3634459wey.29
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OG0PccajOHZA3QMoLJtzY2AFYOEiY/2ecljalMj/gLg=;
        b=gfYOcRrH5d8wgZ7H7ZOJ1IwugREIykDI4trD1OUFOHOPoDJhGHjaLnkB2sWk0XTGKw
         2WuvX6sQcW8vHlTawEg6L9GM0EFkeR4/yiF1GBvks67BzyXStT22L6pILStNXXooeIoE
         BFo7SxAZZhe/xW8/U9K4GzdQBn1FblAVI6T0fuykByuYueLvPP+1pKVzimxDzgWYBIo4
         JvD7V2eweo0qOtk2rmbDCFLdAmBsCB9SoMM/gTsoquC/JAz9SVLIN28bQ6rTbZ4GqZWM
         cyokPm0yzSGDmieB0mFaaFz+7Jq5UePBj4lA1e4HMJn9tGCtm4OCPDjFbXPC3MYYUWqR
         MkHQ==
X-Received: by 10.180.11.148 with SMTP id q20mr4858685wib.18.1365267068054;
        Sat, 06 Apr 2013 09:51:08 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id gl11sm9948478wic.8.2013.04.06.09.51.06
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 09:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CAMP44s1RhMR4vkUqbOOqQ+VAHVQgO8SCrBSSGNjCD-buGnb10g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220244>

The hg_log() test helper uses the "--graph" parameter that is
implemented by the GraphLog extension. If the extension is not activated
by the user, the parameter is not available. Activate the extension in
setup().

Also changes the way we grep the output in hg_log(). The pipe operator
can hide the return code of hg command. As a matter of fact, if log
fails because it doesn't know about "--graph", it doesn't report any
failure and let's you think everything worked.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
- Updated the title to use remote-hg instead of remote-helpers
- Activate the extension instead of removing the option
- Apply the same to test-hg-hg-git

 contrib/remote-helpers/test-hg-bidi.sh   |    5 ++++-
 contrib/remote-helpers/test-hg-hg-git.sh |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 1d61982..84b9228 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -50,7 +50,8 @@ hg_push () {
 }

 hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+	hg -R $1 log --graph --debug >log &&
+	grep -v 'tag: *default/' log
 }

 setup () {
@@ -62,6 +63,8 @@ setup () {
 	echo "commit = -d \"0 0\""
 	echo "debugrawcommit = -d \"0 0\""
 	echo "tag = -d \"0 0\""
+	echo "[extensions]"
+	echo "graphlog ="
 	) >> "$HOME"/.hgrc &&
 	git config --global remote-hg.hg-git-compat true

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 7e3967f..17a074e 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -78,7 +78,8 @@ hg_push_hg () {
 }

 hg_log () {
-	hg -R $1 log --graph --debug | grep -v 'tag: *default/'
+	hg -R $1 log --graph --debug >log &&
+	grep -v 'tag: *default/' log
 }

 git_log () {
@@ -97,6 +98,7 @@ setup () {
 	echo "[extensions]"
 	echo "hgext.bookmarks ="
 	echo "hggit ="
+	echo "graphlog ="
 	) >> "$HOME"/.hgrc &&
 	git config --global receive.denycurrentbranch warn
 	git config --global remote-hg.hg-git-compat true
--
1.7.9.5
