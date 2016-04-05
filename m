From: santiago@nyu.edu
Subject: [PATCH v5 1/6] builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
Date: Tue,  5 Apr 2016 12:07:24 -0400
Message-ID: <1459872449-7537-2-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWE-0000aC-S5
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759455AbcDEQHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:42 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:35766 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcDEQHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:37 -0400
Received: by mail-qg0-f68.google.com with SMTP id b32so1624138qgf.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zs4kBhP0be6Oe9QCTZl01LlzA+DX+vjyIBZjco+6LBI=;
        b=NZo59V+WoPGGiYK4+KoFAvNlzoq1blHEIb57QU9z1kuGqx+Mfkf+LoQYIsNidRzBAs
         nPN8/wbXlZ9qJQCRZcvGIyUFHZMyYIIH6eId1jMDNfld+J19+4jVawRYhhq2X8zGkfDA
         8thXN2LQynW8ZMqlFBhYo2+dm5OaQ8MVe9E+9g5CPv0QsjsIzKCRl/ErC1zMKZ0p853+
         yjTzG0mLNmBMZsi2Gxd/xB9GIzpYg2cUFkqW3+Fg7PLDLrtOudAONjfToKIfTbnoxXpj
         khc4EuyiIauJ/0J72Yd1mMA4oSNNf60Sci4Z8UVhY/hLHHs9d/vy+OjspOq4DxbfQoJ6
         dTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zs4kBhP0be6Oe9QCTZl01LlzA+DX+vjyIBZjco+6LBI=;
        b=g4coPNXu5jeDqBVnS8dipWlmvEE+QhIOczqYTdZPMccAnNjQmxH8mMoxnNExi9xHm6
         K2E7h/n5eUfbRHFXXnEZFgeeeZCGCGR3/EEYW/ph8qSizjz3jrpvqlM32r12FugS5XzI
         NzMN4WvWcHw6A9JR8Zd9X4FMvovEiAwme3wyhN4BCOhez+Qk73I7s2Y5ONCNJIQq2y+3
         yMrTmaeGGQCkGfk0akLBsLWoEPMjvKcMxyNYylNsTykNGSXw/wrHxnpoMfMK98dFh1Wn
         PaCFdb1aH8GdRaGsCFINtVxdZUfUovmmIU9rxWi1DE/82YTqE2y67d+bhttGkk2zlf7J
         Uk1Q==
X-Gm-Message-State: AD7BkJIA3kYfbxj27e2ONhHXItQY7sTSM2SP5c8uxrXd98oVtLOAMg1j9YaayvvYnDroOrge
X-Received: by 10.140.97.202 with SMTP id m68mr47226148qge.102.1459872456237;
        Tue, 05 Apr 2016 09:07:36 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:35 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290793>

From: Santiago Torres <santiago@nyu.edu>

The verify_signed_buffer comand might cause a SIGPIPE signal when the
gpg child process terminates early (due to a bad keyid, for example) and
git tries to write to it afterwards. Previously, ignoring SIGPIPE was
done on the builtin/verify-tag.c command to avoid this issue. However,
any other caller who wanted to use the verify_signed_buffer command
would have to include this signal call.

Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
verify_signed_buffer call (pretty much like in sign_buffer()) so
that any caller is not required to perform this task. This will avoid
possible mistakes by further developers using verify_signed_buffer.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 3 ---
 gpg-interface.c      | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 00663f6..77f070a 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -95,9 +95,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	/* sometimes the program was terminated because this signal
-	 * was received in the process of writing the gpg input: */
-	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
 		if (verify_tag(argv[i++], flags))
 			had_error = 1;
diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..2259938 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -237,6 +237,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		return error(_("could not run gpg."));
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(gpg.in, payload, payload_size);
 	close(gpg.in);
 
@@ -250,6 +251,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	close(gpg.out);
 
 	ret = finish_command(&gpg);
+	sigchain_pop(SIGPIPE);
 
 	unlink_or_warn(path);
 
-- 
2.8.0
