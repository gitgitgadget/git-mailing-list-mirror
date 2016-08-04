Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3709620191
	for <e@80x24.org>; Thu,  4 Aug 2016 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbcHDDfh (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 23:35:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752048AbcHDDff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 23:35:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E887B3217B;
	Wed,  3 Aug 2016 23:00:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A1wDfs1qqCcFpaFVdhsnUMR4sf4=; b=bOs8Dp
	lSskwwi8P759O3cDAcvtdx/1JO86WUME3Tp9zGdQmXKyNTieaGIQxzv9t9yhrEdy
	fItuHEBnkBPJjlglyD+r3Eyq9lZRRibr+YrLfvAuNvKUB18lPL6MkvxzzMW7eO8E
	BxrdXBUcnCRzDomgfAuC9viWGIALtKBKHpsWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5EDanI9hM+lZCcvdlfRBxzj+W/GwsTr
	ZV6Syp77+tYLzY6MohIrnYpSVRPXz9fGKCQq22jrK0PIcDb6UvlJe+s8av1vJ49+
	WmMMvvSz5ewaYGK2dsmacRUMylIC5wvJjq4vtMjQS/KXpp5w1wERJ8ZlpdrVflzw
	QdxeNAwCYr0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFE1D32179;
	Wed,  3 Aug 2016 23:00:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 665C332175;
	Wed,  3 Aug 2016 23:00:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-5-kcwillford@gmail.com>
	<xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608011055180.149069@virtualbox>
	<xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021244450.79248@virtualbox>
	<xmqqk2fzf69w.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 03 Aug 2016 20:00:44 -0700
In-Reply-To: <xmqqk2fzf69w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Aug 2016 10:08:11 -0700")
Message-ID: <xmqqziot5jc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F6F908-59EF-11E6-B934-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not think negative (or non-zero) return is an "abuse" at all.
> It is misleading in the context of the function whose name has "cmp"
> in it, but that is not the fault of this function, rather, the
> breakage is more in the API that calls a function that wants to know
> only equality a "cmp".  A in-code comment before the function name
> may be appropriate:
>
>         /*
>          * hashmap API calls hashmap_cmp_fn, but it only wants
>          * "does the key match the entry?" with 0 (matches) and
>          * non-zero (does not match).
>          */
>         static int patch_id_match(const struct patch_id *ent,
>                                   const struct patch_id *key,
>                                   const void *keydata)
>         {
>                 ...

How about this one instead (to be squashed into 4/4)?

The updated wording directly addresses the puzzlement I initially
felt "This returns error() which is always negative, so comparing
(A, B) would say A < B, while comparing (B, A) would say B < A.
Would it cause a problem in the caller?" while reading the function
by being explicit that the sign does not matter.

 patch-ids.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/patch-ids.c b/patch-ids.c
index 0a4828a..082412a 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -16,6 +16,16 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	return diff_flush_patch_id(options, sha1, diff_header_only);
 }
 
+/*
+ * When we cannot load the full patch-id for both commits for whatever
+ * reason, the function returns -1 (i.e. return error(...)). Despite
+ * the "cmp" in the name of this function, the caller only cares about
+ * the return value being zero (a and b are equivalent) or non-zero (a
+ * and b are different), and returning non-zero would keep both in the
+ * result, even if they actually were equivalent, in order to err on
+ * the side of safety.  The actual value being negative does not have
+ * any significance; only that it is non-zero matters.
+ */
 static int patch_id_cmp(struct patch_id *a,
 			struct patch_id *b,
 			struct diff_options *opt)
