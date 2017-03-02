Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1E31F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdCBUib (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 15:38:31 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:54069 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdCBUi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 15:38:28 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1cjVEG-00034h-6u; Thu, 02 Mar 2017 18:13:28 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22712.24775.714535.313432@chiark.greenend.org.uk>
Date:   Thu, 2 Mar 2017 18:13:27 +0000
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
In-Reply-To: <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
References: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
        <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
        <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
        <20170226001607.GH11350@io.lakedaemon.net>
        <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
        <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
        <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
        <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
        <22708.8913.864049.452252@chiark.greenend.org.uk>
        <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson writes ("Re: Transition plan for git to move to a new hash function"):
> On Mon, Feb 27, 2017 at 01:00:01PM +0000, Ian Jackson wrote:
> > Objects of one hash may refer to objects named by a different hash
> > function to their own.  Preference rules arrange that normally, new
> > hash objects refer to other new hash objects.
> 
> The existing codebase isn't really intended with that in mind.

Yes.  I've seen the attempts to start to replace char* with a hash
struct.

> I like Peff's suggested approach in which we essentially rewrite history
> under the hood, but have a lookup table which looks up the old hash
> based on the new hash.  That allows us to refer to old objects, but not
> have to share serialized data that mentions both hashes.

I think this means that the when a project converts, every copy of the
history must be rewritten (separately).  Also, this leaves the whole
system lacking in algorithm agililty.  Meaning we may have to do all
of this again some time.

I also think that we need to distinguish old hashes from new hashes in
the command line interface etc.  Otherwise there is a possible
ambiguity.

> > The object name textual syntax is extended.  The new syntax may be
> > used in all textual git objects and protocols (commits, tags, command
> > lines, etc.).
> > 
> > We declare that the object name syntax is henceforth
> >   [A-Z]+[0-9a-z]+ | [0-9a-f]+
> > and that names [A-Z].* are deprecated as ref name components.
> 
> I'd simply say that we have data always be in the new format if it's
> available, and tag the old SHA-1 versions instead.  Otherwise, as Peff
> pointed out, we're going to be stuck typing a bunch of identical stuff
> every time.  Again, this encourages migration.

The hash identifier is only one character.  Object names are not
normally typed very much anyway.

If you say we must decorate old hashes, then all existing data
everywhere in the world which refers to any git objects by object name
will become invalid.  I don't mean just data in git here.  I mean CI
systems, mailing list archives, commit messages (perhaps in other
version control systems), test cases, and so on.

Ian.
