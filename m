Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3F81FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 08:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdFJIGd (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 04:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:37519 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbdFJIG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 04:06:29 -0400
Received: (qmail 2177 invoked by uid 109); 10 Jun 2017 08:06:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 08:06:28 +0000
Received: (qmail 29496 invoked by uid 111); 10 Jun 2017 08:06:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 04:06:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 04:06:27 -0400
Date:   Sat, 10 Jun 2017 04:06:27 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "There are too many unreachable loose objects" - why don't we
 run 'git prune' automatically?
Message-ID: <20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net>
References: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com>
 <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net>
 <7497DFA7-3F4E-4DB2-B31B-FDDEB2F30BB8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7497DFA7-3F4E-4DB2-B31B-FDDEB2F30BB8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 02:03:18PM +0200, Lars Schneider wrote:

> > I agree the existing message isn't great. There should probably be a big
> > advise() block explaining what's going on (and that expert users can
> > disable).
> 
> How about this?
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index c2c61a57bb..12ee212544 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -473,9 +473,18 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (pack_garbage.nr > 0)
>  		clean_pack_garbage();
>  
> -	if (auto_gc && too_many_loose_objects())
> -		warning(_("There are too many unreachable loose objects; "
> -			"run 'git prune' to remove them."));
> +	if (auto_gc && too_many_loose_objects()) {
> +		warning(_("Auto packing did not lead to optimal results as the "
> +			"repository contains too many unreachable objects."));
> +		advice(_("Unreachable objects are Git objects (commits, files, ...) "
> +			"that are not referenced by any branch or tag. This might happen "
> +			"if you use 'git rebase' or if you delete branches. Auto packing "
> +			"only prunes unreachable objects that are older than 2 weeks "
> +			"(default, overridable by the config variable 'gc.pruneExpire'). "
> +			"Please run 'git prune' to prune all unreachable objects for "
> +			"optimal repository performance."));
> +	}

s/advice/advise/, of course. This probably be protected by a new entry
in advice_config[] in advice.c.

But I assume you are most interested in the text. I think it
simultaneously goes into too much and too little detail. I think the
warning itself should just say _what_ we observed: after garbage
collection, there were still enough objects to trigger a gc.  And then
the hint doesn't need to go into the details of why we prune or what
unreachable objects are. Those can be cross-referenced with other
documentation. I think we need to focus on what the warning means, and
whether and how they would correct it.

Maybe:

  warning: too many loose objects remain after garbage collection
  hint: Automatic garbage collection is triggered when there are a
  hint: large number of unpacked objects in the repository. Unreachable
  hint: objects that are more recent than gc.pruneExpire are not
  hint: pruned. If there are too many of these recent loose
  hint: objects, automatic garbage collection may be triggered more
  hint: frequently than necessary. You may run "git prune" now to
  hint: prune all unreachable objects, regardless of their age.

I was tempted to suggest that we find and report the correct "prune"
cutoff that would let us avoid auto-gc. I.e., sort the unreachable
objects by timestamp and find the cutoff that will drop enough to leave
fewer than `gc.auto`. That in theory makes things a bit safer. That's
probably not a good idea, though:

  1. Telling the user to run `git prune --expire=37.minutes.ago` is
     just going to confuse them. We could hide it behind a command line
     option like `git prune --expire-auto-gc` or something, though.

  2. Now that we try to keep recent chunks, the analysis isn't quite so
     easy. You may have a single recent commit that references a ton of
     old history, and only dropping that commit would help. So the
     analysis is harder than a simple sort-and-cutoff, but it also means
     that the prune times are likely to skew close to "now".

  3. If we just show them how to prune the minimal amount, then they're
     likely to just hit this message again soon.

So that's probably a dead end.

To be honest, the fact that we have to write this warning at all is a
sign that Git is not doing a very good job. The best place to spend
effort would be to teach git-gc to pack all of the unreachable objects
into a single "cruft" pack, so this problem doesn't happen at all (and
it's way more efficient, as well).

The big problem with that approach is that we lose individual-object
timestamps. Each object just gets the timestamp of its surrounding pack,
so as we continually ran auto-gc, the cruft-pack timestamp would get
updated and we'd never drop objects. So we'd need some auxiliary file
(e.g., pack-1234abcd.times) that stores the per-object timestamps. This
can be as small as a 32- or 64-bit int per object, since we can just
index it by the existing object list in the pack .idx.

The trickiest part would be when an object's timestamp gets freshened
(because somebody tried to write it again but we optimized out the
write). Updating the timestamps in the .times file would probably work
atomically, though we usually avoid writing in the middle of a file (we
certainly can't portably do so via mmap, and I can't think of another
case where we do seeked writes). It might be sufficient for objects in
the cruft pack to just do the actual loose object write instead of
optimizing it out. It should happen very rarely.

-Peff
