Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94FC11F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 20:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdB0U5R (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 15:57:17 -0500
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:41419 "EHLO
        ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdB0U5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 15:57:00 -0500
X-Greylist: delayed 1153 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Feb 2017 15:56:34 EST
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from grey.csi.cam.ac.uk ([131.111.57.57]:60646)
        by ppsw-32.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
        with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)
        id 1ciQwg-000GJx-1i (Exim 4.88)
        (return-path <dot@dotat.at>); Mon, 27 Feb 2017 19:26:54 +0000
Date:   Mon, 27 Feb 2017 19:26:54 +0000
From:   Tony Finch <dot@dotat.at>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
Subject: Re: Transition plan for git to move to a new hash function
In-Reply-To: <22708.8913.864049.452252@chiark.greenend.org.uk>
Message-ID: <alpine.DEB.2.11.1702271846040.13590@grey.csi.cam.ac.uk>
References: <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>        <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>        <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>        <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
        <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>        <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>        <20170226001607.GH11350@io.lakedaemon.net>        <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>       
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>        <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>        <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
 <22708.8913.864049.452252@chiark.greenend.org.uk>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson <ijackson@chiark.greenend.org.uk> wrote:

A few questions and one or two suggestions...

> TEXTUAL SYNTAX
> ==============
>
> We also reserve the following syntax for private experiments:
>   E[A-Z]+[0-9a-z]+
> We declare that public releases of git will never accept such
> object names.

Instead of this I would suggest that experimental hash names should have
multi-character prefixes and an easy registration process - rationale:
https://tools.ietf.org/html/rfc6648

> A single object may refer to other objects the hash function which
> names the object itself, or by other hash functions, in any
> combination.

If I understand it correctly, this freedom is greatly restricted later on
in this document, depending on the object type in question. If so, it's
probably worth saying so at this point.

> Commits
> -------
>
> The hash function naming an origin commit is controlled by the hint
> left in .git for the ref named by HEAD (or for HEAD itself, if HEAD is
> detached) by git checkout --orphan or git init.

This confused me for a while - I think you mean "root commit"?

> TRANSITION PLAN
> ===============
>
> Y4: BLAKE by default for new projects.
>
>     When creating a new working tree, it starts using BLAKE.
>
>     Servers which have been updated will accept BLAKE.

Why not allow newhash pushes before making it the default for new
projects? Wouldn't it make sense to get the server side ready some time
before projects start actively using new hashes?

Or is the idea that newhash upgrade is driven from the server?

What's the upgrade process for send-email patch exchange?

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/  -  I xn--zr8h punycode
Fair Isle: Southwest 6 to gale 8, backing east 5 or 6, backing north 6 to gale
8 later. Rough or very rough. Rain or showers. Moderate or good.
