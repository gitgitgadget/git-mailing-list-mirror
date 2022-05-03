Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F8C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 01:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiECBTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 21:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiECBSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 21:18:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36ECE08
        for <git@vger.kernel.org>; Mon,  2 May 2022 18:14:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9023E1096BB;
        Mon,  2 May 2022 20:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r7+ziDC31rn/V74RgtVDiFRG7FQC1BJ4ZzXvyz
        VYM3c=; b=rcHTH3I0ybTh3o5IEleQXU1mR8tRyQPOiHL6xdXcGXbE/h1tZk3spq
        iAe+R11jfwAvXC4a+9IL9G6zDd8sR4XuOAz1X7GiT8ADThXTpvhBVzwhjIOVJzN9
        GFYd2jvYJUM80rc/VNR4yUyXFWQnPChZKTQyQ/tzRUf1dH8D5hQEo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77C041096BA;
        Mon,  2 May 2022 20:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C18931096B9;
        Mon,  2 May 2022 20:54:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 5/8] transport: add client side capability to request
 object-info
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-6-calvinwan@google.com>
Date:   Mon, 02 May 2022 17:54:38 -0700
In-Reply-To: <20220502170904.2770649-6-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 2 May 2022 17:09:01 +0000")
Message-ID: <xmqqilqnsaep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C8FABF8-CA7B-11EC-B669-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> The question of version mismatch often comes up with client/server
> relationships. There are two cases to consider here (assuming either
> client or server functionality for object-info changes between the
> different versions):
>
>  1. client version > server version
>  	- client can request additional attributes from server
>  2. server version > client version
>  	- server can return additional info to the client
>
> The second case is a non-issue since the client would never be able to
> request additional info from the server.

That assumes that we can never remove attributes once we start
supporting them, so it is not a non-issue exactly.  The way we make
it a non-issue is to make sure that the server returns no more than
what the client has asked, i.e. the same way we deal with the first
case.

> In order to solve the first
> case, recall an earlier patch where the server sends back the attributes
> even if no object ids are sent by the client. This allows the client to
> first check whether the server can accept the requested attributes
> before sending the entire request.

It requires two round-trips when the server does not know something
the client has asked, one without any object names, and then a real
request with the list of object names?

I think in practice, because the way the previous step is
structured, you can send a full request and in the non-error
codepath the server side will understand everything and give full
response back without an extra round-trip.  Only in the error case,
the client will see the set of acceptable attributes and no object
data (and implicitly treat that as an indication of an error), but
then what would the client do after that happens?

 - The client will just give up; the attributes it wanted but the
   server couldn't supply are so fundamentally necessary to perform
   whatever the client wanted to do.

 - The client will retry the request by asking a known subset of
   attributes for the same set of objects.  This requires an extra
   round-trip.  If an earlier step didn't make .unknown case bypass
   the response loop, this extra round-trip would have been totally
   unnecessary.

> index 8c7752fc82..c27018d48c 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -69,6 +69,12 @@ struct fetch_pack_args {
>  	unsigned connectivity_checked:1;
>  };
>  
> +struct object_info_args {
> +	const struct string_list *object_info_options;
> +	const struct string_list *server_options;
> +	const struct oid_array *oids;
> +};

These are const pointers because these lists are not owned by this
structure and are borrowed from somebody else?

