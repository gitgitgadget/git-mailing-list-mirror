Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875A420135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbdCHWFa (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:05:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752985AbdCHWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:05:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E2C26E90F;
        Wed,  8 Mar 2017 16:59:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kEMNkgZ4BkX8f56gZHKDHXyP9yc=; b=capTza
        6OEK2hcms9BtGpbeY2AZYq5I27V/7DW1RQpg6e2AWBsaCUjvK8Zwcv2cW09PFrVH
        7Gazricr7LS+uNy4k7sEz7bwLKqGEAoXXn8a8H4qd4pvVCH16OYVlxbnOw5VgVw4
        iQVmCvktOwgX+V3n+MMjmLp7eo3sVduOBrdJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAjA+Ti85JX14JvxD5g53CLc54mBvn9y
        +R9usfMDJkWh00Veti8asz+KYx9NxO7bj3PDprhxzpYlY7M8o50K6c0Eg0CfuzqF
        fSVQoWidvIviOSs6tAAXI6/Gc23zLBh2HShAk98lkgX4yC+nKkQjUzKQ0JGlxTZq
        C4Y1b2O6dQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95A586E90E;
        Wed,  8 Mar 2017 16:59:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B0836E90D;
        Wed,  8 Mar 2017 16:59:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, Guillaume Wenzek <guillaume.wenzek@gmail.com>
Subject: Re: BUG Report: git branch ignore --no-abbrev flag
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
        <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 08 Mar 2017 13:59:24 -0800
In-Reply-To: <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 08 Mar 2017 10:33:39 -0800")
Message-ID: <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EDD0F80-044A-11E7-9982-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Guillaume Wenzek <guillaume.wenzek@gmail.com> writes:
>
>> After updating to git 2.12.0 on Monday I noticed that the "git branch"
>> wasn't behaving as usual.
>
> Are you sure you are trying 2.12?  v2.12.0 and before should behave
> the same way and honor --no-abbrev as far as I know.
>
> On the other hand, 'master' has 93e8cd8b ("Merge branch
> 'kn/ref-filter-branch-list'", 2017-02-27), which seems to introduce
> the regression.
>
> Karthik?

I haven't fully checked if filter.abbrev is set correctly, but I
noticed the output format is formulated without taking the value of
filter.abbrev into account at all, so this is an attempt to fix
that omission.

I also notice that filter.abbrev is _ONLY_ used by builtin/branch.c and
the actual ref-filter code does not have to know anything about it.

We probably should eliminate filter.abbrev field from the structure
and use a regular variable in builtin/branch.c and use it to pass
the result of command line parsing from cmd_branch() down to
build_format() as an argument.  

But that is outside the scope of regression fix.


 builtin/branch.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cbaa6d03c0..537c47811a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -335,9 +335,18 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		    branch_get_color(BRANCH_COLOR_CURRENT));
 
 	if (filter->verbose) {
+		struct strbuf obname = STRBUF_INIT;
+
+		if (filter->abbrev < 0)
+			strbuf_addf(&obname, "%%(objectname:short)");
+		else if (!filter->abbrev)
+			strbuf_addf(&obname, "%%(objectname)");
+		else
+			strbuf_addf(&obname, " %%(objectname:short=%d) ", filter->abbrev);
+
 		strbuf_addf(&local, "%%(align:%d,left)%%(refname:lstrip=2)%%(end)", maxwidth);
 		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
-		strbuf_addf(&local, " %%(objectname:short=7) ");
+		strbuf_addf(&local, " %s ", obname.buf);
 
 		if (filter->verbose > 1)
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
@@ -346,10 +355,12 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		else
 			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
-		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
-			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
+			    "%%(if)%%(symref)%%(then) -> %%(symref:short)"
+			    "%%(else) %s %%(contents:subject)%%(end)",
 			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
-			    branch_get_color(BRANCH_COLOR_RESET));
+			    branch_get_color(BRANCH_COLOR_RESET), obname.buf);
+		strbuf_release(&obname);
 	} else {
 		strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
 			    branch_get_color(BRANCH_COLOR_RESET));
