Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C9B2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753783AbcIOSM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:12:59 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:43011 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbcIOSM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:12:57 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bkb9a-00051s-Qa
        for git@vger.kernel.org; Thu, 15 Sep 2016 14:12:54 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1bkb9a-00051n-JN
        for git@vger.kernel.org; Thu, 15 Sep 2016 14:12:54 -0400
Date:   Thu, 15 Sep 2016 14:12:54 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
Message-ID: <20160915181254.GN9830@onerussian.com>
References: <20160915130233.GC9833@onerussian.com>
 <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 15 Sep 2016, Junio C Hamano wrote:

> >> which then stops without even looking at other submodules.

> >> I think it would be more logical to make it a 'warning:' not a 'fatal:' and
> >> proceed.

> Making "git submodule" listing to continue from that point may be
> one thing, but do we have a sensible way in "git submodule add" to
> allow the user to recover from this condition?  That is, "git add"
> is a right way to tell the core level that there is a gitlink, but
> as Yaroslav correctly observed in the early part of his message,
> having that gitlink alone is not good enough for the world view of 
> "git submodule" that sits at higher-layer.  And the usual way to
> tell the submodule layer that there is a submodule is with "git
> submodule add", but

> 	$ git init top
>         $ cd top
>         $ git commit --allow-empty -m 'initial in top'
>         $ git init sub
>         $ git -C sub commit --allow-empty -m 'initial in sub'

>         $ git add sub
> 	$ git submodule
>         fatal: no submodule mapping found in .gitmodules for path 'sub'

> 	$ git submodule add ./sub sub
>         'sub' already exists in the index
> 	$ git submodule add -f ./sub sub
>         'sub' already exists in the index

FWIW
I could have sworn that I have tried to 'submodule add' it and it
worked... but pragmatically I just did edit .gitmodules, added the
record for it, committed it, and then iirc git submodule update --init
which seemed to make  git happy... FTR:

$> git submodule add ./sub ./sub
'sub' already exists in the index

$> git submodule add ./sub/ ./sub/
'sub' already exists in the index

$> vim .gitmodules

$> git add .gitmodules
cached/staged changes:                                                                                                                                                                                                                                                                                            
 .gitmodules | 4 ++++
 sub         | 1 +

$> git submodule update --init
Submodule 'sub' (/tmp/111/top/sub) registered for path 'sub'
cached/staged changes:                                                                                                                                                                                                                                                                                            
 .gitmodules | 4 ++++
 sub         | 1 +

$> git commit -m 'added finally'
[master aa6d912] added finally
 2 files changed, 5 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sub

$> git submodule
 6f574b298ef51aebd36daafad450a3e38802ca03 sub (heads/master)


> I highly suspect that the user will then get stuck at this point,
> after trying to "submodule add" and then even attempting to force
> it.

> I think that is a more pressing thing to address.  Once we make it
> easier for the user to bring a half-initialized submodule properly
> into the world view of the submodule subsystem, we would have to
> worry about the reported failure case even less and you do not need 
> to pile on workaround options to let things continue in a state that
> is half-broken (that is, in a state that is perfectly sane to the
> core layer, but is not liked by the submodule layer).

do you foresee any unpleasant side-effects from above manual editing
.gitmodules/submodule update --init ?

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
