Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1243C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B18C2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZVF2t9BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHQVNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:13:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52238 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgHQVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:13:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD727E025D;
        Mon, 17 Aug 2020 17:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b8zR15hpDHuiouANn491NKeYtZU=; b=ZVF2t9
        BF4FJTm4fdjOHpPgHlaaZcz2to+pFL2n7D9InwIEbSQr5P6jzkbAbu1MX9fdx6cD
        EJeWQr/yUJZUMKqOvYGfhec3QvRQL5372SnkFWZeCJV2PEEUVXf1xSuxcBZkUC9R
        jiAwsALKvJsbsNm7J+0enhzR3oT1AaR7nIHqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cFmcQjXmdAZKHf7CgnL/TlKrPvaOKqf4
        w2l4YFoqaydHGSNV4RTcZnEwLDyb2Xba++FRbZX12jJAO4wy2AR2r9EMHh46YDGO
        Jaue8J3rgWDlxStQPLCK+qQ301zr1XZsmbWldyo2i+1jyV6gj+uKsgc15X+csFN+
        5be+LBOB4gs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5E02E025C;
        Mon, 17 Aug 2020 17:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ECE2E0258;
        Mon, 17 Aug 2020 17:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v17 04/10] New capability "report-status-v2" for git-push
References: <20200518094039.757-1-worldhello.net@gmail.com>
        <20200815171740.6257-5-worldhello.net@gmail.com>
Date:   Mon, 17 Aug 2020 14:12:58 -0700
In-Reply-To: <20200815171740.6257-5-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 15 Aug 2020 13:17:34 -0400")
Message-ID: <xmqq364l0yed.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DFCADCE-E0CE-11EA-9766-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> +static void report_v2(struct command *commands, const char *unpack_status)
> +{
> +	struct command *cmd;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct ref_push_report_options *options;
> +
> +	packet_buf_write(&buf, "unpack %s\n",
> +			 unpack_status ? unpack_status : "ok");
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		int count = 0;
> +
> +		if (!cmd->report.error_message)
> +			packet_buf_write(&buf, "ok %s\n",
> +					 cmd->ref_name);
> +		else
> +			packet_buf_write(&buf, "ng %s %s\n",
> +					 cmd->ref_name,
> +					 cmd->report.error_message);
> +		for (options = cmd->report.options; options; options = options->next) {
> +			if (count++ > 0)
> +				packet_buf_write(&buf, "ok %s\n", cmd->ref_name);

If there was an error, the first one gets "ng" but all others say it
was "ok"?  That smells somewhat strange.

> +			if (options->ref_name)
> +				packet_buf_write(&buf, "option refname %s\n",
> +						 options->ref_name);
> +			if (options->old_oid)
> +				packet_buf_write(&buf, "option old-oid %s\n",
> +						 oid_to_hex(options->old_oid));
> +			if (options->new_oid)
> +				packet_buf_write(&buf, "option new-oid %s\n",
> +						 oid_to_hex(options->new_oid));
> +			if (options->forced_update)
> +				packet_buf_write(&buf, "option forced-update\n");
> +		}

> +		if (ref->report.error_message)
> +			msg = ref->report.error_message;
>  		if (msg) {
>  			strbuf_addch(&buf, ' ');
>  			quote_two_c_style(&buf, "", msg, 0);
>  		}
>  		strbuf_addch(&buf, '\n');
>  
> +		for (options = ref->report.options; options; options = options->next) {
> +			if (count++ > 0)
> +				strbuf_addf(&buf, "ok %s\n", ref->name);

Would this one ever report a "ng" for an error?

> +			if (options->ref_name)
> +				strbuf_addf(&buf, "option refname %s\n",
> +					    options->ref_name);
> +			if (options->old_oid)
> +				strbuf_addf(&buf, "option old-oid %s\n",
> +					    oid_to_hex(options->old_oid));
> +			if (options->new_oid)
> +				strbuf_addf(&buf, "option new-oid %s\n",
> +					    oid_to_hex(options->new_oid));
> +			if (options->forced_update)
> +				strbuf_addstr(&buf, "option forced-update\n");
> +		}
>  		write_or_die(1, buf.buf, buf.len);
>  	}
>  	strbuf_release(&buf);

> diff --git a/transport-helper.c b/transport-helper.c
> index defafbf4c1..0029ba18bd 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -729,6 +729,49 @@ static int push_update_ref_status(struct strbuf *buf,
>  {
>  	char *refname, *msg;
>  	int status, forced = 0;
> +	static struct ref *hint = NULL;
> +	static int new_options = 1;

I hate to see more helper functions turned into pieces that are
impossible to reuse by gaining internal state like this.  Does this
function have so many callers that makes it impractical to update
its signature to have the pointer to a "state" structure passed by
the caller?  This is called only from push_update_refs_status(), so
you should be able to define a new structure that has the two fields

	struct {
		struct ref *hint;
		int new_option;
	};

initialize an instance of it before push_update_refs_status() enters
its endless loop, and pass a pointer to it to this helper function.

> +	if (starts_with(buf->buf, "option ")) {
> +		struct ref_push_report_options *options;
> +		struct object_id old_oid, new_oid;
> +		const char *key, *val;
> +		char *p;
> +
> +		if (!hint)
> +			die(_("'option' without a matching 'ok/error' directive"));
> +		options = hint->report.options;
> +		while (options && options->next)
> +			options = options->next;
> +		if (new_options) {
> +			if (!options) {
> +				hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
> +				options = hint->report.options;
> +			} else {
> +				options->next = xcalloc(1, sizeof(struct ref_push_report_options));
> +				options = options->next;
> +			}
> +			new_options = 0;
> +		}


> -static int print_one_push_status(struct ref *ref, const char *dest, int count,
> -				 int porcelain, int summary_width)
> +static int _print_one_push_status(struct ref *ref, const char *dest, int count,
> +				  struct ref_push_report_options *options,
> +				  int porcelain, int summary_width)

Our naming convention avoids leading underscore (instead we use _1
suffix, when we cannot come up with a better name).

> +static int print_one_push_status(struct ref *ref, const char *dest, int count,
> +				 int porcelain, int summary_width)
> +{
> +	struct ref_push_report_options *options;
> +	int n = 0;
> +
> +	if (!ref->report.options)
> +		return _print_one_push_status(ref, dest, count,
> +					      NULL, porcelain, summary_width);
> +
> +	for (options = ref->report.options; options; options = options->next)

This comment applies to all the patches in this series that adds the
same pattern, but 

 * "ref->report.options" may be a good name in that it is a (linked)
   list of options;

 * The variable that is used to iterate over the list points at one
   of the elements on the list at any time, and is better called
   'option' without 's' at the end.

> +		_print_one_push_status(ref, dest, count + n++,
> +				       options, porcelain, summary_width);
> +	return n;
> +}
> +
>  static int measure_abbrev(const struct object_id *oid, int sofar)
>  {
>  	char hex[GIT_MAX_HEXSZ + 1];
