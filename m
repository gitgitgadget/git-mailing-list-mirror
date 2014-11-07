From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 1/5] builtin/notes: Fix premature failure when trying to add the empty blob
Date: Fri,  7 Nov 2014 10:19:17 +0100
Message-ID: <1415351961-31567-2-git-send-email-johan@herland.net>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:20:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfi4-0007YC-2F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaKGJTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:50 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:34613 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaKGJTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:32 -0500
Received: by mail-la0-f50.google.com with SMTP id hz20so4103437lab.9
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vte1Qi/UotYrNJbMxjhh9jIMnDSa900mNXicE4TscIQ=;
        b=R4Rlp5g55oRgif7vST0nMLufH0xRfZJauOMaP+YeyvPwD1y6THo8427yxWw1VmXlbL
         n4hwl8lTKLbnkX4ZciemE/BcmfX88yKJ794T5dHJIsK2pXGP6f771fFMLLLZa3OF2jzz
         1l854Q/Z7o6p1WXVaNDyHC5WtklZv+6yYh+DHSHMCpzgRuO/VpQFwnBbYau1zzEY4y6F
         /ADrJTuyBhHsyk37mr5Ox18Ki4MuB+zI/kOB3yMp0UFbjkWbUjxHEcPFG1BAPifHWmY4
         dgbp6XVf1LzW2G0/RMrTEw+imvOupwPcDS3ZqdGUGmBcVc+tnBooRQJT/NcJogTZMh6v
         3oMw==
X-Received: by 10.112.63.70 with SMTP id e6mr1074498lbs.93.1415351970401;
        Fri, 07 Nov 2014 01:19:30 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:29 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415351961-31567-1-git-send-email-johan@herland.net>
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
