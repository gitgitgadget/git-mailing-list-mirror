From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/11] t8001/t8002: blame: demonstrate -L bounds checking bug
Date: Wed, 31 Jul 2013 04:15:36 -0400
Message-ID: <1375258545-42240-3-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:16:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4RaQ-0005zM-8W
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab3GaIQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:34 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:56515 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3GaIQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:33 -0400
Received: by mail-gh0-f179.google.com with SMTP id f16so178847ghb.10
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=een36haJ+Nf4YYvfb38HKryK9P8ehdWD83Xc72ZUkZ0=;
        b=G7ZgpX2JYyERn3XSTUQt6NcOa4eBUVc0LJ4Uvcw9hLcg2+rIRvkhlnV4REV6gc7Ki4
         y3rdYvBv9WIRBCwY0jw+5kPE4BgMSr7GKWr5MkvU6lP0CrbXZCaskRhVGXVxdPn6ev/q
         vCYzGbMtlEo1EgB1qVcw1FCeEisfJ8RYY3c6rDuuFk4SLBJQID5qdmeBBdKYHi3jxpzX
         woKl93n7mOqVEP7T9f20LLdtvpLJ0HaYKrW35DWK1k/Qx8Nu8VXzBTJBsvIJe5oQT7+L
         +sS1a4ElcJabUt1dyuvZ+3zoA68VyeotSz6jJkE0YmpzyQxN2/TpDkXnFuAM8LNx/Itp
         EOVA==
X-Received: by 10.236.203.232 with SMTP id f68mr31805883yho.191.1375258592577;
        Wed, 31 Jul 2013 01:16:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231402>

A bounds checking bug allows the X in -LX to extend one line past the
end of file. For example, given a file with 5 lines, -L6 is accepted as
valid. Demonstrate this problem.

While here, also add tests to check that the remaining cases of X and Y
in -LX,Y are handled correctly at and in the vicinity of end-of-file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 3524eaf..02fbbf1 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -225,10 +225,32 @@ test_expect_success 'blame -L /RE/,-N' '
 	check_count -L/99/,-3 B 1 B2 1 D 1
 '
 
+# 'file' ends with an incomplete line, so 'wc' reports one fewer lines than
+# git-blame sees, hence the last line is actually $(wc...)+1.
+test_expect_success 'blame -L X (X == nlines)' '
+	n=$(expr $(wc -l <file) + 1) &&
+	check_count -L$n C 1
+'
+
+test_expect_failure 'blame -L X (X == nlines + 1)' '
+	n=$(expr $(wc -l <file) + 2) &&
+	test_must_fail $PROG -L$n file
+'
+
 test_expect_success 'blame -L X (X > nlines)' '
 	test_must_fail $PROG -L12345 file
 '
 
+test_expect_success 'blame -L ,Y (Y == nlines)' '
+	n=$(expr $(wc -l <file) + 1) &&
+	check_count -L,$n A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
+'
+
+test_expect_success 'blame -L ,Y (Y == nlines + 1)' '
+	n=$(expr $(wc -l <file) + 2) &&
+	test_must_fail $PROG -L,$n file
+'
+
 test_expect_success 'blame -L ,Y (Y > nlines)' '
 	test_must_fail $PROG -L,12345 file
 '
-- 
1.8.3.4.1120.gc240c48
