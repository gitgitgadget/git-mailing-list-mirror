From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] stash: don't leak underlying error messages
Date: Wed, 11 Apr 2012 20:36:19 +0200
Message-ID: <1334169379-20827-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 20:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2Pu-0004sO-E4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab2DKShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:37:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64013 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab2DKShL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:37:11 -0400
Received: by wibhq7 with SMTP id hq7so1175291wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HgGyuIUzuALg3Sjx5Obp0kZZk8D0BmM7yt5tNbb0K38=;
        b=Bnrijb8M2ptAbQB9IHzcc5f50YHxEH/FHRgBa/SOqPiNHPCTr+7SoBeqYwk2qWDM7Y
         hwmwqh9MKb1xuyYMA7PwuVeqwdAfwe7bX0uofV7I79cKdCRVKXtfpUcCzAzoN3KcN+O5
         sNYUx2VGbmTwQ67m0So/jsdTZfnjPgFunbdY6JeeN+zYdO1oHN6U3589LdV8ddRUVAow
         /aEeEeuFUK6eKwplxSeH830wxbgewx0x2rzmq/8yYRNBaSZNVZEKRozuHu+25L/ymDIC
         XO1Z0oA6AOJ1fuP+3P6ny2HrwkAhJcFRYk3UtsKjgpjtJHswlqjMNhP7Ti3S6LyEsVHD
         0wNw==
Received: by 10.180.102.101 with SMTP id fn5mr18568283wib.6.1334169429919;
        Wed, 11 Apr 2012 11:37:09 -0700 (PDT)
Received: from localhost.localdomain (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id fz9sm46643840wib.3.2012.04.11.11.37.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 11:37:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195234>

When running git-stash on an empty repository, don't let the underlying
error messages leak through to the surface; instead, redirect them to
/dev/null.
---
 git-stash.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fe4ab28..5c72d1b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -34,8 +34,8 @@ else
 fi
 
 no_changes () {
-	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
-	git diff-files --quiet --ignore-submodules &&
+	git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null &&
+	git diff-files --quiet --ignore-submodules 2>/dev/null &&
 	(test -z "$untracked" || test -z "$(untracked_files)")
 }
 
@@ -67,7 +67,7 @@ create_stash () {
 	fi
 
 	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
+	if b_commit=$(git rev-parse --verify HEAD 2>/dev/null)
 	then
 		head=$(git rev-list --oneline -n 1 HEAD --)
 	else
-- 
1.7.10
