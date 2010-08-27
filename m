From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] t6200-fmt-merge-msg: Exercise 'merge.log' to configure shortlog length
Date: Fri, 27 Aug 2010 19:44:49 +0530
Message-ID: <1282918490-5190-2-git-send-email-artagnon@gmail.com>
References: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 16:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OozkA-0005po-U0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 16:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab0H0ORH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 10:17:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab0H0ORF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 10:17:05 -0400
Received: by pwi7 with SMTP id 7so1153741pwi.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=T/+TD07nygC8fxdrwi828Af2PZo4gg9Pux/MDCYbSrM=;
        b=GcJxMSD0dUmAlJCH5m1aCob2khdNmrt9caIyctMELN4sx43kRsEFIuXI6tpBw2q5zS
         HzugkOwTR1sbJvFDwBAhvwJJHblcQ2HKBUn7bQ/17lt02p79eTQifBsRh7x6Kw3jIgNY
         mI8/VA0dhkYueKTyRvRRoJWnaC0ETkzG4l0kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xBKfZsCFzoHMMIO6X/zd8wgTmPMWwHckUr3hzvfgKdHoof7fCJuTphjAZtiXIFYEiP
         4I7/d87kYrSqf/0qSZcKf2iTh/r91iFN4GbkOUPsmTz7D99Rs27hvkuKmx24pTAsgHTP
         zldrb+49x47a7enNw7+2NBGsajz7AsOUEbjU8=
Received: by 10.114.77.13 with SMTP id z13mr480450waa.196.1282918624838;
        Fri, 27 Aug 2010 07:17:04 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o17sm525142wal.21.2010.08.27.07.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 07:17:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154598>

Add a test to exercise the 'merge.log' configuration option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 71f6cad..750568e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -129,6 +129,61 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
+test_expect_success 'configurable shortlog length: merge.log' '
+	cat >expected_a <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left: (5 commits)
+	  Left #5
+	  Left #4
+	  Left #3
+	  ...
+	EOF
+
+	git config merge.log 3 &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
+
+	test_might_fail git config --unset-all merge.log &&
+	git config merge.summary 3 &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual2 &&
+
+	echo "Merge branch ${apos}left${apos}" >expected_b &&
+
+	git config merge.log 0 &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual3 &&
+
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual4 &&
+
+	test_cmp expected_a actual1 &&
+	test_cmp expected_a actual2 &&
+	test_cmp expected_b actual3 &&
+	test_cmp expected_b actual4
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