> diff --git a/transport-helper.c b/transport-helper.c
> index b4dbbabb0c..093946f7fd 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -686,13 +686,16 @@ static int fetch_refs(struct transport *transport,
>  
>  	/*
>  	 * If we reach here, then the server, the client, and/or the transport
> -	 * helper does not support protocol v2. --negotiate-only requires
> -	 * protocol v2.
> +	 * helper does not support protocol v2. --negotiate-only and --object-info
> +	 * require protocol v2.
>  	 */

OK.

>  	if (data->transport_options.acked_commits) {
>  		warning(_("--negotiate-only requires protocol v2"));
>  		return -1;
>  	}
> +	if (transport->smart_options->object_info) {
> +		die(_("--object-info requires protocol v2"));
> +	}

OK.

> diff --git a/transport.c b/transport.c
> index 3d64a43ab3..08c505e1d0 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -353,6 +353,79 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  	return refs;
>  }
>  
> +static int fetch_object_info(struct transport *transport, struct object_info **object_info_data)
> +{
> +	size_t i;
> +	int size_index = -1;
> +	struct git_transport_data *data = transport->data;
> +	struct object_info_args args;
> +	struct packet_reader reader;
> +	struct string_list server_attributes = STRING_LIST_INIT_DUP;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.server_options = transport->server_options;
> +	args.object_info_options = transport->smart_options->object_info_options;

It is unclear who fills smart_options->object_info_options and from
what.  Are we referring to something that is not yet used, or worse
yet, code that is not yet written?

It seems that the result of applying 1-5/8 does not compile.

> +	connect_setup(transport, 0);
> +	packet_reader_init(&reader, data->fd[0], NULL, 0,
> +			PACKET_READ_CHOMP_NEWLINE |
> +			PACKET_READ_DIE_ON_ERR_PACKET);
> +	data->version = discover_version(&reader);
> +
> +	transport->hash_algo = reader.hash_algo;
> +
> +	switch (data->version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info", 0))
> +			return -1;
> +		/**
> +		 * Send a request with only attributes first. If server can return all
> +		 * of the requested attributes, then send request with object ids
> +		 */

Doesn't it force the most pessimistic behaviour, i.e. always do a
likely-to-be-useless (when the feature becomes widely avaiable)
probe round-trip before making a real request?

> +		send_object_info_request(data->fd[1], &args);
> +		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
> +			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
> +			return -1;
> +		}

All these check_stateless_delimiter() calls in this patch are on
overly long lines.

> +		string_list_split(&server_attributes, reader.line, ' ', -1);
> +		packet_reader_read(&reader);
> +		check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
> +		if (server_attributes.nr != args.object_info_options->nr)
> +			return -1;

So, I am guessing (without having the code that prepares the right
hand side) that we are comparing the number of attributes we asked
(on the right hand side) and the number of attributes the other side
said it supports in response to our request (on the left hand
side).  

This does not protect against a server that responds with attribute
names duplicated or any somewhat odd third-party servers that are
not identical to what you wrote here.  I would rather see us to loop
through object_info_options array and see if server_attributes list
says all of them are supported more explicitly.  That can be done in
the loop below, where you'd figure out the "foo_index" for each
attribute "foo" you are supporting in the code.

> +		for (i = 0; i < server_attributes.nr; i++) {
> +			if (!strcmp(server_attributes.items[i].string, "size"))
> +				size_index = i + 1;
> +		}

size_index was initialized to -1 and I was expecting we can tell the
attribute is not used by checking (size_index < 0), but this seems
to make size_index 1 based, not 0 based.  Intended?

I think this is to skip the object name that comes as the first item
in the response, but it would be more "pure" to keep foo_index
0-based and add the offset by whatever constant number of things
that come in front (currently, 1 for object name) near a lot closer
to where we parse and read the data, i.e. in the while() loop below.

> +		args.oids = transport->smart_options->object_info_oids;
> +		send_object_info_request(data->fd[1], &args);

And this is the second round-trip.

> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("wrong protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
> +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
> +		die(_("error reading object info header"));
> +	i = 0;
> +	while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader.line, ' ', -1);
> +		if (size_index > 0) {
> +			if (!strcmp(object_info_values.items[size_index].string, ""))
> +				die("object-info: not our ref %s",
> +					object_info_values.items[0].string);
> +			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[size_index].string, NULL, 10);
> +		}
> +		i++;
> +	}
> +	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
> +
> +	return 0;
> +}

All of the above look written for the best case scenario (i.e. it
assumes there won't be any unexpected type of response), which makes
a good fuzz target.  A malicious server side can throw non-number in
the "size" slot and strtoul() does not check for a malformatted
number, or it can return more response records than it was
requested, and overflow object_info_data[] array the caller of this
function prepared.

smart_options->object_info_oids may know how many response records
we should expect, so at least this while() loop should be able to
protect against an object_info_data[] overflow attack using it as
the upper limit of i.

>  static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
>  					struct transport_ls_refs_options *options)
>  {
> @@ -392,8 +465,14 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.server_options = transport->server_options;
>  	args.negotiation_tips = data->options.negotiation_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> +	args.object_info = transport->smart_options->object_info;
>  
> -	if (!data->got_remote_heads) {
> +	if (transport->smart_options && transport->smart_options->object_info) {
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;
> +		ret = -1;
> +		goto cleanup;
> +	} else if (!data->got_remote_heads) {
>  		int i;
>  		int must_list_refs = 0;
>  		for (i = 0; i < nr_heads; i++) {
> diff --git a/transport.h b/transport.h
> index 12bc08fc33..dbf60bb710 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -6,6 +6,7 @@
>  #include "remote.h"
>  #include "list-objects-filter-options.h"
>  #include "string-list.h"
> +#include "object-store.h"
>  
>  struct git_transport_options {
>  	unsigned thin : 1;
> @@ -31,6 +32,12 @@ struct git_transport_options {
>  	 */
>  	unsigned connectivity_checked:1;
>  
> +	/*
> +	 * Transport will attempt to pull only object-info. Fallbacks
> +	 * to pulling entire object if object-info is not supported
> +	 */
> +	unsigned object_info : 1;
> +
>  	int depth;
>  	const char *deepen_since;
>  	const struct string_list *deepen_not;
> @@ -54,6 +61,10 @@ struct git_transport_options {
>  	 * common commits to this oidset instead of fetching any packfiles.
>  	 */
>  	struct oidset *acked_commits;
> +
> +	struct oid_array *object_info_oids;
> +	struct object_info **object_info_data;
> +	struct string_list *object_info_options;
>  };
>  
>  enum transport_family {
