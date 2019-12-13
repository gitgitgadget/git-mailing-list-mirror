Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B9C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE87214AF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FUpRwCh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMV4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:56:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59010 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMV4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:56:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30C69A9519;
        Fri, 13 Dec 2019 16:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1N4fLpCRV3P9ci88JECqCW18IZA=; b=FUpRwC
        h9gmf5XrxSXnqRPpOt1Qn/42ugiXFd0C+imB/ifziivmk19dSQLzcbp90wvkTM2u
        dUb75wpZKF9ejs1DYx09+mJU1niofc+UhpoGsaSP72SnXhN9WqMKarJCQ9bG/wsI
        pH+R1LiuX32ucTgn2Rw8S0D51pw4PXcWn49uE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g8j9+L5Khu/1qZir2fGeV5IjvdP4w18X
        tbfx7fsJBz1t6VynfqiswPsqFGzzyHOr2ds6JodT9PIXkrnUjyWkeJIf31mayHZu
        ljeFXghyChV5TrHQcTGNOPiMdVMRbFuhZMAw/ikkh8Vt+gIhJ/ncZKjT9wjHF6nq
        HxfN2sLVo/M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2901DA9518;
        Fri, 13 Dec 2019 16:56:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BB90A9517;
        Fri, 13 Dec 2019 16:56:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 13/15] bugreport: add packed object summary
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-14-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:56:07 -0800
In-Reply-To: <20191213004312.169753-14-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:10 -0800")
Message-ID: <xmqqr217houg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5ED117CA-1DF3-11EA-94EE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Alongside the list of loose objects, it's useful to see the list of
> object packs as well. It can help us to examine what Git did and did not
> pack.

Not exactly the same comment, but is in the same spirit, as the
previous step applies to this one.

Would it be too much work to libify the bulk of cmd_count_objects()
that computes numbers, making the cmd_count_objects() into a thin
wrapper that calls the libified "counter/collector" function and
prints the resulting numbers received from it?

That way, the get_packed_object_summary() can be another consumer       
of the same "counter/collector" function, no?

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index 3abb83d77f..992d8f9de7 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -234,6 +234,34 @@ static void get_loose_object_summary(struct strbuf *obj_info) {
>  	strbuf_release(&dirpath);
>  }
>  
> +static void get_packed_object_summary(struct strbuf *obj_info)
> +{
> +	struct strbuf dirpath = STRBUF_INIT;
> +	struct dirent *d;
> +	DIR *dir = NULL;
> +
> +	strbuf_addstr(&dirpath, get_object_directory());
> +	strbuf_complete(&dirpath, '/');
> +	strbuf_addstr(&dirpath, "pack/");
> +
> +	dir = opendir(dirpath.buf);
> +	if (!dir) {
> +		strbuf_addf(obj_info, "could not open packed object directory '%s'\n",
> +			    dirpath.buf);
> +		strbuf_release(&dirpath);
> +		return;
> +	}
> +
> +	while ((d = readdir(dir))) {
> +		strbuf_addbuf(obj_info, &dirpath);
> +		strbuf_addstr(obj_info, d->d_name);
> +		strbuf_complete_line(obj_info);
> +	}
> +
> +	closedir(dir);
> +	strbuf_release(&dirpath);
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output <file>]"),
>  	NULL
> @@ -307,6 +335,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Loose Object Counts");
>  	get_loose_object_summary(&buffer);
>  
> +	get_header(&buffer, "Packed Object Summary");
> +	get_packed_object_summary(&buffer);
> +
>  	report = fopen_for_writing(report_path.buf);
>  	strbuf_write(&buffer, report);
>  	fclose(report);
