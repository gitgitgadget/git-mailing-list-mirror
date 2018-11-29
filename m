Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146E5211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 06:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeK2ReJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:34:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56611 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeK2ReJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:34:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 682851064DC;
        Thu, 29 Nov 2018 01:29:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6mlhEQRvlc8P
        vcCltL7Fmo6bejA=; b=kY2r2mZxSMJe//eJaV8m9iMvLdvy3PtP6QVehC6sxaFu
        mScRJx2KoL6Ylcd3sIm7nx4dAgAFsfgjtyaQKz+Alhk67Jra73YcqctOfc2T0FH/
        Pc3gXqHLb+qjXMOr513ZsJ32XVpzcMlaM5FrI4wB4QqqeVthKjjxOsILlXpPiRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lYzR5U
        gZ8cWXtTueDVNOvW5tm83bvYF3iQbu9S6m9NeB3iVm8InfUs1fuiUeW62v+bQW91
        5K8id1pbMyo99GHqgHO+lSKTzOJcLZXEga75WcgWUMT3dRDYLIOnlC5aJhZnUdHj
        64Az45q9oWIW7hV52djXcRjP7VGhUfWncFL9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1191064DB;
        Thu, 29 Nov 2018 01:29:48 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1F9B1064DA;
        Thu, 29 Nov 2018 01:29:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: Re: [PATCH v2 5/7] checkout: split options[] array in three pieces
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-6-pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 15:29:46 +0900
In-Reply-To: <20181127165211.24763-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 27 Nov 2018 17:52:09 +0100")
Message-ID: <xmqqsgzko0px.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B17581E-F3A0-11E8-AC09-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static struct option *add_switch_branch_options(struct checkout_opts *=
opts,
> +						struct option *prevopts)
> +{
> +	struct option options[] =3D {
>  		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
>  			   N_("create and checkout a new branch")),

I think there should be another step to rename the options to more
sensible ones for the context.  In the context of overall "checkout"
command, the 'b' option

	git checkout -b <new-name> <commit-ish>"

that signals that its parameter has something to do with a 'branch'
makes perfect sense.  But when the user uses the new command

	git switch-branch -b <new-name> <commit-ish>

does not convey the more important fact in the context.  In the
orignal context, "this is about a branch" and "we are not checking
out an existing one, but are creating" are both worthwhile thing to
express, but because a single letter option cannot stand for both,
"-b" is the most reasonable choice (compared to calling it "-c" that
stands for "create" that invites "what exactly are you creating?").

In the new context of "switch-branch", it no longer has to be said
that the optional feature is about "branch".  So I would imagine
that users naturally expect this option to be called

	git switch-branch --create <new-name> <commit-ish>

(or -c for short).

I'll just stop with this single example, but I think we should make
sure all the options make sense in the context of new command.

Of course, that means it will NOT be sufficient to just split the
option table into two tables and stitch them together for the single
command.  This option must stay to be "-b" (giving it a synonym
"--create-branch" is OK) in the context of "checkout".
