Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62787EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbjIHXWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbjIHXWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:22:42 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6C18E
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:22:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34858)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke8-007R3v-GP; Fri, 08 Sep 2023 17:12:16 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke7-009u13-Hq; Fri, 08 Sep 2023 17:12:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:40 -0500
Message-Id: <20230908231049.2035003-23-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qeke7-009u13-Hq;;;mid=<20230908231049.2035003-23-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18ET2hP4skw7r+DIIXWhRGh6nCdeaE1x0c=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 23/32] builtin/ls-tree: Let the oid determine the output algorithm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update cmd_ls_tree to call get_oid_with_context and pass
GET_OID_UNTRANSLATED instead of calling the simpler repo_get_oid.

This implments in ls-tree the behavior that asking to display a sha1
hash displays the corrresponding sha1 encoded object and asking to
display a sha256 hash displayes the corresponding sha256 encoded
object.

This is useful for testing the conversion of an object to an
equivlanet object encoded with a different hash function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/ls-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f558db5f3b80..346e3fd812eb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -376,6 +376,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
+	struct object_context obj_context;
 	int ret;
 
 	git_config(git_default_config, NULL);
@@ -407,7 +408,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			ls_tree_usage, ls_tree_options);
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (repo_get_oid(the_repository, argv[0], &oid))
+	if (get_oid_with_context(the_repository, argv[0],
+				 GET_OID_UNTRANSLATED, &oid,
+				 &obj_context))
 		die("Not a valid object name %s", argv[0]);
 
 	/*
-- 
2.41.0

