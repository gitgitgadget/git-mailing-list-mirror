Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85761F855
	for <e@80x24.org>; Fri, 29 Jul 2016 21:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbcG2VqW (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 17:46:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751640AbcG2VqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 17:46:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C18A6323CA;
	Fri, 29 Jul 2016 17:46:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O8nb7Qaw/IdjKI3V8wNwM+Y/UWg=; b=Ii02SE
	x27MsRuSWtIco8nwVvDsFhyyetqDu5cOtd3+NZACI4d1YrK20kVCAqs0FfAp/MTo
	MSd3lCp9O7U21q7+DsgoYiM+KVvfuWgEc0l/FFwkGmLfPTpSdT8i4gdmWquzE1JK
	dX621nt4i7Gq9AxUKsVdBWRsHZIMRcP0z+4YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFRi6xIoW3jV6Ipap2iEVtBrd+jD6hWJ
	taZwiX7nWLTsEIq1uBU7FV1fLHjILmiB20KBDD7P7tRXCmYM9yRCoHvHWZdj7xOU
	yPLgvDtRCDodgGT1p1NYkKS9EeMHwMNyinUSHj21hGY8noz4shPdNa3WM3RXj+OO
	iyO/YZAk09A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2A97323C9;
	Fri, 29 Jul 2016 17:46:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F7F0323C8;
	Fri, 29 Jul 2016 17:46:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-5-kcwillford@gmail.com>
Date:	Fri, 29 Jul 2016 14:46:16 -0700
In-Reply-To: <20160729161920.3792-5-kcwillford@gmail.com> (Kevin Willford's
	message of "Fri, 29 Jul 2016 12:19:20 -0400")
Message-ID: <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2281A68-55D5-11E6-9568-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

>  static int patch_id_cmp(struct patch_id *a,
>  			struct patch_id *b,
> -			void *keydata)
> +			struct diff_options *opt)
>  {
> +	if (is_null_sha1(a->patch_id) &&
> +	    commit_patch_id(a->commit, opt, a->patch_id, 0))
> +		return error("Could not get patch ID for %s",
> +			oid_to_hex(&a->commit->object.oid));
> +	if (is_null_sha1(b->patch_id) &&
> +	    commit_patch_id(b->commit, opt, b->patch_id, 0))
> +		return error("Could not get patch ID for %s",
> +			oid_to_hex(&b->commit->object.oid));
>  	return hashcmp(a->patch_id, b->patch_id);
>  }

These error returns initially looks slightly iffy in that in general
the caller of any_cmp_fn() wants to know how a/b compares, but by
returning error(), it always says "a is smaller than b".  This
however may be OK because the callers in hashmap_get* implementation
only wants to know "are they equal?", and we are saying "no they
cannot possibly be equal" here.  The original that ran a full
commit_patch_id() in now-removed add_commit() helper function didn't
even diagnose this error and silently omitted the commit from the
candidate list, so this may be even seen as an improvement.

The idea of using the two level hash, computing the more expensive
one only when the hashmap hashes of the result of the cheaper hash
function collide, is excellent.  Thanks.


