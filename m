From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 5/5] fsck: improve committer/author check
Date: Thu, 11 Aug 2011 16:21:10 +0600
Message-ID: <1313058070-4774-6-git-send-email-divanorama@gmail.com>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO4-0004S2-1v
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab1HKKVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:21:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56320 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab1HKKVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:21:05 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so867233bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mCsYHYk2WAts+fWKEptXr5JiGpR/WvBszm/ePuicf0Q=;
        b=vdtzlKqOywrS4yPZB7dpm7jyxFSBbQE2rro60oSSGXgH2tQr7+wykxLAglXnytRxFa
         97DO58PcGRY19St7pomBmNbbbDai/B8NaiRUVG9zmLtybeAYBnffy737oYPi8iiWBGpT
         IzcVLT8Ef32kvqfqQ39Add+eGl5w4I22jtPSk=
Received: by 10.204.152.139 with SMTP id g11mr2732993bkw.220.1313058064650;
        Thu, 11 Aug 2011 03:21:04 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.21.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:21:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179104>

fsck allows a name with > character in it like "name> <email>". Also for
"name email>" fsck says "missing space before email".

More precisely, it seeks for a first '<', checks that ' ' preceeds it.
Then seeks to '<' or '>' and checks that it is the '>'. Missing space is
reported if either '<' is not found or it's not preceeded with ' '.

Change it to following. Seek to '<' or '>', check that it is '<' and is
preceeded with ' '. Seek to '<' or '>' and check that it is '>'. So now
"name> <email>" is rejected as "bad name". More strict name check is the
only change in what is accepted.

Report 'missing space' only if '<' is found and is not preceeded with a
space.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fsck.c          |   10 ++++++----
 t/t1450-fsck.sh |    6 +++---
 2 files changed, 9 insertions(+), 7 deletions(-)

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
index 01ccefd..523ce9c 100755
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
 
-test_expect_failure 'missing email is reported nicely' '
+test_expect_success 'missing email is reported nicely' '
 	git cat-file commit HEAD >basis &&
 	sed "s/[a-z]* <[^>]*>//" basis >bad-email-3 &&
 	new=$(git hash-object -t commit -w --stdin <bad-email-3) &&
@@ -134,7 +134,7 @@ test_expect_failure 'missing email is reported nicely' '
 	grep "error in commit $new.* - missing email" out
 '
 
-test_expect_failure '> in name is reported' '
+test_expect_success '> in name is reported' '
 	git cat-file commit HEAD >basis &&
 	sed "s/ </> </" basis >bad-email-4 &&
 	new=$(git hash-object -t commit -w --stdin <bad-email-4) &&
-- 
1.7.3.4
