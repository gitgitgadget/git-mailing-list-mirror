Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047EEC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiHAVSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHAVSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:18:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF50BA8
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:18:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42D5D1A4D6E;
        Mon,  1 Aug 2022 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fit+M8XeoBuFlls7ywxW5u81ubEYUy/QCbJfqv
        qDofk=; b=B3Io1gqBuTWcQjriXrlDUrs3RGQJF+j2kU3IVLy5jEDIWIU0bCSrBF
        19uYvLhQYHcpBTMusSezdn+t0C/tXZrWMQzFKVXfQZ6UC6Z+zJWpFRX2OVhP5TyT
        KKIRuHOr4UEcjZQXQr6MurGxYDWrG5zx40b+regaZmw4jjbS9+PbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B9531A4D6C;
        Mon,  1 Aug 2022 17:18:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC3F71A4D6B;
        Mon,  1 Aug 2022 17:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
References: <cover.1659291025.git.matheus.bernardino@usp.br>
        <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
Date:   Mon, 01 Aug 2022 14:18:45 -0700
In-Reply-To: <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sun, 31 Jul 2022 15:19:49 -0300")
Message-ID: <xmqqr11zoe6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87A07B22-11DF-11ED-978D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +static char *get_value(char *buf, size_t size, const char *key)
> +{
> +	const char *orig_buf = buf;
> +	int orig_size = (int)size;
> +
> +	if (!skip_prefix_mem((const char *)buf, size, key, (const char **)&buf, &size) ||
> +	    !skip_prefix_mem((const char *)buf, size, "=", (const char **)&buf, &size) ||
> +	    !size)

So, skip_prefix_mem(), when successfully parses the prefix out,
advances buf[] to skip the prefix and shortens size by the same
amount, so buf[size] is pointing at the same byte.  The code wants
to make sure buf[] begins with the "<key>=", skip that part, so
presumably buf[] after the above part moves to the beginning of
<value> in the "<key>=<value>" string?  It also wants to reject
"<key>=", i.e. an empty string as the <value>?

> +		die("expected key '%s', got '%.*s'",
> +		    key, orig_size, orig_buf);
> +
> +	buf[size] = '\0';

I find this assignment somewhat strange, but primarily because it
uses the updated buf[size] that ought to be pointing at the same
byte as the original buf[size].  Is this necessary because buf[size]
upon the entry to this function does not necessarily have NUL there?

Reading ahead,

 * packet_key_val_read() feeds the buffer taken from
   packet_read_line_gently(), so buf[size] should be NUL terminated
   already.

 * read_capabilities() feeds the buffer taken from
   packet_read_line(), so buf[size] should be NUL terminated
   already.

> +	return buf;
> +}

And the caller gets the byte position that begins the <value> part.

> +static char *packet_key_val_read(const char *key)
> +{
> +	int size;
> +	char *buf;
> +	if (packet_read_line_gently(0, &size, &buf) < 0)
> +		return NULL;
> +	return xstrdup(get_value(buf, size, key));
> +}

The returned value from get_value() is pointing into
pkt-line.c::packet_buffer[], so we return a copy to the caller,
which takes the ownership.  OK.

> +static inline void assert_remote_capability(struct strset *caps, const char *cap)
> +{
> +	if (!strset_contains(caps, cap))
> +		die("required '%s' capability not available from remote", cap);
> +}
> +
> +static void read_capabilities(struct strset *remote_caps)
> +{
> +	for (;;) {
> +		int size;
> +		char *buf = packet_read_line(0, &size);
> +		if (!buf)
> +			break;
> +		strset_add(remote_caps, get_value(buf, size, "capability"));
> +	}

strset_add() creates a copy of what get_value() borrowed from
pkt-line.c::packet_buffer[] here, which is good.

> +	assert_remote_capability(remote_caps, "clean");
> +	assert_remote_capability(remote_caps, "smudge");
> +	assert_remote_capability(remote_caps, "delay");
> +}

