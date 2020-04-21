Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A0FC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAAA206A2
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 14:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDUOmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:42:20 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:47768 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDUOmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 10:42:20 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id A711360113;
        Tue, 21 Apr 2020 14:42:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 1i1Hbd3tgIbW; Tue, 21 Apr 2020 14:42:16 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Tue, 21 Apr 2020 14:42:16 +0000 (UTC)
Message-ID: <be69ed1bade98cb7e414c2713fe0d6b5cadd7172.camel@scientia.net>
Subject: Re: how to (integrity) verify a whole git repo
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Date:   Tue, 21 Apr 2020 16:42:16 +0200
In-Reply-To: <20200421065301.GH96152@google.com>
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
         <20200421065301.GH96152@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jonathan.

On Mon, 2020-04-20 at 23:53 -0700, Jonathan Nieder wrote:
> This happens automatically as part of fetch.  When you fetch, the
> objects' content is transfered over the wire but not their
> names.  The
> name of each object is a hash of its content.  Thus, whenever you
> address an object by its name, you are using its verified identity.

Okay maybe I wasn't clear enough :D (mixing up integrity and
authenticity).


I'd guess that what you describe here is, that effectively the chain of
all SHA1 hashes is computed when one does fetch, right?

But this alone doesn't guarantee cryptographic authenticity, e.g. as in
"that's the kernel sources as released by Linus".


> Tag and commit object content include the object ids for the objects
> they reference, so (assuming we are using a strong hash) their name
> is enough to verify all content reachable from them.
> 
> In other words, it's a Merkle tree.

And for (cryptographically) checking the authenticity of that tree,
wouldn't I need to verify the signatures on it's leaves?


Taking again the kernel as an example:
If I clone the repo (or fsck it later), than all I know is that there
was no corruption, if the all the tips are correct, since they start
the chain of hash sums to all other objects.

But an attacker could have just forged these tips.
So for checking authenticity, I need to verify some signatures on them

Now if I check e.g. Linus signature on tag v5.6; I should know that
everything earlier (in the tree, not chronologically) to that tag are
authentic.

But not e.g. any commits on top of v.5.6 (which aren't either signed
themselves or protected by another tag "above" them).
Neither any commits never reached from v.5.6, e.g. later stable patches
like anything from above v.5.5 (which is again below v.5.6) up to 
v.5.5.13, which is not.


So from my understanding, to use only commits that are authentic by the
kernel upstream developers, I'd need verify all these tips.. and throw
away everything which is not reachable by one of them.

Is that somehow possible?




Thanks,
Chris.

