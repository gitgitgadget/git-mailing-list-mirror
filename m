Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12DA1FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755082AbdEKHyn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:54:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:49186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754923AbdEKHym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:54:42 -0400
Received: (qmail 28416 invoked by uid 109); 11 May 2017 07:54:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 07:54:39 +0000
Received: (qmail 9921 invoked by uid 111); 11 May 2017 07:55:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 03:55:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 03:54:37 -0400
Date:   Thu, 11 May 2017 03:54:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Message-ID: <20170511075437.yjxs6oit7ibe7rkq@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
 <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
 <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
 <CACBZZX6hpL0=Zw0kvB-Ww95uGvuJ8129MTwkmv7DOEE1i66a_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6hpL0=Zw0kvB-Ww95uGvuJ8129MTwkmv7DOEE1i66a_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 09:49:09AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I don't like this because it copies the rules for _one_ property to the
> > conditional section. What happens when you're looking for some other
> > property of include.path?
> 
> Yeah, as I said once I wrote it up I found it wasn't really any
> better, but just wanted to send an explanation for why I didn't find
> it while I remembered, as a sort of case study.
> [...]
> > I suspect that whole paragraph under Includes could be reworded to make
> > it clear that anything it is saying applies equally to include.$key and
> > includeIf.*.$key, and then that would future-proof us for other
> > modifications.

What about this:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..e44ad21eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -80,13 +80,13 @@ Includes
 ~~~~~~~~
 
 You can include a config file from another by setting the special
-`include.path` variable to the name of the file to be included. The
-variable takes a pathname as its value, and is subject to tilde
-expansion. `include.path` can be given multiple times.
+`include.path` and `includeIf.*.path` variables to the name of the file
+to be included. The variable takes a pathname as its value, and is
+subject to tilde expansion. These variables can be given multiple times.
 
 The included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
-`include.path` variable is a relative path, the path is considered to
+variable is a relative path, the path is considered to
 be relative to the configuration file in which the include directive
 was found.  See below for examples.
 
@@ -95,8 +95,7 @@ Conditional includes
 
 You can include a config file from another conditionally by setting a
 `includeIf.<condition>.path` variable to the name of the file to be
-included. The variable's value is treated the same way as
-`include.path`. `includeIf.<condition>.path` can be given multiple times.
+included (see the "Includes" section above for more details).
 
 The condition starts with a keyword followed by a colon and some data
 whose format and meaning depends on the keyword. Supported keywords
