From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Fri,  5 Sep 2014 22:06:48 +1200
Message-ID: <1409911611-20370-2-git-send-email-judge.packham@gmail.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 12:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPqQT-0005bN-CT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 12:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbaIEKHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 06:07:20 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41987 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbaIEKHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 06:07:19 -0400
Received: by mail-ie0-f179.google.com with SMTP id tr6so13752279ieb.10
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wP88feSp0AKlE6gJZhps+wEfwoQ2CZJ0m9XoP7q3ZJo=;
        b=Q8BtirVuLj5PdTbiewnlLQV790wa7aU5I+aZY1MI1BQ8VsXv3M+bmrTIt5FpMuFNHy
         MpW52EYZ+oPQK4ZDBRTqpFKemb4gonLng0NTgIMH3CcuE3WBM+BTu+Z1kEdsIjUiMzov
         TNSQT0F1WIaHTYuCtUqseQe0GLg8O8MtI7Uk6a3xgMb3mGDigFM7bAqOT3JXQkhwXQPO
         fP+kOKrCFrq4nbjiHIzENRud1jLLHNbq8TCkkZaCLEfznlU4n76yeMonozTxFHw5Vcr4
         dLz7Tgp2HiTcTkCNiq9FjhWlynX0FiHv1iWHMDLgzinMeUrvnwQjgwREqqKaoFholGog
         N/uA==
X-Received: by 10.66.246.109 with SMTP id xv13mr19323453pac.144.1409911637325;
        Fri, 05 Sep 2014 03:07:17 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id o2sm1348068pdk.87.2014.09.05.03.07.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 03:07:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256503>

In check_patch_format we feed $1 to a block that attempts to determine
the patch format. Since we've already redirected $1 to stdin there is no
need to redirect it again when we invoke tr. This prevents the following
errors when invoking git am

  $ git am patch.patch
  tr: write error: Broken pipe
  tr: write error
  Patch format detection failed.

Cc: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Nothing new since http://article.gmane.org/gmane.comp.version-control.git/256425

 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..fade7f8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -250,7 +250,7 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			tr -d '\015' <"$1" |
+			tr -d '\015' |
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
-- 
2.1.0.64.gc343089
