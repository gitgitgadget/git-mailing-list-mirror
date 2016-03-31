From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 11:04:03 -0700
Message-ID: <1459447446-32260-2-git-send-email-sbeller@google.com>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:04:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algxA-0001Ix-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765AbcCaSER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:04:17 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34295 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbcCaSEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:04:15 -0400
Received: by mail-pa0-f45.google.com with SMTP id fe3so71332461pab.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9w1fPBqFBJe6E+mfxH0Em+/kReBqjs3JUpCYStAcIg=;
        b=Rl80whWq7QnL3o23p0bpeORgTznSV1FMrl64sAttCYaYsf17PWBE5SW6ina6TQdynp
         aDFV1jMtRQd61DvCDpF16JBi8k72UaUpR6CgHJ+qtV+dz+EBuqCgALs9dRN4HmCCerQd
         KJbo8/kuV4d0cNbsr+TWGU3B5NYPgc9QmvMaBdaRUBpz3cEBpp24mT72HfCibCQJtpP7
         b5YSYwhx87BGnzaCr6rk0QktoiLfQxyuN0oMzvJWCtb6UwuvU9bAO7L7YXS2zcel46Ky
         rHcEp9aVLYYgcMEIdn6NwJ/CGMU8b1KWXq88f3j0ZACeXq48pjPCUGGawIqYuKrefFny
         htBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h9w1fPBqFBJe6E+mfxH0Em+/kReBqjs3JUpCYStAcIg=;
        b=MXA90c2TgjYWKYVWHkTSUfXaHK5FJy+FOHlFvvVJFalC6GVrXiUYdUjJWcboc5DWFP
         LfPz+LTrd06gXBQRwKamYaER2EBaz9fXMm02lRkTfR+XkPBsZKrriVaMNlU0hhxQkEL/
         38EJBCxTwbyt7VJHeBRKcWGGu4X9/ae7NUacxTtN5te39qWE0NR794JVPtr245VYGMGN
         A+qJ1U/DNKjEZUfwDit50DrEKwcqpDemPhgOzJqAcAStmqGq/l58nKKCcZFNbkN8jPHQ
         OOxKrlXWz7dg+I+7kQxMVuZqIk937n31zQR9Xg0EQR9Rhn/vuhO7GMS50GfGNyaQzfua
         8vOg==
X-Gm-Message-State: AD7BkJLGnRH0JOtDEOzDeHDCg1r1R9hlqovA7xEuPpWCOISAO/8j/X59NKB+f292qLqDDWZz
X-Received: by 10.66.162.193 with SMTP id yc1mr23991488pab.148.1459447455084;
        Thu, 31 Mar 2016 11:04:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id m87sm14961312pfj.38.2016.03.31.11.04.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 11:04:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459447446-32260-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290435>

`value` is just a temporary scratchpad, so we need to make sure it doesn't
leak. It is xstrdup'd in `git_config_get_string_const` and
`parse_notes_merge_strategy` just compares the string against predefined
values, so no need to keep it around longer. Instead of using
`git_config_get_string_const`, use `git_config_get_value`, which doesn't
return a copy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..fa21f1a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -746,7 +746,7 @@ static int git_config_get_notes_strategy(const char *key,
 {
 	const char *value;
 
-	if (git_config_get_string_const(key, &value))
+	if (git_config_get_value(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
-- 
2.5.0.264.g4004fdc.dirty
