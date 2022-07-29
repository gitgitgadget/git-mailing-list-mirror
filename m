Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555FEC00140
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiG2ACg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG2ACf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 20:02:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD33134D
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 17:02:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B9E214FA09;
        Thu, 28 Jul 2022 20:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ayud16iXUNoJolEJFfgF6dFj7MOE0t4vRW9tJO
        9LfP4=; b=surUB0gTMR44sqNjeM74sVRHtttVMtuGuzcz0n7nHOa2yqngVSvk7/
        vmDwJ6RuyWMsRHC/XNCnVyeQfKXk36mRI1Ui0Z5j+nlsYTatZg0WVNjJe9qCLfec
        IjxaC8HDghbuDcGhnTM3LqRcFbn9K8rjhhda98Xy+xNh6LA1E8SkI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6335D14FA08;
        Thu, 28 Jul 2022 20:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB96214FA07;
        Thu, 28 Jul 2022 20:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
 command
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-1-calvinwan@google.com>
        <xmqqo7x8aj1b.fsf@gitster.g>
Date:   Thu, 28 Jul 2022 17:02:31 -0700
In-Reply-To: <xmqqo7x8aj1b.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        28 Jul 2022 16:56:16 -0700")
Message-ID: <xmqqk07waiqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEA662FA-0ED1-11ED-963D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  Since this has changed significantly enough to render
> range-diff less useful, I think a fresh round of full review may be
> needed.  I'll use a more recent tip of 'master' as the base when I
> queue these patches.

Having said that, here is a diff between

 a/ is previous round queued with fixups merged to 'master'
 b/ is the latest round queued on top of 'master'.

which may help people to see what got changed since the previous
round.

I notice that use of CALLOC_ARRAY() suggested during the review of
the last round was dropped (it should be easy to resurrect).


 Documentation/git-cat-file.txt |  2 +-
 builtin/cat-file.c             |  4 +--
 fetch-pack.c                   | 17 +++--------
 fetch-pack.h                   |  4 +--
 object-file.c                  |  1 -
 protocol-caps.c                | 12 ++++----
 serve.c                        | 10 +++++-
 t/t1006-cat-file.sh            |  3 +-
 t/t5555-http-smart-common.sh   |  2 +-
 t/t5701-git-serve.sh           |  2 +-
 transport.c                    | 69 +++++++++++++++++++++++++-----------------
 11 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 0d9e8e6214..c073d5e50d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -117,7 +117,7 @@ info <object>::
 
 remote-object-info <remote> [<object>]::
 	Print object info for object references `<object>` at specified <remote>.
