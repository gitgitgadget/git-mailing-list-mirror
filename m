Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5FC7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjFKSuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSub (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:50:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A246E64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so35860255e9.3
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509428; x=1689101428;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NODsiNAlG4vb2GIEImBT8Ci9czCAMw8/gKhjVazLjTI=;
        b=IkugZLi+z0Vfr5Bjes+hqgWrnvn1wdNPS6MOeBmA4E4AQ4sKSe6e6NMzjcta48mA0h
         naehTFrIqvDjcY8W2jWFgzfUrMCaUyUl3Ce6KEfN2yE54EPBrauhXiN+AvIgBWZNFJ0A
         9NV44hG5Wbv1ix1AsqHNEM7PL3SFIo9yqpLV3RXj4wQNkAUkdWPDlKJAKQdBNy8mJv1y
         QALvi9BhYz8y2baWAEDstTKMgIXNA+qRbT/ojh0inm7rRajh14GBEs3Z8QDJuXMa9fT+
         7O36+QfbX8xIA+LQWv0apdbz50E+oZ66mcvRYCYKusdCHWlve497isr8hdViZq82psdM
         rZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509428; x=1689101428;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NODsiNAlG4vb2GIEImBT8Ci9czCAMw8/gKhjVazLjTI=;
        b=i0ELa0HwBmbarniu5n8FFLpRoN0sZXNZyGLWm1m0eC3H3PZBJ6rZNAz7U5vVZWH5q6
         zviEoO/8WPtVlZGcYqTRcCCRiMtZEcdG4Rnjq6BDvlNfx8skAOSkAF8uMCreYmeDZeAO
         cYZmA+QqXV8H5Hflf5T91W3tAQY/G6Ms3oiOYj6zWjf9H9q/FwaO8zMNeRdDQKvsLmJb
         Hkl7LErDsmmRfhUp7DfcXmjQ1FeZsoPAHfrldln44lkUTcXmAeYtV++MJZN8aMN8536R
         m8R4BZKgup4kKVU5XmHLYYQxXpef6sPudKaqGkFcpRJMvVFoGEEXDROSpqzxRum7P96a
         fqKg==
X-Gm-Message-State: AC+VfDw7kNoQy5DLjgO1HpZfqTvZKuvBi8Z3yEg7t0XDCNNvLoaaqZbN
        oxQaBNTBzQY57THA9kg0SzQgPjJL1vI=
X-Google-Smtp-Source: ACHHUZ7Lzc5Auqyp2PDtuDMYAmYwUu0ZBuzuwAMzWkmzF6Pwuz2eEQPxT3B6SBqg4JL3iInPy5bifg==
X-Received: by 2002:a7b:c447:0:b0:3f7:cb42:fa28 with SMTP id l7-20020a7bc447000000b003f7cb42fa28mr5481153wmi.28.1686509428685;
        Sun, 11 Jun 2023 11:50:28 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id l5-20020a1ced05000000b003f8178bf349sm2395143wmh.44.2023.06.11.11.50.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:28 -0700 (PDT)
Subject: [PATCH 08/11] branch: fix a leak in check_tracking_branch
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <98c68cb4-abbe-0b86-0052-517f47711271@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's fix a leak we have in check_tracking_branch() since the function
was introduced in 41c21f22d0 (branch.c: Validate tracking branches with
refspecs instead of refs/remotes/*, 2013-04-21).

The leak can be reviewed with:

   $ git remote add local .
   $ git update-ref refs/remotes/local/foo HEAD
   $ git branch --track bar local/foo

   Direct leak of 24 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_add strbuf.c
       ... in match_name_with_pattern remote.c
       ... in query_refspecs remote.c
       ... in remote_find_tracking remote.c
       ... in check_tracking_branch branch.c
       ... in for_each_remote remote.c
       ... in validate_remote_tracking_branch branch.c
       ... in dwim_branch_start branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 19d606d360..09b9563ae7 100644
--- a/branch.c
+++ b/branch.c
@@ -480,9 +480,12 @@ static int check_tracking_branch(struct remote *remote, void *cb_data)
 {
 	char *tracking_branch = cb_data;
 	struct refspec_item query;
+	int res;
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = tracking_branch;
-	return !remote_find_tracking(remote, &query);
+	res = !remote_find_tracking(remote, &query);
+	free(query.src);
+	return res;
 }
 
 static int validate_remote_tracking_branch(char *ref)
-- 
2.40.1
