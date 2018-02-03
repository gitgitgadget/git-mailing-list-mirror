Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388091F404
	for <e@80x24.org>; Sat,  3 Feb 2018 20:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeBCUWh (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 15:22:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:39212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752714AbeBCUWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 15:22:36 -0500
Received: (qmail 12169 invoked by uid 109); 3 Feb 2018 20:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Feb 2018 20:22:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27629 invoked by uid 111); 3 Feb 2018 20:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Feb 2018 15:23:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Feb 2018 15:22:34 -0500
Date:   Sat, 3 Feb 2018 15:22:34 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: contrib/completion/git-completion.bash: declare -g is not
 portable
Message-ID: <20180203202234.GA13374@sigill.intra.peff.net>
References: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
 <87lgg9g8cr.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgg9g8cr.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 03, 2018 at 08:51:16PM +0100, Andreas Schwab wrote:

> On Feb 03 2018, Torsten Bögershausen <tboegi@web.de> wrote:
> 
> > What is "declare -g" good for ?
> 
>       -g        create global variables when used in a shell function; otherwise
>                 ignored
> 
>     When used in a function, `declare' makes NAMEs local, as with the `local'
>     command.  The `-g' option suppresses this behavior.

I think the bigger question is why one would use "declare -g" instead of
just assigning the variable with "var=value".

Glancing at the code, I suspect it is because the name of the variable
itself needs expanded. If that's the case, we could use eval instead,
like:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3cc815be0d..204d620ff7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -297,7 +297,7 @@ __gitcomp_builtin ()
 	eval "options=\$$var"
 
 	if [ -z "$options" ]; then
-		declare -g "$var=$(__git ${cmd/_/ } --git-completion-helper)"
+		eval "$var=\$(__git \${cmd/_/ } --git-completion-helper)"
 		eval "options=\$$var"
 	fi
 

-Peff