> +static void command_loop(void)
> +{
> +	for (;;) {
> +		char *buf, *output;
> +		int size;
> +		char *pathname;
> +		struct delay_entry *entry;
> +		struct strbuf input = STRBUF_INIT;
> +		char *command = packet_key_val_read("command");
> +
> +		if (!command) {
> +			fprintf(logfile, "STOP\n");
> +			break;
> +		}
> +		fprintf(logfile, "IN: %s", command);
> +
> +		if (!strcmp(command, "list_available_blobs")) {
> +			reply_list_available_blobs_cmd();
> +			free(command);
> +			continue;
> +		}

OK.

> +		pathname = packet_key_val_read("pathname");
> +		if (!pathname)
> +			die("unexpected EOF while expecting pathname");
> +		fprintf(logfile, " %s", pathname);
> +
> +		/* Read until flush */
> +		while ((buf = packet_read_line(0, &size))) {
> +			if (!strcmp(buf, "can-delay=1")) {
> +				entry = strmap_get(&delay, pathname);
> +				if (entry && !entry->requested) {
> +					entry->requested = 1;
> +				} else if (!entry && always_delay) {
> +					add_delay_entry(pathname, 1, 1);
> +				}

These are unnecessary {} around single statement blocks, but let's
let it pass in a test helper.

> +			} else if (starts_with(buf, "ref=") ||
> +				   starts_with(buf, "treeish=") ||
> +				   starts_with(buf, "blob=")) {
> +				fprintf(logfile, " %s", buf);
> +			} else {
> +				/*
> +				 * In general, filters need to be graceful about
> +				 * new metadata, since it's documented that we
> +				 * can pass any key-value pairs, but for tests,
> +				 * let's be a little stricter.
> +				 */
> +				die("Unknown message '%s'", buf);
> +			}
> +		}
> +
> +
> +		read_packetized_to_strbuf(0, &input, 0);

I do not see a need for double blank lines above.

> +		fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);
> +
> +		entry = strmap_get(&delay, pathname);
> +		if (entry && entry->output) {
> +			output = entry->output;
> +		} else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.r")) {
> +			output = "";
> +		} else if (!strcmp(command, "clean") && has_clean_cap) {
> +			output = rot13(input.buf);
> +		} else if (!strcmp(command, "smudge") && has_smudge_cap) {
> +			output = rot13(input.buf);
> +		} else {
> +			die("bad command '%s'", command);
> +		}

Good.  At this point, output all points into something and itself
does not own the memory it is pointing at.

> +		if (!strcmp(pathname, "error.r")) {
> +			fprintf(logfile, "[ERROR]\n");
> +			packet_write_fmt(1, "status=error");
> +			packet_flush(1);
> +		} else if (!strcmp(pathname, "abort.r")) {
> +			fprintf(logfile, "[ABORT]\n");
> +			packet_write_fmt(1, "status=abort");
> +			packet_flush(1);
> +		} else if (!strcmp(command, "smudge") &&
> +			   (entry = strmap_get(&delay, pathname)) &&
> +			   entry->requested == 1) {
> +			fprintf(logfile, "[DELAYED]\n");
> +			packet_write_fmt(1, "status=delayed");
> +			packet_flush(1);
> +			entry->requested = 2;
> +			if (entry->output != output) {
> +				free(entry->output);
> +				entry->output = xstrdup(output);
> +			}
> +		} else {
> +			int i, nr_packets = 0;
> +			size_t output_len;
> +			const char *p;
> +			packet_write_fmt(1, "status=success");
> +			packet_flush(1);
> +
> +			if (skip_prefix(pathname, command, &p) &&
> +			    !strcmp(p, "-write-fail.r")) {
> +				fprintf(logfile, "[WRITE FAIL]\n");
> +				die("%s write error", command);
> +			}
> +
> +			output_len = strlen(output);
> +			fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
> +
> +			if (write_packetized_from_buf_no_flush_count(output,
> +				output_len, 1, &nr_packets))
> +				die("failed to write buffer to stdout");
> +			packet_flush(1);
> +
> +			for (i = 0; i < nr_packets; i++)
> +				fprintf(logfile, ".");
> +			fprintf(logfile, " [OK]\n");
> +
> +			packet_flush(1);
> +		}
> +		free(pathname);
> +		strbuf_release(&input);
> +		free(command);
> +	}
> +}

OK, at this point we are done with pathname and command so we can
free them for the next round.  input was used as a scratch buffer
and we are done with it, too.

Looking good.

Thanks.