-	This command may only be combined with `--buffer`.
+	This command may be combined with `--buffer`.
 
 flush::
 	Used with `--buffer` to execute all preceding commands that were issued
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 48bf0ee02f..57c090f249 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -515,12 +515,12 @@ static int get_remote_info(struct batch_options *opt, int argc, const char **arg
 		size_t j;
 		int include_size = 0, include_type = 0;
 
-		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
+		remote_object_info = xcalloc(object_info_oids.nr, sizeof(struct object_info));
 		gtransport->smart_options->object_info = 1;
 		gtransport->smart_options->object_info_oids = &object_info_oids;
 		/**
 		 * 'size' is the only option currently supported.
-		 * Other options that are passed in the format will default to a
+		 * Other options that are passed in the format will fallback to a
 		 * standard fetch request rather than object-info.
 		 */
 		if (strstr(format, "%(objectsize)")) {
diff --git a/fetch-pack.c b/fetch-pack.c
index ca06a7130f..d373aed775 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1296,14 +1296,16 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
 void send_object_info_request(int fd_out, struct object_info_args *args)
 {
 	struct strbuf req_buf = STRBUF_INIT;
-	struct string_list unsorted_object_info_options = *args->object_info_options;
 	size_t i;
 
 	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
 
-	if (unsorted_string_list_has_string(&unsorted_object_info_options, "size"))
+	if (unsorted_string_list_has_string(args->object_info_options, "size"))
 		packet_buf_write(&req_buf, "size");
 
+	if (unsorted_string_list_has_string(args->object_info_options, "type"))
+		packet_buf_write(&req_buf, "type");
+
 	if (args->oids) {
 		for (i = 0; i < args->oids->nr; i++)
 			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
@@ -1669,7 +1671,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-			if (!args->refetch && !args->object_info && everything_local(args, &ref))
+			if (!args->refetch && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
@@ -2056,15 +2058,6 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		args->connectivity_checked = 1;
 	}
 
-	if (args->object_info) {
-		struct ref *ref_cpy_reader = ref_cpy;
-		int i = 0;
-		while (ref_cpy_reader) {
-			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args->object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
-			ref_cpy_reader = ref_cpy_reader->next;
-			i++;
-		}
-	}
 	update_shallow(args, sought, nr_sought, &si);
 cleanup:
 	clear_shallow_info(&si);
diff --git a/fetch-pack.h b/fetch-pack.h
index 552fd7bde0..11c513f748 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -72,9 +72,9 @@ struct fetch_pack_args {
 };
 
 struct object_info_args {
-	const struct string_list *object_info_options;
+	struct string_list *object_info_options;
 	const struct string_list *server_options;
-	const struct oid_array *oids;
+	struct oid_array *oids;
 };
 
 /*
diff --git a/object-file.c b/object-file.c
index 333fed9f68..417c76def3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2844,7 +2844,6 @@ void free_object_info_contents(struct object_info *object_info)
 {
 	if (!object_info)
 		return;
-
 	free(object_info->typep);
 	free(object_info->sizep);
 	free(object_info->disk_sizep);
diff --git a/protocol-caps.c b/protocol-caps.c
index bc7def0727..2ad9f45c59 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,7 +11,6 @@
 
 struct requested_info {
 	unsigned size : 1;
-	unsigned unknown : 1;
 };
 
 /*
@@ -41,12 +40,12 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	struct string_list_item *item;
 	struct strbuf send_buffer = STRBUF_INIT;
 
+	if (!oid_str_list->nr)
+		return;
+
 	if (info->size)
 		packet_writer_write(writer, "size");
 
-	if (info->unknown || !oid_str_list->nr)
-		goto release;
-
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
 		struct object_id oid;
@@ -73,7 +72,6 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
 	}
-release:
 	strbuf_release(&send_buffer);
 }
 
@@ -94,7 +92,9 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
-		info.unknown = 1;
+		packet_writer_error(&writer,
+				    "object-info: unexpected line: '%s'",
+				    request->line);
 	}
 
 	if (request->status != PACKET_READ_FLUSH) {
diff --git a/serve.c b/serve.c
index 733347f602..1adf9df4a8 100644
--- a/serve.c
+++ b/serve.c
@@ -56,6 +56,14 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
 	return 1;
 }
 
+static int object_info_advertise(struct repository *r,
+				   struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, "size");
+	return 1;
+}
+
 static void session_id_receive(struct repository *r,
 			       const char *client_sid)
 {
@@ -132,7 +140,7 @@ static struct protocol_capability capabilities[] = {
 	},
 	{
 		.name = "object-info",
-		.advertise = always_advertise,
+		.advertise = object_info_advertise,
 		.command = cap_object_info,
 	},
 };
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7f0baea07c..55b2a1f06f 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1100,6 +1100,7 @@ test_expect_success 'batch-command flush without --buffer' '
 # If a filter is not set, the filter defaults to "%(objectname) %(objectsize) %(objecttype)"
 # Since "%(objecttype)" is currently not supported by the command request, object-info,
 # the filters are set to "%(objectname) %(objectsize)".
+# Tests with the default filter are used to test the fallback to 'fetch' command
 
 set_transport_variables () {
     tree_sha1=$(git -C "$1" write-tree)
@@ -1163,7 +1164,7 @@ test_expect_success 'batch-command remote-object-info http:// default filter' '
 		echo "$tree_sha1 tree $tree_size" >>expect &&
 		echo "$commit_sha1 commit $commit_size" >>expect &&
 		echo "$tag_sha1 tag $tag_size" >>expect &&
-		git cat-file --batch-command >actual <<-EOF &&
+		GIT_TRACE_PACKET=1 git cat-file --batch-command >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_sha1 $tree_sha1
 		remote-object-info "$GIT_DAEMON_URL/parent" $commit_sha1 $tag_sha1
 		EOF
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index b1cfe8b7db..5a16d4259a 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -131,7 +131,7 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
+	object-info=size
 	0000
 	EOF
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 1896f671cb..ebb32644e3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -20,7 +20,7 @@ test_expect_success 'test capability advertisement' '
 	fetch=shallow wait-for-done
 	server-option
 	object-format=$(test_oid algo)
-	object-info
+	object-info=size
 	0000
 	EOF
 
diff --git a/transport.c b/transport.c
index 1baa1a194a..64bcc311ff 100644
--- a/transport.c
+++ b/transport.c
@@ -360,15 +360,16 @@ static int fetch_object_info(struct transport *transport, struct object_info **o
 	struct git_transport_data *data = transport->data;
 	struct object_info_args args;
 	struct packet_reader reader;
-	struct string_list server_attributes = STRING_LIST_INIT_DUP;
 
 	memset(&args, 0, sizeof(args));
 	args.server_options = transport->server_options;
 	args.object_info_options = transport->smart_options->object_info_options;
+	args.oids = transport->smart_options->object_info_oids;
 
 	connect_setup(transport, 0);
 	packet_reader_init(&reader, data->fd[0], NULL, 0,
 			PACKET_READ_CHOMP_NEWLINE |
+			PACKET_READ_GENTLE_ON_EOF |
 			PACKET_READ_DIE_ON_ERR_PACKET);
 	data->version = discover_version(&reader);
 
@@ -378,25 +379,14 @@ static int fetch_object_info(struct transport *transport, struct object_info **o
 	case protocol_v2:
 		if (!server_supports_v2("object-info", 0))
 			return -1;
-		/**
-		 * Send a request with only attributes first. If server can return all
-		 * of the requested attributes, then send request with object ids
-		 */
-		send_object_info_request(data->fd[1], &args);
-		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
-			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
+		if (unsorted_string_list_has_string(args.object_info_options, "size")
+				&& !server_supports_feature("object-info", "size", 0)) {
 			return -1;
 		}
-		string_list_split(&server_attributes, reader.line, ' ', -1);
-		packet_reader_read(&reader);
-		check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
-		if (server_attributes.nr != args.object_info_options->nr)
+		if (unsorted_string_list_has_string(args.object_info_options, "type")
+				&& !server_supports_feature("object-info", "type", 0)) {
 			return -1;
-		for (i = 0; i < server_attributes.nr; i++) {
-			if (!strcmp(server_attributes.items[i].string, "size"))
-				size_index = i + 1;
 		}
-		args.oids = transport->smart_options->object_info_oids;
 		send_object_info_request(data->fd[1], &args);
 		break;
 	case protocol_v1:
@@ -406,18 +396,29 @@ static int fetch_object_info(struct transport *transport, struct object_info **o
 		BUG("unknown protocol version");
 	}
 
-	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
-		die(_("error reading object info header"));
+	for (i = 0; i < args.object_info_options->nr; i++) {
+		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
+			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
+			return -1;
+		}
+		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
+			if (!strcmp(reader.line, "size"))
+				size_index = i;
+			continue;
+		}
+		return -1;
+	}
+
 	i = 0;
-	while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+	while (packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr) {
 		struct string_list object_info_values = STRING_LIST_INIT_DUP;
 
 		string_list_split(&object_info_values, reader.line, ' ', -1);
-		if (size_index > 0) {
-			if (!strcmp(object_info_values.items[size_index].string, ""))
+		if (0 <= size_index) {
+			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
 				die("object-info: not our ref %s",
 					object_info_values.items[0].string);
-			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[size_index].string, NULL, 10);
+			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);
 		}
 		i++;
 	}
@@ -441,7 +442,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	struct ref *refs = NULL;
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
-	struct ref *wanted_refs = xcalloc(1, sizeof (struct ref));
+	struct ref *object_info_refs = xcalloc(1, sizeof (struct ref));
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
@@ -470,11 +471,13 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.object_info = transport->smart_options->object_info;
 
 	if (transport->smart_options && transport->smart_options->object_info) {
-		struct ref *ref = wanted_refs;
+		struct ref *ref = object_info_refs;
 
 		if (!fetch_object_info(transport, data->options.object_info_data))
 			goto cleanup;
 		args.object_info_data = data->options.object_info_data;
+		args.quiet = 1;
+		args.no_progress = 1;
 		for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
 			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));
 			temp_ref->old_oid = *(transport->smart_options->object_info_oids->oid + i);
@@ -482,7 +485,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 			ref->next = temp_ref;
 			ref = ref->next;
 		}
