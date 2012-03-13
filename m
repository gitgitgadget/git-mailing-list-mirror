From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] test: test cherry-pick functionality and output
 separately
Date: Tue, 13 Mar 2012 00:00:36 -0500
Message-ID: <20120313050036.GD12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jqx-0003rq-VC
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab2CMFAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:00:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51477 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2CMFAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:00:50 -0400
Received: by yhmm54 with SMTP id m54so140351yhm.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6UtQ1Ioq+xsiNkTVxFpcJmrs1vtpy7F07urhh6wO3cg=;
        b=dJg/Yi94rbdFVXefwIxJJmHCnkYqkcDrD/IiKkO6fsf/4xMvP4ebP99M9V+2ZNxOS/
         KU7iZRmQpEb424SFMee7+VL2uXHhh62V19U7OD8P3Fa5ZPxIu0mphEJwppCjZCZpuXnf
         DD3CPxVTYke0Qx+Qql5CL1KqA1zbJcq0HPAyESmupK7j/SIgHtaJ4XMpzkBfiR2WBBxh
         Afzc/gmI4JvlIpP2c9q4IEGnECxgdkazsbUkMzUH9fjRc3JlTm44EQbC27nfo/vNqzxO
         zXs0AGqyMT1IAgngHjLJT+FwNMCe/xUvkhWX7R2C6cTYDcnLuwtr+76zZpvMZuEQE8s5
         G4WQ==
Received: by 10.182.111.3 with SMTP id ie3mr10304167obb.14.1331614849428;
        Mon, 12 Mar 2012 22:00:49 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c7sm13868205oeh.1.2012.03.12.22.00.48
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192975>

Since v1.7.3-rc0~26^2~9 (revert: report success when using option
--strategy, 2010-07-14), the cherry-pick-many-commits test checks the
format of output written to the terminal during a cherry-pick sequence
in addition to the functionality.  There is no reason those have to
be checked in the same test, though, and it has some downsides:

 - when progress output is broken, the test result does not convey
   whether the functionality was also broken or not

 - it is not immediately obvious when reading that these checks are
   meant to prevent regressions in details of the output format and
   are not just a roundabout way to check functional details like the
   number of commits produced

 - there is a temptation to include the same kind of output checking
   for every new cherry-pick test, which would make future changes
   to the output unnecessarily difficult

Put the tests from v1.7.3-rc0~26^2~9 in separate assertions, following
the principle "test one feature at a time".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3508-cherry-pick-many-commits.sh |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index d909e6db..75f7ff4f 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -35,6 +35,16 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick first..fourth works' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick first..fourth &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	check_head_differs_from fourth
+'
+
+test_expect_success 'output to keep user entertained during multi-pick' '
 	cat <<-\EOF >expected &&
 	[master OBJID] second
 	 Author: A U Thor <author@example.com>
@@ -51,15 +61,22 @@ test_expect_success 'cherry-pick first..fourth works' '
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick first..fourth >actual &&
-	git diff --quiet other &&
-	git diff --quiet HEAD other &&
-
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
-	test_i18ncmp expected actual.fuzzy &&
-	check_head_differs_from fourth
+	test_line_count -ge 3 actual.fuzzy &&
+	test_i18ncmp expected actual.fuzzy
 '
 
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick --strategy resolve first..fourth &&
+	git diff --quiet other &&
+	git diff --quiet HEAD other &&
+	check_head_differs_from fourth
+'
+
+test_expect_success 'output during multi-pick indicates merge strategy' '
 	cat <<-\EOF >expected &&
 	Trying simple merge.
 	[master OBJID] second
@@ -79,11 +96,8 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 	git reset --hard first &&
 	test_tick &&
 	git cherry-pick --strategy resolve first..fourth >actual &&
-	git diff --quiet other &&
-	git diff --quiet HEAD other &&
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
-	test_i18ncmp expected actual.fuzzy &&
-	check_head_differs_from fourth
+	test_i18ncmp expected actual.fuzzy
 '
 
 test_expect_success 'cherry-pick --ff first..fourth works' '
-- 
1.7.9.2
