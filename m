From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/12] submodule config: keep update strategy around
Date: Thu, 15 Oct 2015 18:52:08 -0700
Message-ID: <1444960333-16003-8-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCO-0002W9-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbbJPBwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34263 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbJPBwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:24 -0400
Received: by payp3 with SMTP id p3so56447546pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qZMygM01TjzQSjF5A4uZL1lcI+X7rUKV2z1JuOFIyBs=;
        b=IlMxCHu8j5/bsN2SNvJ5rMrm8C7WzPS7NJvpfEyV/PaoXe2nkx8F7UAn9e4rXk1JnT
         zS7fj4UyxNJpPPNXGlrTwmGvn20yQEQDEWSfbIzf0/GI1XRi6/MqXnxY9fEgIxe0kjdx
         ND3+v3xS23KXPd2KgBmIbxOLuIcv7bD65alpA+j7bTrqNfXnTm/hU+9QlHiN8xUsMcRQ
         h4Ncej0DmmCUxDWbg1hKfaTBKa1tUoxqCG9+psESZ9iSkEc6+lyTSHQLoc/Vl3Tcu1Oa
         gCWTIMwfmycZnf76w1zBivJUVxlKCVzGxxI2Xy+KY4aCTDaLfqhMVYkIyntvlOTW2sOB
         6obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qZMygM01TjzQSjF5A4uZL1lcI+X7rUKV2z1JuOFIyBs=;
        b=Shfr5uaJo4jFixNgx3lapOVFBBVSRW+xk9WCRDS2/vM48i5MPkK2oMpr/fjpD9uZK/
         abC7211wFVFr5bxy9p1fGOoVy5UdM3YasS6iPVhdTph0CnC5+W+PaUVuCFfggsmD7fSW
         yToSZLgN1QmgOuzzivCbFfQHeuwB4V7p27MOnj33BFHE1oddRcmCubjJqnZGxUfJjvSE
         WAWf3JA3JGPcTyH8tEkU29t7xhu7gBO/xVFtywmcW0BLXdj97iMR4et35CF+71NbdsSM
         /y32cDtbjLsUEKorXyqOlyGPcp9W336OtmSmGWBLyk7ZcTwRMMpKTIX0+4ndq7dQwWI8
         1dPQ==
X-Gm-Message-State: ALoCoQkyQMLRVmr7S/fQi98gfsWXuoz7/Do0g1pTmcEqHgVCo8pT+E+/moxQhSDdJy7UTz14Lq/M
X-Received: by 10.68.204.37 with SMTP id kv5mr13361486pbc.64.1444960344303;
        Thu, 15 Oct 2015 18:52:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id dd4sm17786282pbb.52.2015.10.15.18.52.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279726>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 393de53..175bcbb 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -326,6 +327,16 @@ static int parse_config(const char *var, const char *value, void *data)
 		free((void *) submodule->url);
 		strbuf_addstr(&url, value);
 		submodule->url = strbuf_detach(&url, NULL);
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->update != NULL)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			free((void *)submodule->update);
+			submodule->update = xstrdup(value);
+		}
 	}
 
 release_return:
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..f9e2a29 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -14,6 +14,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.5.0.277.gfdc362b.dirty
