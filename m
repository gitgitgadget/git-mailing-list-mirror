From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule-config: keep `depth` around
Date: Wed, 25 May 2016 15:00:05 -0700
Message-ID: <20160525220006.27138-3-sbeller@google.com>
References: <20160525220006.27138-1-sbeller@google.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 00:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gqo-0007VI-KY
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcEYWAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:00:18 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35919 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcEYWAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:00:16 -0400
Received: by mail-pa0-f49.google.com with SMTP id eu11so12633635pad.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJdaiL8VNpe99/FSAPRB8RirNK3rDqJ3AtWihCTIfFQ=;
        b=hOlpNdFhbr+CaGfaWKBrSvxM+dxHISEFHcjHN3XeRPirME4AroLZNAkQPUc8vX5Zal
         xRPtg0jRELrfakvWVsA2YoF/F6CSY6SJOYjX0vEr9Kp/KVjQaQCcaMykKVoBrfTGNa7c
         FIGMc2EdQlE8LhUD8/AL+sIXyXldmVVGzCSWap/kNaNPHIoX11wDj+cnD+ViVh7iDFek
         wfaFjRX5eRbMPpQYZTi1otaBNnoqV57Nneka2ElEm1mUgB4fvy3viy8c2EvZUbOHf/6G
         v352UGvzDvv56wqf0bndsA02rCBtcu43AcrlHzpagmPwd/VShtkrHTZnxj2rtkQ9wCFa
         RkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJdaiL8VNpe99/FSAPRB8RirNK3rDqJ3AtWihCTIfFQ=;
        b=gn1dTVjK15zvCGl4QwN95isRsq2vadIypW+VvIZNzlYUTtZWWbkWmhbKQUSjIQ8KrM
         cpBfDTP0Wlu93aWDaBAnhpb354Iwzs9r3lcgYtOFzeZPHl9Zv8zT7lAO2WENtZ4jEQjj
         +bmEOxB0B4qvS1fPV1lcX2ZKx02jUX42thPeFyEiUuKoFjqrLSS9E/9wap9aJObnC2CV
         /Ev8aQzXymTpuuwsKUNQSls+EaMD06VU7nOVfWyyl9DpR3Cidj1rOLm5L6NO3/fcVtP+
         C5eNDx3XOfodGjb6FQ2DuSooHiNUZG74rExiBgJtHrjOgplFoKyapHh58hEkmyN4DJSy
         HGCA==
X-Gm-Message-State: ALyK8tJ/utUzAdLseaZQoJAvNgVMeYn5ngRRUSBkgMytFHnb5d0bSvHA2g9q4/WYcGewdUQV
X-Received: by 10.66.160.133 with SMTP id xk5mr9186791pab.71.1464213615026;
        Wed, 25 May 2016 15:00:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id f187sm715363pfb.60.2016.05.25.15.00.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 15:00:14 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.3.g892bdd0.dirty
In-Reply-To: <20160525220006.27138-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295594>

The depth field will be used in a later patch by `submodule update`.
To differentiate between the actual depth (which may be different),
we name it recommended depth as the field in the .gitmodules file
is only a recommendation by the project.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 16 ++++++++++++++++
 submodule-config.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index debab29..e65a171 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -199,6 +199,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->recommended_depth = -1;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -353,6 +354,21 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
+	} else if (!strcmp(item.buf, "depth")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite &&
+			 submodule->recommended_depth != -1)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "depth");
+		else {
+			int d = strtol(value, NULL, 0);
+			if (d < 0)
+				warning("Invalid parameter '%s' for config option "
+					"'submodule.%s.depth'", value, var);
+			else
+				submodule->recommended_depth = d;
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index e4857f5..5635b6c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -15,6 +15,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	int recommended_depth;
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
-- 
2.9.0.rc0.3.g892bdd0.dirty
