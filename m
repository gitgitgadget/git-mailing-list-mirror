Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C021FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764001AbcLSS0l (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:26:41 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35717 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763998AbcLSSZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:25:49 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so24923307pfk.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssmzqnYbGhSZOQ5Q8XaJplGuaEojLMrkpnnpVgL3pMk=;
        b=k16NfpNJWcKa4F4uxv0HX34nmbWa8bGfrMpueVEWfcW6yxTikyw78bmWUJXtoZ1DHe
         MrmPOXpgFcgPskVAUNiBF8suyRDVbEhhCfahWxIN2PvpdvxOXDq4MXjo+BfieVathFt/
         jGeAk32hbvAxqWdPT8GLKCgrJMW5HD4F4JXAOiVcTsK7UfV9E9ooFLm52BpUng41tn8e
         UhzfIkmLOIOaaMww1uOMBQ0CHdDHAR2PjjKwqXW8raTj/rtbSec4g6AqSTYjmmjKWoQs
         R+mEDSrPgsppitLbL7uKAWQG/t6K8vWWwYWBcWDvUN1wYCR9I0kZCSXp38mk19mE1M4M
         dzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssmzqnYbGhSZOQ5Q8XaJplGuaEojLMrkpnnpVgL3pMk=;
        b=OudJ5TfGG5W/kFyLvDxTvmGCSN159cg3WkNJJ471BeqZ1twBGsyNthE3CufljcMZ26
         3cbMRZfZOvSvEwJM9hmTdwrbYuQkj0Vr+mCoj1pat1lNZ7rfe/I3uqLUAT9c7sm3SKl0
         UNK3pN98lQ34MbWS1baAl6AldkKON1t5/4DzUHWRah5dJX8ykiwqnp0EyrW6z/6CJFc6
         pD3ZTuIcpARxRhKmoDN9Y73KqLTvHebDRuo7hQJGFRZOl6475DH1ghEnZfTxBWdG9NOQ
         8b+XjBDEkHgv3V9BiiDeC1OJzqDmCJ24pxmP5vuPJpTmPY3T9EFeBC6eprWbyRmuDrNh
         FbWQ==
X-Gm-Message-State: AKaTC00nnSmmNDvCi121mQZuE+dG5KNFgpvqWIpyp7dkez51YyObYI9tbaaU1TLE+pFQYKOa
X-Received: by 10.84.193.101 with SMTP id e92mr37350335pld.12.1482171948257;
        Mon, 19 Dec 2016 10:25:48 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm33098745pfk.73.2016.12.19.10.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 10:25:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/3] push: add option to push only submodules
Date:   Mon, 19 Dec 2016 10:25:33 -0800
Message-Id: <1482171933-180601-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1482171933-180601-1-git-send-email-bmwill@google.com>
References: <1482171933-180601-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach push the --recurse-submodules=only option.  This enables push to
recursively push all unpushed submodules while leaving the superproject
unpushed.

This is a desirable feature in a scenario where updates to the
superproject are handled automatically by some other means, perhaps a
code review tool.  In this scenario a developer could make a change
which spans multiple submodules and then push their commits for code
review.  Upon completion of the code review, their commits can be
accepted and applied to their respective submodules while the code
review tool can then automatically update the superproject to the most
recent SHA1 of each submodule.  This would eliminate the merge conflicts
in the superproject that could occur if multiple people are contributing
to the same submodule.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c                 |  2 ++
 t/t5531-deep-submodule-push.sh | 21 +++++++++++++++++++++
 transport.c                    | 15 +++++++++++----
 transport.h                    |  1 +
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 3bb9d6b..9433797 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -565,6 +565,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
+	else if (recurse_submodules == RECURSE_SUBMODULES_ONLY)
+		flags |= TRANSPORT_RECURSE_SUBMODULES_ONLY;
 
 	if (tags)
 		add_refspec("refs/tags/*");
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 1524ff5..676d686 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -454,4 +454,25 @@ test_expect_success 'push --dry-run does not recursively update submodules' '
 	test_cmp expected_submodule actual_submodule
 '
 
+test_expect_success 'push --dry-run does not recursively update submodules' '
+	git -C work push --dry-run --recurse-submodules=only ../pub.git master &&
+
+	git -C submodule.git rev-parse master >actual_submodule &&
+	git -C pub.git rev-parse master >actual_pub &&
+	test_cmp expected_pub actual_pub &&
+	test_cmp expected_submodule actual_submodule
+'
+
+test_expect_success 'push only unpushed submodules recursively' '
+	git -C pub.git rev-parse master >expected_pub &&
+	git -C work/gar/bage rev-parse master >expected_submodule &&
+
+	git -C work push --recurse-submodules=only ../pub.git master &&
+
+	git -C submodule.git rev-parse master >actual_submodule &&
+	git -C pub.git rev-parse master >actual_pub &&
+	test_cmp expected_submodule actual_submodule &&
+	test_cmp expected_pub actual_pub
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 04e5d66..20ebee8 100644
--- a/transport.c
+++ b/transport.c
@@ -947,7 +947,9 @@ int transport_push(struct transport *transport,
 			if (run_pre_push_hook(transport, remote_refs))
 				return -1;
 
-		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
+		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+			      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
+		    !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct sha1_array commits = SHA1_ARRAY_INIT;
 
@@ -965,7 +967,8 @@ int transport_push(struct transport *transport,
 		}
 
 		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
-		     ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) &&
+		     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+				TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
 		      !pretend)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
@@ -984,7 +987,10 @@ int transport_push(struct transport *transport,
 			sha1_array_clear(&commits);
 		}
 
-		push_ret = transport->push_refs(transport, remote_refs, flags);
+		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY))
+			push_ret = transport->push_refs(transport, remote_refs, flags);
+		else
+			push_ret = 0;
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
 
@@ -996,7 +1002,8 @@ int transport_push(struct transport *transport,
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
 
-		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
+		if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
+			       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
 				transport_update_tracking_ref(transport->remote, ref, verbose);
diff --git a/transport.h b/transport.h
index 1b65458..efd5fb6 100644
--- a/transport.h
+++ b/transport.h
@@ -146,6 +146,7 @@ struct transport {
 #define TRANSPORT_PUSH_CERT_IF_ASKED		(1<<12)
 #define TRANSPORT_PUSH_ATOMIC			(1<<13)
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
+#define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
 
 extern int transport_summary_width(const struct ref *refs);
 
-- 
2.8.0.rc3.226.g39d4020

