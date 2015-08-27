From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/3] git-p4: failing test for ignoring invalid p4 labels
Date: Thu, 27 Aug 2015 08:18:56 +0100
Message-ID: <1440659938-12952-2-git-send-email-luke@diamand.org>
References: <1440659938-12952-1-git-send-email-luke@diamand.org>
Cc: marcus.holl@sap.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 09:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUrT6-0005Dv-EB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 09:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbbH0HTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 03:19:16 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37105 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbbH0HTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 03:19:15 -0400
Received: by widdq5 with SMTP id dq5so35494810wid.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WPqA1gQ/yy4KZ3Sl/AvqERPYGZt1m9rQEbzpZCe/nGA=;
        b=Gbx3eJZuS5g67qsJEZ89sv6sskCjbRs0VqWrGb2TSuhtLy0+2wdOmYqobHB2F7Sk1p
         4Ugm93778uiDnf7F7+QSVbkg5w8TUnXziJLQ0Wv4n4YduXeKUwIUOsl4mk4dQpz5/7VN
         SH9j/ZM7CvSVSHytWlkDuFv/h+a1TaWdvO23M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WPqA1gQ/yy4KZ3Sl/AvqERPYGZt1m9rQEbzpZCe/nGA=;
        b=SzcDHePjAtrF5U0gKQELYHdNRrsaAWFrczNc1EVnFTk3pPdM/9GzR99PRLUWQ/nJB0
         08UpjVdEP/dYMvD+SreIQLSS7oS6EHSFJjoBnfDytvarmp/8eFMRXUCplqKKKNDPezXR
         zNUFKHh4p1n8t/mIy6oYZaBFTd1PJfB2RogDlAJf1HxU0x3v5r/ONsnH0fHgImv3coqA
         RvssiyummcNgm78lOGrFauqykO0ko9qfANCqGttnOQ1FmTatLW7VRH8Y0+56n2U7KC2A
         TGsXXZua6BBEywj1jB6c+cpUtUoCym417jHbmWQDsdu+reNpkxqmjBSEQJkyZwE1srzB
         1jmg==
X-Gm-Message-State: ALoCoQnV4CnTV8Wizfp8TnDvGXya8sceWNAXuBzIXpHyXEOk+tAH2FKgRRBKM4j5ERQOdJHjOlVD
X-Received: by 10.194.82.167 with SMTP id j7mr2797024wjy.123.1440659954000;
        Thu, 27 Aug 2015 00:19:14 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id ne7sm2140308wic.12.2015.08.27.00.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 00:19:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0
In-Reply-To: <1440659938-12952-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276662>

When importing a label which references a commit that git-p4 does
not know about, git-p4 should skip it and go on to process other
labels that can be imported.

Instead it crashes when attempting to find the missing commit in
the git history. This test demonstrates the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9811-git-p4-label-import.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 095238f..f7d5048 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -214,6 +214,51 @@ test_expect_success 'use git config to enable import/export of tags' '
 	)
 '
 
+p4_head_revision() {
+	p4 changes -m 1 "$@" | awk '{print $2}'
+}
+
+# Importing a label that references a P4 commit that has
+# has not been seen. The presence of a label on a commit
+# we haven't seen should not cause git-p4 to fail. It should
+# merely skip that label, and still import other labels.
+test_expect_failure 'importing labels with missing revisions' '
+	test_when_finished cleanup_git &&
+	(
+		rm -fr "$cli" "$git" &&
+		mkdir "$cli" &&
+		P4CLIENT=missing-revision &&
+		client_view "//depot/missing-revision/... //missing-revision/..." &&
+		cd "$cli" &&
+		>f1 && p4 add f1 && p4 submit -d "start" &&
+
+		p4 tag -l TAG_S0 ... &&
+
+		>f2 && p4 add f2 && p4 submit -d "second" &&
+
+		startrev=$(p4_head_revision //depot/missing-revision/...) &&
+
+		>f3 && p4 add f3 && p4 submit -d "third" &&
+
+		p4 edit f2 && date >f2 && p4 submit -d "change" f2 &&
+
+		endrev=$(p4_head_revision //depot/missing-revision/...) &&
+
+		p4 tag -l TAG_S1 ... &&
+
+		# we should skip TAG_S0 since it is before our startpoint,
+		# but pick up TAG_S1.
+
+		git p4 clone --dest="$git" --import-labels -v \
+			//depot/missing-revision/...@$startrev,$endrev &&
+		(
+			cd "$git" &&
+			git rev-parse TAG_S1 &&
+			! git rev-parse TAG_S0
+		)
+	)
+'
+
 
 test_expect_success 'kill p4d' '
 	kill_p4d
-- 
2.5.0.rc0
