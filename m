From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 21/21] remote-hg: activate graphlog extension for hg_log()
Date: Thu, 11 Apr 2013 07:23:17 -0500
Message-ID: <1365682997-11329-22-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZZ-0000Ih-C8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161559Ab3DKMZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:43 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:61273 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161544Ab3DKMZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:32 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so663985qcs.34
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ikTiNkWMfdQ8PGpImleVbM1sPj9tBljj4mA6V0gWBL0=;
        b=a+jWSaiMNJ9pDGeFvZ3Bz5PyoQJ6a86Sld4aWJMAZbtk2jdV7o0JJtvRXuVzxFPtZf
         fXbBe44nHcZpnl2h9kQm5Ig30i0Bhdkuo5UbKkOyg+cLUU1lLLPZJYflmOQsTnLdexPs
         itGhXrXFm/eCsshVNMHQvYkFxd0yp1HrPddWqlv/9Vr/S3/SvNYl2ltayY5yY2DwzO5A
         JagnFzpASR2U+KL3Ir4XbQMO4vXscwczXwxQYk87zEEfUoiSQOl6XmvcoT4nl4j5g7B2
         kgV42gv0fSAUgd3GOBIxZa4j01ugLTkz73OAJXuacU2LDDAa31zY3ykcMvCcg4RdXvC5
         2jxA==
X-Received: by 10.224.11.200 with SMTP id u8mr6841779qau.76.1365683132286;
        Thu, 11 Apr 2013 05:25:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id en8sm5891820qeb.0.2013.04.11.05.25.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220873>

From: Antoine Pelisse <apelisse@gmail.com>

The hg_log() test helper uses the "--graph" parameter that is
implemented by the GraphLog extension. If the extension is not activated
by the user, the parameter is not available. Activate the extension in
setup().

Also changes the way we grep the output in hg_log(). The pipe operator
can hide the return code of hg command. As a matter of fact, if log
fails because it doesn't know about "--graph", it doesn't report any
failure and let's you think everything worked.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 5 ++++-
 contrib/remote-helpers/test-hg-hg-git.sh | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index a3c88f6..f368953 100755
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
index 73ae18d..253e65a 100755
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
1.8.2.1
