Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D04FC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 20:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJRUnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJRUnX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 16:43:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644F6705A
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 13:42:57 -0700 (PDT)
Received: (qmail 730 invoked by uid 109); 18 Oct 2022 20:42:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 20:42:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23247 invoked by uid 111); 18 Oct 2022 20:42:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 16:42:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 16:42:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
Message-ID: <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
 <xmqq4jw1wl6z.fsf@gitster.g>
 <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 03:28:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Hmph...  I somehow thought that the concensus is rather try the
> > complete opposite approach shown by René's patch to lose the use of
> > run_command_v_opt() by replacing it with run_command(&args), with
> > args.v populated using strvec_pushl() and other strvec API
> > functions.
> >
> > One of the reasons I would prefer to see us moving in that direction
> > was because the first iteration of this series was a good
> > demonstration of the relatively limited usefulness of _l_opt()
> > variant and also it seemed to be error prone to use it.
> 
> I'm getting somewhat mixed messages. Jeff seemed to like the end-to-end
> safety of run_command_l_opt() before I wrote it. I think the
> run_command_l_opt() still really shines for the simple cases.

Sorry if I gave that impression. I like the safety of strvec_pushl(),
but I think using it with a "struct child_process" is just fine. It's
more flexible, and as René's patch showed, doesn't really make the
callers more complex (that definitely _wasn't_ the case long ago, when
most of these callers were written).

I do think Junio saying "consensus" may have been premature. I expressed
my opinion and he agreed, but I think that is as far as it got. :)

> I don't see how *_l_opt() is particularly error prone, I just had a
> stupid think-o in v1 of this, but that if/else if bug is something that
> could have snuck in with run_command() given the same stupidity :)

I don't think it's error-prone. It just seems like it complicates an API
for little gain, and causes us to have a lot of boilerplate mapping
RUN_* flags into cmd.* fields.

> I wonder if a run_command() that just had the prototype (struct
> child_process *cmd, ...) might not be the best of both worlds (or a
> run_commandl() alternative). I.e. to do away with the whole custom way
> of specifying the flag(s), and just take the passed-in arguments and
> append them to "&cmd.args".

That would work, but is it buying much? You still have to declare the
child_process at that point, which means you have:

  struct child_process cmd = CHILD_PROCESS_INIT;
  cmd.git_cmd = 1;
  run_command(&cmd, "log", "--", "HEAD", NULL);

instead of:

  struct child_process cmd = CHILD_PROCESS_INIT;
  cmd.git_cmd = 1;
  strvec_pushl(&cmd.args, "log", "--", "HEAD", NULL);
  run_command(&cmd);

Saving one line doesn't seem worth complicating the API to me. Plus
existing users have to say "run_command(&cmd, NULL)", or we need to
ignore varargs when "cmd.args.nr > 0" (which papers over errors).

And most of the time run_command() is inside an if() anyway. Just
style-wise, keeping the long command name on its own line is a
readability improvement (IMHO, anyway).

> It's also interesting to consider adding a --noop option to be supported
> by parse-options.c. The reason we can't use a run_command_l_opt() in
> some cases is because we're doing e.g.:
> 
> 	if (progress)
> 		strvec_push(&args, "--progress");
> 
> We have a --no-progress, but in those cases the recipient at the end
> often cares about a default of -1 for a bool variable, or similar. So if
> we could do:
> 
> 	run_command_l_opt(0, command,
> 		(progress ? "--progress" : "--noop"),
> 		...,
> 		NULL
> 	);

I dunno. That does not seem more readable to me, and would end up with
GIT_TRACE lines like:

  git foo --noop --noop --real-option --noop

> We could benefit from compile-time checks, and wouldn't have to allocate
> a strvec just for building up the arguments in some cases. Just food for
> thought...

Keep in mind we allocate a strvec either way. And IMHO seeing:

  if (foo)
          strvec_push(&cmd.args, "foo");

is the most readable form. Not to mention that it is more flexible. Many
cases use "pushf" for the same thing.

-Peff
