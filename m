From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/6] t/t5528-push-default: test pushdefault workflows
Date: Wed, 19 Jun 2013 16:41:44 +0530
Message-ID: <1371640304-26019-7-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGME-0003hC-0s
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934422Ab3FSLPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:15:16 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56463 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934324Ab3FSLPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:15:06 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so4927274pbb.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JC9vTvgkaVWXCeSCxlYY4E287PYj2rtTEJkjtLeeDsc=;
        b=FTB5icrZYu9q1yndTz8Ou3oamRBJsAoIOsswKG233wgsCkqUlgT6j42Um01ADf/sO9
         qV9Uuag+va4n7Ivgaz3HMi+1zCDXj6ejRYTQk8VfMvzxXj9XHTcr+lfigusbY/MMv1J/
         RllmbWjOwYaRnN3oTgy1QvYVwNO9R9uuHkBI62k+ghFPHHQg0qmZa13tQwKPpHQXbwu5
         t3gwcGPspY+Z3ov98+nuwD7wmL1A41x0yiNfzhWUdY8T3Gg5KOZn7kZRDW+b0Vwn6R6F
         l4HgXQamtm0hU2S1d5kEyhfVecI7mPFAAo6Brb3oryj7uJOVn92GCl4x2lCVEdQC2uKz
         2qhw==
X-Received: by 10.68.175.228 with SMTP id cd4mr2362473pbc.40.1371640506067;
        Wed, 19 Jun 2013 04:15:06 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.15.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228389>

Introduce test_pushdefault_workflows(), and test that all push.default
modes work with central and triangular workflows as expected.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5528-push-default.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index b599186..eabc09d 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -39,6 +39,26 @@ test_push_failure () {
 	test_cmp expect actual
 }
 
+# $1 = success or failure
+# $2 = push.default value
+# $3 = branch to check for actual output (master or foo)
+# $4 = [optional] switch to triangular workflow
+test_pushdefault_workflow () {
+	workflow=central
+	pushdefault=parent1
+	if test -n "${4-}"; then
+		workflow=triangular
+		pushdefault=parent2
+	fi
+test_expect_success "push.default = $2 $1 in $workflow workflows" "
+	test_config branch.master.remote parent1 &&
+	test_config branch.master.merge refs/heads/foo &&
+	test_config remote.pushdefault $pushdefault &&
+	test_commit commit-for-$2${4+-triangular} &&
+	test_push_$1 $2 $3 ${4+repo2}
+"
+}
+
 test_expect_success '"upstream" pushes to configured upstream' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
@@ -115,4 +135,20 @@ test_expect_success 'push to existing branch, upstream configured with different
 	test_cmp expect-other-name actual-other-name
 '
 
+## test_pushdefault_workflow() arguments:
+# $1 = success or failure
+# $2 = push.default value
+# $3 = branch to check for actual output (master or foo)
+# $4 = [optional] switch to triangular workflow
+
+test_pushdefault_workflow success current master  # breaks push/pull symmetry
+test_pushdefault_workflow success upstream foo    # preserves push/pull symmetry
+test_pushdefault_workflow failure simple master   # errors out on asymmetry
+test_pushdefault_workflow success matching master # always works
+
+test_pushdefault_workflow success current master triangular  # always works
+test_pushdefault_workflow failure upstream foo triangular    # always errors out
+test_pushdefault_workflow success simple master triangular   # works like current
+test_pushdefault_workflow success matching master triangular # always works
+
 test_done
-- 
1.8.3.1.454.g30263f3.dirty