-		transport->remote_refs = wanted_refs->next;
+		transport->remote_refs = object_info_refs->next;
 	} else if (!data->got_remote_heads) {
 		int i;
 		int must_list_refs = 0;
@@ -500,7 +503,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	else if (data->version <= protocol_v1)
 		die_if_server_options(transport);
 
-	if (data->options.acked_commits && !transport->smart_options->object_info) {
+	if (data->options.acked_commits) {
 		if (data->version < protocol_v2) {
 			warning(_("--negotiate-only requires protocol v2"));
 			ret = -1;
@@ -523,12 +526,22 @@ static int fetch_refs_via_pack(struct transport *transport,
 			  to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfiles, data->version);
 
+	if (args.object_info) {
+		struct ref *ref_cpy_reader = object_info_refs->next;
+		int i = 0;
+		while (ref_cpy_reader) {
+			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid, &(*args.object_info_data)[i], OBJECT_INFO_LOOKUP_REPLACE);
+			ref_cpy_reader = ref_cpy_reader->next;
+			i++;
+		}
+	}
+
 	data->got_remote_heads = 0;
 	data->options.self_contained_and_connected =
 		args.self_contained_and_connected;
 	data->options.connectivity_checked = args.connectivity_checked;
 
-	if (!refs)
+	if (refs == NULL && !args.object_info)
 		ret = -1;
 	if (report_unmatched_refs(to_fetch, nr_heads))
 		ret = -1;
@@ -543,7 +556,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	free_refs(refs_tmp);
 	free_refs(refs);
-	free_refs(wanted_refs);
+	free_refs(object_info_refs);
 	return ret;
 }
 
