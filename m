From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/20] checkout: check_linked_checkout: simplify symref parsing
Date: Thu, 16 Jul 2015 04:20:12 -0400
Message-ID: <1437034825-32054-8-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:21:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFePg-0008HB-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbbGPIVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:21:00 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37632 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbbGPIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:54 -0400
Received: by igbpg9 with SMTP id pg9so8106976igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NfRuMEgPOfIriITa9jfUwfdmgIlObioSAzoqM3PwYBo=;
        b=GBUrzcXdjsGObWp7Bf0aSsKdK8gqQKcPDenje3T6Q1CCqll6jsnOlMYVEMrFQVi3an
         q5QQZRk2lMgr6Y9rgOh4G/qj/iNhHfLdc36TPKhDjdAVKUcvGTVVEViFiZiPi9eZwQnn
         i21vOoWbwJCnbQAefPxOAyTcDmP7oHCj9Nj7C5FTHBAlExFkjscPBeluiF0Fv2Svzk2M
         o8Rb8/PEMp5aTylFvVvbU+5HE7rkIwyM2iwLSWiq259Zv4BRZejKNU3ObtbtjVhdrzv5
         hEu/QQzr1VWuCBPsnZ1yt0XI4PgY2k+kinWYxsgqw/p4F2TguAa7IQ6Ecx99Yf1r31L7
         JRYg==
X-Received: by 10.107.156.140 with SMTP id f134mr11500771ioe.34.1437034853698;
        Thu, 16 Jul 2015 01:20:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274009>

check_linked_checkout() only understands symref-style HEAD (i.e. "ref:
refs/heads/master"), however, HEAD may also be a an actual symbolic link
(on platforms which support it), thus it will need to check that style
HEAD, as well (via readlink()). As a preparatory step, simplify parsing
of symref-style HEAD so the actual branch check can be re-used easily
for symbolic links (in an upcoming patch).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v2: code cleanup in preparation for new patch 08/20.

 builtin/checkout.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a331345..3487712 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -878,7 +878,6 @@ static void check_linked_checkout(const char *branch, const char *id)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
-	const char *start, *end;
 
 	/*
 	 * $GIT_COMMON_DIR/HEAD is practically outside
@@ -890,15 +889,13 @@ static void check_linked_checkout(const char *branch, const char *id)
 	else
 		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
-	if (strbuf_read_file(&sb, path.buf, 0) < 0 ||
-	    !skip_prefix(sb.buf, "ref:", &start))
+	if (strbuf_read_file(&sb, path.buf, 0) >= 0 &&
+	    starts_with(sb.buf, "ref:")) {
+		strbuf_remove(&sb, 0, strlen("ref:"));
+		strbuf_trim(&sb);
+	} else
 		goto done;
-	while (isspace(*start))
-		start++;
-	end = start;
-	while (*end && !isspace(*end))
-		end++;
-	if (strncmp(start, branch, end - start) || branch[end - start] != '\0')
+	if (strcmp(sb.buf, branch))
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
-- 
2.5.0.rc2.378.g0af52e8
