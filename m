From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 1/3] builtin/notes: Fix premature failure when trying to add the empty blob
Date: Wed,  5 Nov 2014 09:32:25 +0100
Message-ID: <1415176347-18694-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 05 09:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlw1f-0006Mv-5m
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 09:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaKEIdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 03:33:03 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62440 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKEIdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 03:33:00 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so251934lbj.9
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 00:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=vte1Qi/UotYrNJbMxjhh9jIMnDSa900mNXicE4TscIQ=;
        b=I/njCHQmL53B+tNxL5Gpvry2i2txxjMsi/AIH2Y4VS+Cr2ahQ1tMPoPLX+xXRrF7xz
         EY3DlBK03bqQ2b6jz6FeWIMtTm5jzJkpYSF6cbZiSO857HL2B6pFiyxHGqjLjEga9Cbd
         HAieriM+7rGTbUU5u5NteTQ2XDjnH60i6iPGYQTglCd8kCsqeplhjXR46GNRIQyXiY9U
         QQI32IRtbgTgK3uYZyTwBxZZXLb6UthGvL7+EX+Zv/8OoPhLk+xG5wL8cST32rJp8dSN
         XtYRDru8RaNu1/MaSN19PQkLLAYae5bPZIIv6GYajYDTW2yJg/v2zCK96CxYdJcUucn6
         kpSQ==
X-Received: by 10.152.36.165 with SMTP id r5mr35183466laj.91.1415176379040;
        Wed, 05 Nov 2014 00:32:59 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ro7sm1072041lbb.14.2014.11.05.00.32.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Nov 2014 00:32:57 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a small buglet when trying to explicitly add the empty blob
as a note object using the -c or -C option to git notes add/append.
Instead of failing with a nonsensical error message indicating that the
empty blob does not exist, we should rather behave as if an empty notes
message was given (e.g. using -m "" or -F /dev/null).

The next patch contains a test that verifies the fixed behavior.

Found-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 68b6cd8..9ee6816 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -266,7 +266,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_sha1(arg, object))
 		die(_("Failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object, &type, &len)) || !len) {
+	if (!(buf = read_sha1_file(object, &type, &len))) {
 		free(buf);
 		die(_("Failed to read object '%s'."), arg);
 	}
-- 
2.0.0.rc4.501.gdaf83ca
