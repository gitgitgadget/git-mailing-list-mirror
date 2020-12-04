Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F6C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D20822581
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgLDGhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:37:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61929 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDGhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:37:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 342E7A098E;
        Fri,  4 Dec 2020 01:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9d6OMkF/70QbT1bnJmWfPWhAkMs=; b=Pd7Yml
        UuVkhOtcxvxNYvjcMTHPt9lvrneqPTuoPJY5XLy7qvYntlZKkGbYhCuxdAxSCe6j
        Xh/nEVT6xU3/8uGGKSPIOq2D/9tU3/lNPSndGWXJ/9up1aA8HRrJH4tbuTtA9oSp
        eQYZ0scCDMQrlHuzdL1a7YgCZfiwRRdN1fIGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K5fmEjAqXJF5Xq/xjLEss3unC9f7uYjS
        TpjE4JC1OJZ7MTuiI6WM9ifjF+KK6y8SVDHpFHaIkiPB2HmVHHcfbZHJyqYWNUfQ
        Oq9sbWncD12fUgv59QpaKdF21YN/9rey3mJemTmgji9q6cM6lcTBDoa+Ah7pqtXm
        VFccwIXLi40=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CC23A098D;
        Fri,  4 Dec 2020 01:36:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA3B6A098C;
        Fri,  4 Dec 2020 01:36:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 01/27] revision: factor out parsing of diff-merge
 related options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-2-sorganov@gmail.com>
        <xmqqv9djk9tv.fsf@gitster.c.googlers.com> <87a6uuj4wx.fsf@osv.gnss.ru>
Date:   Thu, 03 Dec 2020 22:36:51 -0800
In-Reply-To: <87a6uuj4wx.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        03 Dec 2020 18:16:46 +0300")
Message-ID: <xmqqlfeef56k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18639166-35FB-11EB-8116-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>> +		if (!strcmp(optarg, "off")) {
>>> +			revs->ignore_merges = 1;
>>> +		} else {
>>> +			die(_("unknown value for --diff-merges: %s"), optarg);
>>> +		}
>>
>> To correct the above bug, it probably is sufficient to add
>>
>> 		return argcount;
>>
>> here.
>
> Right, but not enough. "argcount" should also be set to 1 at the
> beginning of the function, to avoid returning uninitialized value here.

You seem to be a bit confused.

The suggested fix is to ...

+static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
+	int argcount;
+	const char *optarg;
+	const char *arg = argv[0];
+
+	if (!strcmp(arg, "-m")) {
+		/*
+		 * To "diff-index", "-m" means "match missing", and to the "log"
+		 * family of commands, it means "show full diff for merges". Set
+		 * both fields appropriately.
+		 */
+		revs->ignore_merges = 0;
+		revs->match_missing = 1;
+	} else if (!strcmp(arg, "-c")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 0;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--cc")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 1;
+		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--no-diff-merges")) {
+		revs->ignore_merges = 1;
+	} else if (!strcmp(arg, "--combined-all-paths")) {
+		revs->diff = 1;
+		revs->combined_all_paths = 1;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die(_("unknown value for --diff-merges: %s"), optarg);
+		}

... add

		return argcount;

here.  We know argcount has a valid value that was returned from
parse_long_opt() at this point.  Nobody else needs to look at the
argcount variable.

+	} else
+		return 0;
+
+	return 1;
+}

Incidentally, that is consistent with the way the original function
handled the "diff-merges" option at ...

 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
 {
 	const char *arg = argv[0];
 	const char *optarg;
 	int argcount;
 	const unsigned hexsz = the_hash_algo->hexsz;
 ...
-		revs->ignore_merges = 0;
-		revs->match_missing = 1;
-	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
-		if (!strcmp(optarg, "off")) {
-			revs->ignore_merges = 1;
-		} else {
-			die(_("unknown value for --diff-merges: %s"), optarg);
-		}
+	} else if ((argcount = parse_diff_merge_opts(revs, argv))) {
 		return argcount;

... this point.  We asked parse_long_opt() to supply the return
value for us, and then returned that to our caller.

-	} else if (!strcmp(arg, "--no-diff-merges")) {
-		revs->ignore_merges = 1;
