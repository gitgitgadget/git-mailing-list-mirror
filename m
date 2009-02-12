From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Bugfix: GIT_EXTERNAL_DIFF with more than one changed files
Date: Thu, 12 Feb 2009 21:36:14 +0800
Message-ID: <20090212133614.GA12746@bigbear>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 14:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXbfY-0002PI-8C
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 14:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbZBLNa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 08:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbZBLNa2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 08:30:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:1775 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbZBLNa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 08:30:27 -0500
Received: by ti-out-0910.google.com with SMTP id d10so463091tib.23
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=9300pqjrKifhphZD7rO2P0c7knc6EB/kEdM3pCCLrpg=;
        b=k6rJx0bjh+t2Yx4m2p+0e47A27yJ598oMHKNQroMR4af4L3QDndeUJxTajSO9P+J7N
         ztP+bJPyuIy7QUnvvgGtq7XvFbWDy5u7kwEY4LNBjvOviaiauuJmOaeTH3mCNZL6XGTT
         vmucpYWwZ3N7a5LDhxzK6dzDpMkvfydwWRy5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=bgr0lcgCxPcRK/o2ymc1+ZSfgv7zBbJzHhuo72nkNRcwNf9NnbTJa4XqhwALYgQFdj
         P/M0w9OyItNiFvXQfI6B2FGAyzjIsld+tb4AdH+sofXopYKNC/bazu1cWvfRjK+UY0NN
         3pXoI2rXDPwVJqoplWZxDORLbD9jzPYM3QtLs=
Received: by 10.110.40.8 with SMTP id n8mr1039798tin.28.1234445424414;
        Thu, 12 Feb 2009 05:30:24 -0800 (PST)
Received: from bigbear ([118.101.6.21])
        by mx.google.com with ESMTPS id w5sm30896tib.5.2009.02.12.05.30.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 05:30:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109617>

Regression introduced in 479b0ae81c9291a8bb8d7b2347cc58eeaa701304.

When there is more than one file that are changed, running
git diff with GIT_EXTERNAL_DIFF works only for the first file.

This patch fixes this problem and added a test case for it.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 diff.c                   |    8 ++++----
 t/t4020-diff-external.sh |    8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index a5a540f..be3859e 100644
--- a/diff.c
+++ b/diff.c
@@ -184,11 +184,11 @@ static int remove_tempfile_installed;
 static void remove_tempfile(void)
 {
 	int i;
-	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
-		if (diff_temp[i].name == diff_temp[i].tmp_path) {
+	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
+		if (diff_temp[i].name == diff_temp[i].tmp_path)
 			unlink(diff_temp[i].name);
-			diff_temp[i].name = NULL;
-		}
+		diff_temp[i].name = NULL;
+	}
 }
 
 static void remove_tempfile_on_signal(int signo)
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index caea292..281680d 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -128,4 +128,12 @@ test_expect_success 'force diff with "diff"' '
 	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
+	echo anotherfile > file2 &&
+	git add file2 &&
+	git commit -m "added 2nd file" &&
+	echo modified >file2 &&
+	GIT_EXTERNAL_DIFF=echo git diff
+'
+
 test_done
-- 
1.6.2.rc0.55.g30aa4f
