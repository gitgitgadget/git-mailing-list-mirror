Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534D320401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdFUSUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:20:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:47766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752002AbdFUSUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:20:39 -0400
Received: (qmail 2303 invoked by uid 109); 21 Jun 2017 18:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 18:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26176 invoked by uid 111); 21 Jun 2017 18:20:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 14:20:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 14:20:21 -0400
Date:   Wed, 21 Jun 2017 14:20:21 -0400
From:   Jeff King <peff@peff.net>
To:     Christian =?utf-8?B?UsO2c2No?= <christian@croesch.de>
Cc:     git@vger.kernel.org
Subject: Re: git add -p does not work with custom comment char currently
Message-ID: <20170621182020.ywopkykzdfhlxi5o@sigill.intra.peff.net>
References: <89d4e348-167e-b201-d243-63b1156b9ed0@croesch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89d4e348-167e-b201-d243-63b1156b9ed0@croesch.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 06:31:34PM +0200, Christian Rösch wrote:

> [core]
>     commentchar = $
> 
> as far as I can see with 2.13.0 and 2.13.1.516.g05ec6e1 (built from
> source) if I do
> 
> $ git add -p
> 
> and edit the hunk manually the comment char is not parsed correctly:
> 
> Stage this hunk [y,n,q,a,d,/,s,e,?]? e
> warning: recount: unexpected line: $ Manual hunk edit mode -- see bottom
> for a quick guide.
> 
> error: corrupt patch at line 6
> Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]? n
> 
> 
> As far as I can tell this is a bug but it would be nice if you could let
> me know if it works for you with a custom comment char.

I can reproduce easily here with the script below. It looks like a
regression in c9d961647 (i18n: add--interactive: mark edit_hunk_manually
message for translation, 2016-12-14), which is in v2.12.0. It taught the
script to write out with the comment char, but reading it back does not
seem to work.

Here's my reproduction script:

-- >8 --
rm -rf repo

git init repo
cd repo
git config core.commentchar '$'

seq 10 >file
git add file
git commit -m base
perl -pi -e 'print "new\n" if $. == 5' file
(echo e; echo n) | GIT_EDITOR=true git.compile add -p
# look for "corrupt patch" in the output
-- 8< --

I think there's another bug, too, where the "patch did not apply
cleanly" prompt goes into an infinite loop if it gets EOF.

-Peff
