Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446791F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 16:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNQkt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 12:40:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52858 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNQkt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 12:40:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC5D17B6B5;
        Wed, 14 Aug 2019 12:40:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JNkAGi4NvnrRyoX1NgeKX8wVbh4=; b=s+1bs3
        ckyk4Z3opFodVw/pef6s/SE+OAZC8UdyzI7ZCyy5YX8agO5+yr3HgJQMTvG0rAvr
        Hue14iwm3rEUs5BE0cJaVOPSPSIyQATfPNozaN0r+jruLxUpCDSbpdZq8cpRrYMm
        pHMxeuUFMfFDJ+8kpA5cdwBonoAs0f6WCj1Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qj8BavwZRmUvzfKm4vaclF5N9ECER4BR
        PKxVr/z6t7c/7mc03nm/r5CuwtjjmZ7vgjiMIhr26w81Gyhpe0dA220mGP3Kouns
        2MP7i+xUDtzw8TDzFzdzZNBPjis/LSi565yEtRlnS0/8jgmXl89PsWFtr+S8fRIW
        AY8QvZZ0QIw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3D607B6B4;
        Wed, 14 Aug 2019 12:40:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7CA17B6B2;
        Wed, 14 Aug 2019 12:40:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Paolo Pettinato \(ppettina\)" <ppettina@cisco.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
        <20190814153607.GB12093@sigill.intra.peff.net>
Date:   Wed, 14 Aug 2019 09:40:40 -0700
In-Reply-To: <20190814153607.GB12093@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 14 Aug 2019 11:36:07 -0400")
Message-ID: <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41C4500C-BEB2-11E9-B8F6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Because you created a file in the uninitialized submodule directory, it
> fools the is_empty_dir() check. It seems like there should be a more
> robust way to check whether the submodule is initialized. Maybe:
>
> diff --git a/submodule.c b/submodule.c
> index 77ace5e784..748ebe5909 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1294,6 +1294,9 @@ static int get_next_submodule(struct child_process *cp,
>  		if (!S_ISGITLINK(ce->ce_mode))
>  			continue;
>  
> +		if (!is_submodule_active(spf->r, ce->name))
> +			continue;
> +
>  		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
>  		if (!submodule) {
>  			const char *name = default_name_or_path(ce->name);
>
> but that seems to fail t5526's "on-demand works without .gitmodules
> entry" test.
>
> I think is_submodule_populated_gently() more exactly matches what the
> current code is trying to do, like so:
>
> diff --git a/submodule.c b/submodule.c
> index 77ace5e784..4b26faee5d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1347,8 +1347,7 @@ static int get_next_submodule(struct child_process *cp,
>  			 * An empty directory is normal,
>  			 * the submodule is not initialized
>  			 */
> -			if (S_ISGITLINK(ce->ce_mode) &&
> -			    !is_empty_dir(ce->name)) {
> +			if (is_submodule_populated_gently(ce->name, NULL)) {
>  				spf->result = 1;
>  				strbuf_addf(err,
>  					    _("Could not access submodule '%s'"),
>
> but it feels odd to me. Even if the submodule is not currently checked
> out, we'd presumably still want to do the recursive fetch as long as we
> have a repo under $GIT_DIR/modules?

... which means that we are not interested in "is it populated?" but
in "have we done 'git submodule init' to show interest in it?".  But
since we are walking the in-core index and picking only the gitlink
entries in it in the early part of this loop, we know ce cannot be
anything but a submodule at this point, so we will not be in the "we
are interesteed in the submodule, but the current HEAD and index is
at a commit that does not have it, hence $GIT_DIR/modules/ is the
only place that knows about it" situation.  If we are interested in
it enough to have a repository stashed under $GIT_DIR/modules/, we
should have a submodule there, shouldn't we?

What I do not quite get is that repo_submodule_init(), which is
called by get_submodule_repo_for(), looks into $GIT_DIR/modules/,
according to the in-code comment of that function.  So "we cannot
get the repo for it, which is an error condition, but we will
complain only for non-empty directory" logic feels iffy.

Stepping back even a bit more, "an empty directory is normal" makes
some sense.  If the user or the build system created a non-directory
at a path where a populated submodule would sit, that would not be
good.  If the user or the build system created a random file in the
unpopulated empty directory, in which the working tree files of the
submodule would be created once the submodule getspopulated, that
would be equally bad, wouldn't it?  Why is the user mucking with
that directory in the first place, and isn't the flagging of the
situation as an error, done with 26f80ccf ("submodule: migrate
get_next_submodule to use repository structs", 2018-11-28), a
bugfix?  If not, why not?

Puzzled....

