From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 1/9] builtin/notes: Fix premature failure when trying to add the empty blob
Date: Sun,  9 Nov 2014 13:30:47 +0100
Message-ID: <1415536255-19961-2-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReH-0007k1-NM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaKIMbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:06 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:61881 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaKIMbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:04 -0500
Received: by mail-la0-f45.google.com with SMTP id pn19so6447583lab.32
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MMgXmXt5NdiroIIH30eILv880wnvLmT+UgQnMz8jpKA=;
        b=RxVbpfoEAapcLj2cOeDmYaJhuHP5qakmXCrSEFZpgzv/Wj/jIt5ToznNedJMWFeEgl
         POpYmpmCKTlyuUrrcKdtX6/vhroZxxZZnu4LvkQlulD502ylVIgLP2/xQkOw8+2u8ICh
         rIu08ZDpGKm6F6z956pykfYzKMTXefvnb+AZZ3PNN43PeJ860lqwQGFIeLn7Ns2hluyQ
         nMoMGmeQl2VVnZk3u5P62AqwD5fPtYA3YEi7e1JzftmSOTdpopsZf7rB0RC05bAEmNJB
         tXay5rpQY0haX38N1EQipYdaH7TYLvUIFKN2UcfkxAnTFvnabk6oBABx+MjtROuMm7VI
         nUpw==
X-Received: by 10.112.200.34 with SMTP id jp2mr23394159lbc.1.1415536263289;
        Sun, 09 Nov 2014 04:31:03 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:02 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
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
2.1.1.392.g062cc5d
