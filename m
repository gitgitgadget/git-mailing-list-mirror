From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/11] t4211: log: demonstrate -L bounds checking bug
Date: Wed, 31 Jul 2013 04:15:39 -0400
Message-ID: <1375258545-42240-6-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:21:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rel-0000Tb-O5
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252Ab3GaIVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:21:11 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:50623 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759091Ab3GaIQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:38 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so217849yhn.40
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=m9dl+VBd3dpUlnlPpDfeys9uGLeZs7x3qdPYGzjbGHU=;
        b=hKkE5I3V0vccMzFKqUrd0Nk/TzogKOYszLDf7G4iwuLy0SArrFG0hzaOv3Anbker+I
         Ltp1cgUqvwciI5oP+4TH4AwgHN9fgqZi8hioDeofkKFqR+FYNVlpRqciky210CMkWeI1
         G/4a71WOupyiBNfR+U/AQkHEPxo9Kq/XBZ404mIaYsNiYfSdnk+spMnoZ+4seuVa+oNA
         wrJ0mxoxAjT5j6M2T/BZT3kd4BLQpFlULDggFXI14pDb/xq0V3yIqUwGPIY+EHF9arOd
         7oZo6xYUtDhJIuZPjT6iBLw7FQ69ju4IQZ6oERAZRtUpuL3Cy+HKWvCHJykcd+A/+aeR
         6B2A==
X-Received: by 10.236.90.143 with SMTP id e15mr21457489yhf.185.1375258598325;
        Wed, 31 Jul 2013 01:16:38 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231411>

A bounds checking bug allows the X in -LX to extend one line past the
end of file. For example, given a file with 5 lines, -L6 is accepted as
valid. Demonstrate this problem.

While here, also add tests to check that the remaining cases of X and Y
in -LX,Y are handled correctly at and in the vicinity of end-of-file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4211-line-log.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7665d67..f98275c 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -64,6 +64,36 @@ test_bad_opts "-L 1,1000:b.c" "has only.*lines"
 test_bad_opts "-L :b.c" "argument.*not of the form"
 test_bad_opts "-L :foo:b.c" "no match"
 
+test_expect_success '-L X (X == nlines)' '
+	n=$(wc -l <b.c) &&
+	git log -L $n:b.c
+'
+
+test_expect_failure '-L X (X == nlines + 1)' '
+	n=$(expr $(wc -l <b.c) + 1) &&
+	test_must_fail git log -L $n:b.c
+'
+
+test_expect_success '-L X (X == nlines + 2)' '
+	n=$(expr $(wc -l <b.c) + 2) &&
+	test_must_fail git log -L $n:b.c
+'
+
+test_expect_success '-L ,Y (Y == nlines)' '
+	n=$(printf "%d" $(wc -l <b.c)) &&
+	git log -L ,$n:b.c
+'
+
+test_expect_success '-L ,Y (Y == nlines + 1)' '
+	n=$(expr $(wc -l <b.c) + 1) &&
+	test_must_fail git log -L ,$n:b.c
+'
+
+test_expect_success '-L ,Y (Y == nlines + 2)' '
+	n=$(expr $(wc -l <b.c) + 2) &&
+	test_must_fail git log -L ,$n:b.c
+'
+
 # There is a separate bug when an empty -L range is the first -L encountered,
 # thus to demonstrate this particular bug, the empty -L range must follow a
 # non-empty -L range.
-- 
1.8.3.4.1120.gc240c48
