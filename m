Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C526E1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 15:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbcI1PKQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 11:10:16 -0400
Received: from avasout03.plus.net ([84.93.230.244]:60634 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932486AbcI1PKP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 11:10:15 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id p3AB1t0020zhorE013ACkv; Wed, 28 Sep 2016 16:10:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=N659UExz7-8A:10 a=pGLkceISAAAA:8 a=cCri8_SAAAAA:8 a=NbMcLem9hdnjO6TtWB8A:9
 a=pILNOxqGKmIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=sbRuPzbSW-bVi6QwGVni:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] gpg-interface: use more status letters
To:     Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
 <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
Cc:     Alex <agrambot@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dc55746d-ccca-e5d5-be08-01082b5610d4@ramsayjones.plus.com>
Date:   Wed, 28 Sep 2016 16:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/09/16 15:24, Michael J Gruber wrote:
> According to gpg2's doc/DETAILS:
> "For each signature only one of the codes GOODSIG, BADSIG, EXPSIG,
> EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted."
> 
> gpg1 ("classic") behaves the same (although doc/DETAILS
> differs).
> 
> Currently, we parse gpg's status output for GOODSIG, BADSIG and trust
> information and translate that into status codes G, B, U, N for the %G?
> format specifier.
> 
> git-verify-* returns success in the GOODSIG case only. This is somewhat in
> disagreement with gpg, which considers the first 5 of the 6 above as VALIDSIG,
> but we err on the very safe side.
> 
> Introduce additional status codes E, X, R for ERRSIG, EXP*SIG, REVKEYSIG
> so that a user of %G? gets more information about the absence of a 'G'
> on first glance.
> 
> Requested-by: Alex <agrambot@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Changes in v2:
> 
> - Use GNUPGHOME="$HOME/gnupg-home-not-used" just like in other tests (lib).
> - Do not parse for signer UID in the ERRSIG case (and test that we do not).
> - Retreat "rather" addition from the doc: good/valid are terms that we use
>   differently from gpg anyways.
> 
>  Documentation/pretty-formats.txt |  9 +++++++--
>  gpg-interface.c                  | 13 ++++++++++---
>  pretty.c                         |  3 +++
>  t/t7510-signed-commit.sh         | 12 +++++++++++-
>  4 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index a942d57..c28ff2b 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -143,8 +143,13 @@ ifndef::git-rev-list[]
>  - '%N': commit notes
>  endif::git-rev-list[]
>  - '%GG': raw verification message from GPG for a signed commit
> -- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
> -  "U" for a good signature with unknown validity and "N" for no signature
> +- '%G?': show "G" for a good (valid) signature,
> +  "B" for a bad signature,
> +  "U" for a good signature with unknown validity,
> +  "X" for a good expired signature, or good signature made by an expired key,

Hmm, this looks odd. Would the following:

    "X" for a good signature made with an expired key,

mean something different?

ATB,
Ramsay Jones

