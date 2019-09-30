Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB14B1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfI3BvX (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45424 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BvW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id z67so6386270qkb.12
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2GhhSRV6LXMMvgatnOqDZDnEP37kWP7zdaFkJZKwHE=;
        b=0QH8YtUjsmESg8NCanQ5mphknGlgX2VipNTvzb6gncT+NOEx3TAkEPWh2UtOpCmelX
         awTzmdOo/+xyKJ59vOrbtkMEf+T0RYyPSCeSlQyp9b/aoylU0DpCFpcTdjuZSnQPqULR
         lZ8xOH25FUbGQZWzky5SQNzJ9zpQfqgNU26+knQSfkOAH/qLX7nmedFXo0e9sF59xoqC
         0Sz33fnciru1InetNOtuZj9wk9/gqLuqODitPYx9EXMLoYvoCNpyE9+qLqXvmcrTTEcq
         dJO2M1JVeEFKRKJA4s/PTjhkPGl7kxMYK/WCCOqcUiLHWJkDeHnceym9mmG7NxpNpZnM
         i3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2GhhSRV6LXMMvgatnOqDZDnEP37kWP7zdaFkJZKwHE=;
        b=sPvOR2m1bDL9A4sB7ekLExetzZgPjeIKbVyOpoBTRlDvNPbcfzfKCdWiJsqsto2gor
         I15WAxlKiENs4JB5uS+Rt6ZPaF901RBOIQWn0lwdl4P5wxOdnNNP5jbskyJFSE+eqgjB
         CqakOoh/HxMAeBp/WjrFJ0tPWQab8qMTOBOlpfD8sk+I6AWKbb8ZNDlSeSJvaVlxf16R
         kIwMD0/HZAEyyEHYdBN/hXxsQB63dRNWr1dtXOGcs5GNNcmBfxQjyRHqzTYgcdwlivsc
         Z4+kk/xRLeeZdOIPDLpOL4ckrWKaJ42J5OlenRBdR5IMKjYOrsGwpp0AworA8pUvehFf
         VoFA==
X-Gm-Message-State: APjAAAWGbisX3bO9Cv0jB/F5rUryukFB7fjmrkCsfh5cT02KH7U85oQX
        sDa6/e8OOrIEpAsqSN/2DGhfuwGxuos=
X-Google-Smtp-Source: APXvYqxX7U6u6qIkljl+jwKds3nndM5rvBcoJk41ex8JeNziSStY9J+9LIxZIrYLVCRoWc+ivm2Olg==
X-Received: by 2002:a05:620a:6cd:: with SMTP id 13mr16793534qky.266.1569808281282;
        Sun, 29 Sep 2019 18:51:21 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 03/11] grep: fix racy calls in grep_objects()
Date:   Sun, 29 Sep 2019 22:50:49 -0300
Message-Id: <34aeb218bf266ac1a8fabcd9e8b307130d31eb0b.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

deref_tag() calls is_promisor_object() and parse_object(), both of which
perform lazy initializations and other thread-unsafe operations. If it
was only called by grep_objects() this wouldn't be a problem as the
latter is only executed by the main thread. However, deref_tag() is also
present in read_object_file()'s call stack. So calling deref_tag() in
grep_objects() without acquiring the grep_read_mutex may incur in a race
condition with object reading operations (such as the ones internally
performed by fill_textconv(), called at fill_textconv_grep()). The same
problem happens with the call to gitmodules_config_oid() which also has
parse_object() in its call stack. Fix that protecting both call with the
said grep_read_mutex.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 626dbe554d..fa8b9996d1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -658,13 +658,18 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
+
+		grep_read_lock();
 		real_obj = deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
+		grep_read_unlock();
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
+			grep_read_lock();
 			gitmodules_config_oid(&real_obj->oid);
+			grep_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
 				list->objects[i].path)) {
-- 
2.23.0

