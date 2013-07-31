From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/11] blame: reject empty ranges -L,+0 and -L,-0
Date: Wed, 31 Jul 2013 04:15:45 -0400
Message-ID: <1375258545-42240-12-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:20:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Rdr-0008GV-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759103Ab3GaIUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:20:11 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:46787 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759198Ab3GaIQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:51 -0400
Received: by mail-yh0-f46.google.com with SMTP id i57so218705yha.33
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ebWKQRK0Y9CRssrmy30S2f9+1KZZR58CIsX+NO1ZsOA=;
        b=yE+zpBJq/sCJpmhHwpOQznA49EHZtt8NAbbqfiXLAoymbJeIu8rz87pMlcdWnjnuIu
         MqiMNendhkXUvgUjX+YuSOE6sVuCNUcZ7TcMtKKOu3McaMi5eifbQ6eebaAKiYDqsaOB
         wAqM58PrGaFhU2aHOm/7P6rY4DZmw1rGG5mX1SBU56LK6MqiClJ5vR2+X4VsBRyRcr+/
         3SpK7G4FUhM3tXjj2dt211mUYZb2vCGM+KDaciLl0YECA2gqZcnPmfue6hgVVa3XKsaM
         SXp2MOh4NNlHuWv4/Ys2C3NRPMdNypo/ic6g/9Rh6dY2uFwnM3TY5uXrovVq+TPaQidE
         biYQ==
X-Received: by 10.236.207.2 with SMTP id m2mr31528060yho.214.1375258610424;
        Wed, 31 Jul 2013 01:16:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231408>

Empty ranges -L,+0 and -L,-0 are nonsensical in the context of blame yet
they are accepted (in fact, both are interpreted as -L1,Y where Y is
end-of-file). Report them as invalid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-range.c        | 2 +-
 t/annotate-tests.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/line-range.c b/line-range.c
index a816951..69e8d6b 100644
--- a/line-range.c
+++ b/line-range.c
@@ -21,7 +21,7 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
 	 * <something>.
 	 */
-	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
+	if (1 <= begin && (spec[0] == '+' || spec[0] == '-')) {
 		num = strtol(spec + 1, &term, 10);
 		if (term != spec + 1) {
 			if (!ret)
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d7807df..e422a9e 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -185,7 +185,7 @@ test_expect_success 'blame -L Y,X (undocumented)' '
 	check_count -L6,3 B 1 B1 1 B2 1 D 1
 '
 
-test_expect_failure 'blame -L ,+0' '
+test_expect_success 'blame -L ,+0' '
 	test_must_fail $PROG -L,+0 file
 '
 
@@ -201,7 +201,7 @@ test_expect_success 'blame -L X,+N' '
 	check_count -L3,+4 B 1 B1 1 B2 1 D 1
 '
 
-test_expect_failure 'blame -L ,-0' '
+test_expect_success 'blame -L ,-0' '
 	test_must_fail $PROG -L,-0 file
 '
 
-- 
1.8.3.4.1120.gc240c48
