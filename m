Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E10201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 19:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdCNTiG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 15:38:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62852 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751450AbdCNTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 15:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32A3A6B35D;
        Tue, 14 Mar 2017 15:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9VuMqASzh+Qx2OPb2d9Zc7djurg=; b=TbggHo
        sPCFFsOu3AjktBrwlPNO54yslHwtcp9tW4OT7Eua2VC9lUEncKxzH2WhxCXN98RP
        jhSi/Blmq0B6NtDZ76gjWP7Bzkvf/9eagIjTOBeZyWgpPRIzm7IuurO0dYrmYbiC
        uyNwKg3QpnnsI24yeSieoqa3W6FfR46gWjgaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yXFL5aMw/LRKvbqACkzadJPtBuK5X1/+
        pUqG80E1U9aAxHWFiuHPZwG4jq61EJPIHjDyN1eJTWpByvWZs5iC2gBLuFwubLQb
        d0llYfw9mDd630eJWpd98LyPfENkvKRayMK8b1yrdxB6kY/nbqb1O3n9dEzxvEKT
        BBfauVGIa7A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BCC06B35B;
        Tue, 14 Mar 2017 15:38:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 917856B35A;
        Tue, 14 Mar 2017 15:38:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 07/10] clone: add --submodule-spec=<pathspec> switch
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-8-bmwill@google.com>
Date:   Tue, 14 Mar 2017 12:38:01 -0700
In-Reply-To: <20170313214341.172676-8-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:38 -0700")
Message-ID: <xmqqmvcnir8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCCF928E-08ED-11E7-B65E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The new switch passes the pathspec to `git submodule update
> --init-active` which is called after the actual clone is done.
>
> Additionally this configures the submodule.active option to
> be the given pathspec, such that any future invocation of
> `git submodule update --init-active` will keep up
> with the pathspec.
>
> Based on a patch by Stefan Beller <sbeller@google.com>
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-clone.txt | 23 ++++++++++-----
>  builtin/clone.c             | 36 +++++++++++++++++++++--
>  t/t7400-submodule-basic.sh  | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 35cc34b2f..9692eab30 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -15,7 +15,8 @@ SYNOPSIS
>  	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch]
>  	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
> -	  [--jobs <n>] [--] <repository> [<directory>]
> +	  [--submodule-spec <pathspec>] [--jobs <n>] [--]
> +	  <repository> [<directory>]

Hmph.  Can we then make "--recurse-submodules" an obsolete way to
spell "--submodule-spec ."?  I am not actively suggesting to
deprecate it; I am trying to see if there are semantic differences
between the two.

I am also wondering "--recurse-submodules=<pathspec>" would be a
better UI, instead of introducing yet another option.

> @@ -217,12 +218,20 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --recursive::
>  --recurse-submodules::
> -	After the clone is created, initialize all submodules within,
> -	using their default settings. This is equivalent to running
> -	`git submodule update --init --recursive` immediately after
> -	the clone is finished. This option is ignored if the cloned
> -	repository does not have a worktree/checkout (i.e. if any of
> -	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
> +	After the clone is created, initialize and clone all submodules
> +	within, using their default settings. This is equivalent to
> +	running `git submodule update --recursive --init` immediately
> +	after the clone is finished. This option is ignored if the
> +	cloned repository does not have a worktree/checkout (i.e.  if
> +	any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)

With reflowing it is unnecessarily harder to spot what got changed.
"and clone" is inserted, "--init" and "--recursive" were swapped.
Any other changes?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 3f63edbbf..c6731379b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -56,6 +56,16 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
>  static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
>  static int option_dissociate;
>  static int max_jobs = -1;
> +static struct string_list submodule_spec;
> +
> +static int submodule_spec_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		return -1;
> +
> +	string_list_append((struct string_list *)opt->value, arg);
> +	return 0;
> +}

Hmph,  doesn't OPT_STRING_LIST work for this thing?

> +	if (submodule_spec.nr > 0) {
> +		struct string_list_item *item;
> +		struct strbuf sb = STRBUF_INIT;
> +		for_each_string_list_item(item, &submodule_spec) {
> +			strbuf_addf(&sb, "submodule.active=%s",
> +				    item->string);
> +			string_list_append(&option_config,
> +					   strbuf_detach(&sb, NULL));
> +		}
> +	}

OK.  Each pathspec becomes submodule.active in the newly created
repository.
