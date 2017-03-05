Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0C02013E
	for <e@80x24.org>; Sun,  5 Mar 2017 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdCEOTa (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 09:19:30 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:59814 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdCEOT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 09:19:28 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1ckWTq-0001Dt-JZ; Sun, 05 Mar 2017 13:45:46 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22716.5770.95842.704242@chiark.greenend.org.uk>
Date:   Sun, 5 Mar 2017 13:45:46 +0000
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
Subject: Re: Transition plan for git to move to a new hash function
In-Reply-To: <20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net>
References: <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
        <20170226001607.GH11350@io.lakedaemon.net>
        <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
        <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
        <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
        <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
        <22708.8913.864049.452252@chiark.greenend.org.uk>
        <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
        <22712.24775.714535.313432@chiark.greenend.org.uk>
        <20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson writes ("Re: Transition plan for git to move to a new hash function"):
> Instead, I was referring to areas like the notes code.  It has extensive
> use of the last byte as a type of lookup table key.  It's very dependent
> on having exactly one hash, since it will always want to use the last
> byte.

You mean note_tree_search ?  (My tree here may be a bit out of date.)
This doesn't seem difficult to fix.  The nontrivial changes would be
mostly confined to SUBTREE_SHA1_PREFIXCMP and GET_NIBBLE.

It's true that like most of git there's a lot of hardcoded `sha1'.


Are you arguing in favour of "replace git with git2 by simply
s/20/64/g; s/sha1/blake/g" ?  This seems to me to be a poor idea.
Takeup of the new `git2' would be very slow because of the pain
involved.

Any sensible method of moving to a new hash that isn't "make a
completely incompatible new version of git" is going to involve
teaching the code we have in git right now to handle new hashes as
well as sha1 hashes.

Even if the plan is to try to convert old data, rather than keep it
and be able to refer to it from new data, something will have to be
able to parse old packfiles, old commits, old tags, old notes,
etc. etc. etc.  Either that's going to be some separate conversion
utility, or it has to be the same code in git that's there already.[1]

The ability to handle both old-format and new-format data can be
achieved in the code by doing away with the hardcoded sha1s, so that
instead the hash is an abstract data type with operations like
"initialise", "compare", "get a nybble", etc.  We've already seen
patches going in this direction.

[1] I've heard suggestions here that instead we should expect users to
"git1 fast-export", which you would presumably feed into "git2
fast-import".  But what is `git1' here ?  Is it the current git
codebase frozen in time ?  I don't think it can be.  With this
conversion strategy, we will need to maintain git1 for decades.  It
will need portability fixes, security fixes, fixes for new hostile
compiler optimisations, and so on.  The difficulty of conversion means
there will be pressure to backport new features from `git2' to `git1'.
(Also this approach means that all signatures are definitively lost
during the conversion process.)

So if we want to provide both `git1' and `git2', it's still better to
compile `git' and `git2' from the same codebase.  But if we do that,
the resulting ifdeffery and/or other hash abstractions are most of the
work to be hash-agile.  It's just the difference between a
compile-time and runtime switch.

I think the incompatibile approach is much more work in the medium and
long term - and it leads to a longer transition period.


Bear in mind that our objective is not to minimise the time until the
new version of git is available.  Our objective is to minimise the
time until (most) people are using it.  An approach which takes longer
for the git community to develop, but which is easier to deploy, can
easily be better.

Or maybe the objective is to minimise overall effort.  In which case
more work on git, for an easier transition for all the users, seems
like a no-brainer.  I think this is arguably true even from the point
of view of effort amongst the community of git contributors.  git
contributors start out as git users - and if git's users are all busy
struggling with a difficult transition, they will have less time to
improve other stuff and will tend less to get involved upstream.  (And
they may be less inclined to feel that the git upstream developers
understand their needs well.)

The better alternative is to adopt a plan that has a clear and
straightforward transition for users, and ask git users to help with
implementation.

I think many git users, including sophisticated users and competent
organisations, are concerned about sha1.  Currently most of those
users will find it difficult to help, because it's not clear to them
what needs to be done.

Thanks,
Ian.
