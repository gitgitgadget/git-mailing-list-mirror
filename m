Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2B71F454
	for <e@80x24.org>; Thu,  7 Nov 2019 19:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfKGTIH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 14:08:07 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:46547 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfKGTIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:06 -0500
Received: (qmail 2069 invoked by uid 484); 7 Nov 2019 19:08:05 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.085747 secs); 07 Nov 2019 19:08:05 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 7 Nov 2019 19:08:04 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     git@vger.kernel.org
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH v2 1/4] refs: new function newname_has_bad_prefix
Date:   Thu,  7 Nov 2019 20:07:47 +0100
Message-Id: <20191107190750.26674-2-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
 <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function is intended to check if a user specified name
for a new reference (for remotes, branches or tags) has
a bad prefix.

Intention: Prevent users from creating tags/remotes/branches
which are named "refs" or "refs/..."

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 refs.c | 30 ++++++++++++++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..49e4f662df 100644
--- a/refs.c
+++ b/refs.c
@@ -321,6 +321,36 @@ int ref_exists(const char *refname)
 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
+
+static int starts_with_component(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++) {
+		if (!*prefix) {
+			if (!*str || *str == '/')
+				return 1;
+			return 0;
+		} else if (*str != *prefix)
+			return 0;
+	}
+}
+
+static const char *newname_bad_prefixes[] = {
+	"refs",
+	NULL
+};
+
+int newname_has_bad_prefix(const char *refname)
+{
+	const char **p;
+	p = newname_bad_prefixes;
+	while (*p) {
+		if (starts_with_component(refname, *p))
+			return 1;
+		p++;
+	}
+	return 0;
+}
+
 static int match_ref_pattern(const char *refname,
 			     const struct string_list_item *item)
 {
diff --git a/refs.h b/refs.h
index 730d05ad91..00c11ec589 100644
--- a/refs.h
+++ b/refs.h
@@ -107,6 +107,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 
 int ref_exists(const char *refname);
 
+int newname_has_bad_prefix(const char *refname);
+
 int should_autocreate_reflog(const char *refname);
 
 int is_branch(const char *refname);
-- 
2.24.0

