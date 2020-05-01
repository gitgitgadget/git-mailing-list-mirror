Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD19C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7830F20731
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEAF5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 01:57:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:33264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbgEAF5j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 01:57:39 -0400
Received: (qmail 1730 invoked by uid 109); 1 May 2020 05:57:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 05:57:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15413 invoked by uid 111); 1 May 2020 05:57:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 01:57:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 01:57:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix quoting bug in credential cache example
Message-ID: <20200501055738.GB23665@coredump.intra.peff.net>
References: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
 <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1w4sv5t.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:09:02AM -0700, Junio C Hamano wrote:

> [...]
> Having said all that, I think we should clarify what these sample
> strings are in the introductory text in the examples.  

You already said everything I was going to. :)

> I've always thought that they are illustrating possible values and
> how to express that value in the context the values appear in is up
> to the readers who learn what values to write in this document (and
> they learn from manual for shell to learn the shell quoting
> convention and manual for 'git config' to learn the config quoting
> convention).  Hence my initial reaction to your patch was "shell?
> Quoting for shell is outside the scope of the explanation here".
> 
> On the other hand, for anybody who assumes that these examples are
> literally showing what you write after "[credential] helper = " in
> the configuration file, the example clearly is wrong and dq may be
> needed (but yours is also wrong, in that it loses double quotes
> around the argument to echo; if ~/.secret file had a tab in it, the
> helper will now yield a wrong password and you won't be able to log
> in).

Yes, they were definitely meant as: here are the raw values you would
want to use, and it is up to you to figure out how to get that into a
config file (whether on the cmdline via "git config" or editing the file
yourself).

I think we can either clarify that with a note at the beginning of the
list, or we can just present it as config, like:

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1814d2d23c..c756ecb8fd 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -216,20 +216,25 @@ Here are some example specifications:
 
 ----------------------------------------------------
 # run "git credential-foo"
-foo
+[credential]
+helper = foo
 
 # same as above, but pass an argument to the helper
-foo --bar=baz
+[credential]
+helper = foo --bar=baz
 
 # the arguments are parsed by the shell, so use shell
 # quoting if necessary
-foo --bar="whitespace arg"
+[credential]
+helper = "foo --bar='whitespace arg'"
 
 # you can also use an absolute path, which will not use the git wrapper
-/path/to/my/helper --with-arguments
+[credential]
+helper = /path/to/my/helper --with-arguments
 
 # or you can specify your own shell snippet
-!f() { echo "password=`cat $HOME/.secret`"; }; f
+[credential]
+helper = "!f() { echo \"password=`cat $HOME/.secret`\"; }; f"
 ----------------------------------------------------
 
 Generally speaking, rule (3) above is the simplest for users to specify.

It may be easier to just use double-quotes consistently, even for ones
that do not need it, to give readers one less thing to wonder about.

-Peff
