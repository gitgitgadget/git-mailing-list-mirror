Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CDDB201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 04:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbdKNEqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 23:46:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55459 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753450AbdKNEqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 23:46:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8618AE265;
        Mon, 13 Nov 2017 23:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qMitf4POPkqUk75Qdj5+5aeLW60=; b=kFClPg
        0puG4ro+tJcnjYrPrjaQ/auvYtHgcwc8dZzloSE7EUHXp1fA41HDNBDWw4P6L/bU
        bG+h+Cgr9h1UDenBJqoPYJhbvIuDW/5W00ESWm2FH4zS+XdYYDb2wI7yn4so7H9F
        nrSB6ng8ePxZxc6bhYzRo5Eh7SPNY3Dv0Xjto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XuumTGF3wa/HGCkYYGKqzul8PcBEV4JV
        uMbF1f5/HJotyDVM0eabqwkfbFA0rDdWBEaw+FX0hW/1oo0JLD317+jBcgaTERB7
        ot/bdn/VRrzNFRLEOmOoLcOXt91sw85jjfEbaii+5e/l6D3qeeAnYaw6tdyRdWV8
        dbVjz1lhSCk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE93FAE263;
        Mon, 13 Nov 2017 23:46:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A6C5AE261;
        Mon, 13 Nov 2017 23:46:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 15/30] merge-recursive: Move the get_renames() function
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-16-newren@gmail.com>
Date:   Tue, 14 Nov 2017 13:46:43 +0900
In-Reply-To: <20171110190550.27059-16-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:35 -0800")
Message-ID: <xmqqh8tx5ux8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D079586E-C8F6-11E7-8A3C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I want to re-use some other functions in the file without moving those other
> functions or dealing with a handful of annoying split function declarations
> and definitions.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

It took me a while to figure out that you are basing this on top of
a slightly older tip of 'master'.  When rebasing on, or merging to,
a newer codebase, these two lines

> -	diff_setup(&opts);
> -	DIFF_OPT_SET(&opts, RECURSIVE);
> -	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
> -	opts.detect_rename = DIFF_DETECT_RENAME;
> ...
> +	diff_setup(&opts);
> +	DIFF_OPT_SET(&opts, RECURSIVE);
> +	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
> +	opts.detect_rename = DIFF_DETECT_RENAME;

would need a bit of adjustment.

By the way, checkpatch.pl complains about // C99 comments and binary
operators missing SP on both ends, etc., on the entire series [*1*].
These look like small issues, but they are distracting enough to
break concentration while reading the changes to spot places with
real issues and places that can be improved, so cleaning them up
early would help the final result to get better reviews.

I won't reproduce all of them here, but here are a representable
few.

ERROR: spaces required around that '=' (ctx:VxV)
#30: FILE: merge-recursive.c:1491:
+       for (i=0; i<slist->nr; i++) {
              ^

ERROR: spaces required around that '<' (ctx:VxV)
#30: FILE: merge-recursive.c:1491:
+       for (i=0; i<slist->nr; i++) {
                   ^

ERROR: "foo* bar" should be "foo *bar"
#42: FILE: merge-recursive.c:1503:
+static char* handle_path_level_conflicts(struct merge_options *o,

WARNING: suspect code indent for conditional statements (8, 10)
#80: FILE: merge-recursive.c:791:
+       if (o->call_depth || !was_tracked(path))
+         return !dirty;

Thanks.

[Footnote]

Just FYI, checkpatch.pl also notices these but it seems that our
existing codebase already violates them in a major way, so I usually
do not pay attention to these classes of complaints:

ERROR: spaces required around that ':' (ctx:VxV)
#30: FILE: merge-recursive.c:603:
+       unsigned add_turned_into_rename:1;
                                       ^

WARNING: quoted string split across lines
#74: FILE: merge-recursive.c:1433:
+                       output(o, 1, _("Refusing to lose untracked file at "
+                                      "%s, even though it's in the way."),
