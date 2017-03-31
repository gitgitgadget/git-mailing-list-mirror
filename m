Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B6D20966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935104AbdCaBkS (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:18 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59216 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935082AbdCaBkM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:12 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DB50E280AD;
        Fri, 31 Mar 2017 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924410;
        bh=6zip+PdXjdNtQmaYbWcRg+KNAx1EagFTPI9MKTaBqSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkUOen9sYtw2FAk7mImcNWKKlRukDIlsjV2G5cMZRb5ybGby5fJytn+VNYI76dAk4
         rZk57TTaohXquLLRI5Pf439MqNfAs1ikV5cyGMl9HRwLs0jH+kjpDFGOtsICR1kRuR
         Guyy81vIc7vYGYKtqRubxWPs4Xfg7FglMS/pvTaFHaqOpFYkBgayxAkcqk0e8RTuVT
         Q5r6qyRi91+o+fhf9wsTukUHT1bbAHSLvWTeaK4ZXYqTv/yWPBt8j+dQGE6/PKeUsy
         Y//LDY7Jw/ecEQ+Qca4JZNKtjrrPZ5InaLzm6fkZ2BD8+ZgWYHCjuIANBwv8XqRoF7
         TWAzcHrt2yPQeXp/UZXRZMUj7SaaNmGNTiQfrarsPKdJjaotetDrlH+BbMFHGMJMof
         VqgisdSeOnLKqPa68eWXyUPiNBgYgDhMHk5Gme4rYPtR03J5qDIpSWoCDEMYH97hVs
         Mk3+vFljBUBybwwDJY3ejndi7os5XXcddApVryQtXFSc+5WPXhZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/20] submodule: convert check_for_new_submodule_commits to object_id
Date:   Fri, 31 Mar 2017 01:39:53 +0000
Message-Id: <20170331014001.953484-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers of this function have been converted, so convert this
function and update the callers.  This function also calls
sha1_array_append, which we'll convert shortly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch.c | 6 +++---
 submodule.c     | 4 ++--
 submodule.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5ad09d046..a41b892dcc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -659,7 +659,7 @@ static int update_local_ref(struct ref *ref,
 
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_oid.hash);
+			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
@@ -675,7 +675,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_oid.hash);
+			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
@@ -690,7 +690,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_oid.hash);
+			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..5c5c18ec3d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -821,14 +821,14 @@ static int add_sha1_to_array(const char *ref, const struct object_id *oid,
 	return 0;
 }
 
-void check_for_new_submodule_commits(unsigned char new_sha1[20])
+void check_for_new_submodule_commits(struct object_id *oid)
 {
 	if (!initialized_fetch_ref_tips) {
 		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
 		initialized_fetch_ref_tips = 1;
 	}
 
-	sha1_array_append(&ref_tips_after_fetch, new_sha1);
+	sha1_array_append(&ref_tips_after_fetch, oid->hash);
 }
 
 static int add_sha1_to_argv(const unsigned char sha1[20], void *data)
diff --git a/submodule.h b/submodule.h
index c8a0c9cb29..9c32b28b12 100644
--- a/submodule.h
+++ b/submodule.h
@@ -58,7 +58,7 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
-extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
+extern void check_for_new_submodule_commits(struct object_id *oid);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
