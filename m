Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED1C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68F2610F7
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhDOVyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:54:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57750 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhDOVyB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:54:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3CE3C14D6;
        Thu, 15 Apr 2021 17:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nknVMNlKDObP
        uCleJpduBOj5Zkk=; b=a4Vm/NIWYB0x/9cl9mQyf4UcGAGoVDEKmFiHqn7NWf6t
        H8I9FLMVFQCn+7G9V6VCtgYrFtkVJFS580op7EMe+d/N8UBPDXLDXLXOsaZyu4zI
        7gNuDn0H++CXpgGeX0oQooJ6G/HIWFAtP1rhM8FwJwIw5PNPCSWl2dh743V7HK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CvUBoe
        07nVgjQhZmz/0GawBMXE7Om/crcycHOPE1SeQDH/bS0T2qsqckgFiYmFVO4IESRT
        ALT2b3uXNTn6gpj/Ypmy9gxwaQP/uCHyQxmy6Qlkseru9Z8AR3s5cS14BLc/lAB2
        G5v/sJrwexfHP3Pd20/czks/JfGrdFNJnQooc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7822C14D5;
        Thu, 15 Apr 2021 17:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65E2DC14D4;
        Thu, 15 Apr 2021 17:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] object-info: support for retrieving object info
References: <20210415212017.1407303-1-bga@google.com>
Date:   Thu, 15 Apr 2021 14:53:36 -0700
In-Reply-To: <20210415212017.1407303-1-bga@google.com> (Bruno Albuquerque's
        message of "Thu, 15 Apr 2021 14:20:17 -0700")
Message-ID: <xmqq4kg7p63j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0847ED98-9E35-11EB-9592-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> Sometimes it is useful to get information of an object without having t=
o
> download it completely.
>
> Add the "object-info" capability that lets the client ask for
> object-related information with their full hexadecimal object names.
>
> Only sizes are returned for now.
>
> Signed-off-by: Bruno Albuquerque <bga@google.com>
> ---

