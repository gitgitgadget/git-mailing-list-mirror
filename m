From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 10:05:15 -0700
Message-ID: <1459357518-14913-2-git-send-email-sbeller@google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 19:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJYt-00029r-08
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbcC3RF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:05:27 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35261 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbcC3RFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:05:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id td3so45066771pab.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1ptgoL4aopugZkgpiRAQ8GwPHJliCGQoaVdTC2ZBpA=;
        b=BjxUhVzYmSGTHks92sIxL6KgTUB+Polx0uWBIVGpEc90Qfr7FugC12UJInCCk8CB+D
         +bcAu4+WwHnqJOkFVg+9QlP5STjNRG02KqkPpNUoZhuY6INSxdIZ0YKUu2K5tNc8+YRo
         s3cd7x2PC2PTDp9YwqkxYi1oHtdYRSkRXNdTEQtYDFb6TpwH6236oifzd8uw9Iu50PBz
         A4XlH8TugAKI7+842EHf+JhNjgLnjCohBsEol1OM/SBYad1jpoJOplzjtW9iYdJWyX2L
         Ru5nX3XxBTq1E3cBGgQ2pn5QBexjtB9dc7I7cVxsOLU6ubTGAtIONTaDLytxouuddXyj
         8wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1ptgoL4aopugZkgpiRAQ8GwPHJliCGQoaVdTC2ZBpA=;
        b=PY9XYP+0gOcxCFssf8b+vGksyDfDfe0+42uQYLlbTePdLb8UV6LKQHP+mjhL273qmS
         bjx8lrKM/QsLliebxTUxrAOUf59GvVtX5skp9prjKvweBsP0SQy4WcQysGYajbAJiqfV
         s1n7S5gR0H+MVmDG1+QVYWgjKiehAvjYrpcT7aCWJ7lpmUHS2hIFC9ACHGObbn5xN0hE
         dInOGNDZGebUyQj680I80CgLydo4TuI/srHvStQcm+vzdPUSe6z8/2v8r8SGvr9zfypN
         pxXV18ZUMJPRIVItWVQz+TwdXpYtiW/7mJnrZ2CvDaLkwfUSPjUSD7VNpzA5WjmlrRss
         D2pA==
X-Gm-Message-State: AD7BkJLae41kdhshXa4CMM2WKr6dBwvrOd2xA/UjacDdpJ0iwr3Z8zHW9Ksja5F9GtM8lwpt
X-Received: by 10.66.243.35 with SMTP id wv3mr14813708pac.93.1459357524190;
        Wed, 30 Mar 2016 10:05:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id e87sm7229766pfb.76.2016.03.30.10.05.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 10:05:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459357518-14913-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290317>

`value` is just a temporary scratchpad, so we need to make sure it doesn't
leak. It is xstrdup'd in `git_config_get_string` and
`parse_notes_merge_strategy` just compares the string against predefined
values, so no need to keep it around longer. Make `value` non-const to
avoid the cast in the free.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/notes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..6fd058d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -744,13 +744,14 @@ static int merge_commit(struct notes_merge_options *o)
 static int git_config_get_notes_strategy(const char *key,
 					 enum notes_merge_strategy *strategy)
 {
-	const char *value;
+	char *value;
 
-	if (git_config_get_string_const(key, &value))
+	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
 		git_die_config(key, "unknown notes merge strategy %s", value);
 
+	free(value);
 	return 0;
 }
 
-- 
2.8.0.2.gb331331
