Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901E820445
	for <e@80x24.org>; Fri, 13 Oct 2017 05:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbdJMFLh (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 01:11:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751353AbdJMFLg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 01:11:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4256AABA3;
        Fri, 13 Oct 2017 01:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=gncZ
        XlCY9gIImQlcElNUMGE8ies=; b=Ds+uZfUvKygZXNVF30tUr+X8+kOx4MvJaYhg
        tCta05Ggl40oViYDGnLld7/Ee39ilKMZmeA+FlLKBGBlgh6KazyBy+b1R3kE+a+U
        DKXJgMtLAz3Q39idhfRXMQBnwwcveRwx/bZb3CF9+PLggGhtXYraMc2QM57BrHMj
        v+BvkC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZpsZBq
        2Rny5m8JPwtLvq8XckKuBHICuP7TkCZUWg/v9pIjvJVY23ft1DmboQ2sD842MPjF
        kPygGFkf8MPDMOJHEJK5AgJV810RSegeducQN1U4Euq4PfCzLL7wQFMojt+YZX7p
        EosHBWWtI/7jCangtS7B2JrdFtA/WcNWQ+3D8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D588AABA0;
        Fri, 13 Oct 2017 01:11:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 169C3AAB9F;
        Fri, 13 Oct 2017 01:11:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] branch: streamline "attr_only" handling in validate_new_branchname()
Date:   Fri, 13 Oct 2017 14:11:30 +0900
Message-Id: <20171013051132.3973-2-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-158-gbd035ae683
In-Reply-To: <20171013051132.3973-1-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
X-Pobox-Relay-ID: FBD4CA1A-AFD4-11E7-8362-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function takes a parameter "attr_only" (which is a name that is
hard to reason about, which will be corrected soon) and skips some
checks when it is set.  Reorganize the conditionals to make it move
obvious that some checks are never made when this parameter is set.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 4377ce2fb1..7404597678 100644
--- a/branch.c
+++ b/branch.c
@@ -181,21 +181,25 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 int validate_new_branchname(const char *name, struct strbuf *ref,
 			    int force, int attr_only)
 {
+	const char *head;
+
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
 	if (!ref_exists(ref->buf))
 		return 0;
-	else if (!force && !attr_only)
-		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
 
-	if (!attr_only) {
-		const char *head;
+	if (attr_only)
+		return 1;
+
+	if (!force)
+		die(_("A branch named '%s' already exists."),
+		    ref->buf + strlen("refs/heads/"));
+
+	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
+		die(_("Cannot force update the current branch."));
 
-		head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-			die(_("Cannot force update the current branch."));
-	}
 	return 1;
 }
 
-- 
2.15.0-rc1-158-gbd035ae683

