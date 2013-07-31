From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/11] blame: reject empty ranges -LX,+0 and -LX,-0
Date: Wed, 31 Jul 2013 04:15:43 -0400
Message-ID: <1375258545-42240-10-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Raq-0006FE-8D
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206Ab3GaIQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:52 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:58918 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759063Ab3GaIQr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:47 -0400
Received: by mail-ye0-f178.google.com with SMTP id r9so171314yen.23
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XHIaYMncQCI1siVcbmI+15drwdneeNeUryX/1XfY+GI=;
        b=tpWTOPmql41fdbdsflCx699e3HetOcMPRZLB/moTWP6cMm0BT9wplD75gL9Ega4JG+
         GCZ+uBexuIONjP8zuuFTBmZH4s13gyR8JsjKiSxYv+OACqeYZ2dYYmh6Re2tFngZ/uk9
         SlWTrY2xWSe328LJaRnexNNycbyDhxKgxG15y0DvZhYfFQ55rJNcH+p+CXSIqVUEekAB
         qcgL3B9fgr29II9ozAFhY0u3j1f/y9OMS4asj/dBCGRpj2i42h8jmPViXraUcHk9pUN0
         DNUnawpt6KiZUGrYVCPYTOrnQX1+9tzeYOSIsZMDPJQLAF10R8v74HQ6kTiqHrUazxc1
         aYEw==
X-Received: by 10.236.167.1 with SMTP id h1mr8181494yhl.136.1375258606582;
        Wed, 31 Jul 2013 01:16:46 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231405>

Empty ranges -LX,+0 and -LX,-0 are nonsensical in the context of blame
yet they are accepted (in fact, both are interpreted as -LX,+2).  Report
them as invalid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-range.c        | 2 ++
 t/annotate-tests.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/line-range.c b/line-range.c
index 3942475..a816951 100644
--- a/line-range.c
+++ b/line-range.c
@@ -26,6 +26,8 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 		if (term != spec + 1) {
 			if (!ret)
 				return term;
+			if (num == 0)
+				die("-L invalid empty range");
 			if (spec[0] == '-')
 				num = 0 - num;
 			if (0 < num)
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 0f80cba..01d50c5 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,7 +185,7 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
-test_expect_failure 'blame -L X,+0' '
+test_expect_success 'blame -L X,+0' '
 	test_must_fail $PROG -L1,+0 file
 '
 
@@ -197,7 +197,7 @@ test_expect_success 'blame -L X,+N' '
 	check_count -L3,+4 B 1 B1 1 B2 1 D 1
 '
 
-test_expect_failure 'blame -L X,-0' '
+test_expect_success 'blame -L X,-0' '
 	test_must_fail $PROG -L1,-0 file
 '
 
-- 
1.8.3.4.1120.gc240c48
