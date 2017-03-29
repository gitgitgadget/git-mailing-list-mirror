Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB0720969
	for <e@80x24.org>; Wed, 29 Mar 2017 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdC2RG5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:06:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbdC2RGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:06:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A438078D;
        Wed, 29 Mar 2017 13:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HgM+XfP5Y+Uj5j6bXpGh82jBMak=; b=mGuQTi
        67FwzEaHk9t2ztZQkDM6blf24mEao1MJCIOvdwUF30Ef78akEaI87n6n/UWaIx3/
        HuFEX1aooAuDyVRG3bLpzcpoXau6R8nu274l0jJgFJBtKVh/XIYCEUHIgEO7UVA8
        8Rag4KAQdLF9yfHQWCQRGHwQBhLes1LldvTC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kFSfowQArbPaa58Uu635QC6DC2t4ddNH
        xsSfYiFP6FW18bpU5MgoW4lW3gS1G83RmZDrt75DXmUizODa/knEUnbSSeDXNYYs
        X3MNPidXIT5OntO7bTkCqLieH+rN+ys1tbGJokJ1Tx14Gwy698GwLtis9Hvbwrr3
        ek/wxwbseHo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ACD78078C;
        Wed, 29 Mar 2017 13:06:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93A4F8078B;
        Wed, 29 Mar 2017 13:06:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
Date:   Wed, 29 Mar 2017 10:06:52 -0700
In-Reply-To: <20170329080820.8084-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 29 Mar 2017 10:08:20 +0200")
Message-ID: <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B820AA4-14A2-11E7-97ED-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> When performing an interactive rebase in split-index mode,
> the commit message that one should rework when squashing commits
> can contain some garbage instead of the usual concatenation of
> both of the commit messages.

OK, that is an understandable explanation of what problem you are
trying to fix.

>
> When bisecting it appears that 94c9b5af70 (Merge branch
> 'cc/split-index-config', 2017-03-17) is the first bad commit.
>
> But when rebasing cc/split-index-config on top of the commit it
> was merged with, the first bad commit is then c3a0082502
> (read-cache: use freshen_shared_index() in read_index_from(),
> 2017-03-06).

This part however doesn't help understanding the issue.  "When X but
when Y" sounds as if you found a botched merge, but that does not
seem to be the case.  The resulting tree after rebasing (with
conflict resolution) is the same as the recorded merge result.  It
could be saying that "git bisect" is buggy and does not pinpoint the
broken commit, but this is not a commit to fix "bisect".

That leaves the reader confused.

> This shows that we should be careful not to use git_path() in
> freshen_shared_index(). It is using a shared buffer that can
> too easily lead to races.

The impression I get from the symptom is that after git_path() is
called here, before check_and_freshen_file() uses that result, it
(or functions it calls) uses git_path(), and the number of times it
does so has changed since cc/split-index-config was written on the
mainline, and the rotating 4-element buffer get_pathname() gives is
now exhausted, leading to the failure you observed.  By the way,
that does not sound a race to me.

In any case, that explains why bisect says the merge is the first
bad one, and cures the confused reader ;-) The use of git_path() on
the topic was still safe; it was a timebomb waiting to go off.  The
mainline started using more calls and the merge result was unsafe.

If you meant to summarise the whole two paragraphs above that I
needed to think it through with "This shows that", I'd have to say
that you are expecting too much from your readers.  Please be a bit
more gentle to them.

Thanks.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  read-cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index e447751823..2f10242c24 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1682,9 +1682,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   */
>  static void freshen_shared_index(char *base_sha1_hex, int warn)
>  {
> -	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
> +	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
>  	if (!check_and_freshen_file(shared_index, 1) && warn)
>  		warning("could not freshen shared index '%s'", shared_index);
> +	free(shared_index);
>  }
>  
>  int read_index_from(struct index_state *istate, const char *path)
