Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A5C38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DB720880
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F5R5eQKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXS0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:26:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59689 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:26:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30FA747177;
        Mon, 24 Feb 2020 13:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZjvKv9hnw3W43Bv/uxWHQVknkoc=; b=F5R5eQ
        KDb7jaM5QPKAhsP8L56t3wKLV4VUymm/NXhLs6KIMS3oquGZvv/3PKOX/oF8QtdD
        w84lqPo9H7Tb+k4W7qGD/s2Z7SXA1bPiceEtuYDeAZdo4S8xTQO0AMWPfyf+AEIW
        GL18ejuOwMxWu1jFpcbDz1gYA5Iob+YLZoqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MQ/mnVVhC59vhK7Rgn+lKml+QsspCq5C
        dTB96vWWktZ7+6KeFJfPTpmYWH4LEfAvkzc4wGo4mSCUEU0DSmpcG2+7Jkd6Yy4p
        jHTXsCdD+aJ/5k7hFKB180oWjPqdtKGPL903TMY/tgIH2iEgu3aoq5i3v0QsuyxO
        Nlh2t0ZXM2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28B3D47176;
        Mon, 24 Feb 2020 13:26:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9195F47175;
        Mon, 24 Feb 2020 13:26:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing tags
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-19-sandals@crustytoothpaste.net>
Date:   Mon, 24 Feb 2020 10:26:45 -0800
In-Reply-To: <20200222201749.937983-19-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 22 Feb 2020 20:17:43 +0000")
Message-ID: <xmqq8skrrgd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3702EFA6-5733-11EA-8FE6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We have a function which parses a buffer with a signature at the end,
> parse_signature, and this function is used for signed tags.  However,
> the transition plan has SHA-256 tags using a header, which is a
> materially different syntax.  The current interface is not suitable for
> parsing such tags.
>
> Adjust the parse_signature interface to store the parsed data in two
> strbufs and turn the existing function into parse_signed_buffer.  The
> latter is still used in places where we want to strip off the signature
> in a SHA-1 tag or in places where we know we always have a signed
> buffer, such as push certs.
>
> Adjust all the callers to deal with this new interface.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/fmt-merge-msg.c | 26 ++++++++++++++++++--------
>  builtin/receive-pack.c  |  4 ++--
>  builtin/tag.c           | 16 ++++++++++++----
>  commit.c                |  9 ++++++---
>  gpg-interface.c         | 13 ++++++++++++-
>  gpg-interface.h         |  9 ++++++++-
>  log-tree.c              | 14 ++++++++------
>  ref-filter.c            | 18 ++++++++++++++----
>  tag.c                   | 15 ++++++++-------
>  9 files changed, 88 insertions(+), 36 deletions(-)
>
> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> index 05a92c59d8..29f647e2d9 100644
> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -472,6 +472,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
>  			      const char *buf,
>  			      unsigned long len)
>  {
> +
>  	const char *tag_body = strstr(buf, "\n\n");
>  	if (tag_body) {
>  		tag_body += 2;

Is this hunk a pun to rhyme with the strstr ;-)?

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 2d538bcd6e..b25f5c21d8 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -345,7 +345,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
>  		fputs(output, stderr);
>  }
>  
> -size_t parse_signature(const char *buf, size_t size)
> +size_t parse_signed_buffer(const char *buf, size_t size)
>  {
>  	size_t len = 0;
>  	size_t match = size;
> @@ -361,6 +361,17 @@ size_t parse_signature(const char *buf, size_t size)
>  	return match;
>  }
>  
> +int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct strbuf *signature)
> +{
> +	size_t match = parse_signed_buffer(buf, size);
> +	if (match != size) {
> +		strbuf_add(payload, buf, match);
> +		strbuf_add(signature, buf + match, size - match);
> +		return 1;
> +	}
> +	return 0;
> +}
> +

Makes sense.

