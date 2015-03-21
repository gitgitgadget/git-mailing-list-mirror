From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/15] read-cache: free cache entry in add_to_index in case of early return
Date: Fri, 20 Mar 2015 17:28:00 -0700
Message-ID: <1426897692-18322-4-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7Hk-00028j-4V
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbbCUA27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:59 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33521 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbCUA2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:21 -0400
Received: by iecvj10 with SMTP id vj10so1847374iec.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DEqFoCHxnzt5w8VI8s6H484SS2Q4ydrjvODfQ4dPRIc=;
        b=ClbYEoiDvlt15fsC4FOx/iDtZDNZ+wlIh5xn30BDAxMoEciVimcqSLQqHPtVoB+Rew
         VdJRoCAs4Hd+2kVqlOVYf7R1Y3mxWaDSjttQ0IwK6ipyc0zPHC0r/bU5RqyouoV3tNsm
         G1eC57nMMRv8eCERwUsxYk5Cdxw2Ur3jim1qT6cTfHcvwfJCXB9Kb1dnTqzFk6Dy6zUV
         Xzz4Dqy15nqWaO4d2uYQ92fYRI7jaNpoH86eA8i+B21JdJEGwjLZEDg/5+DDaqt2tRVE
         OiJtuWrxiXy3BYk2aOGuulSLnCkGOQ1pMXF2te2aEwq2b5cehepQzK5lGeB775pq9+ty
         kJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DEqFoCHxnzt5w8VI8s6H484SS2Q4ydrjvODfQ4dPRIc=;
        b=Xp03H8BstcoNqMKTcFTyp+PLhWXIn1/vh/VFL0oMb2hWzDhar3NRipQiWzqBYePkeq
         gU+TkZfvsYai41n/Y+fJzI4lsE4PPO9pGp2jUf5Mao+JNRlbOZn6MOXosZ1DgkTF88IL
         tcjHkBY1h3I9Mxf/78ZJXJYeKWk3hhQdseeO0/9cH5zy1pUPW0As9MD7Wvo3bsDuvwvd
         GmxBS+A/sKw+r1GMxUfS8OxToDB1zkn8dxknSD8Zr4EsybDi8rw9spQ2sKrlzeZjACMd
         qqSUVb4Ane+oUKJX8vrd1Eo5njQFxagMKUQiBiasnbbAkI97ipPkqGKIfgwnTf0ChDPO
         iCqw==
X-Gm-Message-State: ALoCoQmBjUKCJvRlibpFXz3i2xf98JsRXPoTrT46JGn/izl7cnEFBi5yy265gqANNdinhTTNLief
X-Received: by 10.50.61.34 with SMTP id m2mr503856igr.20.1426897700912;
        Fri, 20 Mar 2015 17:28:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id t7sm178020igz.17.2015.03.20.17.28.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:20 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265992>

This frees `ce` would be leaking in the error path.

Additionally a free is moved towards the return. This helps code
readability as we often have this pattern of freeing resources just
before return/exit and not in between the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 769897e..935f91a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -681,15 +681,18 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	alias = index_file_exists(istate, ce->name, ce_namelen(ce), ignore_case);
 	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
 		/* Nothing changed, really */
-		free(ce);
 		if (!S_ISGITLINK(alias->ce_mode))
 			ce_mark_uptodate(alias);
 		alias->ce_flags |= CE_ADDED;
+
+		free(ce);
 		return 0;
 	}
 	if (!intent_only) {
-		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT))
+		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT)) {
+			free(ce);
 			return error("unable to index file %s", path);
+		}
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
 
-- 
2.3.0.81.gc37f363
