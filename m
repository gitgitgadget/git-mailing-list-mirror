From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/11] log: fix -L bounds checking bug
Date: Wed, 31 Jul 2013 04:15:41 -0400
Message-ID: <1375258545-42240-8-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rap-0006FE-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193Ab3GaIQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:47 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:40169 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759134Ab3GaIQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:42 -0400
Received: by mail-yh0-f52.google.com with SMTP id f11so218918yha.39
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=F2EbrO7KvjtdzXtRyt0QesPQhNo9DdR9sU8f2saqDQQ=;
        b=VYWPrQSGlLoBfvx5qKahfE694G/HZLx0tnHconehI3PtOLuOiJlsIOmnILykIFPxzS
         Zg31DJ1KtpwSz9Q4IoWZqtFwpD+8qigVSjYFsOWMJm/Bb9L99z38vJivk1fV4O7j5ujY
         QMxP3rSkxqE7kXWB4D0KWCqmIdT2q8SE1qqonnmzuLy5PlhxX60nFAanKcCTiUsiui/q
         GjLUDj4VxR7TJMtFYBn6vsn/jtbjHWdcFNPzm1374xTzjqqVIL2c1LQSBPkIz7EPd0c3
         dfLBD6MnX6x1Iq+lIF5mWFZIz7qpg5aigb61pikWAApLM05GcxyuwdtFV7LJDMaBR67+
         VJHg==
X-Received: by 10.236.118.144 with SMTP id l16mr15359488yhh.84.1375258602132;
        Wed, 31 Jul 2013 01:16:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231406>

When 12da1d1f added -L support to git-log, a broken bounds check was
copied from git-blame -L which incorrectly allows -LX to extend one line
past end of file without reporting an error.  Instead, it generates an
empty range.  Fix this bug.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-log.c          | 4 ++--
 t/t4211-line-log.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index c2d01dc..1c3ac8d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -594,13 +594,13 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 				    lines, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
+		if (lines < end || ((lines || begin) && lines < begin))
+			die("file %s has only %lu lines", name_part, lines);
 		if (begin < 1)
 			begin = 1;
 		if (end < 1)
 			end = lines;
 		begin--;
-		if (lines < end || lines < begin)
-			die("file %s has only %ld lines", name_part, lines);
 		line_log_data_insert(&ranges, full_name, begin, end);
 
 		free_filespec(spec);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 769ac68..b01b3dd 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -69,7 +69,7 @@ test_expect_success '-L X (X == nlines)' '
 	git log -L $n:b.c
 '
 
-test_expect_failure '-L X (X == nlines + 1)' '
+test_expect_success '-L X (X == nlines + 1)' '
 	n=$(expr $(wc -l <b.c) + 1) &&
 	test_must_fail git log -L $n:b.c
 '
-- 
1.8.3.4.1120.gc240c48
