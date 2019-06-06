Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D57A1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 22:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfFFWUt (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 18:20:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFFWUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 18:20:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E7006CA94;
        Thu,  6 Jun 2019 18:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YG6CMksIVUbLF6xFaxkGuSBqQOw=; b=qzAD4u
        ynKH/PvYLW/lhGk9z8k7oicffI1IO804booC1xASdiQ+Sth1Nenu603waX5vT30z
        l1y8DAx+WsdXhqJiClV7+tuHwrsrm99cn3YjdXDVlLCuwODhxlJPtZxDAv6TqQ7F
        iTGdklBDSUdt1JrNDKytUnAtneiuPUD/Z61qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=drg7yXfUfp0OBlosMv2D4HHrMJAyN7oI
        WJwNs4W40IID0PQ78XJaKWNn9XsjP2IXW3vKRpMRapqRXi/rT48kzUGDnYa7ZxEy
        67GGExLYWUSrHWrNFLa/8x2qYT6sSk31ZAUUJSlfbQYGcLeBa/hOAixjc4+VhsDa
        QfFR/bygyac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 117F16CA93;
        Thu,  6 Jun 2019 18:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 348EE6CA90;
        Thu,  6 Jun 2019 18:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/14] commit-graph: load commit-graph chains
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <ca670536dfe08277e953b2ef5f017dc32c1581d5.1559830527.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Jun 2019 15:20:43 -0700
In-Reply-To: <ca670536dfe08277e953b2ef5f017dc32c1581d5.1559830527.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 06 Jun 2019
        07:15:32 -0700 (PDT)")
Message-ID: <xmqq4l52qrt0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54A2C292-88A9-11E9-A5FC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (stat(chain_name, &st)) {
> ...
> +	if (st.st_size <= the_hash_algo->hexsz) {
> ...
> +	fp = fopen(chain_name, "r");
> +	free(chain_name);
> +
> +	if (!fp)
> +		return NULL;

Checking for size before opening is an invitation for an unnecessary
race, isn't it?  Perhaps fopen() followed by fstat() is a better
alternative?

> +	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
> +
> +	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
> +		char *graph_name;
> +		struct commit_graph *g;

I am imagining an evil tester growing the file after you called
xcalloc() above ;-) Should we at least protect ourselves not to read
more than we planned to read originally?  I would imagine that the
ideal code organization would be more like

	valid = 1; have_read_all = 0;

	fopen();
	fstat(fp->fileno);
	count = st.st_size / hashsize;
	oids = xcalloc();

	for (i = 0; i < count; i++) {
        	if (getline() == EOF) {
			have_read_all = 1;
			break;
		}
		add one graph based on the line;
		if (error) {
			valid = 0;
			break;
		}
	}
	if (valid && i < count)
		die("file truncated while we are reading?");
	if (valid && !have_read_all)
		die("file grew while we are reading?");

if we really care, but even without going to that extreme, at least
we should refrain from reading more than we allocated.

