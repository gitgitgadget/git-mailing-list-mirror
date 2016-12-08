Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE071FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbcLHOrr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:47:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:57476 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932090AbcLHOrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:47:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEMs-1c04R23Pnm-00OpSW; Thu, 08
 Dec 2016 15:47:34 +0100
Date:   Thu, 8 Dec 2016 15:47:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Turner <novalis@novalis.org>
cc:     git@vger.kernel.org
Subject: [REGRESSION 2.10.2] problematic "empty auth" changes
Message-ID: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:snYawwUxMCeHeaiQDHceTWJ62h9Ato3EXQVw9mJxkV9xgyRWFsP
 7oAVIxcSo2SW8mQptRtmd18CPoYgXrwtCcQGRJ60b8rXN74wp3HdIeAPSZYFxAcDGnH5HJw
 7xUoHzj5cgGbIZPQuQDpSQu0SLhFm1WstY1KtD+3XojXP/SSUAnOm3F7qnRtk39tzwAGHRh
 fGdcF570Nmwa6H/3b4swQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/4nm/IlxPZg=:b0LfB3oy9Df+B6+LvXpxib
 JYd7iKPw87gBgU+468A++6KQMyiZwCreTCmwqnoYNXMXL7Jzl9sDDvXF3Wv03ccuR1kaseQV8
 L9SNZSDaXfUwoWytlZHlyK1etGShozpsxMXsNQJay1Mkdc9Y+1PxJNOKF4SeCJB0ZKCayyvHX
 rQyA+IXzbi8NtAcv1a35+Ch7Vm+3n6vOcwvX89UkXWN4uxHV2nE0OfoFE1Ps3bdcBiOaQcjp7
 nquholRzFzve+6KhSQmydRkWkg20XifgU2C6v2pez0y23zZVCTQUEwGeSHE7A0eRZttTHx9IS
 A6NipI2YRtmYpDcE+QBtX3hKLo1RiWx7sCGvqeFR8MBURHlV27A3oyUX58xg2DOIiHTRd7FUo
 cF8ucLbZojBmbLx6vcW4EPCmBntPv9NUqjWKsOtwbU05P/NotDu5pTBtdyF1Wz4O1Nh1pSBMg
 eImgddFgLI7DlrsxG8Rt+8W2yWRmkeM06Q8/ZRB6JndpZp8skVKktIo/vic6xoYpwGWIG8Z9Y
 TiDhe8pTp15TYqcrXn1dZaLwAACYjBGBL3MVOAPswzkCF1pMnqxzvdumlRkBnLCfaQfce4+3m
 IPMNR1OUSmhlBK5+ZG3bnVScHt9KwWUfkfTf+F++AIRvOwUOm7BR0CIhpR92WKihH+AI1vV+f
 cKWcSzzGxaGqICAbUgrsMK+aAaGX/acrTWovjNRh7rIF1k0WdkBqxUNWBWkBiNa0QYpBFKwFC
 FBRkx54oyIjAdyGXDsalJgciQ1JJAGVyIt+ogpdQr1/w+mTLBom1eegB//9xarVR1F2CbC9ol
 aKPvjTO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dave,

I got a couple of bug reports that claim that 2.10.2 regressed on using
network credentials. That is, users regularly hit Enter twice when being
asked for user name and password while fetching via https://, and cURL
automatically used to fall back to using the login credentials (i.e.
authenticating via the Domain controller).

Turns out those claims are correct: hitting Enter twice (or using URLs
with empty user name/password such as https://:tfs:8080/) work in 2.10.1
and yield "Authentication failed" in 2.10.2.

I tracked this down to 5275c3081c (http: http.emptyauth should allow empty
(not just NULL) usernames, 2016-10-04) which all of a sudden disallowed
empty user names (and now only handles things correctly when
http.emptyAuth is set to true specifically).

This smells like a real bad regression to me, certainly given the time I
had to spend to figure this out (starting from not exactly helpful bug
reports, due to being very specific to their setups being private).

I am *really* tempted to change the default of http.emptyAuth to true, *at
least* for Windows (where it is quite common to use your login credentials
to authenticate to corporate servers).

Before I do anything rash, though: Do you see any downside to that?

Ciao,
Dscho
