Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3001F453
	for <e@80x24.org>; Thu, 25 Apr 2019 04:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfDYEQd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 00:16:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58239 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYEQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 00:16:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 956BE148F1C;
        Thu, 25 Apr 2019 00:16:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f2HPY4zLsPeIwX0C8MvG5GUuTVQ=; b=CL+b/i
        CLHBFd6dM3AajrIJZRrcp+k8EiajUjD2gmh98MeM5pvVTMZFNz+8EkooX/DuzYmB
        8Qwmo4xitUlXGkHQosv0J7yjr+SANRqQJFPI286n40j8xfgzuVeSyzdcY+YgpKZ3
        7muVkHb590w3CTue9n0PVTT89VLxjt6KGp/Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uscPXQz0l+XGvWuqIS+Xzu98hu4eYVrN
        u1eoqUaXZ5A3nu4rzMZTrjzgPGhq1mFwLcwLDssbvchgGutZ3xZ3UmARyqWnkCSD
        YjeJ7APjcaVNwEI0mTl4e1Yz0nwZxdJwNQOmNrHlfXuQE3mJBjquhMLDnVPvSnQN
        yhWdWSc/yxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B0CA148F13;
        Thu, 25 Apr 2019 00:16:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D25A3148F12;
        Thu, 25 Apr 2019 00:16:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     <git@vger.kernel.org>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: [PATCH] Documentation/merge-options: clarify --squash behavior
References: <20190424212212.10039-1-vishal.l.verma@intel.com>
Date:   Thu, 25 Apr 2019 13:16:25 +0900
In-Reply-To: <20190424212212.10039-1-vishal.l.verma@intel.com> (Vishal Verma's
        message of "Wed, 24 Apr 2019 15:22:12 -0600")
Message-ID: <xmqqr29qyb1i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4E357DC-6710-11E9-8843-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> Add a note to the --squash option for git-merge to clarify its behavior
> with respect to --commit. When --squash is supplied, 'option_commit' is
> silently dropped. This can be surprising to a user who tries to override
> the no-commit behavior of squash using --commit explicitly.
>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>
> There may be an argument to make --commit 'just work' with squash, but
> that might involve changing option_commit from OPT_BOOL to something
> that can distinguish between the default, what's requested on the
> command line, or the --no- version.

I think it is bad to silently ignore the option.  With or without
this documentation update, I think it is sensible to update the code
so that it errors out when "--squash --commit" are both given at the
same time, just like when "--squash --no-ff" is given.

Or make it "just work" as you said.  Using a boolean variable as
tristate is something we do in many places and it by itself is not a
rocket science.  You initialize the variable to -1 (unset), let
parse_options() to set it to 0/1 when "--[no-]commit" is seen, and
inspect after parse_options() finishes.  If the variable is still
-1, you know the user wants "the default" behaviour.

The "default" behaviour you are proposing would probably be
something like

        if (option_commit < 0) {
                /* 
                 * default to record the result in a commit.
                 * but --squash traditionally does not.
                 */
                if (!squash)
                        option_commit = 1;
                else
                        option_commit = 0;
        }

But I suspect that the option parsing part is the least difficult in
the "make it just work" change.  That is because I think that the
machinery to record the result in a commit is not expecting to be
asked to create a single-parent commit to record the result of the
squashing, so there may be need for adjusting to how the result
wants to be recorded before the code makes a commit.

