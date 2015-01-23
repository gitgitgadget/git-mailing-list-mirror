From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/6] update-ref: test handling large transactions properly
Date: Fri, 23 Jan 2015 12:03:57 -0800
Message-ID: <1422043442-30676-2-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTk-0007KR-5j
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbbAWUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:10 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34952 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbbAWUFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:06 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so3794796igb.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bKeX5Rbf3FbKhWd9oYF9lkpP4qGDrRK4sHnWMo7azws=;
        b=HGj+3l+nYyB+AxE1QTfPyV9tHaHxTKyVGWRyV9SguxxtzCvqMBZ7rKJRX/uD9LFBiX
         3C17M8s9XR9+OeqlvC63sYgWV+r7vS8u3b6dwnt0H6kLKBvFRwkxqtX9gcBCflUUpvez
         BtVd5OojjBWA2D4/6oaNY5BJZkZ6+BAysvfniz/RzYX8W3AhLhYErMIZyXNqkietOyA+
         gP6iYiD9+jjuXuTvPDWz+hbCofSHHU5Qv2O34BZb/5ya9CjkzuB3vXrI+9QyxmLDj94F
         nkxgO0AgS4/1ReqDYCMfOvW3/5dPX+xjDb/7FrNV5N/GuJcd0RQ+OIA1XDERZgoYMtg9
         498A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bKeX5Rbf3FbKhWd9oYF9lkpP4qGDrRK4sHnWMo7azws=;
        b=LmViLjFHlS61wzMuzOTNIi2voyBsgAvikUIPxgNUC0bpNP/1MpEur+lE1Y/RX3ylu0
         A8/rqA0aHBX4hyvmIHBIBWXRUddV70ZNK6UtUsemG4lKI5PQfZHo+k/T2iOwd0z3q1C5
         pSswAKMrOvLlx0zBBQHpuc8/42a1QqrzfccXkxw7WxdAok0Z8ffMiAMzqMoToaOZB93B
         jeWLiP8sbE2vRVfb99O3haUbB9SmcCxdASqmb8so/1p6yfhor8sXqoxiobpxbSMF44pB
         /VHYPHy4686vFU9bG+TIavKOCFOGcKP9PLOo1gRWqh0u5pqDSJpF9tmxzr/3MQm8MB3i
         YqtQ==
X-Gm-Message-State: ALoCoQmqqCvcGnkz2GEL1/brjhXOf+tpRhX08jaA/F5BOxweAKspphwNwCmkA0GycIscraO+etli
X-Received: by 10.42.194.17 with SMTP id dw17mr10370424icb.4.1422043505718;
        Fri, 23 Jan 2015 12:05:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id v64sm1368037ioi.18.2015.01.23.12.05.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:05 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262956>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes:
    v2->v3:
    no changes

 t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7b4707b..47d2fe9 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -973,4 +973,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "create refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	git rev-parse --verify -q refs/heads/33
+)
+'
+
+test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
+(
+	for i in $(test_seq 33)
+	do
+		echo "delete refs/heads/$i HEAD"
+	done >large_input &&
+	run_with_limited_open_files git update-ref --stdin <large_input &&
+	test_must_fail git rev-parse --verify -q refs/heads/33
+)
+'
+
 test_done
-- 
2.2.1.62.g3f15098
