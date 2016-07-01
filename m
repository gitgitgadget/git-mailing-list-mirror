Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A192018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbcGARLa (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:11:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751932AbcGARL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:11:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 83118266E6;
	Fri,  1 Jul 2016 13:11:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3eyKAoAwBem5Pzk78M+xY4MfKjo=; b=WCjpxC
	TR0FhPAvgCKf6Cjptg1uonONRO3G+EF92yeDzIQGCMZZjYGenYEoisVMxtZZ+RBD
	wGaIJ2ANeUXCYhAhKirAfu0Q71PPJ6TVypcCwbb6JgYJbCkuufBTwWcrKOoLxCkx
	EMKlqVMynA6nqUoahb2tW3rgO4BUqh1G9EPAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FVQnLkV4omlpgW+8J8a7seCbd081GrCz
	NgRWyDgzj5NPqIfYGfFrXj87Y7/P4HPrngqEy6EJfBUILoFSyUYVCNrlHoc9RHSZ
	GqsZg+ixRnQaWXzwDaOVJ9ljhxCjidso8KLp3yIjfDCYU0s6RWfqql2lNI2GsMV/
	5W4UlQJIeas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C18E266E5;
	Fri,  1 Jul 2016 13:11:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02995266E4;
	Fri,  1 Jul 2016 13:11:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, dwwang@google.com
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160630005951.7408-1-sbeller@google.com>
	<20160630005951.7408-3-sbeller@google.com>
Date:	Fri, 01 Jul 2016 10:11:12 -0700
In-Reply-To: <20160630005951.7408-3-sbeller@google.com> (Stefan Beller's
	message of "Wed, 29 Jun 2016 17:59:49 -0700")
Message-ID: <xmqqh9c9z3kf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1545590-3FAE-11E6-9A6A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static const char *stream_push_options_to_file()
> +{
> +	static const char *fname = "push-options-XXXXXX";
> +	char *ret = xmallocz(strlen(fname));
> +	int fd;
> +	memcpy(ret, fname, strlen(fname));
> +	fd = mkstemp(ret);

Probably

	char *ret;
	int fd;

	ret = xstrdup("push-options-XXXXXX");
	fd = xmkstemp(ret);

or use mkstemp but check the return value and "goto fail".

> +	for (;;) {
> +		char *line;
> +		int len;
> +
> +		line = packet_read_line(0, &len);
> +
> +		if (!line)
> +			break;
> +
> +		if (write_in_full(fd, line, len) < 0 ||
> +		    write_in_full(fd, "\n", 1) < 0)
> +			goto fail;
> +	}
> +
> +	return ret;
> +fail:
> +	close(fd);
> +	free(ret);
> +	return NULL;
> +}
> +
>  static const char *parse_pack_header(struct pack_header *hdr)
>  {
>  	switch (read_pack_header(0, hdr)) {
> @@ -1767,6 +1808,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		const char *unpack_status = NULL;
>  		const char *push_options_file = NULL;
>  
> +		if (use_push_options)
> +			push_options_file = stream_push_options_to_file();
> +
>  		prepare_shallow_info(&si, &shallow);
>  		if (!si.nr_ours && !si.nr_theirs)
>  			shallow_update = 0;
