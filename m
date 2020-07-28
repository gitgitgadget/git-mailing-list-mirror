Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD8C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE4F206F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A4g1RcnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgG1VxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:53:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53644 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1VxO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:53:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9625EA65F;
        Tue, 28 Jul 2020 17:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N9uwkJpHg+CzwDtjtv8GMPImJrc=; b=A4g1Rc
        nBIXEFa1WFRcEQY5To9BOj6kjz7UsQM1K3H8IPVhOtLcG3i7oCy9XY9KmKA7iNox
        7wYmKt0Em2QPpM2kB5cVYWPJhyBt1dKA0xl1jtJTYUAkpJcog7Nh+PcPqGWBIhZj
        TNse8kjhd16T8wtr8zqRSKFRWCWARwfxkgoR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R3BxL0KobO0Y/5daZ+9pmrp33LlLtEd+
        08pLX4VJTn7tgFx7acIDRV/xxWh+MNDFswmLip5XkCqLPj222SqEdYkP/fcu19cx
        nxite3go1PsFO1UGy49xK2VdzQY4Jn3mgOig+lDM0MUXZgCBIa4jAh5gywfrvYF0
        NVT7FY2zJEw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2900EA65E;
        Tue, 28 Jul 2020 17:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ED3EDEA65B;
        Tue, 28 Jul 2020 17:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Aaron Lipman <alipman88@gmail.com>
Subject: Re: [PATCH 1/3] rev-list: allow bisect and first-parent flags
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
        <25263842832eeb09769b55cec025978b5f361eca.1595951056.git.gitgitgadget@gmail.com>
        <xmqq4kpre6cl.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Jul 2020 14:53:05 -0700
In-Reply-To: <xmqq4kpre6cl.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Jul 2020 13:23:54 -0700")
Message-ID: <xmqqa6zjcnni.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8EA2C9C-D11C-11EA-95FE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taking all the suggestions and speculations I made in the message I
am responding to, I think squashing the following changes into the
[PATCH 1/3] would make the code simpler and much easier to follow.

The first two hunks revert the changes made to count_distance(); the
third hunk makes sure that count_distance() is not called under the
first-parent mode, since the "single-strand-of-pearls" optimization
is the only counting method needed in the first-parent mode.  The
last hunk is to revert the changes to the single-strand-of-pearls
optimized counting and tweak the loop control to take only the first
parent into account.

Your new tests in 6000 and 6002 of course still pass with this
clean-up.

 bisect.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/bisect.c b/bisect.c
index 762f68c8e9..a11fdb1473 100644
--- a/bisect.c
+++ b/bisect.c
@@ -37,7 +37,7 @@ static const char *term_good;
  * We care just barely enough to avoid recursing for
  * non-merge entries.
  */
-static int count_distance(struct commit_list *entry, int first_parent_only)
+static int count_distance(struct commit_list *entry)
 {
 	int nr = 0;
 
@@ -52,10 +52,10 @@ static int count_distance(struct commit_list *entry, int first_parent_only)
 		commit->object.flags |= COUNTED;
 		p = commit->parents;
 		entry = p;
-		if (p && !first_parent_only) {
+		if (p) {
 			p = p->next;
 			while (p) {
-				nr += count_distance(p, first_parent_only);
+				nr += count_distance(p);
 				p = p->next;
 			}
 		}
@@ -315,7 +315,9 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p, first_parent_only));
+		if (first_parent_only)
+			BUG("shouldn't be calling count-distance in fp mode");
+		weight_set(p, count_distance(p));
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
@@ -331,21 +333,16 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			struct commit_list *q;
 			unsigned flags = p->item->object.flags;
 
-			/* if commit p has already been weighted, continue. */
 			if (0 <= weight(p))
 				continue;
 
-			/*
-			 * otherwise, find the first interesting
-			 * already-weighted parent of p and store as q.
-			 */
-			for (q = p->item->parents; q; q = q->next) {
-				if (!(q->item->object.flags & UNINTERESTING) && 0 <= weight(q)) {
-					break;
-				} else if (first_parent_only) {
-					q = NULL;
+			for (q = p->item->parents;
+			     q;
+			     q = first_parent_only ? NULL : q->next) {
+				if (q->item->object.flags & UNINTERESTING)
+					continue;
+				if (0 <= weight(q))
 					break;
-				}
 			}
 			if (!q)
 				continue;


