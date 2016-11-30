Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B7B1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbcK3XaN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:30:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59027 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751606AbcK3XaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:30:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 527E75396F;
        Wed, 30 Nov 2016 18:30:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5L+d1H6EXv87hDz9a/JTCn2qy5w=; b=UpISiz
        llluZnnXRKEj+t+tUDRmP5sq7P+Uexf4UW283yYorkFNHEvO0npg9ThyvLZg1D8j
        Slyr2EVrZmsUKwyfmyFbeK6tGmWtN2UnD/8P2DlORpNayyNowiTOzNblOE9ul7H/
        OQ0ame3Y+Hsa+j4nEIHqAZ0dMCklOku4Kqz8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jSpjJZ2lO5B0G2iqy1WC4j0/zj+JqlR0
        tcMX9iXAC0PJLM1khf6Ora392YRBYQ1zmtZQcTMvfS0Mx8vXpdCQZutPPrGy81KP
        QfWCXADGtEVSCj4Eo/ZHSwZiX482YBaynkyeliI2aH1jpujKBlXoIcHnrQ9TqyuS
        jT3RPAnBkFk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 492CB5396E;
        Wed, 30 Nov 2016 18:30:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 984665396C;
        Wed, 30 Nov 2016 18:30:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 01/16] Add initial external odb support
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
        <20161130210420.15982-2-chriscool@tuxfamily.org>
Date:   Wed, 30 Nov 2016 15:30:09 -0800
In-Reply-To: <20161130210420.15982-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 30 Nov 2016 22:04:05 +0100")
Message-ID: <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFA43722-B754-11E6-AC2D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

By the time the series loses RFC prefix, we'd need to see the above
three lines straightened out a bit more, e.g. a real message and a
more proper sign-off sequence.

> +static struct odb_helper *find_or_create_helper(const char *name, int len)
> +{
> +	struct odb_helper *o;
> +
> +	for (o = helpers; o; o = o->next)
> +		if (!strncmp(o->name, name, len) && !o->name[len])
> +			return o;
> +
> +	o = odb_helper_new(name, len);
> +	*helpers_tail = o;
> +	helpers_tail = &o->next;
> +
> +	return o;
> +}
> +
> +static int external_odb_config(const char *var, const char *value, void *data)
> +{
> +	struct odb_helper *o;
> +	const char *key, *dot;
> +
> +	if (!skip_prefix(var, "odb.", &key))
> +		return 0;
> +	dot = strrchr(key, '.');
> +	if (!dot)
> +		return 0;

Is this something Peff wrote long time ago?  I find it surprising
that he would write this without using parse_config_key().

> +struct odb_helper_cmd {
> +	struct argv_array argv;
> +	struct child_process child;
> +};
> +
> +static void prepare_helper_command(struct argv_array *argv, const char *cmd,
> +				   const char *fmt, va_list ap)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addstr(&buf, cmd);
> +	strbuf_addch(&buf, ' ');
> +	strbuf_vaddf(&buf, fmt, ap);
> +
> +	argv_array_push(argv, buf.buf);
> +	strbuf_release(&buf);

This concatenates the cmdname (like "get") and its parameters into a
single string (e.g. "get 454cb6bd52a4de614a3633e4f547af03d5c3b640")
and then places the resulting string as the sole element in argv[]
array, which I find somewhat unusual.  It at least deserves a
comment in front of the function that the callers are responsible to
ensure that the result of vaddf(fmt, ap) is properly shell-quoted.
Otherwise it is inviting quoting errors in the future (even if there
is no such errors in the current code and command set, i.e. a 40-hex
object name that "get" subcommand takes happens to require no
special shell-quoting consideration).

> +int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
> +			    int fd)
> +{
> +	struct odb_helper_object *obj;
> +	struct odb_helper_cmd cmd;
> +	unsigned long total_got;
> +	git_zstream stream;
> +	int zret = Z_STREAM_END;
> +	git_SHA_CTX hash;
> +	unsigned char real_sha1[20];
> +
> +	obj = odb_helper_lookup(o, sha1);
> +	if (!obj)
> +		return -1;
> +
> +	if (odb_helper_start(o, &cmd, "get %s", sha1_to_hex(sha1)) < 0)
> +		return -1;
> +
> +	memset(&stream, 0, sizeof(stream));
> +	git_inflate_init(&stream);
> +	git_SHA1_Init(&hash);
> +	total_got = 0;
> +
> +	for (;;) {
> +		unsigned char buf[4096];
> +		int r;
> +
> +		r = xread(cmd.child.out, buf, sizeof(buf));
> +		if (r < 0) {
> +			error("unable to read from odb helper '%s': %s",
> +			      o->name, strerror(errno));
> +			close(cmd.child.out);
> +			odb_helper_finish(o, &cmd);
> +			git_inflate_end(&stream);
> +			return -1;
> +		}
> +		if (r == 0)
> +			break;
> +
> +		write_or_die(fd, buf, r);
> +
> +		stream.next_in = buf;
> +		stream.avail_in = r;
> +		do {
> +			unsigned char inflated[4096];
> +			unsigned long got;
> +
> +			stream.next_out = inflated;
> +			stream.avail_out = sizeof(inflated);
> +			zret = git_inflate(&stream, Z_SYNC_FLUSH);
> +			got = sizeof(inflated) - stream.avail_out;
> +
> +			git_SHA1_Update(&hash, inflated, got);
> +			/* skip header when counting size */
> +			if (!total_got) {
> +				const unsigned char *p = memchr(inflated, '\0', got);

Does this assume that a single xread() that can result in a
short-read would not return in the middle of "header", and if so, is
that a safe assumption to make?

> +				if (p)
> +					got -= p - inflated + 1;
> +				else
> +					got = 0;
> +			}
> +			total_got += got;
> +		} while (stream.avail_in && zret == Z_OK);
> +	}
> +
> +	close(cmd.child.out);
> +	git_inflate_end(&stream);
> +	git_SHA1_Final(real_sha1, &hash);
> +	if (odb_helper_finish(o, &cmd))
> +		return -1;
> +	if (zret != Z_STREAM_END) {
> +		warning("bad zlib data from odb helper '%s' for %s",
> +			o->name, sha1_to_hex(sha1));
> +		return -1;
> +	}
> +	if (total_got != obj->size) {
> +		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
> +			o->name, sha1_to_hex(sha1), total_got, obj->size);
> +		return -1;
> +	}
> +	if (hashcmp(real_sha1, sha1)) {
> +		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
> +			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
> +		return -1;
> +	}
> +
> +	return 0;
> +}

OK.  So we call the external helper with "get" command, expecting
that the helper returns the data as a zlib deflated stream, and
validate that the data matches the expected hash and the expected
size, while also saving the contents of the deflated stream to fd.
Presumably the caller opened a fd to write into a loose object?  I
do not see this code actually validating that the loose object
header, i.e. "<type> <len>\0", matches what the caller wanted to see
in obj->size and obj->type.  Shouldn't there be a check for that,
too?

I am tempted to debate myself if it is a sensible design to require
"get" to return a loose object representation, but cannot decide
without seeing the remainder of the series.  An obvious alternative
is to define the "get" request to interface with us via the raw
contents (not even deflated) and leave the deflating to us, i.e. Git
sitting on the receiving end, which would allow us to choose to
store it differently (e.g. we may want to try streaming it into its
own pack using the streaming.h API, for example).

