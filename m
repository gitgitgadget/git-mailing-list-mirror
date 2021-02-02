Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE2C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA75164ECA
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBBJoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:44:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBBJmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:42:36 -0500
Received: (qmail 12631 invoked by uid 109); 2 Feb 2021 09:41:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:41:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 459 invoked by uid 111); 2 Feb 2021 09:41:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:41:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:41:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 02/14] pkt-line: promote static buffer in
 packet_write_gently() to callers
Message-ID: <YBkeYSA5UfQP1m/x@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <3b03a8ff7a72c101f82a685cc6f34a5dd37a9c4b.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b03a8ff7a72c101f82a685cc6f34a5dd37a9c4b.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:35PM +0000, Jeff Hostetler via GitGitGadget wrote:

> -static int packet_write_gently(const int fd_out, const char *buf, size_t size)
> +/*
> + * Use the provided scratch space to build a combined <hdr><buf> buffer
> + * and write it to the file descriptor (in one write if possible).
> + */
> +static int packet_write_gently(const int fd_out, const char *buf, size_t size,
> +			       struct packet_scratch_space *scratch)

Thanks for addressing my stack space concern.

This solution does work (and I like wrapping it in a struct like this),
though I have to wonder if we're not just punting on the thread issues
in an ever-so-slight way with things like this:

>  void packet_write(int fd_out, const char *buf, size_t size)
>  {
> -	if (packet_write_gently(fd_out, buf, size))
> +	static struct packet_scratch_space scratch;
> +
> +	if (packet_write_gently(fd_out, buf, size, &scratch))
>  		die_errno(_("packet write failed"));
>  }

Where we just moved it one step up the call stack.

>  int write_packetized_from_fd(int fd_in, int fd_out)
>  {
> +	/*
> +	 * TODO We could save a memcpy() if we essentially inline
> +	 * TODO packet_write_gently() here and change the xread()
> +	 * TODO to pass &buf[4].
> +	 */

And comments like this make me wonder if the current crop of pktline
functions are just mis-designed in the first place. There are two
obvious directions here.

One, we can observe that the only reason we need the scratch space is to
ship out the whole thing in a single write():

> [in packet_write_gently]
> -	set_packet_header(packet_write_buffer, packet_size);
> -	memcpy(packet_write_buffer + 4, buf, size);
> -	if (write_in_full(fd_out, packet_write_buffer, packet_size) < 0)
> +
> +	set_packet_header(scratch->buffer, packet_size);
> +	memcpy(scratch->buffer + 4, buf, size);
> +
> +	if (write_in_full(fd_out, scratch->buffer, packet_size) < 0)
>  		return error(_("packet write failed"));

Would it really be so bad to do:

  char header[4];
  set_packet_header(header, packet_size);
  if (write_in_full(fd_out, header, 4) < 0 ||
      write_in_full(fd_out, buf, size) < 0)
          return error(...);

I doubt that two syscalls is breaking the bank here, but if people are
really concerned, using writev() would be a much better solution.
Obviously we can't rely on it being available everywhere, but it's quite
easy to emulate with a wrapper (and I'd be happy punt on any writev
stuff until somebody actually measures a difference).

The other direction is that callers could be using a correctly-sized
buffer in the first place. I.e., something like:

  struct packet_buffer {
          char full_packet[LARGE_PACKET_MAX];
  };
  static inline char *packet_data(struct packet_buffer *pb)
  {
	return pb->full_packet + 4;
  }

That lets people work with the oversized buffer in a natural-ish way
that would be hard to get wrong, like:

  memcpy(packet_data(pb), some_other_buf, len);

(though if we wanted to go even further, we could provide accessors that
actually do the writing and sanity-check the lengths; the downside is
that I'm not sure how callers typically get the bytes into these bufs in
the first place).

That's a much bigger change, of course, and I'd guess you'd much prefer
to focus on the actual point of your series. ;)

-Peff
