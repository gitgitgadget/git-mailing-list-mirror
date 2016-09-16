Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5FF207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 20:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965304AbcIPURR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 16:17:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964945AbcIPURQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 16:17:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84EF03EA13;
        Fri, 16 Sep 2016 16:17:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9n8c7X3mxZtxq9rhCi394Pfc95o=; b=YWFF9X
        Tnn7IZ/Uwv9xiQ9/d1jcz8379amtuS6Iig/6OcK8a+tEm+rcwAjWKRIdxItnpYC1
        V4y5TEENQmdm4MzhEcZOIHLwlPjRA0P6GVLHiWq4TNEgtv0klcXcS6PTHGYdBBdL
        uP3ovi5QueWLZoWqnbYkqC4O36RWB+yppdHZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eEfbJxli5oMNjaNL+/oxTHziXqm7Zf1b
        ouoQVQ2sGH1lnjJrWrvOccc6TUDS+166sHDk9XyiT1T/sVZeaFSym9mNjilm1jfb
        Ztkt1j7J4YgNhs8JL5IGg+PL2wGGa0UoT+zl/aS12tZD9oaJH99ZopRVlLJRzdMI
        +YHGGwpyYd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B24F3EA12;
        Fri, 16 Sep 2016 16:17:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9BD53EA11;
        Fri, 16 Sep 2016 16:17:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
Date:   Fri, 16 Sep 2016 13:17:11 -0700
In-Reply-To: <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 16 Sep 2016 10:37:24 -0700")
Message-ID: <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E63A118-7C4A-11E6-B783-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Instead of repeatedly calling "check_header" (as in this patch), one
> alternate method to accomplish this would be to have a buffer of
> potential header text in struct mailinfo to be flushed whenever a header
> is known to end (for example, if we detect the start of a new header),
> but this makes the logic more complicated - for example, the flushing
> would not only invoke check_header but would also need to reconstruct
> the original lines, possibly decode them into UTF-8, and store them in
> log_message, and any failures would be noticed a few "lines" away from
> the original failure point. Also, care would need to be taken to flush
> the buffer at all appropriate places.

I am not sure how much the UTF-8 decoding argument above matters.

The current way handle_commit_msg() is structured (before any of
your patches) is for it to take one raw line at a time and:

    - If we haven't seen a non-header line (i.e. at the beginning,
      or we were reading in-body headers), return without doing
      anything.

    - If we are told to honor in-body headers and if we haven't seen
      a non-header line, see if the line itself looks like a header
      and if so, handle it as an in-body header and return.  If that
      line is not an in-body header, continue processing.

    - If the processing reaches at this point, we are done with the
      headers (i.e. mi->header_stage is set to 0).

    - Make sure the line is in utf8.

    - If it is a scissors line and we are told to honor scissors
      lines, ignore what we have read so far and go back to "we
      haven't seen a non-header line" state and return.

    - If it is a patch break, return and signal the caller we are
      done with the log message.

    - Otherwise accumulate the line as part of the log message.

The bug we want to address is in the second step.  We only look at
the first line of folded in-body header line, because we are fed one
line at a time.

If we keep the location of UTF8 conversion, and buffered the in-body
header in "struct mailinfo *mi" (like you seem to do in this patch),
what we will queue there will be _before_ conversion.  We'd call
check_header() on it once we know one logical line of a header is
accumulated, and check_header() would do the right conversion via
decode_header() etc., so I do not see why you need to worry about
the encoding issues at all.

I wonder if the simplest would be to introduce another state in the
state machine that is "we know we are processing in-body header, and
we have read early part of an in-body header line that may not be
complete".

In other words, wouldn't something like the illustration at the end
of this message sufficient?  If the body consists solely of in-body
header without any patch or patchbreak, we may reach EOF with
something in mi->in_line_header buffer and nothing in
mi->log_message and without this function getting any chance to
return 1, so a careful caller may want to flush in_line_header, but
the overall result of the mailinfo subsystem in such a case would be
an error ("you didn't have any patch or a message?"), so it may not
matter too much.

What am I missing?

handle_commit_msg(...)
{
	if (mi->in_line_header->len) {
		/* we have read the beginning of one in-line header */
		if (line->len && isspace(*line->buf))
			append to mi->in_line_header strbuf;
                        return 0;
		/* otherwise we know mi->in_line_header is now complete */
		check_header(mi, mi->in_line_header, ...);
		strbuf_reset(&mi->in_line_header);
	}

	if (mi->header_stage && (it is a blank line))
		return 0;

	if (mi->use_inbody_headers && mi->header_stage &&
	    (the line looks like beginning of 2822 header)) {
		strbuf_addbuf(&mi->in_line_header, line);
		return 0;
	}
        /* otherwise we are no longer looking at headers */
        mi->header_stage = 0;

	/* normalize the log message to UTF-8. */
	if (convert_to_utf8(mi, line, mi->charset.buf))
		return 0; /* mi->input_error already set */

	if (mi->use_scissors && is_scissors_line(line)) {
		int i;

		strbuf_setlen(&mi->log_message, 0);
		mi->header_stage = 1;

		/*
		 * We may have already read "secondary headers"; purge
		 * them to give ourselves a clean restart.
		 */
		for (i = 0; header[i]; i++) {
			if (mi->s_hdr_data[i])
				strbuf_release(mi->s_hdr_data[i]);
			mi->s_hdr_data[i] = NULL;
		}
		return 0;
	}

	if (patchbreak(line)) {
		if (mi->message_id)
			strbuf_addf(&mi->log_message,
				    "Message-Id: %s\n", mi->message_id);
		return 1;
	}

	strbuf_addbuf(&mi->log_message, line);
	return 0;
}
 
