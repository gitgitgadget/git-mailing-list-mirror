Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28A120189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbcFVQxh (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:53:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32930 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbcFVQxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:53:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so4497867pfb.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:53:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+BIiObjsJsxSBbAvRQUQ1szFakfCZkK3SC+argcpUZ4=;
        b=k72VJpm8okPmHO84SNsgOAQfZqQW1ifDFlVJ/kPXygxWF+r4FlgbCHdoc7iQpQlWOV
         XMHcqDHrklPObFeeL6QsKI1vjVI4jYIc+qKeZH3P9AHdfNVAcx0pOjeQHC1ZYA335fim
         ZSCqaTl4226A3eVM9DJPFiWqNj5cX0gvNj1d+vMLH7iK6O2TML4nABO0//eeXMPeFY87
         c77tTRqe4Z9EdIJ8J6gLhS5yt55jzKOfyeWS2Ej5nU2EPaTg1hfiAzgLosjA2CPchNLs
         xUO0a4UIMSd77YhNlA9IJ/vDGSBx+8MJaT1wzo3fsC/jo0MyMewFIgxgPv8CO48lIk8E
         A7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+BIiObjsJsxSBbAvRQUQ1szFakfCZkK3SC+argcpUZ4=;
        b=c2fN/RJOCUVsXdnyWl5OQVGGCVg0cZDm1ret0CWWh3/aC85BhxXUp1CqMOFnkYzAa4
         RfdfjvCHur3q6q0zOquBQG3kx/Ry96uQLH0qRtdS9ZnDTAgfbQn9Gnqz4JZuJ6FPfgRT
         oCg1dP3zxPK9L0u4DohZ9LH6RLGChC3pOnTGgxa1WmdfppZ+7xPATFQUuFilm0wfT4vL
         LOy/ui0WLA9dJP4Vk+zFQ04Qsto7JYfFL47MCFOIpycTpMmF5gvr8bbmOMdlnYPQvQE8
         AZ6cE1TVg9HWocSyX0Tj9muQa58qRQNeTBCWk7QK+5D5M8om9tU8JBDBmDhEhvipJO2z
         f+HA==
X-Gm-Message-State: ALyK8tJaYDmdtn/p+fO00WeLw2FA2wD1iKD4pPBPKnCCFs1sBahhuU9+jEbnHLmkkcbLsA==
X-Received: by 10.98.32.65 with SMTP id g62mr35490161pfg.12.1466614415950;
        Wed, 22 Jun 2016 09:53:35 -0700 (PDT)
Received: from localhost.localdomain ([106.218.86.37])
        by smtp.gmail.com with ESMTPSA id sz7sm1132865pab.23.2016.06.22.09.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jun 2016 09:53:35 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 2/3] log: add "--no-show-signature" command line option
Date:	Wed, 22 Jun 2016 22:21:25 +0530
Message-Id: <20160622165126.12786-3-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160622165126.12786-1-mehul.jain2029@gmail.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If an user creates an alias with "--show-signature" early in command
line, e.g.
	[alias] logss = log --show-signature

then there is no way to countermand it through command line.

Teach git-log and related commands about "--no-show-signature" command
line option. This will make "git logss --no-show-signature" run
without showing GPG signature.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 revision.c     | 2 ++
 t/t4202-log.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/revision.c b/revision.c
index d30d1c4..3546ff9 100644
--- a/revision.c
+++ b/revision.c
@@ -1871,6 +1871,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
+	} else if (!strcmp(arg, "--no-show-signature")) {
+		revs->show_signature = 0;
 	} else if (!strcmp(arg, "--show-linear-break") ||
 		   starts_with(arg, "--show-linear-break=")) {
 		if (starts_with(arg, "--show-linear-break="))
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ab66ee0..93a82e9 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -893,6 +893,11 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPG '--no-show-signature overrides --show-signature' '
+	git log -1 --show-signature --no-show-signature signed >actual &&
+	! grep "^gpg:" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
-- 
2.9.0.rc0.dirty

