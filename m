Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8FF1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcHLWdA (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:33:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845AbcHLWc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:32:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AF733DA9;
	Fri, 12 Aug 2016 18:32:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VV1USDj3Zjr93rcyZ+ixqnmf9H4=; b=cb5mBe
	MRbiIYIm5QUVY04wGhf9lNL2FxduLvBiw7nKzYKwK6t/gV+Yd9BKA/rnswwySwnA
	7IvLRyRrCaFvQG3xYUtbc7uRmBv/LLCYTP49Z/MSaO5D+Tjq2pxU2uB41LnD32o7
	gcFxK3mhp0adlU9VeZ+sGt18Su0q03oTYhN84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wPk00pfuwev1o6EOyV6DTTNvxKVgwP8S
	l9QJzuh1wbXIbfwEUNnucr6AnI6/rBhkHea0QlATPJJYI6DwL/E+actKmMc4x28b
	5TAK3+9ze6LdPgHMNiQWpQbOtMaCp3byLrF2Y6Q+WUyaPkbZdS9YhVn0aKIWPf4V
	QtsgHyKf6RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AB3433DA8;
	Fri, 12 Aug 2016 18:32:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1135733DA6;
	Fri, 12 Aug 2016 18:32:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv4 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160811231405.17318-1-sbeller@google.com>
	<20160811231405.17318-9-sbeller@google.com>
Date:	Fri, 12 Aug 2016 15:32:55 -0700
In-Reply-To: <20160811231405.17318-9-sbeller@google.com> (Stefan Beller's
	message of "Thu, 11 Aug 2016 16:14:05 -0700")
Message-ID: <xmqq60r5vcrs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B83354E0-60DC-11E6-AD13-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +int add_possible_reference_from_superproject(
> +		struct alternate_object_database *alt, void *sas_cb)
> +{
> +	struct submodule_alternate_setup *sas = sas_cb;
> +
> + ...
> +	size_t namelen = alt->name - alt->base - 1;
> +	struct strbuf name = STRBUF_INIT;
> +	strbuf_add(&name, alt->base, namelen);
> +
> +	/*
> +	 * If the alternate object store is another repository, try the
> +	 * standard layout with .git/modules/<name>/objects
> +	 */
> +	if (ends_with(name.buf, ".git/objects")) {
> +		char *sm_alternate;
> +		struct strbuf sb = STRBUF_INIT;
> +		struct strbuf err = STRBUF_INIT;
> +		strbuf_add(&sb, name.buf, name.len - strlen("objects"));
> +		/*
> +		 * We need to end the new path with '/' to mark it as a dir,
> +		 * otherwise a submodule name containing '/' will be broken
> +		 * as the last part of a missing submodule reference would
> +		 * be taken as a file name.
> +		 */
> +		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
> +
> +		sm_alternate = compute_alternate_path(sb.buf, &err);

OK.  Thanks to the refactoring in the earlier step, this has become
quite straight-forward and robust; this code will always decide if
the other directory can be used as an alternate the same way the
"git clone" we will call would decide.

Good.
