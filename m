Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A01ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIPRxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIPRxA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 13:53:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC75B69C8
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 10:53:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 221311B9839;
        Fri, 16 Sep 2022 13:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jdcszkgXeBPHWE0BNPnatJuC27SZ4DDAkTmNaz
        FrObw=; b=vZE1gjUUIaUZONUhHBiuJiXX3rO7j18uVjbPrjfxDNbhECJxre9Jl4
        ZUNkF8QGAonhIMBHdZZ99OT8acJ6ULWwymAkjtWtsBYNVltEyF9T3LJTkPCQh0q3
        OjrS1mc8DFfH9vkIF73IJYa0lCgANSzUUXNrlRpcw40W8kqTmWJ+Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B3CD1B9838;
        Fri, 16 Sep 2022 13:52:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB5071B9837;
        Fri, 16 Sep 2022 13:52:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>,
        Sun Chao <sunchao9@huawei.com>
Subject: Re: [PATCH v5 1/5] hiderefs: add hide-refs hook to hide refs
 dynamically
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <278bd185aec26285f8c00aca838f89e5f3877748.1662735985.git.gitgitgadget@gmail.com>
        <xmqqedwf9pjr.fsf@gitster.g>
Date:   Fri, 16 Sep 2022 10:52:52 -0700
In-Reply-To: <xmqqedwf9pjr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        13 Sep 2022 10:01:28 -0700")
Message-ID: <xmqq5yhni4uj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63965F26-35E8-11ED-B37E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The first conditional to parse the configuration variable name var
> tries to handle both generic transfer.hideRefs and direction
> specific {receive,uploadpack}.hideRefs and "section" at this point
> has "transfer", "receive" or "uploadpack", doesn't it?

This part of my review comments was based on my misreading the
patch.  Sorry.  "section" comes from the caller and says either
"receive" or "uploadpack".

But because the updating of hide_refs_section is done outside that
"first conditional" that makes sure we are actually looking at a
"*.hiderefs" configuration variable, it is misleading.  The only
saving grace is that it is guarded by "hook"

> +	if (hook && hide_refs_section.len == 0)
> +		strbuf_addstr(&hide_refs_section, section);
> +

that is only set inside the body of the if statement of the first
conditional that ensures that we are reading *.hiderefs variable,
but it would make more sense to move it inside it.

Or even better would be to clean the function up with a preliminary
patch to return early when we are not looking at *.hiderefs variable,
perhaps like the attached, and then build on top.

 refs.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git i/refs.c w/refs.c
index c89d558892..8cf8c58ebd 100644
--- i/refs.c
+++ w/refs.c
@@ -1393,24 +1393,29 @@ static struct string_list *hide_refs;
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
 	const char *key;
-	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
-	     !strcmp(key, "hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings = 1;
-		}
-		string_list_append(hide_refs, ref);
+	char *ref;
+	int len;
+
+	/*
+	 * "section" is either "receive" or "uploadpack"; are we looking
+	 * at transfer.hiderefs or $section.hiderefs?
+	 */
+	if (strcmp("transfer.hiderefs", var) &&
+	    !(!parse_config_key(var, section, NULL, NULL, &key) &&
+	      !strcmp(key, "hiderefs")))
+		return 0; /* neither */
+	if (!value)
+		return config_error_nonbool(var);
+	ref = xstrdup(value);
+	len = strlen(ref);
+	while (len && ref[len - 1] == '/')
+		ref[--len] = '\0';
+	if (!hide_refs) {
+		CALLOC_ARRAY(hide_refs, 1);
+		hide_refs->strdup_strings = 1;
 	}
+	string_list_append(hide_refs, ref);
+
 	return 0;
 }
 
