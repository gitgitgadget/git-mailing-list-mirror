Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E278202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbdKFL3S (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:29:18 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:10561 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdKFL3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:29:16 -0500
Received: from lindisfarne.localdomain ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id BfYqeiZ2C3CyHBfaMewtww; Mon, 06 Nov 2017 11:29:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1509967748; bh=kPWlFkrCUpRUgz+PygXzTedPXt0SdWeRGQUzNDUbP+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=D0SOldrZwZrqKiXk/wPNBpLd/FEVuF6rQsrImGHKpA0zmYNKAP6uBtNgzGrvMJPmo
         nvQQwoiKLqHU5BLDaYMqgRUukzie+rm8NPRsFfndTx26Ci2f8HZw2D5hceo6Rv4Wrq
         CxxrFy96COAAmlFXa8czVrsOnmBgZr5kxU+8CvJk=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=evINK-nbAAAA:8 a=LPvblEiyalS0-xaKrEMA:9
 a=HkobT9auY8qRQhDe:21 a=xAt_lYRgs9lS18oS:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
Date:   Mon,  6 Nov 2017 11:27:06 +0000
Message-Id: <20171106112709.2121-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171106112709.2121-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEvSdctq9rpqC9qRM5W5SIQiqe3jQ2BMk9ua5boepLcIGKk4CDhntNWBPfPfWj15aQaXnzPzArFd+oTaGfT8aZh+vCKZPjCeEMTaYd5F6oUx46W9T5Z5
 3OmHuJUz0ObEPE+hFloQCDl+zrImfMx1uy4YIovi0h27tAyAvuePqDhMINtPK0eXAES5gZ84g+h2NF9eKJUtsfuqeq9Y22xqdizZSkqg0aBKgxrjGUrN3nU6
 6l0+2C3autQx0nKAUmIJfQKjlfFLbv0L02MLPeGYvXoFSocgDnI7X7JLOBVb9xdT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Return an error rather than dying so that the sequencer can exit
cleanly once it starts committing without forking 'git commit'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c |  3 ++-
 sequencer.c      | 17 +++++++++++------
 sequencer.h      |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b109feaca11e3e43b1a59dee1868244824eaf345..c924cbac9e0d55941e984b3cce3c1e565cd8cf3c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1612,7 +1612,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			flags |= SUMMARY_INITIAL_COMMIT;
 		if (author_date_is_interesting())
 			flags |= SUMMARY_SHOW_AUTHOR_DATE;
-		print_commit_summary(prefix, &oid, flags);
+		if (print_commit_summary(prefix, &oid, flags))
+			exit(128);
 	}
 
 	UNLEAK(err);
diff --git a/sequencer.c b/sequencer.c
index d4f77a5f24c89479a4a18c2b89a3cd4e7ba7ba6c..ae24405c23d021ed7916e5e2d9df6de27f867a2e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -875,8 +875,8 @@ static const char *implicit_ident_advice(void)
 
 }
 
-void print_commit_summary(const char *prefix, const struct object_id *oid,
-			  int flags)
+int print_commit_summary(const char *prefix, const struct object_id *oid,
+			 int flags)
 {
 	struct rev_info rev;
 	struct commit *commit;
@@ -885,12 +885,13 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
+	int ret = 0;
 
 	commit = lookup_commit(oid);
 	if (!commit)
-		die(_("couldn't look up newly created commit"));
+		return error(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
-		die(_("could not parse newly created commit"));
+		return error(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
 
@@ -934,8 +935,10 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!head)
-		die_errno(_("unable to resolve HEAD after creating commit"));
+	if (!head) {
+		ret = error_errno(_("unable to resolve HEAD after creating commit"));
+		goto out;
+	}
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
@@ -948,7 +951,9 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 		log_tree_commit(&rev, commit);
 	}
 
+out:
 	strbuf_release(&format);
+	return ret;
 }
 
 static int is_original_commit_empty(struct commit *commit)
diff --git a/sequencer.h b/sequencer.h
index c7989f93fcf08f979f5869cd4ec27f0dd0b88c82..0e3c2c9fd416349fb704a7ebc72c93a9b9a67703 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -76,6 +76,6 @@ void commit_post_rewrite(const struct commit *current_head,
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-void print_commit_summary(const char *prefix, const struct object_id *oid,
-			  int flags);
+int print_commit_summary(const char *prefix, const struct object_id *oid,
+			 int flags);
 #endif
-- 
2.14.3

