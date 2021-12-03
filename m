Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1DC433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 15:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381921AbhLCQBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:01:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:43096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381919AbhLCQBk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 11:01:40 -0500
Received: (qmail 23920 invoked by uid 109); 3 Dec 2021 15:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 15:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1999 invoked by uid 111); 3 Dec 2021 15:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 10:58:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 10:58:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 01:31:16PM +0000, Johannes Schindelin via GitGitGadget wrote:

> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms this
> hypothesis. Signature verification passes with the fix.
> [...]
> @@ -497,7 +497,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>  			if (!*line)
>  				break;
>  
> -			trust_size = strcspn(line, "\n");
> +			trust_size = strcspn(line, "\r\n");
>  			principal = xmemdupz(line, trust_size);

Just playing devil's advocate for a moment: this parsing is kind of
loose. Is there any chance that I could smuggle a CR into my principal
name, and make "a principal\rthat is fake" now get parsed as "a
principal"? Our strcspn() here would cut off at the first CR.

I'm guessing probably not, but when it comes to something with security
implications like this, it pays to be extra careful. I'm hoping somebody
familiar with the ssh-keygen side and how the rest of the parsing works
(like Fabian) can verify that this is OK.

-Peff
