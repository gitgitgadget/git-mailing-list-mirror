From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
Date: Fri, 27 Aug 2010 19:44:50 +0530
Message-ID: <1282918490-5190-3-git-send-email-artagnon@gmail.com>
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
	id 1OozkC-0005po-4N
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 16:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab0H0ORL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 10:17:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab0H0ORK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 10:17:10 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so1153741pwi.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+nntP2SZaIDixxV1pSuChvPbnagtPN/H2J091BEEURU=;
        b=aur0pODwq2kua8NCASJ9hoGug6oTj7S/8J6w7gwchPzhgSy4Z/8cogf6eEpMAceMlP
         upGmhAOfRff7PiTmESgW+VIF4mkui0mw4LvEjAh5+OCoeTgaXu08bMJ5cD4w7LOQ9hbA
         +XXfgIXu8EpRtrAi9it8hLDBriwPT5bwPQc6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cVnpVpuuvOPadbSk7G9V1gqmbx2BCMr5rztW4+z1Gn95rHh8Xrp4tuO4GeI5Nh0Xi/
         /mmibQ64CMBBvXlsIRy6/3XPvIBuiBtPHWVUi/Cb56kh/nHEN/jSDCrHUcG8hT08t4st
         1Rf3B4aN71kZIaRhzJT7rEKXDhV/19LOdzQp8=
Received: by 10.114.66.5 with SMTP id o5mr478041waa.219.1282918630075;
        Fri, 27 Aug 2010 07:17:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o17sm525142wal.21.2010.08.27.07.17.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 07:17:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154599>

Add a test to exercise the '--log' command-line option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 750568e..b308c3b 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -184,6 +184,62 @@ test_expect_success 'configurable shortlog length: merge.log' '
 	test_cmp expected_b actual4
 '
 
+test_expect_success 'configurable shortlog length: --log' '
+	cat >expected1 <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left: (5 commits)
+	  Left #5
+	  Left #4
+	  Left #3
+	  ...
+	EOF
+
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg --log=3 <.git/FETCH_HEAD >actual1 &&
+
+	cat >expected_b <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg --log <.git/FETCH_HEAD >actual2 &&
+
+	echo "Merge branch ${apos}left${apos}" >expected_c &&
+
+	test_might_fail git config --unset-all merge.log &&
+	test_might_fail git config --unset-all merge.summary &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . left &&
+
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual3 &&
+
+	test_cmp expected_a actual1 &&
+	test_cmp expected_b actual2 &&
+	test_cmp expected_c actual3
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
