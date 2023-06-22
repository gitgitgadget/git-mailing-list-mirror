Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C78EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 10:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFVKJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFVKJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 06:09:04 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 03:09:03 PDT
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14BE2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 03:09:02 -0700 (PDT)
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
 <20230602102533.876905-14-christian.couder@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1687428540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSHH9SxRfFoMKakUiNs45rzBi9U97Ynuj/z9kMuzROo=;
        b=uw7KZfGpRW9wR3A/c2CORYMqB5U+9OMK67fti1RZLAUFxfP2eX+sppaGHqPoD5Sd84OfjK
        9+t1XpSzZDuKyvceJiV1KhM6D7uo6fHITCrMPHughTVM7kjJfcnKGVDEilSaGGtZpaEWIN
        N0/CKrFj24WLrWVawdQSh5wZ/IHy63w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 13/15] replay: add --advance or 'cherry-pick' mode
Date:   Thu, 22 Jun 2023 12:05:03 +0200
In-reply-to: <20230602102533.876905-14-christian.couder@gmail.com>
Message-ID: <87h6qzst8u.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> +	/*
> +	 * When the user specifies e.g.
> +	 *   git replay origin/main..mybranch
> +	 *   git replay ^origin/next mybranch1 mybranch2

When I'm trying these, I'm getting the error:
    error: option --onto or --advance is mandatory

In what situation can I omit both --onto and --advance?

> +static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
> +				  const char *onto_name,
> +				  const char **advance_name,
> +				  struct commit **onto,

Would it make sense to call this target?

> +				  struct strset **update_refs)
> +{
> +	struct ref_info rinfo;
> +
> +	get_ref_information(cmd_info, &rinfo);
> +	if (!rinfo.positive_refexprs)
> +		die(_("need some commits to replay"));
> +	if (onto_name && *advance_name)
> +		die(_("--onto and --advance are incompatible"));

Do we actually need to disallow this? I mean from git-replay's point of
view, there's no technical limitation why can cannot support both modes
at once. The update-ref commands in the output will update both target
and source branches, but it's not up to us whether that's desired.

> +	else if (onto_name) {

No need to 'else' here IMHO.

> +		*onto = peel_committish(onto_name);
> +		if (rinfo.positive_refexprs <
> +		    strset_get_size(&rinfo.positive_refs))
> +			die(_("all positive revisions given must be references"));

I tested this locally with the following command:

$ git replay --onto main OID..OID

This command didn't give any errors, neither did it return any
update-ref lines. I would have expected to hit this die().

> +	} else if (*advance_name) {
> +		struct object_id oid;
> +		char *fullname = NULL;
> +
> +		*onto = peel_committish(*advance_name);
> +		if (repo_dwim_ref(the_repository, *advance_name, strlen(*advance_name),
> +			     &oid, &fullname, 0) == 1) {
> +			*advance_name = fullname;
> +		} else {
> +			die(_("argument to --advance must be a reference"));
> +		}
> +		if (rinfo.positive_refexprs > 1)
> +			die(_("cannot advance target with multiple source branches because ordering would be ill-defined"));

The sources aren't always branches, so I suggest something like:

+			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));

> +	determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
> +			      &onto, &update_refs);
> +
> +	if (!onto) /* FIXME: Should handle replaying down to root commit */
> +		die("Replaying down to root commit is not supported yet!");

When I was testing locally I tried the following:

$ git replay --onto main feature

I was expecting this command to find the common ancestor automatically,
but instead I got this error. I'm fine if for now the command does not
determine the common ancestor yet, but I think we should provide a
better error for this scenario.

> +test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
> +	git -C bare replay --advance main topic1..topic2 >result-bare &&
> +	test_cmp expect result-bare
> +'
> +
>  test_done

Shall we add a test case when providing both --onto and --advance? And
one that omits both?
