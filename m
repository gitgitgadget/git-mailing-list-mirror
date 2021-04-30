Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3674C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 05:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F2761362
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 05:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3Fqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 01:46:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56444 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3Fqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 01:46:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D682C22DF;
        Fri, 30 Apr 2021 01:45:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjotpeW9F9Wtim92Lwj6GfD6APXVqy07gggqrW
        ytdpU=; b=hZfPehNI3zEfJfK/JmjC10uLqrkH2WtB2isBnr/uiQVrYoJOMy0o2F
        N8ktGlsbJjqF++GkeWFWiIMNfU8yBg/Em1OI5rfbaddNWsSPvthOU6ZfEpqhOLZS
        /JGnD7vsetZH/cqVls0lldPBkMgZUEqsC8ac9U+t2RBFAkZRF0FmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25AF7C22DE;
        Fri, 30 Apr 2021 01:45:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C665C22DC;
        Fri, 30 Apr 2021 01:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Bruno Albuquerque <bga@google.com>
Subject: Re: [PATCH v2] object-info: support for retrieving object info
References: <20210420233830.2181153-1-bga@google.com>
Date:   Fri, 30 Apr 2021 14:45:50 +0900
In-Reply-To: <20210420233830.2181153-1-bga@google.com> (Bruno Albuquerque's
        message of "Tue, 20 Apr 2021 16:38:31 -0700")
Message-ID: <xmqqpmyccokx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51FBE974-A977-11EB-80E2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> Sometimes it is useful to get information of an object without having to
> download it completely.
>
> Add the "object-info" capability that lets the client ask for
> object-related information with their full hexadecimal object names.
>
> Only sizes are returned for now.
>
> Signed-off-by: Bruno Albuquerque <bga@google.com>
> ---

I recall seeing a comment that this would probably not help the vfs
usecase all that much, but does anybody else have further comment on
this change?  Otherwise let me mark the topic to be merged to 'next'
in a few days.

Thanks.

