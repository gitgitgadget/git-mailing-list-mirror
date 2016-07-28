Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DCD1F859
	for <e@80x24.org>; Thu, 28 Jul 2016 11:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbcG1LRU (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 07:17:20 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:48764 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbcG1LRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 07:17:18 -0400
Received: from [62.224.174.160] (helo=sandbox)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bSjJR-0006u3-6e; Thu, 28 Jul 2016 13:17:13 +0200
Date:	Thu, 28 Jul 2016 13:17:11 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] fix passing a name for config from submodules
Message-ID: <20160728111636.GA7760@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
 <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 10:22:07AM -0700, Stefan Beller wrote:
> On Tue, Jul 26, 2016 at 2:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
> Thanks for continuing on the submodule cache!

No worries. Its my code so I am happy to fix any bugs in it. Although it
was obviously perfect from the beginning ;)

> > In commit 959b5455 we implemented the initial version of the submodule
> 
> Usually we refer to the commit by a triple of "abbrev. sha1 (date, subject).
> See d201a1ecd (2015-05-21, test_bitmap_walk: free bitmap with bitmap_free)
> for an example. Or ce41720ca (2015-04-02, blame, log: format usage strings
> similarly to those in documentation).
> 
> Apparently we put the subject first and then the date. I always did it
> the other way
> round, to there is no strict coding guide line, though it helps a lot to have an
> understanding for a) how long are we in the "broken" state already as well as
> b) what was the rationale for introducing it.

Ah ok did not know about this format. Will change that. I also will
follow-up with a patch to document this in SubmittingPatches so we can
point others to that...

> > @@ -397,8 +397,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
> >                 return entry->config;
> >         }
> >
> > -       if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
> > +       if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
> > +               strbuf_release(&rev);
> >                 return NULL;
> 
> This is a reoccuring pattern below. Maybe it might make sense to
> just do a s/return.../ goto out/ and at that label we cleanup `rev` and `config`
> and return a result value?
> There are currently 6 early returns (not counting the 3 from the last switch),
> 4 of them return NULL, so that would result in just a "goto out", whereas 2
> return an actual value, they would need to assign the result value first before
> jumping out of the logic. I dunno, just food for though.

I also though about that but was not sure whether it would actually make
things simple. Will look into that as the second patch.

> > @@ -425,8 +432,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
> >         parameter.commit_sha1 = commit_sha1;
> >         parameter.gitmodules_sha1 = sha1;
> >         parameter.overwrite = 0;
> > -       git_config_from_mem(parse_config, "submodule-blob", "",
> > +       git_config_from_mem(parse_config, "submodule-blob", rev.buf,
> >                         config, config_size, &parameter);
> 
> Ok, this is the actual fix. Do you want to demonstrate its impact by adding
> one or two tests that failed before and now work?
> (As I was using the submodule config API most of the time with null_sha1
> to indicate we'd be looking at the current .gitmodules file in the worktree,
> the actual bug may have not manifested in the users of this API.
> But still, it would be nice to see what was broken?)

This popped up because of Rene's cleanup patch and I wanted to provide
a patch of what was originally supposed to go in there.

The name (originally representing the filename of the parsed config) is
put into the structure that represents the source. I had a quick look
and it seems to mostly be used in error messages. E.g.:

   * in error message git_parse_source() to reference the file
   * error message in git_die_config_linenr() (filename is derived from
     name)

There is some more, but I will add a test which checks whether the error
message actually contains a reference to the blob instead of nothing.

E.g. looks like this:

	error: bad config line 7 in submodule-blob 39a7458d2b5b3e3d1938b01ff2645b14c94ac284:.gitmodules

instead of this

	error: bad config line 7 in submodule-blob

That might be quite helpful to find out where the error is when you have
one in the history. So we are fixing a real bug here (not just a
theoretical one).

Cheers Heiko
