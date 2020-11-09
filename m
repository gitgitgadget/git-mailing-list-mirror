Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC47C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115AA206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgKIXMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:12:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:52118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgKIXMs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:12:48 -0500
Received: (qmail 4924 invoked by uid 109); 9 Nov 2020 23:12:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2020 23:12:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28694 invoked by uid 111); 9 Nov 2020 23:12:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 18:12:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 18:12:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
Message-ID: <20201109231246.GA677345@coredump.intra.peff.net>
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
 <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
 <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 12:59:24PM -0800, Junio C Hamano wrote:

> > @@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct command *commands,
> >  		packet_flush(proc.in);
> >  	}
> >  
> > +	close(proc.in);
> > +
> >  	/* Read result from proc-receive */
> >  	code = read_proc_receive_report(&reader, commands, &errmsg);
> >  
> >  cleanup:
> > -	close(proc.in);
> >  	close(proc.out);
> >  	if (use_sideband)
> >  		finish_async(&muxer);
> 
> OK, without us closing our end, the hook cannot even tell that it
> read to the end of our input.

That doesn't seem right. It should be expecting our flush packet,
shouldn't it? And if it sees an EOF before the flush packet, that would
be an error from the hook's perspective.

This part of the patch seems like a red herring to me.

> > @@ -52,8 +53,10 @@ static void proc_receive_verison(struct packet_reader *reader) {
> >  		}
> >  	}
> >  
> > -	if (server_version != 1 || die_version)
> > +	if (server_version != 1)
> >  		die("bad protocol version: %d", server_version);
> > +	if (die_version)
> > +		die("die with the --die-version option");
> 
> If any of these trigger, wouldn't we end up dying without consuming
> what receive-pack said?

Yeah, I think they would have the same race that the commit message
describes (proc-receive hook writes to stderr and dies, receive-pack
gets an error writing to now-closed hook pipe and never relays the
stderr).

But it seems like fixing this in the hook is the wrong place. The hook
has failed and has nothing else to say. Adding a pump-the-stdin-to-eof
loop to every die() is a lot of effort. Not to mention that the hook
could fail for reasons outside its usual flow control (e.g., segfault,
oom, etc, and receive-pack should be able to handle that gracefully,
even if the hook doesn't appear to behave.

I.e., I think the bug is in receive-pack's run_proc_receive_hook(). It
cleverly ignores SIGPIPE exactly to avoid dying during the write phase,
but then it proceeds to call packet_write_fmt(), etc, that will die on
any error (going to extra effort to emulate sigpipe, no less!). So we
die and take our sideband muxer with us.

So instead of this hunk:

> > @@ -79,9 +82,15 @@ static void proc_receive_read_commands(struct packet_reader *reader,
> >  		    *p++ != ' ' ||
> >  		    parse_oid_hex(p, &new_oid, &p) ||
> >  		    *p++ != ' ' ||
> > -		    die_readline)
> > +		    die_readline) {
> > +			char *bad_line = xstrdup(reader->line);
> > +			while (packet_reader_read(reader) != PACKET_READ_EOF)
> > +				; /* do nothing */
> > +			if (die_readline)
> > +				die("die with the --die-readline option");
> >  			die("protocol error: expected 'old new ref', got '%s'",
> > -			    reader->line);
> > +			    bad_line);
> > +		}
> 
> This part is different from the previous one in that it slurps all
> the input before dying evein in die_readline case.

I think the patch really ought to be in receive-pack, converting
packet_write_fmt() and packet_flush() into their "gently" forms.

And when we see a write error, close our pipe to the hook, set errmsg to
"hook failed to run" or similar, and then jump to the "cleanup" label,
where we'll wait on our sideband muxer to finish (which in turn will
wait pump any remaining data out of the hook's stderr).

Optionally we can pump the hook stdout to see if it gave us a better
message, but I think if write() failed, then all bets are off. The hook
broke protocol; a well-behaved hook that wanted to pass along a specific
per-ref message to the user would actually read all the input and then
report on each ref).

-Peff
