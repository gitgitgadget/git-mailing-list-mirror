From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 2/4] ll-merge.c: refactor `read_merge_config()` to use
 `git_config_string()`
Date: Wed, 13 Aug 2014 18:13:04 +0530
Message-ID: <53EB5D58.7000300@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>	<1407918122-29973-2-git-send-email-tanayabh@gmail.com> <vpqfvh0vd4a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 14:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHXtd-0000UP-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 14:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaHMMnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 08:43:12 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47228 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbaHMMnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 08:43:10 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so14810173pab.20
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GbvPkHgU5D78QQWMtcwyuDxZVzM4U+s/n5CNOa8rXlE=;
        b=vpxNjegkRZt4t/Zjxvvcy+vO7TH1Ccl5iJsMLyUken+LjZkIBc9KPaMocYyKN7xrtD
         7FP+G5bg5N77KJXpXugFLJvwWFR7+IxSoo3NfZXvPrytkiNLhUWISSdHg7sML2l0aB7p
         lDKkjeM/p8VSKv3Y68u3Y3RSBOxH0gAvvzY0pTe1GP3sqWxQv1MG1+E6j4Xwsnzeb5Og
         Nt9lQ33PzSDOTkpz6UCHo/86ce2mcoRYMk2a3+Jh14eDsUH2dMPqFOvok/YSbm/HhBLA
         KeDOs67dIqUUZMiECK1gp12PSwXuxIWrRrpRWSwz4s2TqQToeWSd8hzCZ4uvrChdtNto
         yWXQ==
X-Received: by 10.69.31.43 with SMTP id kj11mr3720925pbd.121.1407933789520;
        Wed, 13 Aug 2014 05:43:09 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.107])
        by mx.google.com with ESMTPSA id dk2sm2974432pdb.10.2014.08.13.05.43.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 05:43:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqfvh0vd4a.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255206>

There is one slight behavior change, previously "merge.default"
silently ignored a NULL value and didn't raise any error. But,
in the same function, all other values raise an error on a NULL
value. So to conform with other call sites in Git, a NULL value
for "merge.default" raises an error.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
We cannot easily use the new config-set API here, because
much of the function is dedicated to processing
"merge.<name>.variable" which does not easily translate to
the new API. If it were for variables like,
"merge.summary", "merge.tool", and "merge.verbosity", we
could use the new API.

 ll-merge.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..8ea03e5 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -225,11 +225,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 	const char *key, *name;
 	int namelen;

-	if (!strcmp(var, "merge.default")) {
-		if (value)
-			default_ll_merge = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "merge.default"))
+		return git_config_string(&default_ll_merge, var, value);

 	/*
 	 * We are not interested in anything but "merge.<name>.variable";
@@ -254,12 +251,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		ll_user_merge_tail = &(fn->next);
 	}

-	if (!strcmp("name", key)) {
-		if (!value)
-			return error("%s: lacks value", var);
-		fn->description = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp("name", key))
+		return git_config_string(&fn->description, var, value);

 	if (!strcmp("driver", key)) {
 		if (!value)
@@ -285,12 +278,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		return 0;
 	}

-	if (!strcmp("recursive", key)) {
-		if (!value)
-			return error("%s: lacks value", var);
-		fn->recursive = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp("recursive", key))
+		return git_config_string(&fn->recursive, var, value);

 	return 0;
 }
-- 
1.9.0.GIT
