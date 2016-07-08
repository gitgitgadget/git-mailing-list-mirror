Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB422070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbcGHRJj (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:09:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756082AbcGHRJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:09:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E2B62A51D;
	Fri,  8 Jul 2016 13:09:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bEK0ZgiQjNo5Pf+HBUyZcmoYLAc=; b=w697Xo
	E8QIPmBQsz4AWXjrb9qGBtMfqzOod3zbN+oZFObmz5OVUa319fU7OAdosjqDZOqz
	rtxQBtbIi1QmW71xB/M79oDYNk+/hNvH5oF+8kBcPdjjIbvC7BrsjQlcDaPvxMX/
	uFO+btk7t3nl8cNX/tlwvY6h6Y7owkCqQE+x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TqqraLZ12SluAEUCmoY5JRS2VuHTAow6
	xAYBem2W/rTK0SCuM1PGXxEFhIldcsChr19bTfKTg7zcigS2NPtm5ObR807pDhsI
	bbJYbCeMLfMGyZY0CnPK4VrkauQJSL7PR/LwT4XF/w8AuPFtfMKjZ6vpkwxh/HIS
	eBtt4NKwyTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 658622A51C;
	Fri,  8 Jul 2016 13:09:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1E722A51B;
	Fri,  8 Jul 2016 13:09:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] avoid using sha1_to_hex output as printf format
References: <20160708092510.GB17072@sigill.intra.peff.net>
	<20160708092526.GB18263@sigill.intra.peff.net>
	<20160708103515.GA19705@sigill.intra.peff.net>
	<xmqqinwgm5aa.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 08 Jul 2016 10:09:28 -0700
In-Reply-To: <xmqqinwgm5aa.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Jul 2016 10:02:53 -0700")
Message-ID: <xmqqeg74m4zb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC2F0374-452E-11E6-AA2E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As to the hunk to commit.c that was dropped in this round, the only
> caller of print_commit_list() is bisect.c, and it passes "%s\n" to
> format_cur and format_last, it seems, so that suggests a more
> obvious direction for cleaning things up, I would say.

And the result is a pleasing diffstat.

-- >8 --
Subject: commit.c: remove print_commit_list()

The helper function tries to offer a way to conveniently show the
last one differently from others, presumably to allow you to say
something like

	A, B, and C.

while iterating over a list that has these three elements.

However, there is only one caller, and it passes the same format
string "%s\n" for both the last one and the other ones.  Retire the
helper function and update the caller with a simplified version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c |  5 ++++-
 commit.c | 10 ----------
 commit.h |  4 ----
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/bisect.c b/bisect.c
index dc13319..02f76f0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -646,7 +646,10 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
-	print_commit_list(tried, "%s\n", "%s\n");
+
+	for ( ; tried; tried = tried->next)
+		printf("%s\n", oid_to_hex(&tried->item->object.oid));
+
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf("We cannot bisect more!\n");
diff --git a/commit.c b/commit.c
index 3f4f371..bf27972 100644
--- a/commit.c
+++ b/commit.c
@@ -1617,16 +1617,6 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new->next;
 }
 
-void print_commit_list(struct commit_list *list,
-		       const char *format_cur,
-		       const char *format_last)
-{
-	for ( ; list; list = list->next) {
-		const char *format = list->next ? format_cur : format_last;
-		printf(format, oid_to_hex(&list->item->object.oid));
-	}
-}
-
 const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
 {
 	int key_len = strlen(key);
diff --git a/commit.h b/commit.h
index 78ed513..71693ce 100644
--- a/commit.h
+++ b/commit.h
@@ -376,10 +376,6 @@ extern int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
 extern int remove_signature(struct strbuf *buf);
 
-extern void print_commit_list(struct commit_list *list,
-			      const char *format_cur,
-			      const char *format_last);
-
 /*
  * Check the signature of the given commit. The result of the check is stored
  * in sig->check_result, 'G' for a good signature, 'U' for a good signature