> This version is a small change with just style fixes.
>
>  Documentation/technical/protocol-v2.txt |  31 +++++++
>  Makefile                                |   1 +
>  protocol-caps.c                         | 113 ++++++++++++++++++++++++
>  protocol-caps.h                         |  10 +++
>  serve.c                                 |   2 +
>  t/t5701-git-serve.sh                    |  26 ++++++
>  6 files changed, 183 insertions(+)
>  create mode 100644 protocol-caps.c
>  create mode 100644 protocol-caps.h
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index a7c806a73e..f4ed141774 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -514,3 +514,34 @@ packet-line, and must not contain non-printable or whitespace characters. The
>  current implementation uses trace2 session IDs (see
>  link:api-trace2.html[api-trace2] for details), but this may change and users of
>  the session ID should not rely on this fact.
> +
> +object-info
> +~~~~~~~~~~~
> +
> +`object-info` is the command to retrieve information about one or more objects.
> +Its main purpose is to allow a client to make decisions based on this
> +information without having to fully fetch objects. Object size is the only
> +information that is currently supported.
> +
> +An `object-info` request takes the following arguments:
> +
> +	size
> +	Requests size information to be returned for each listed object id.
> +
> +	oid <oid>
> +	Indicates to the server an object which the client wants to obtain
> +	information for.
> +
> +The response of `object-info` is a list of the the requested object ids
> +and associated requested information, each separated by a single space.
> +
> +	output = info flush-pkt
> +
> +	info = PKT-LINE(attrs) LF)
> +		*PKT-LINE(obj-info LF)
> +
> +	attrs = attr | attrs SP attrs
> +
> +	attr = "size"
> +
> +	obj-info = obj-id SP obj-size
> diff --git a/Makefile b/Makefile
> index 21c0bf1667..3225e37b63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -961,6 +961,7 @@ LIB_OBJS += progress.o
>  LIB_OBJS += promisor-remote.o
>  LIB_OBJS += prompt.o
>  LIB_OBJS += protocol.o
> +LIB_OBJS += protocol-caps.o
>  LIB_OBJS += prune-packed.o
>  LIB_OBJS += quote.o
>  LIB_OBJS += range-diff.o
> diff --git a/protocol-caps.c b/protocol-caps.c
> new file mode 100644
> index 0000000000..13a9e63a04
> --- /dev/null
> +++ b/protocol-caps.c
> @@ -0,0 +1,113 @@
> +#include "git-compat-util.h"
> +#include "protocol-caps.h"
> +#include "gettext.h"
> +#include "pkt-line.h"
> +#include "strvec.h"
> +#include "hash.h"
> +#include "object.h"
> +#include "object-store.h"
> +#include "string-list.h"
> +#include "strbuf.h"
> +
> +struct requested_info {
> +	unsigned size : 1;
> +};
> +
> +/*
> + * Parses oids from the given line and collects them in the given
> + * oid_str_list. Returns 1 if parsing was successful and 0 otherwise.
> + */
> +static int parse_oid(const char *line, struct string_list *oid_str_list)
> +{
> +	const char *arg;
> +
> +	if (!skip_prefix(line, "oid ", &arg))
> +		return 0;
> +
> +	string_list_append(oid_str_list, arg);
> +
> +	return 1;
> +}
> +
> +/*
> + * Validates and send requested info back to the client. Any errors detected
> + * are returned as they are detected.
> + */
> +static void send_info(struct repository *r, struct packet_writer *writer,
> +		      struct string_list *oid_str_list,
> +		      struct requested_info *info)
> +{
> +	struct string_list_item *item;
> +	struct strbuf send_buffer = STRBUF_INIT;
> +
> +	if (!oid_str_list->nr)
> +		return;
> +
> +	if (info->size)
> +		packet_writer_write(writer, "size");
> +
> +	for_each_string_list_item (item, oid_str_list) {
> +		const char *oid_str = item->string;
> +		struct object_id oid;
> +		unsigned long object_size;
> +
> +		if (get_oid_hex(oid_str, &oid) < 0) {
> +			packet_writer_error(
> +				writer,
> +				"object-info: protocol error, expected to get oid, not '%s'",
> +				oid_str);
> +			continue;
> +		}
> +
> +		strbuf_addstr(&send_buffer, oid_str);
> +
> +		if (info->size) {
> +			if (oid_object_info(r, &oid, &object_size) < 0) {
> +				strbuf_addstr(&send_buffer, " ");
> +			} else {
> +				strbuf_addf(&send_buffer, " %lu", object_size);
> +			}
> +		}
> +
> +		packet_writer_write(writer, "%s",
> +				    strbuf_detach(&send_buffer, NULL));
> +	}
> +}
> +
> +int cap_object_info(struct repository *r, struct strvec *keys,
> +		    struct packet_reader *request)
> +{
> +	struct requested_info info;
> +	struct packet_writer writer;
> +	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
> +
> +	packet_writer_init(&writer, 1);
> +
> +	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
> +		if (!strcmp("size", request->line)) {
> +			info.size = 1;
> +			continue;
> +		}
> +
> +		if (parse_oid(request->line, &oid_str_list))
> +			continue;
> +
> +		packet_writer_error(&writer,
> +				    "object-info: unexpected line: '%s'",
> +				    request->line);
> +	}
> +
> +	if (request->status != PACKET_READ_FLUSH) {
> +		packet_writer_error(
> +			&writer, "object-info: expected flush after arguments");
> +		die(_("object-info: expected flush after arguments"));
> +	}
> +
> +	send_info(r, &writer, &oid_str_list, &info);
> +
> +	string_list_clear(&oid_str_list, 1);
> +
> +	packet_flush(1);
> +
> +	return 0;
> +}
> diff --git a/protocol-caps.h b/protocol-caps.h
> new file mode 100644
> index 0000000000..6351648e37
> --- /dev/null
> +++ b/protocol-caps.h
> @@ -0,0 +1,10 @@
> +#ifndef PROTOCOL_CAPS_H
> +#define PROTOCOL_CAPS_H
> +
> +struct repository;
> +struct strvec;
> +struct packet_reader;
> +int cap_object_info(struct repository *r, struct strvec *keys,
> +		    struct packet_reader *request);
> +
> +#endif /* PROTOCOL_CAPS_H */
> \ No newline at end of file
> diff --git a/serve.c b/serve.c
> index ac20c72763..aa8209f147 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -5,6 +5,7 @@
>  #include "version.h"
>  #include "strvec.h"
>  #include "ls-refs.h"
> +#include "protocol-caps.h"
>  #include "serve.h"
>  #include "upload-pack.h"
>  
> @@ -78,6 +79,7 @@ static struct protocol_capability capabilities[] = {
>  	{ "server-option", always_advertise, NULL },
>  	{ "object-format", object_format_advertise, NULL },
>  	{ "session-id", session_id_advertise, NULL },
> +	{ "object-info", always_advertise, cap_object_info },
>  };
>  
>  static void advertise_capabilities(void)
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 509f379d49..73e74a9c54 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -19,6 +19,7 @@ test_expect_success 'test capability advertisement' '
>  	fetch=shallow
>  	server-option
>  	object-format=$(test_oid algo)
> +	object-info
>  	0000
>  	EOF
>  
> @@ -240,4 +241,29 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
>  	grep "unexpected line: .this-is-not-a-command." err
>  '
>  
> +# Test the basics of object-info
> +#
> +test_expect_success 'basics of object-info' '
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=object-info
> +	object-format=$(test_oid algo)
> +	0001
> +	size
> +	oid $(git rev-parse two:two.t)
> +	oid $(git rev-parse two:two.t)
> +	0000
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	size
> +	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> +	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> +	0000
> +	EOF
> +
> +	test-tool serve-v2 --stateless-rpc <in >out &&
> +	test-tool pkt-line unpack <out >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
