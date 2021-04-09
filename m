Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B46C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A741A61186
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDIFJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:09:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59172 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhDIFJS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 01:09:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8381132258;
        Fri,  9 Apr 2021 01:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ek3dRVCuoqUgOmHRqw4bPPKzaqk=; b=WEqaIz
        ijDXmrYC3SAwqzrx69lrAERIIZCLiPyN2+VWKu1yQ50oUOG5mTvmpWfWHf1iXXcb
        XmsVZkz5fSrQ9aBzCuvvQ80uFAluLmFyjC+W8j4fU0ZJx3wgkbalpgRwf1u7g91R
        M71XGN7NzQ5rSypj3ESKXYZOfKTBeCM95Qs8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t5hiyFdXporrhQuFdUpp0JBGbliZLvjz
        RuhLEba6gbC37AO5Ekvx6re8ZAgUrKd2FUu4EU3d9ro3f3uXV64sxnJmaCcsqmWM
        1Ze9fZSQp6CFo/o9bdHp7MF/KVUk2Onh8fgD62FeV8G3hce8HoCX9R81ZD55HgqP
        OW23ugHkdFw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1159132257;
        Fri,  9 Apr 2021 01:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E740A132256;
        Fri,  9 Apr 2021 01:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] fetch-pack: refactor process_acks()
References: <cover.1617929278.git.jonathantanmy@google.com>
        <6a9f78df1a3513df04ac3275cd1feccfb6cf87b1.1617929278.git.jonathantanmy@google.com>
Date:   Thu, 08 Apr 2021 22:08:15 -0700
In-Reply-To: <6a9f78df1a3513df04ac3275cd1feccfb6cf87b1.1617929278.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 8 Apr 2021 18:09:59 -0700")
Message-ID: <xmqqsg40niyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98000716-98F1-11EB-A6BE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A subsequent commit will need part, but not all, of the functionality in
> process_acks(), so move some of its functionality to its sole caller
> do_fetch_pack_v2(). As a side effect, the resulting code is also
> shorter.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 70 +++++++++++++++++-----------------------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)

Nicely done.

I first found the patch hard to follow, but that wasn't due to this
patch, but because I wasn't all that familiar with the original
anymore (even though I do recall futzing with the codepath that
involves the in_vain stuff myself at some point in the past).

And indeed the resulting code is easy to see what is going on (I'd
need a lot more concentration than I can muster this late in the
night to be able to tell if the behaviour does not change with the
patch, though).

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 2318ebe680..9f3901cdba 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1351,35 +1351,11 @@ static int process_section_header(struct packet_reader *reader,
>  	return ret;
>  }
>  
> -enum common_found {
> -	/*
> -	 * No commit was found to be possessed by both the client and the
> -	 * server, and "ready" was not received.
> -	 */
> -	NO_COMMON_FOUND,
> -
> -	/*
> -	 * At least one commit was found to be possessed by both the client and
> -	 * the server, and "ready" was not received.
> -	 */
> -	COMMON_FOUND,
> -
> -	/*
> -	 * "ready" was received, indicating that the server is ready to send
> -	 * the packfile without any further negotiation.
> -	 */
> -	READY
> -};
> -
> -static enum common_found process_acks(struct fetch_negotiator *negotiator,
> -				      struct packet_reader *reader,
> -				      struct oidset *common)
> +static int process_ack(struct fetch_negotiator *negotiator,
> +		       struct packet_reader *reader,
> +		       struct object_id *common_oid,
> +		       int *received_ready)
>  {
> -	/* received */
> -	int received_ready = 0;
> -	int received_ack = 0;
> -
> -	process_section_header(reader, "acknowledgments", 0);
>  	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
>  		const char *arg;
>  
> @@ -1387,20 +1363,17 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
>  			continue;
>  
>  		if (skip_prefix(reader->line, "ACK ", &arg)) {
> -			struct object_id oid;
> -			received_ack = 1;
> -			if (!get_oid_hex(arg, &oid)) {
> +			if (!get_oid_hex(arg, common_oid)) {
>  				struct commit *commit;
> -				oidset_insert(common, &oid);
> -				commit = lookup_commit(the_repository, &oid);
> +				commit = lookup_commit(the_repository, common_oid);
>  				if (negotiator)
>  					negotiator->ack(negotiator, commit);
>  			}
> -			continue;
> +			return 1;
>  		}
>  
>  		if (!strcmp(reader->line, "ready")) {
> -			received_ready = 1;
> +			*received_ready = 1;
>  			continue;
>  		}
>  
> @@ -1418,13 +1391,12 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
>  	 * sent. Therefore, a DELIM is expected if "ready" is sent, and a FLUSH
>  	 * otherwise.
>  	 */
> -	if (received_ready && reader->status != PACKET_READ_DELIM)
> +	if (*received_ready && reader->status != PACKET_READ_DELIM)
>  		die(_("expected packfile to be sent after 'ready'"));
> -	if (!received_ready && reader->status != PACKET_READ_FLUSH)
> +	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
>  		die(_("expected no other sections to be sent after no 'ready'"));
>  
> -	return received_ready ? READY :
> -		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
> +	return 0;
>  }
>  
>  static void receive_shallow_info(struct fetch_pack_args *args,
> @@ -1573,6 +1545,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct fetch_negotiator negotiator_alloc;
>  	struct fetch_negotiator *negotiator;
>  	int seen_ack = 0;
> +	struct object_id common_oid;
> +	int received_ready = 0;
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
> @@ -1631,22 +1605,22 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			break;
>  		case FETCH_PROCESS_ACKS:
>  			/* Process ACKs/NAKs */
> -			switch (process_acks(negotiator, &reader, &common)) {
> -			case READY:
> +			process_section_header(&reader, "acknowledgments", 0);
> +			while (process_ack(negotiator, &reader, &common_oid,
> +					   &received_ready)) {
> +				in_vain = 0;
> +				seen_ack = 1;
> +				oidset_insert(&common, &common_oid);
> +			}
> +			if (received_ready) {
>  				/*
>  				 * Don't check for response delimiter; get_pack() will
>  				 * read the rest of this response.
>  				 */
>  				state = FETCH_GET_PACK;
> -				break;
> -			case COMMON_FOUND:
> -				in_vain = 0;
> -				seen_ack = 1;
> -				/* fallthrough */
> -			case NO_COMMON_FOUND:
> +			} else {
>  				do_check_stateless_delimiter(args, &reader);
>  				state = FETCH_SEND_REQUEST;
> -				break;
>  			}
>  			break;
>  		case FETCH_GET_PACK:
