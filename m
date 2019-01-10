Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F641F803
	for <e@80x24.org>; Thu, 10 Jan 2019 04:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfAJE0L (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 23:26:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbfAJE0J (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2019 23:26:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D59AD60FE4;
        Thu, 10 Jan 2019 04:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547094368;
        bh=ggXze6EIKai+XFoz5ubIpnH4KMm03oQE/Zqrrlge+MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RxI4BP5FF8be4k/tRo8QaEj5XKP4lEQNnaawPSUmnsD14avepyE4yL8breSMj9aCI
         I0YaU7B+gk/c9U1oYFHbLnsnKVl7uPftn22qo0QZgMym0k1RnlsQllAHpJSC6DDRT7
         uD5qNCx57a3+zunGoii4nVIscf7bFL9n1owppjhgnlD6KIMvnjxu5zPSbP5nKfn0vD
         ewuBF65YumSY7O5KvmceO+B6bzT1Ahy9pbTUP1gfu883HXkLiaXs/2r5gKaPTt+qSg
         1TAje5drqDIQkdyjdIqni9mCcVI7wClqMnD34xQMosR4W7yJbqBvGAfE3cd6p4KbVL
         5QpgK7xlC3VIOU23p/d2xL/C23RBBQmIaS0gp+1nWcvLG16RQhcV/rXVGKbfSeu9wO
         us2lwrnhYEOfzbIh3kNnS0SKuGhfUWUR/torW3XM3f3wdYLXytycd4uGl2duLR1pGq
         xK3qok8G5nWP0rbXfucR7MPG0aDbK1deVZzgwPYvrLKg4tjT/h9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] match-trees: compute buffer offset correctly when splicing
Date:   Thu, 10 Jan 2019 04:25:48 +0000
Message-Id: <20190110042551.915769-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3
In-Reply-To: <20190110042551.915769-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the struct object_id pointer returned from tree_entry_extract
lives directly inside the parsed tree buffer. In a future commit, this
will change so that it instead points to a dedicated struct member.
Since in this code path, we want to modify the buffer directly, compute
the buffer offset we want to modify by using the pointer to the path
instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 match-trees.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 2b6d31ef9d..feca48a5fd 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -199,15 +199,16 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	while (desc.size) {
 		const char *name;
 		unsigned mode;
-		const struct object_id *oid;
 
-		oid = tree_entry_extract(&desc, &name, &mode);
+		tree_entry_extract(&desc, &name, &mode);
 		if (strlen(name) == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree", name,
 				    oid_to_hex(oid1));
-			rewrite_here = (struct object_id *)oid;
+			rewrite_here = (struct object_id *)(desc.entry.path +
+							    strlen(desc.entry.path) +
+							    1);
 			break;
 		}
 		update_tree_entry(&desc);
