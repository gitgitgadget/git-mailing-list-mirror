From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 10/41] update-ref.c: log transaction error from the update_ref
Date: Tue, 27 May 2014 13:25:29 -0700
Message-ID: <1401222360-21175-11-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNz0-0005XW-BR
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbaE0U2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:28:12 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:64908 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so1510600pab.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=va+OE9QbjO3xkgtwMye+nQ78IgtGz5U8WxgSJUFGmFk=;
        b=nig2AQGqM5HDoJycIDAvGlBPIqZ1LyxVWkO1+nylkt+nwFOufItPcwURdUEPSo8TkF
         ZFlQP0Xb0nFop7Sie7TAu7IZB1K9h+JuAeJnjHUD9Z2imDhMtj8OCayIt/k03MDTJWXB
         dyjqbthqWkWgQprDJTZZQX0gAEWNTIsorZRCvYJw7nEs0NDWdvo9LRnRNZ7xMY22d4Hc
         ZHFpgWC12nDkWnMnht0QF0YPahKdUTijLfqHC1pEu04bsbAbt35mqiG01AXv4BNpW2D4
         DjfhZR7Fit3KoJwrhE3wp/JpBdveLd+4/NGmgQzB0ve+1BrnDPZjCqsNWJQohTy6RX2f
         y7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=va+OE9QbjO3xkgtwMye+nQ78IgtGz5U8WxgSJUFGmFk=;
        b=HFZ59/5fHiv4WdlTB+catuE/ru/o+BZOapRVO0bKijITxGyH3QpOUm3TkmQVC9Yqi3
         /886mEhBgPo2Ot+m+GMvNJLhkjMNm8PEVvHfIA63eZHFrrp9/dkm8qrxoVSduPTmZqqV
         6qw8/TOMRn5SPMfdP49Q9BYeQcxkWrw0mMSY1tnPZIYbXgK5JfY+dwZN3ag3hyeJRIDn
         8SUHQBYzOSyfsY6PWa1Ampqr0KamzKTkBaMp+g5va7gkJDownmASqePEjY9oCjPAy6y3
         JzWOrwxDnrpERPeC+tnUfrGndrnq8EzGswOTHOs5a79f/tl/faQY5IE+oO7k+64XlwZ9
         mU2g==
X-Gm-Message-State: ALoCoQmMXxcQwYetollEwhg0yZNsEclGrV7qjeTIstQzExJbe7ICkCT/YNOS0DIv6al9yE5/Kyy7
X-Received: by 10.66.137.2 with SMTP id qe2mr14547598pab.43.1401222364367;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1283649yhg.2.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1B9E6370571;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C8D9FE0DE4; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250234>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.rc3.474.g0203784
