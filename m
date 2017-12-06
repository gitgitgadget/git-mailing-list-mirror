Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1754E20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbdLFWjS (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:39:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51393 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752573AbdLFWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:39:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A7F2B28D6;
        Wed,  6 Dec 2017 17:39:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xZB3rqp1jvTF48oFtCWdRuyqnqo=; b=ivaYTU
        w31noEmHolA6ehj+0g+WvQ4716ktxPE8MIyAjq3EG9VdtCvETV2KMGEb71CFGgIN
        9oRRT507T1p9Qa5y1gqApxwzRByE/ScIpWBfv0a8gj8fecjTjMNGkh09bdkMurQJ
        rthb/5kSxtEXN5iyw0iJQwzM1JLnHlHm7kbYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r89IgwrpHttVcadCPx9UldyILdSmwf7W
        t79+kqvGwDN0lj42PQZvxiDVTJCD0cJTUShLF/xnloRRujSfAfQ5GpBv/UzGSTL1
        iQ/fsvyuA784mcv+3q/+LMBw8ErBJECoV+EcSCyDyKsFjCuJllTo5axr7NfMPwou
        gwRLFEq1Fg0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 200CCB28D5;
        Wed,  6 Dec 2017 17:39:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5699CB28D2;
        Wed,  6 Dec 2017 17:39:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 07/15] connect: convert get_remote_heads to use struct packet_reader
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-8-bmwill@google.com>
Date:   Wed, 06 Dec 2017 14:39:12 -0800
In-Reply-To: <20171204235823.63299-8-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 15:58:15 -0800")
Message-ID: <xmqqh8t3fpm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48953C28-DAD6-11E7-97A8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -56,6 +62,41 @@ static void die_initial_contact(int unexpected)
>  		      "and the repository exists."));
>  }
>  
> +static enum protocol_version discover_version(struct packet_reader *reader)
> +{
> +	enum protocol_version version = protocol_unknown_version;
> +
> +	/*
> +	 * Peek the first line of the server's response to
> +	 * determine the protocol version the server is speaking.
> +	 */
> +	switch (packet_reader_peek(reader)) {
> +	case PACKET_READ_ERROR:
> +		die_initial_contact(0);
> +	case PACKET_READ_FLUSH:
> +	case PACKET_READ_DELIM:
> +		version = protocol_v0;
> +		break;
> +	case PACKET_READ_NORMAL:
> +		version = determine_protocol_version_client(reader->line);
> +		break;
> +	}
> +
> +	/* Maybe process capabilities here, at least for v2 */
> +	switch (version) {
> +	case protocol_v1:
> +		/* Read the peeked version line */
> +		packet_reader_read(reader);
> +		break;
> +	case protocol_v0:
> +		break;
> +	case protocol_unknown_version:
> +		BUG("ERROR");
> +	}
> +
> +	return version;
> +}
> +

This discovers and consumes the "version" thing, but for an older
protocol that does not have the "version" thing, it does not clobber
the first "ref", thanks to its use of peek.  Makes sense.

> +#define EXPECTING_FIRST_REF 0
> +#define EXPECTING_REF 1
> +#define EXPECTING_SHALLOW 2
> +#define EXPECTING_DONE 3
>  
>  static void process_capabilities(int *len)
>  {
> @@ -230,28 +237,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			      struct oid_array *shallow_points)
>  {
>  	struct ref **orig_list = list;
> +	int len = 0;
> +	int state = EXPECTING_FIRST_REF;
> +	struct packet_reader reader;
> +	const char *arg;
>  
> -	/*
> -	 * A hang-up after seeing some response from the other end
> -	 * means that it is unexpected, as we know the other end is
> -	 * willing to talk to us.  A hang-up before seeing any
> -	 * response does not necessarily mean an ACL problem, though.
> -	 */
> -	int responded = 0;
> -	int len;
> -	int state = EXPECTING_PROTOCOL_VERSION;
> +	packet_reader_init(&reader, in, src_buf, src_len);
> +
> +	discover_version(&reader);
>  
>  	*list = NULL;

And thanks to the "peeking" implementation, the version handling is
cleanly separated from the rest of the exchange, which is good.

> -	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +	while (state != EXPECTING_DONE) {
> +		switch (packet_reader_read(&reader)) {
> +		case PACKET_READ_ERROR:
> +			die_initial_contact(1);
> +		case PACKET_READ_NORMAL:
> +			len = reader.pktlen;
> +			if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
> +				die("remote error: %s", arg);
> +			break;
> +		case PACKET_READ_FLUSH:
> +			state = EXPECTING_DONE;
> +			break;
> +		case PACKET_READ_DELIM:
> +			die("invalid packet\n");
> +		}
> +

EXPECTING_DONE sounded like we are expecting to see 'done' packet
sent from the other side, but I was mistaken.  It is the state
where we are "done" expecting anything ;-).

Having an (unconditional) assignment to 'state' in the above switch
makes me feel somewhat uneasy, as the next "switch (state)" is what
is meant as the state machine that would allow us to say things like
"from this state, transition to that state is impossible".  When we
get a flush while we are expecting the first ref, for example, we'd
just go into the "done" state.  There is no provision for a future
update to say "no, getting a flush in this state is an error".

That is no different from the current code; when read_remote_ref()
notices that it got a flush, it just leaves the loop without even
touching 'state' variable.  But at least, I find that the current
code is more honest---it does not even touch 'state' and allows the
code after the loop to inspect it, if needed.  From that point of
vhew, the way the new code uses 'state' to leave the loop upon
seeing a flush is a regression---it makes it harder to notice and
report when we got a flush in a wrong state.

Perhaps getting rid of "EXPECTING_DONE" from the enum and then:

	int got_flush = 0;
	while (1) {
		switch (reader_read()) {
		case PACKET_READ_FLUSH:
			got_flush = 1;
			break;
		... other cases ...
		}

		if (got_flush)
			break;

		switch (state) {
		... current code ...
		}
	}

would be an improvement; we can later extend "if (got_flush)" part
to check what state we are in if we wanted to notice and report an
error there before breaking out of the loop.

