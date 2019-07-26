Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B9A1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGZTcQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:32:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55060 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfGZTcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:32:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40B73150823;
        Fri, 26 Jul 2019 15:32:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zZfK0TGu6CwaGkxGstUGiU/UCHQ=; b=KZ/CaT
        gh320JXbxLNVBtwcJNbbbIKUS7v5cNPBuAhTcYRrTQ2gHQrlcbUrXpE7Gd48wS/S
        O9A7BywnePC8GnPL/kyLDGdhNUNOivnmhn1jtRzaZkpgtTkcMgl8S0PcuvYV4Aj7
        OcunNl2AUkM8YpsRwcGckOqaa5vz8XP9MRtbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cvq47YA/bSzuOEejKh2jkalK8yDb0arS
        g7fsdBOoWZ47IZk3x0EBk1KbjfnNhYttmrTVK/v1A7S0f0R503ZhGReihXuJ/EKf
        ftQoNDrjOkLbwTON0mugabxXyYpUaL0Nco2cGrMIR6Xz7q41UuXtzNHnhBwa12NF
        qsyOt/UtTtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3825F150822;
        Fri, 26 Jul 2019 15:32:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E191150821;
        Fri, 26 Jul 2019 15:32:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/20] merge-recursive: exit early if index != head
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-5-newren@gmail.com>
Date:   Fri, 26 Jul 2019 12:32:12 -0700
In-Reply-To: <20190726155258.28561-5-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:42 -0700")
Message-ID: <xmqqblxgoamb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11BAB41C-AFDC-11E9-8235-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Make sure we do the index == head check at the beginning of the merge,
> and error out immediately if it fails.  While we're at it, fix a small
> leak in the show-the-error codepath.

As the call to repo_index_has_changes() is moved to the very
beginning of merge_recursive() and merge_trees(), the workhorse of
the merge machinery, merge_trees_internal(), can lose it.

> +static int merge_start(struct merge_options *opt, struct tree *head)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	assert(opt->branch1 && opt->branch2);

This is a new assertion that did not exist in the original, isn't
it?  I do not object to new sensible assertions, and I think these
two fields must be non-null in a freshly initialized merge_options
structure, but shouldn't we be discussing if these two fields should
be non-NULL, and if there are other fields in the same structure
that we should be adding new assertions on, in a separate step on
its own?

> +	if (repo_index_has_changes(opt->repo, head, &sb)) {
> +		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> +		    sb.buf);
> +		strbuf_release(&sb);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