>  Documentation/technical/protocol-v2.txt |  31 +++++++
>  Makefile                                |   1 +
>  protocol-caps.c                         | 115 ++++++++++++++++++++++++
>  protocol-caps.h                         |  10 +++
>  serve.c                                 |   2 +
>  t/t5701-git-serve.sh                    |  26 ++++++
>  6 files changed, 185 insertions(+)
>  create mode 100644 protocol-caps.c
>  create mode 100644 protocol-caps.h
>
> Hello.
>
> This is my first git patch so I thought I would introduce myself. I am =
a
> software engineer at Google and I have been involved with opensource fo=
r
> a while (mostly with the Haiku OS project) and now I am working on some
> Git changes that hopefully will be generally usefull.
>
> For this specific change, a clear usage scenario is implementing a VFS
> on top of Git (something like https://github.com/microsoft/VFSForGit) i=
n
> a way that would not require someone to always fully download objects t=
o
> get information about them. Object size is the obvious one and what is
> implemented here.

Is the assumption that such an implementation of VFS would fetch
individual tree object with the existing "fetch this single object
by the object name" interface?

What I am wondering is, as an ingredient for implementing VFS layer,
if this is a bit too low level.  To respond to "ls -l" when you only
have a tree object name, you'd need two roundtrips, one to retrieve
the tree, and then after parsing the tree to find out what objects
the tree refers to with what pathname component, you'd issue the
object-info for all of them in a single request.

If a request takes a single (or multiple) tree object name, and lets
you retrieve _both_ the tree object itself _and_ object-info for the
objects the tree refers to, you can build "ls -l" with a single
roundtrip instead.

I do not know how much the latency matters (or more importantly, how
much a na=C3=AFve coutner-proposal like the above would help), but it is
what immediately came to my mind.

Assuming that we are good with an interface that needs two requests
to obtain "object contents" and "object info" separately, I find
what in this patch quite reasonable, though (admittedly, I've
already read this patch during internal review number of times).

Thanks.

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/te=
chnical/protocol-v2.txt
> index a7c806a73e..f4ed141774 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -514,3 +514,34 @@ packet-line, and must not contain non-printable or=
 whitespace characters. The
>  current implementation uses trace2 session IDs (see
>  link:api-trace2.html[api-trace2] for details), but this may change and=
 users of
>  the session ID should not rely on this fact.
> +
> +object-info
> +~~~~~~~~~~~
> +
> +`object-info` is the command to retrieve information about one or more=
 objects.
> +Its main purpose is to allow a client to make decisions based on this
> +information without having to fully fetch objects. Object size is the =
only
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
> +The response of `object-info` is a list of the the requested object id=
s
> +and associated requested information, each separated by a single space=
.
> +
> +	output =3D info flush-pkt
> +
> +	info =3D PKT-LINE(attrs) LF)
> +		*PKT-LINE(obj-info LF)
> +
> +	attrs =3D attr | attrs SP attrs
> +
> +	attr =3D "size"
> +
> +	obj-info =3D obj-id SP obj-size
> diff --git a/Makefile b/Makefile
> index 21c0bf1667..3225e37b63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -961,6 +961,7 @@ LIB_OBJS +=3D progress.o
>  LIB_OBJS +=3D promisor-remote.o
>  LIB_OBJS +=3D prompt.o
>  LIB_OBJS +=3D protocol.o
> +LIB_OBJS +=3D protocol-caps.o
>  LIB_OBJS +=3D prune-packed.o
>  LIB_OBJS +=3D quote.o
>  LIB_OBJS +=3D range-diff.o
> diff --git a/protocol-caps.c b/protocol-caps.c
> new file mode 100644
> index 0000000000..c15e397756
> --- /dev/null
> +++ b/protocol-caps.c
> @@ -0,0 +1,115 @@
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
> +static int parse_oid(const char *line, struct string_list *oid_str_lis=
t)
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
> + * Validates and send requested info back to the client. Any errors de=
tected
> + * are returned as they are detected.
> + */
> +static void send_info(struct repository *r, struct packet_writer *writ=
er,
> +		      struct string_list *oid_str_list,
> +		      struct requested_info *info)
> +{
> +	struct string_list_item *item;
> +	struct strbuf send_buffer =3D STRBUF_INIT;
> +
> +	if (!oid_str_list->nr)
> +		return;
> +
> +	if (info->size)
> +		packet_writer_write(writer, "size");
> +
> +	for_each_string_list_item (item, oid_str_list) {
> +		const char *oid_str =3D item->string;
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
> +	struct packet_writer writer;
> +	packet_writer_init(&writer, 1);
> +	int parsed_header;
> +	struct requested_info info;
> +
> +	struct string_list oid_str_list =3D STRING_LIST_INIT_DUP;
> +
> +	parsed_header =3D 0;
> +	while (packet_reader_read(request) =3D=3D PACKET_READ_NORMAL) {
> +		if (!strcmp("size", request->line)) {
> +			info.size =3D 1;
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
> +	if (request->status !=3D PACKET_READ_FLUSH) {
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
> =20
> @@ -78,6 +79,7 @@ static struct protocol_capability capabilities[] =3D =
{
>  	{ "server-option", always_advertise, NULL },
>  	{ "object-format", object_format_advertise, NULL },
>  	{ "session-id", session_id_advertise, NULL },
> +	{ "object-info", always_advertise, cap_object_info },
>  };
> =20
>  static void advertise_capabilities(void)
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 509f379d49..73e74a9c54 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -19,6 +19,7 @@ test_expect_success 'test capability advertisement' '
>  	fetch=3Dshallow
>  	server-option
>  	object-format=3D$(test_oid algo)
> +	object-info
>  	0000
>  	EOF
> =20
> @@ -240,4 +241,29 @@ test_expect_success 'unexpected lines are not allo=
wed in fetch request' '
>  	grep "unexpected line: .this-is-not-a-command." err
>  '
> =20
> +# Test the basics of object-info
> +#
> +test_expect_success 'basics of object-info' '
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=3Dobject-info
> +	object-format=3D$(test_oid algo)
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
