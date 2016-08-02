Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D945B1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 19:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbcHBTAM (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 15:00:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753049AbcHBTAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 15:00:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B51632FD8;
	Tue,  2 Aug 2016 13:46:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHBcoMoD11Mnt+Dyy6fq9H3XHW8=; b=Rwrwmv
	9aK85aSHeDOvQR9/o4WaGlxRiE2zTNUQj1kK5sMt4DjiFbXX1HXrLD1DIeu8Chos
	M5rs+aIxTrc9lLGHNPrG59q5N2xpJL8Q8ElybYJVwBPNoeBdNP25CM7t5lSC8UJ2
	s4wqh8Q5SyMErRRBJZBrVyH8mBiMbJ0qqlHqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQkeIJ8QLHPMV4Wq/hhV5IxJRHCuwpIi
	y9+SO5+qqKlyXQOZ3raZyrbsnZu4PHzoGXo3LmxQu9l4FlJ8DZj99GyOrtlP/aKl
	pnh4wix7Znf3XVqNUdBZUNKDfEvryZ0wyKY1+An8lO4GcpO7k4EF5A5bpUsLOTmw
	mCiLL6Kgr9w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6227D32FD7;
	Tue,  2 Aug 2016 13:46:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD51232FD6;
	Tue,  2 Aug 2016 13:46:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 10:46:38 -0700
In-Reply-To: <0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11AEDBF4-58D9-11E6-BD41-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_clean_state(void)
> +{
> +	int result = 0;
> +
> +	/* There may be some refs packed during bisection */
> +	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
> +	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> +	result = delete_refs(&refs_for_removal);
> +	refs_for_removal.strdup_strings = 1;
> +	string_list_clear(&refs_for_removal, 0);
> +	remove_path(git_path_bisect_expected_rev());
> +	remove_path(git_path_bisect_ancestors_ok());
> +	remove_path(git_path_bisect_log());
> +	remove_path(git_path_bisect_names());
> +	remove_path(git_path_bisect_run());
> +	remove_path(git_path_bisect_terms());
> +	/* Cleanup head-name if it got left by an old version of git-bisect */
> +	remove_path(git_path_head_name());
> +	 * Cleanup BISECT_START last to support the --no-checkout option
> +	 * introduced in the commit 4796e823a.
> +	 */
> +	remove_path(git_path_bisect_start());

I can see that refs/files-backend.c misuses it already, but
remove_path() helper is about removing a path in the working tree,
together with any parent directory that becomes empty due to the
removal.  You do not expect $GIT_DIR/ to become an empty directory
after removing $GIT_DIR/BISECT_LOG nor want to rmdir $GIT_DIR even
if it becomes empty.  It is a wrong helper function to use here.

Also you do not seem to check the error from the function to smudge
the "result" you are returning from this function.

Isn't unlink_or_warn() more correct helper to use here?

> +	return result;
> +}
