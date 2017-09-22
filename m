Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171CB20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 01:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdIVBGE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:06:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751779AbdIVBGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B02D5920EE;
        Thu, 21 Sep 2017 21:06:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ooefcudjmmFokTg3+WPiVNg6Ig=; b=yR7ooG
        QAooGG/drp7LZx5BU4j9CEs4DBQrVPebP9S8gu660TSFzTw2smuTczA7jgcoHh1d
        u/vQ4mv8kjaEoGXQHd64jSwiL5Z1D210namM7zmjo01supTU+cgriEWgkwBaql6z
        EGABJuUWMlBmvbglibnr3fhqyu8fDmCX9U0aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cCkhAw9xLbiP9EcQFODXlRmm96bgyNep
        h1U0ioJamy04CbBYikK3qcedqUAj4lD9C5lm2omkplqRl1NinKHClNQJL2C32u6L
        HWavkw+pY0j0x1XnwoZ1bP71mtTaiKV211JsFPzMsxBzbRuDKhtmlaFTDXQsJMg8
        zgtTWuiu47s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4FE8920ED;
        Thu, 21 Sep 2017 21:06:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB82A920E9;
        Thu, 21 Sep 2017 21:06:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        bmwill@google.com
Subject: Re: [PATCH v3] connect: in ref advertisement, shallows are last
References: <20170922000004.GB77641@google.com>
        <20170922000801.22560-1-jonathantanmy@google.com>
Date:   Fri, 22 Sep 2017 10:06:00 +0900
In-Reply-To: <20170922000801.22560-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 21 Sep 2017 17:08:01 -0700")
Message-ID: <xmqqd16jmtjb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3360221C-9F32-11E7-9F11-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, get_remote_heads() parses the ref advertisement in one loop,
> allowing refs and shallow lines to intersperse, despite this not being
> allowed by the specification. Refactor get_remote_heads() to use two
> loops instead, enforcing that refs come first, and then shallows.
>
> This also makes it easier to teach get_remote_heads() to interpret other
> lines in the ref advertisement, which will be done in a subsequent
> patch.

