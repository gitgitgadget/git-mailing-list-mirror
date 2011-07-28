From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 5/5] fsck: improve committer/author check
Date: Thu, 28 Jul 2011 11:44:04 +0600
Message-ID: <1311831844-13123-6-git-send-email-divanorama@gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLj-0004L5-D5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1G1Flb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56514 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab1G1FlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:22 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so916357fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aW5nDIeLdIBAqpXycCcADQTSt7H4jN/Zu0LhgfXJQZI=;
        b=uuduuWMsXjxJwDzOs+9bCH4Jd1B36rnC2j98BJg9j0BuKwGbsaoA8K4WchoOC/kA3/
         LLSvKyQFXgDmEnNoeNmuN47cLuVTDN/vutIWaSa7qhkoZcRPNmmpS5uTpywXXXV4tl4s
         RrmnMCnTHhjkIZp+cOi91ABznP5D6+oGJXpJM=
Received: by 10.204.146.5 with SMTP id f5mr203013bkv.155.1311831681840;
        Wed, 27 Jul 2011 22:41:21 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178040>

Neither name nor email should contain < or >, so split the string with
these and check they come in that order and < is preceeded with a space.

If < is missing don't say a confusing "missing space", say "bad name" if
> isn't missing and "missing email" if both < and > are missing.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fsck.c          |   10 ++++++----
 t/t1450-fsck.sh |    4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fsck.c b/fsck.c
index 60bd4bb..6c855f8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -224,13 +224,15 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 
 static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 {
-	if (**ident == '<' || **ident == '\n')
-		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
-	*ident += strcspn(*ident, "<\n");
-	if ((*ident)[-1] != ' ')
+	if (**ident == '<')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+	*ident += strcspn(*ident, "<>\n");
+	if (**ident == '>')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad name");
 	if (**ident != '<')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing email");
+	if ((*ident)[-1] != ' ')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
 	(*ident)++;
 	*ident += strcspn(*ident, "<>\n");
 	if (**ident != '>')
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index fc7ee8e..0b92d0f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -110,7 +110,7 @@ test_expect_success 'email with embedded > is not okay' '
 	grep "error in commit $new" out
 '
 
-test_expect_failure 'missing < email delimiter is reported nicely' '
+test_expect_success 'missing < email delimiter is reported nicely' '
 	git cat-file commit HEAD >basis &&
 	sed "s/<//" basis >bad-email-2 &&
 	new=$(git hash-object -t commit -w --stdin <bad-email-2) &&
@@ -122,7 +122,7 @@ test_expect_failure 'missing < email delimiter is reported nicely' '
 	grep "error in commit $new.* - bad name" out
 '
 
-test_expect_failure '> in name is reported' '
+test_expect_success '> in name is reported' '
 	git cat-file commit HEAD >basis &&
 	sed "s/ </> </" basis >bad-email-3 &&
 	new=$(git hash-object -t commit -w --stdin <bad-email-3) &&
-- 
1.7.3.4
