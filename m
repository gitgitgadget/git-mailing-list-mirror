Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B35C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiHTWlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTWlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 18:41:05 -0400
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Aug 2022 15:41:02 PDT
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB226AE2
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 15:41:02 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 4432662529; Sun, 21 Aug 2022 00:32:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 42EF17FAA2;
        Sun, 21 Aug 2022 00:32:54 +0200 (CEST)
Date:   Sun, 21 Aug 2022 00:32:54 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
To:     Jeff King <peff@peff.net>
cc:     =?ISO-2022-JP?Q?=1B$B2&=3E=2E7z=1B=28J?= <littlejian8@gmail.com>,
        git@vger.kernel.org
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
In-Reply-To: <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
Message-ID: <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com> <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 20 Aug 2022, Jeff King wrote:

> The curl change seems to be from 620ea2141 (transfer: redirects to other
> protocols or ports clear auth, 2022-04-25). The goal is to avoid leaking
> credentials between ports: https://curl.se/docs/CVE-2022-27774.html
>
> So that makes sense, though I wonder if curl ought to make an exception
> for moving from 80 to 443 and http to https?

Nice research there Jeff, and yes this seems entirely correct.

We stopped curl from following such redirects because of the reasons stated in 
the security advisory for that CVE. We quite simply realized that when curl 
previously did that, it was actually doing more than what was documented and 
what can be considered reasonably safe.

Following a redirect to another protocol and another port, even if it is still 
on the same host name, might very well connect and use another server run by 
someone else than the one reached first. We therefore now consider that second 
host+port+protocol combo a different host.

Setting CURLOPT_UNRESTRICTED_AUTH is then the only way to make libcurl send 
the credentials again after such a redirect.

I would not mind having a discussion in the curl project to see if we should 
possibly consider adding a middle-ground where we allow sending credentials to 
another port for the same host name, but I am personally NOT sold on the idea. 
I think such redirects should rather be fixed and avoided - since I believe 
users will not understand the security implications of doing them.

-- 

  / daniel.haxx.se
