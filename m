Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73483208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 20:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbeHFWfW (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 18:35:22 -0400
Received: from mx.sdf.org ([205.166.94.20]:51343 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731300AbeHFWfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 18:35:22 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w76KOQAX025356
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Mon, 6 Aug 2018 20:24:26 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w76KOPN1012361;
        Mon, 6 Aug 2018 20:24:25 GMT
Date:   Mon, 6 Aug 2018 20:24:25 +0000
From:   Tacitus Aedifex <aedifex@SDF.ORG>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, henning.schild@siemens.com,
        mastahyeti@gmail.com
Subject: Re: abstracting commit signing/verify to support other signing
 schemes
Message-ID: <20180806202424.GA2315@SDF.ORG>
References: <20180803213834.GB7619@SDF.ORG>
 <20180803220746.GA5404@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180803220746.GA5404@sigill.intra.peff.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 06:07:46PM -0400, Jeff King wrote:
>There's been some work on this lately. See this patch and the response
>thread:
>
>  https://public-inbox.org/git/20180409204129.43537-9-mastahyeti@gmail.com/
>
>The more recent work focused on just doing the minimum to provide
>gpg/gpgsm variants:
>
>  https://public-inbox.org/git/cover.1531831244.git.henning.schild@siemens.com/
>
>That replaces the earlier patch series, and is currently merged to the
>'next' branch and is on track to get merged to 'master' before Git 2.19
>is released.

thank you for setting the context. it looks like both patch sets are going in 
the same direction that i suggested, at least with the config variables.  
personally, i prefer the 'signingtool.<tool>' approach in the older patch set 
over the 'gpg.<tool>' approach in the newer patch set since my goal is to get 
away from assuming gpg.

the older patch set suggested the idea of using PEM strings to match up the 
signature payload with a certain signing tool.  i can't tell if they mean the 
'pre-ecapsulation boundary' (e.g. '-----BEGIN FOO-----') or if they mean the 
encapsulated headers; both as defined in RFC 1421 [0].

the newer patch set looks specifically at the pre-encapsulation boundary to 
switch behaviors. that works assuming that the signing tools all understand 
PEM. in the case of signify, it doesn't, so the driver code in git will have to 
translate to/from PEM.

i suggest that we switch to a standard format for all signatures that is 
similar to the commit message format with colon ':' separated fields followed 
by a payload.  the colon separated fields would specify the signing tool used 
to generate the signature and the tool specific data followed by the signature 
blob like so:

  signing-tool: gpg
  gpg-keyid: 0123456789ABCDEF
  
  -----BEGIN PGP SIGNATURE-----
  <base64 encoded signature>
  -----END PGP SIGNATURE-----

by adopting this format, git will be fully abstracted from the underlying 
signing tool and the user can specify multiple signing tools in their config 
and git will be able to map the signature to the tool when verifying (e.g. git 
log --show-signature).

a signify signature would look something like this:

  signing-tool: signify
  signify-public-key: <base64 encoded public key>
  
  <base64 encoded signature>

i hope we adopt a more generic approach like this.

>One of the downsides there is that if we eventually move to a generic
>signing-tool config, we'd have to support two layers of historical
>abstraction (the original "gpg.program" config, and the new
>"gpg.<tool>.*" config).

i like the idea of aliasing all of the old config variables to their equivilent 
and outputting a deprecation warning when we get plan on removing the aliases 
altogether in the future.

>So _if_ we knew what it would take to support signify, we could
>potentially adjust what's going into 2.19 in order to skip straight to
>the more generic interface. But on the OTOH, it may not be worth
>rushing, and there is already a vague plan of how the gpg.<tool>.*
>config would interact with a more generic config.

there's no rush, but i would prefer that the newer patch set get changed to use 
the more generic 'signingtool.<tool>.*' instead of 'gpg.<tool>.*'. if you all 
agree, i'll follow up with a patch to change that part of what is going into 
2.19.

then round two will be to experiment with a new, standard signature format that 
doesn't assume anything about the underlying signing tool.

//tæ

[0] https://tools.ietf.org/html/rfc1421