Sounds sensible.  This still replaces the earlier 1.5?

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I sent the wrong version of this patch :-(
>
> This should be the correct one. A bit less clean because I introduced a
> 3rd state, however.
>
>  connect.c | 167 +++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 101 insertions(+), 66 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 49b28b83b..ef6358cfc 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -107,6 +107,91 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  	string_list_clear(&symref, 0);
>  }
>  
> +/*
> + * Read one line of a server's ref advertisement into packet_buffer.
> + */
> +static int read_remote_ref(int in, char **src_buf, size_t *src_len,
> +			   int *responded)
> +{
> +	int len = packet_read(in, src_buf, src_len,
> +			      packet_buffer, sizeof(packet_buffer),
> +			      PACKET_READ_GENTLE_ON_EOF |
> +			      PACKET_READ_CHOMP_NEWLINE);
> +	const char *arg;
> +	if (len < 0)
> +		die_initial_contact(*responded);
> +	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
> +		die("remote error: %s", arg);
> +
> +	*responded = 1;
> +
> +	return len;
> +}
> +
> +#define EXPECTING_REF_WITH_CAPABILITIES 0
> +#define EXPECTING_REF 1
> +#define EXPECTING_SHALLOW 2
> +
> +static int process_ref(int *state, int len, struct ref ***list,
> +		       unsigned int flags, struct oid_array *extra_have)
> +{
> +	struct object_id old_oid;
> +	char *name;
> +	int name_len;
> +
> +	if (len < GIT_SHA1_HEXSZ + 2 ||
> +	    get_oid_hex(packet_buffer, &old_oid) ||
> +	    packet_buffer[GIT_SHA1_HEXSZ] != ' ') {
> +		*state = EXPECTING_SHALLOW;
> +		return 0;
> +	}
> +
> +	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
> +	name_len = strlen(name);
> +	if (*state == EXPECTING_REF_WITH_CAPABILITIES &&
> +	    len != name_len + GIT_SHA1_HEXSZ + 1) {
> +		free(server_capabilities);
> +		server_capabilities = xstrdup(name + name_len + 1);
> +	} else if (*state == EXPECTING_REF) {
> +		if (len != name_len + GIT_SHA1_HEXSZ + 1)
> +			die("unexpected capabilities after ref name");
> +	}
> +
> +	if (extra_have && !strcmp(name, ".have")) {
> +		oid_array_append(extra_have, &old_oid);
> +	} else if (!strcmp(name, "capabilities^{}")) {
> +		if (**list)
> +			/* cannot coexist with other refs */
> +			die("protocol error: unexpected capabilities^{}");
> +		/* There should be no more refs; proceed to the next state. */
> +		*state = EXPECTING_SHALLOW;
> +		return 1;
> +	} else if (check_ref(name, flags)) {
> +		struct ref *ref = alloc_ref(name);
> +		oidcpy(&ref->old_oid, &old_oid);
> +		**list = ref;
> +		*list = &ref->next;
> +	}
> +	*state = EXPECTING_REF;
> +	return 1;
> +}
> +
> +static int process_shallow(struct oid_array *shallow_points)
> +{
> +	const char *arg;
> +	struct object_id old_oid;
> +
> +	if (!skip_prefix(packet_buffer, "shallow ", &arg))
> +		return 0;
> +
> +	if (get_oid_hex(arg, &old_oid))
> +		die("protocol error: expected shallow sha-1, got '%s'", arg);
> +	if (!shallow_points)
> +		die("repository on the other end cannot be shallow");
> +	oid_array_append(shallow_points, &old_oid);
> +	return 1;
> +}
> +
>  /*
>   * Read all the refs from the other end
>   */
> @@ -123,76 +208,26 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 * willing to talk to us.  A hang-up before seeing any
>  	 * response does not necessarily mean an ACL problem, though.
>  	 */
> -	int saw_response;
> -	int got_dummy_ref_with_capabilities_declaration = 0;
> +	int responded = 0;
> +	int len;
> +	int state = EXPECTING_REF_WITH_CAPABILITIES;
>  
>  	*list = NULL;
> -	for (saw_response = 0; ; saw_response = 1) {
> -		struct ref *ref;
> -		struct object_id old_oid;
> -		char *name;
> -		int len, name_len;
> -		char *buffer = packet_buffer;
> -		const char *arg;
> -
> -		len = packet_read(in, &src_buf, &src_len,
> -				  packet_buffer, sizeof(packet_buffer),
> -				  PACKET_READ_GENTLE_ON_EOF |
> -				  PACKET_READ_CHOMP_NEWLINE);
> -		if (len < 0)
> -			die_initial_contact(saw_response);
> -
> -		if (!len)
> -			break;
> -
> -		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
> -			die("remote error: %s", arg);
> -
> -		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
> -			skip_prefix(buffer, "shallow ", &arg)) {
> -			if (get_oid_hex(arg, &old_oid))
> -				die("protocol error: expected shallow sha-1, got '%s'", arg);
> -			if (!shallow_points)
> -				die("repository on the other end cannot be shallow");
> -			oid_array_append(shallow_points, &old_oid);
> -			continue;
> -		}
> -
> -		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
> -			buffer[GIT_SHA1_HEXSZ] != ' ')
> -			die("protocol error: expected sha/ref, got '%s'", buffer);
> -		name = buffer + GIT_SHA1_HEXSZ + 1;
> -
> -		name_len = strlen(name);
> -		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> -			free(server_capabilities);
> -			server_capabilities = xstrdup(name + name_len + 1);
> -		}
> -
> -		if (extra_have && !strcmp(name, ".have")) {
> -			oid_array_append(extra_have, &old_oid);
> -			continue;
> -		}
>  
> -		if (!strcmp(name, "capabilities^{}")) {
> -			if (saw_response)
> -				die("protocol error: unexpected capabilities^{}");
> -			if (got_dummy_ref_with_capabilities_declaration)
> -				die("protocol error: multiple capabilities^{}");
> -			got_dummy_ref_with_capabilities_declaration = 1;
> -			continue;
> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +		switch (state) {
> +		case EXPECTING_REF_WITH_CAPABILITIES:
> +		case EXPECTING_REF:
> +			if (process_ref(&state, len, &list, flags, extra_have))
> +				break;
> +			/* fallthrough */
> +		case EXPECTING_SHALLOW:
> +			if (process_shallow(shallow_points))
> +				break;
> +			die("protocol error: unexpected '%s'", packet_buffer);
> +		default:
> +			die("unexpected state %d", state);
>  		}
> -
> -		if (!check_ref(name, flags))
> -			continue;
> -
> -		if (got_dummy_ref_with_capabilities_declaration)
> -			die("protocol error: unexpected ref after capabilities^{}");
> -
> -		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
> -		oidcpy(&ref->old_oid, &old_oid);
> -		*list = ref;
> -		list = &ref->next;
>  	}
>  
>  	annotate_refs_with_symref_info(*orig_list);
