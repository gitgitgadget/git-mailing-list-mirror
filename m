From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule-config: keep shallow recommendation around
Date: Wed, 25 May 2016 17:06:32 -0700
Message-ID: <20160526000633.27223-2-sbeller@google.com>
References: <20160526000633.27223-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 02:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ip9-0003EO-2R
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbcEZAGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:06:43 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35783 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcEZAGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:06:42 -0400
Received: by mail-pf0-f178.google.com with SMTP id g64so24665307pfb.2
        for <git@vger.kernel.org>; Wed, 25 May 2016 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zerINdOh8Pj3WqBYBsw3yCW+N44tuKeDldejYlqWz78=;
        b=S43Ibs4HRYpFSpGJjSIVHb5wt76j1Gti0dse7FzKDUaq2v+yNrKytxG+hUiHXGIty8
         UuK+sZ/N6Nwpdld8C6oDsHwpJ0QCgjeb/SZr8/4o6X0SLJveM5DlSBzQaDkk0n1kZ0E3
         8n0/SR9V3gAF4EGEhR2CuvoVBk5LcLYdpTSlnrimzOgBnIxDQvYmr3t4EwFA9wNbCxbD
         l6c64+7+atFF7rTiZ4+kD1zQE0bI+wOSHafUiNXuKFZJU7+u8wmyba0Ui/XGOroskkOj
         hkoNOM3/Mb4zJ/i+QfkGjDm0PHLv1/0lIubvAUPdbnkkJ0PrZTE4TXzU1+bPBTnnn2vK
         Y6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zerINdOh8Pj3WqBYBsw3yCW+N44tuKeDldejYlqWz78=;
        b=m0T5uAjD/wD6HJXfoDbqwaTmzASVkbXXup4EUITSX8knrIgQqBBN4eMxSZ9f8RAT8Q
         OUx+CD58PZ069FDHUCniCTGPX3oZE3+iK3yK19f2Hp1htsHNfiF7FrhIuvl2jKa1W56q
         2S3jlZZhgH8odSlGOIh6hm+3lU+zchvmDT+Km1bQUU9hdpy/p58HCCgee8/+IlRVCCtw
         0GbqTrMfDWRt5oMVELX7NbPGaTWCIc7d8mxaKD36xXTW4RHIkDX4E9o987HzGqrOlKiz
         jVerA61dFF0l+aWmHdOYDCL337LfULfYogS3TtLxy+fJXI92Pb7NL8Q/nphYTTvoYkCq
         S0XA==
X-Gm-Message-State: ALyK8tLlDSU2Lgp7tlnaSL3yGoOsax1/xfWY8Wyq+2Ovxdxo8lHM9uenFbVshPEBdLLZHVHK
X-Received: by 10.98.65.209 with SMTP id g78mr9801768pfd.163.1464221201507;
        Wed, 25 May 2016 17:06:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id c190sm1047543pfb.33.2016.05.25.17.06.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 17:06:40 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
In-Reply-To: <20160526000633.27223-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295620>

The shallow field will be used in a later patch by `submodule update`.
To differentiate between the actual depth (which may be different),
we name it `recommend_shallow` as the field in the .gitmodules file
is only a recommendation by the project.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 10 ++++++++++
 submodule-config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index debab29..e11b35d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -199,6 +199,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->recommend_shallow = -1;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -353,6 +354,15 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
+	} else if (!strcmp(item.buf, "shallow")) {
+		if (!me->overwrite &&
+			 submodule->recommend_shallow != -1)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "shallow");
+		else {
+			submodule->recommend_shallow =
+				git_config_bool(var, value);
+		}
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index e4857f5..b1fdcc0 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,7 @@ struct submodule {
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	int recommend_shallow;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.9.0.rc0.2.g145fc64
