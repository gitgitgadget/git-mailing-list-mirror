Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20511F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbcHXRuE (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:50:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57773 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753014AbcHXRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:50:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F3C0379EF;
        Wed, 24 Aug 2016 13:46:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rXp9RxRip3oB/bnoq7Z3I/0ZIFk=; b=h27L5+
        hzZtP+Gfvv5Z8wIo3zIUCqYwkSGBivxUPaxOnISCvhsOuR+fBUTKsfgILcSxHSwG
        C20TAtacTOttj5ffqNMy2OSFiL6ZBdUdekobIwHOUW3bHqaRirm+S+SpjUxtyZUW
        lk5NQ5dGV4B/FoqUhSaGHFbDQpR+bO7ne0Uls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=giERuZ+3+lpSK2VZ/xbtFT5DdTXj8iyv
        mdzL5UARI23SWc0IqyE93HYdUctISJLSeBtwuNQDfDKIgHzTiMTZCCmgirPxhruI
        7JbTffQOKC4kyhlO+JhxxkTPBkoPmLFsu5myiRHw9y6rQA03626b5aC74xfTokMQ
        LIjhMxGJPPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45841379EE;
        Wed, 24 Aug 2016 13:46:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C33A7379ED;
        Wed, 24 Aug 2016 13:46:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de>
Date:   Wed, 24 Aug 2016 10:46:03 -0700
In-Reply-To: <320f5e862e8df12bbd1d918f0b347aeacbd25d17.1472041389.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 24 Aug 2016 14:23:39 +0200
        (CEST)")
Message-ID: <xmqqmvk2qcv8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1D8AF3E-6A22-11E6-B83C-E86612518317-77302942!pb-smtp1.pobox.com
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

When we see a blob that is not ISREG, what is expected to happen?
Is it an error?

We can argue both ways.

Currently the ONLY kind of blob that is not ISREG is a symbolic
link, and it might be OK to output it as-is without any conversion
[*1*], in which case we can simply lose the S_ISREG(mode) check
altogether (and "mode" parameter to this function).

On the other hand, because "cat-file --filters" is meant to be a
smaller-granularity operation that could be used as a building block
to emulate what "git checkout" does, i.e. "imagine that we had the
blob in the index and checking it out from the path, and hand the
caller what would have been written out to the filesystem, so that
the convert_to_working_tree() logic does not have to be emulated in
the userspace", erroring out when we see a symbolic link may be also
a valid way to handle it.  We know the usual CRLF and other conversions
do not apply to them.

In any case, silently succeeding without any output is probably what
the end-user least expects.

If we choose to fail the request, the necessary update to the test
would look like this, I think.

> diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
> new file mode 100755
> index 0000000..e466634
> --- /dev/null
> +++ b/t/t8010-cat-file-filters.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='git cat-file filters support'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ' '
> +	echo "*.txt eol=crlf diff=txt" >.gitattributes &&
> +	echo "hello" | append_cr >world.txt &&
> +	git add .gitattributes world.txt &&

	git update-index --cacheinfo :world.txt,$EMPTY_BLOB,symlink &&

> +	test_tick &&
> +	git commit -m "Initial commit"
> +'
> +
> +has_cr () {
> +	tr '\015' Q <"$1" | grep Q >/dev/null
> +}
> +
> +test_expect_success 'no filters with `git show`' '
> +	git show HEAD:world.txt >actual &&
> +	! has_cr actual
> +
> +'
> +
> +test_expect_success 'no filters with cat-file' '
> +	git cat-file blob HEAD:world.txt >actual &&
> +	! has_cr actual
> +'
> +
> +test_expect_success 'cat-file --filters converts to worktree version' '
> +	git cat-file --filters HEAD:world.txt >actual &&
> +	has_cr actual
> +'

test_expect_success 'cat-file --filters rejects a non-blob' '
	test_must_fail git cat-file --filters HEAD:
'

test_expect_success 'cat-file --filters rejects a non-regular blob' '
	test_must_fail git cat-file --filters HEAD:symlink
'

And if we choose to accept as long as it is a blob, then the last
step can lose test_must_fail (and perhaps the result needs to be
checked against "hello" without CR).


[Footnote]

*1* But of course other kinds of non-ISREG blob we would add later
    may not be something you would want to write out as-is.

