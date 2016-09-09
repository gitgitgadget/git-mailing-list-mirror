Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEDE1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 15:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcIIPJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 11:09:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751332AbcIIPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 11:09:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C5093B951;
        Fri,  9 Sep 2016 11:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TSDLkj912ui+28wGGMJwbLjLIqE=; b=AntT3k
        a0KWfEayELkYov7uYhGIHnDf3FtDFE//P7aSUHmhZYPehwTwbyeiHmtC/MlybTxN
        klU3c6Q8YDp+tIXdQZHEODgg1QaJeFdJcW+N3KxEkAg+16VfD+z/Isse+Hkxuzjc
        rgD5LkXwf/Um/NCGl3KGsmYUHMehYi5r2F1V4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k35RwFjaDDuNcNC5RslEQQW5rYACIwdm
        Ne+cjagoQGhtGOhzkZxwDBB+88Iy4hOKV+rxfZWpKtlf7j4re5EAvonycuEx1OGo
        yuYxUkIM2rLQBLwjjOy7lvKrHicxKkpA5SOPO+72K30XbIQU79i1ssmel8JNnMec
        cpcYY0bBvTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 552FE3B950;
        Fri,  9 Sep 2016 11:09:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE0483B94F;
        Fri,  9 Sep 2016 11:09:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
References: <cover.1472041389.git.johannes.schindelin@gmx.de>
        <cover.1473415827.git.johannes.schindelin@gmx.de>
        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
Date:   Fri, 09 Sep 2016 08:09:22 -0700
In-Reply-To: <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 9 Sep 2016 12:10:47 +0200
        (CEST)")
Message-ID: <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 650C7516-769F-11E6-A651-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static int filter_object(const char *path, unsigned mode,
> +			 const unsigned char *sha1,
> +			 char **buf, unsigned long *size)
> +{
> +	enum object_type type;
> +
> +	*buf = read_sha1_file(sha1, &type, size);
> +	if (!*buf)
> +		return error(_("cannot read object %s '%s'"),
> +			sha1_to_hex(sha1), path);
> +	if (type != OBJ_BLOB) {
> +		free(*buf);
> +		return error(_("blob expected for %s '%s'"),
> +			sha1_to_hex(sha1), path);
> +	}
> +	if (S_ISREG(mode)) {
> +		struct strbuf strbuf = STRBUF_INIT;
> +		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
> +			free(*buf);
> +			*size = strbuf.len;
> +			*buf = strbuf_detach(&strbuf, NULL);
> +		}
> +	}

This needs to error out when mode is not ISREG just like it errors
out when type is not BLOB.

Other than that, I think these four patches are good to go.

Thanks.
