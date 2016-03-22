From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Mon, 21 Mar 2016 19:06:09 -0700
Message-ID: <1458612372-10966-5-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiP-0000gs-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223AbcCVCGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:33 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34274 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCVCG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:29 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so287820676pfb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhOelHMeRxNNxdIP+YEakT50NxmK2sZYWkZu2+9yN34=;
        b=RY0jbNbP0/yl4nIVTKYPYhhKp0w3iFwIVDQKYoKWnn3Z29CzDUO0SoOcLisTxrHyO+
         KHm+tR187G/VXsv36WBFkjJPw90kEdJ9uB7C8BxOFChEJJwvSrnwYNoqSpuGeKMQKTLt
         tZfyF4C/6WciMUzL7JDmKMrFk7pR1gEToyF8n2ylJzRcO+RPHZXxTqm7hQJXQlmZ8C8+
         B/SGUHhD3SYgo/Te4kQK3KtR9lNw8L4xc1oGFASxM12MFRUYl3/RmUJQ5F1D673bSFB7
         pBswELygdqnV1bOAVM3xPaCK52c5vjHfjHX2YqYRKJ9H3sCoYU6jCU2u8Wq8LF9cdiJI
         PJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhOelHMeRxNNxdIP+YEakT50NxmK2sZYWkZu2+9yN34=;
        b=Zatxd17hSxbv/yzqiRffOK4SS+su4bDvUxniGHia7p3uyx2On51fm5UOoUB3TDhfdy
         OOE6FpeX9ormt0U6y6BBYilmzeRrSheNfGVS1Rnqmeg7HxjdASnK8dmbROeRvMpQcxcv
         o4t5PjUgiN5RKhcd7DKgmNTsGRznOrqamwRmnWRovi6Cpo6y8yWZ5Iq1L1M6ExcH9RSC
         VtbmCgkQhtxA5Z96mfwP+9jPoVfflPX1jnPDqYm3fpzKKi9tW4xs9uMpLDP3uAWj3003
         OasFGSycuzLfwU7sm+dh0mrht0f/QYs3H5ybVadd41ijoIqE4H5cOP0XtjWzA/ZPqYaq
         CEMA==
X-Gm-Message-State: AD7BkJK/xQvym1oEoK89ohOXJaNNb7Z3VJgPdSrsc7WI/OE5WG0uZ44l/+4el3i2HlZOHjoJ
X-Received: by 10.98.68.91 with SMTP id r88mr50110751pfa.12.1458612389040;
        Mon, 21 Mar 2016 19:06:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id 87sm43611052pfq.93.2016.03.21.19.06.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:28 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289480>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

We want to init submodules from the helper for `submodule update`
in a later patch and the stdout output of said helper is consumed
by the parts of `submodule update` which are still written in shell.
So we have to be careful which messages are on stdout.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d942463..a69b1f4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -268,7 +268,8 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!quiet)
-			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+			fprintf(stderr,
+				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
 
-- 
2.7.0.rc0.45.g6b4c145
