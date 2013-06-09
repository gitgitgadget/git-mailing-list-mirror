From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] t/push-default: generalize test_push_{success, commit}
Date: Sun,  9 Jun 2013 22:43:19 +0530
Message-ID: <1370798000-2358-4-git-send-email-artagnon@gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljDK-0001pk-Oc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3FIRPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:15:31 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54195 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3FIRPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:15:30 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so699929pdj.10
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FPPmt6/NVqFKOczXYLizNciCPyBWhPPGkYmdVPshDGc=;
        b=m82xteSPkCxs35MKhy/lRRyZk2+L84SwCVbjow9Gpj5bAUuOgrUOY6yaactehtqpyj
         id07R55Pu4xFjlldf9XmbpVDiNK8QK4+DBsH90IlQ0Z22uTJpjGtrw0SQZaZaH3RNk7E
         5j7QYNUpsADD8dnqiKfkC1lPXkyoGZF9C3vyneCnSA7KHatauSaoduWqmNZWgkI4HJ0D
         dFc5skQhLHKXhdfdYa5bAzSzhSlnCtOKwWTlKkWT9/3JIhPk5Qq4DNdKvKDfpCara8wU
         z/u+ifLZK7s5dlXUEuNsxB2c3zjnWyvGPjpBaSD7OZvjEk6CPn6riGXUhS0YrPeOty8d
         uoEw==
X-Received: by 10.68.113.65 with SMTP id iw1mr6517443pbb.129.1370798129661;
        Sun, 09 Jun 2013 10:15:29 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm7235373pbc.12.2013.06.09.10.15.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227027>

The setup creates two bare repositories: repo1 and repo2, but
test_push_commit() hard-codes checking in repo1 for the actual output.
Generalize it and its caller, test_push_success(), to optionally accept
a third argument to specify the name of the repository to check for
actual output.  We will use this in the next patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4e4824e..9ddd3a9 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -15,17 +15,19 @@ test_expect_success 'setup bare remotes' '
 
 # $1 = local revision
 # $2 = remote revision (tested to be equal to the local one)
+# $3 = [optional] repo to check for actual output (repo1 by default)
 check_pushed_commit () {
 	git log -1 --format='%h %s' "$1" >expect &&
-	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
+	git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
 	test_cmp expect actual
 }
 
 # $1 = push.default value
 # $2 = expected target branch for the push
+# $3 = [optional] repo to check for actual output (repo1 by default)
 test_push_success () {
 	git -c push.default="$1" push &&
-	check_pushed_commit HEAD "$2"
+	check_pushed_commit HEAD "$2" "$3"
 }
 
 # $1 = push.default value
-- 
1.8.3.247.g485169c
