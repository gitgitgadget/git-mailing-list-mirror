From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 02/12] t5520: test for failure if index has unresolved entries
Date: Thu,  7 May 2015 16:43:58 +0800
Message-ID: <1430988248-18285-3-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHPx-0005P8-1H
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbbEGIoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36041 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbEGIoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:22 -0400
Received: by pabsx10 with SMTP id sx10so34333775pab.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g4A35EMp/uvQzUZ5JM2lQLLUsW7deC6muScTY0YeIHg=;
        b=H+qTEB8a++DqCZk7tcACbtKHEsrKFDZeArugmy9e+3dEhG2RRWGjh7tOyZh2NY8+TO
         Fr9BZQjoLZkYQoNr9y3qLqBd0p8gCH4UXR8rSdFYIqPQyEpXwX3GudSa2NiAQT68v6Sg
         MNYPT9XfjSH/lvaP1ENe4ZlECp/XErsRn8E81kBbUDWeDVuI8JHuHuDigW9CnmsbdNgt
         DG6AJFCYV9JrREOPw+KCtROLwxlkP5aUHWZHIVtkirnjoRhwGGbJnm3lGaETuhttBWZW
         IoSUtebeLesop9LCZLKt0aukXNNbiScD+0j99DBn3CRPmcoMv4m1Nz31FtEL0FJiCLN4
         HbLg==
X-Received: by 10.70.5.101 with SMTP id r5mr5000806pdr.139.1430988262301;
        Thu, 07 May 2015 01:44:22 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268512>

Commit d38a30df (Be more user-friendly when refusing to do something
because of conflict) introduced code paths to git-pull which will error
out with user-friendly advices if the user is in the middle of a merge
or has unmerged files.

Implement tests to ensure that git-pull will not run, and will print
these advices, if the user is in the middle of a merge or has unmerged
files in the index.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Test that on merge conflict, git-pull will not reset conflict status,
      or modify the conflicted file.

 t/t5520-pull.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5add900..37ff45f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -164,6 +164,27 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test `cat file` = file
 '
 
+test_expect_success 'fail if the index has unresolved entries' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	echo modified2 >file &&
+	git commit -a -m modified2 &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second &&
+	test -n "$(git ls-files -u)" &&
+	cp file expected &&
+	test_must_fail git pull . second 2>out &&
+	test_i18ngrep "Pull is not possible because you have unmerged files" out &&
+	test_cmp expected file &&
+	git add file &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second 2>out &&
+	test_i18ngrep "You have not concluded your merge" out &&
+	test_cmp expected file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
