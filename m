Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980AAC61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjCDBny (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 20:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDBnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 20:43:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959BC69211
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 17:43:52 -0800 (PST)
Received: (qmail 8823 invoked by uid 109); 4 Mar 2023 01:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Mar 2023 01:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 576 invoked by uid 111); 4 Mar 2023 01:43:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Mar 2023 20:43:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Mar 2023 20:43:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
Message-ID: <ZAKiV9nAet4wlEEu@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqa60tco76.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa60tco76.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2023 at 05:14:37PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > (I do still think we don't want to push it down into prefix_filename(),
> > because it gets used for paths and pathspecs given raw on the command
> > line. It does make me wonder if there are places where OPT_FILENAME() is
> > doing the wrong thing).
> 
> To be quite honest, I had the opposite reaction ;-)  At least for
> OPT_FILENAME() thing, I think it is well known that you should work
> around with "git cmd --opt ./-" if you do mean a file whose name
> happens to be a single dash.  Teaching prefix_filename() the same
> trick does not look _too_ bad.

For OPT_FILENAME() I agree you are generally thinking about "-" as
special anyway. But if it's the argument to an option, you do not
generally need to prefix it.

After a little grepping, here's a real world example where we wouldn't
want prefix_filename() to treat "-" specially:

  git archive --add-virtual-file=-:1234abcd

Using "stdin" there doesn't make sense. It's OK because it's not using
OPT_FILENAME(), but it is using prefix_filename().

But I'd worry much more about non-option arguments. There you _do_ need
to say "./-" if you are intermingled with options. But a "--" separator
splits that. So something like:

  git mv -- - to

should move the literal file "-", and it _should_ be prefixed with the
subdirectory if there is one. Having it mean stdin makes no sense there,
as we are not reading or writing the file, but rather operating on the
path.

Now this particular case isn't a problem, because it uses
internal_prefix_pathspec(), and not prefix_filename(). And maybe most
things are in that boat. Grepping around, most spots I see using
prefix_filename() could reasonably handle "-" as stdin/stdout, though
there are definitely some outliers.  E.g., "git format-patch -o" wants a
directory, and "git merge-file" probably doesn't want to handle stdin.

So I think we probably do want to stick with "-" as being not-special by
default for prefix_filename(), and individual sites would opt into it.

> There is a problem that commands that use prefix_filename() may not
> be prepared to read from the standard input or write to the standard
> output.  For some such callers it may be just the matter of
> replacing an unconditional open() with
> 
> 	-	fd = open(filename, O_RDONLY);
> 	+	if (!strcmp(filename, "-"))
> 	+		fd = 0;
> 	+	else
> 	+		fd = open(filename, O_RDONLY);
> 
> or something, but if some callers have fundamental reasons why they
> do not want to work with the standard input, it may make sense to
> treat "-" as a normal filename, and for them, blindly prefixing the
> leading directory name would be much better than special casing "-".

Right. I think we should stick with the status quo and change over
individual callers if people want that effect (but I do not really hear
anybody clamoring for it, so it seems very non-urgent).

-Peff
