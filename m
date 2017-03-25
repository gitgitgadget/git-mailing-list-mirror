Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8CC20966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdCYVbM (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:31:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:51713 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdCYVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:31:12 -0400
Received: (qmail 16422 invoked by uid 109); 25 Mar 2017 21:31:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 21:31:09 +0000
Received: (qmail 20794 invoked by uid 111); 25 Mar 2017 21:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Mar 2017 17:31:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Mar 2017 17:31:07 -0400
Date:   Sat, 25 Mar 2017 17:31:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH/RFC] parse-options: add facility to make options
 configurable
Message-ID: <20170325213107.u2l5eunqgqbxpcbb@sigill.intra.peff.net>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <20170324231013.23346-1-avarab@gmail.com>
 <CACBZZX6iz5QpfpOO6s9c-GY7+ZZ2uXBxqgKfSRhU+__P0VLC5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6iz5QpfpOO6s9c-GY7+ZZ2uXBxqgKfSRhU+__P0VLC5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 05:47:49PM +0100, Ævar Arnfjörð Bjarmason wrote:

> After looking at some of the internal APIs I'm thinking of replacing
> this pattern with a hashmap.c hashmap where the keys are a
> sprintf("%d:%s", short_name, long_name) to uniquely identify the
> option. There's no other obvious way to uniquely address an option. I
> guess I could just equivalently and more cheaply use the memory
> address of each option to identify them, but that seems a bit hacky.

Rather than bolt this onto the parse-options code, what if it were a
separate mechanism that mapped config keys to options. E.g., imagine
something like:

  struct {
	const char *config;
	const char *option;
	enum {
		CONFIG_CMDLINE_BOOL,
		CONFIG_CMDLINE_MAYBE_BOOL,
		CONFIG_CMDLINE_VALUE
	} type;
  } config_cmdline_map[] = {
	{ "foo.one", "one", CONFIG_CMDLINE_BOOL },
	{ "foo.two", "two", CONFIG_CMDLINE_VALUE },
  };

And then you "apply" that mapping by finding each item that's set in the
config, and then pretending that "--one" or "--two=<value>" was set on
the command-line, before anything the user has said. This works as long
as the options use the normal last-one-wins rules, the user can
countermand with "--no-one", etc.

You have to write one line for each config/option mapping, but I think
we would need some amount of per-option anyway (i.e., I think the
decision was that options would have to be manually approved for use in
the system). So rather than a flag in the options struct, it becomes a
line in this mapping.

And you get two extra pieces of flexibility:

  1. The config names can map to option names however makes sense; we're
     not constrained by some programmatic rule (I think we _would_
     follow some general guidelines, but there are probably special
     cases for historic config, etc).

  2. A command can choose to apply one or more mappings, or not. So
     porcelain like git-log would call:

       struct option options[] = {...};
       apply_config_cmdline_map(revision_config_mapping, options);
       apply_config_cmdline_map(diff_config_mapping, options);
       apply_config_cmdline_map(log_mapping, options);

     but plumbing like git-diff-tree wouldn't call any of those.

I had in mind that apply_config_cmdline_map() would just call
parse_options, but I think even that is too constricting. The revision
and diff options don't use parse_options at all. So really, it would
probably be more like:

  struct argv_array fake_args = ARGV_ARRAY_INIT;
  apply_config_cmdline_map(revision_config_mapping, &fake_args);
  apply_config_cmdline_map(diff_config_mapping, &fake_args);
  apply_config_cmdline_map(log_mapping, &fake_args);
  argv_array_pushv(&fake_args, argv); /* add the real ones */

At this point we've recreated internally the related suggestion:

  [options]
  log = --one --two=whatever

which is the same as:

  [log]
  one = true
  two = whatever

So hopefully it's clear that the two are functionally equivalent, and
differ only in syntax (in this case we manually decided which options
are safe to pull from the config, but we'd have to parse the options.log
string, too, and we could make the same decision there).

-Peff
