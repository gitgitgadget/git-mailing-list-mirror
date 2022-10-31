Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A5FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJaTYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJaTYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 15:24:48 -0400
X-Greylist: delayed 1403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Oct 2022 12:24:46 PDT
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C512614
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
        s=swing; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cq7Wo7Ic06mp/6lcr0joXafKchs9YxmlLDz+6c6k1Zc=; b=j4BTvInKJt4txMzwaIARGFnfnp
        iTQ+lHpmM7iQ9NL31X+6y62a9BU6R+kkSnhv8EYd7I0NKFOTgiG2WwAo44VQ9aPlnRPTdhkAfA+Z5
        Hm/5HQ6YUgQILWeMz1avSizLWoMYIirU/YKJXbMxtkGo3tyYj+1hqewpIhMqYXZ11Ki0=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1opa2D-000OlC-H1
        for git@vger.kernel.org;
        Mon, 31 Oct 2022 19:01:21 +0000
Received: from localhost (stax.localdomain [local])
        by stax.localdomain (OpenSMTPD) with ESMTPA id 674f9102
        for <git@vger.kernel.org>;
        Mon, 31 Oct 2022 19:01:20 +0000 (UTC)
Date:   Mon, 31 Oct 2022 19:01:20 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     git@vger.kernel.org
Subject: Consist timestamps within a checkout/clone
Message-ID: <2210311614160.25661@stax.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our use case: we commit some compiled objects to the repo, where compiling 
is either slow or requires software which is not always available.

Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgrade) 
we are noticing a change in build behaviour.

Now, after a "git clone" we find the Makefile intermittently attempting 
(and failing) some builds that are not intended.

Indeed, Make is acting reasonably as the source file is sometimes 
marginally newer than the destination (both checked out by Git), example 
below.

I've never had to consider consistency timestamps within a Git checkout 
until now.

It's entirely possible there's _never_ a guarantee of consistency here.

But then something has certainly changed in practice, as this fault has 
gone from never happening to now every couple of days.

Imaginging I can't be the first person to encounter this, I searched for 
existing threads or docs, but overwhemingly the results were question of 
Git tracking the timestamps (as part of the commit) which this is not; 
it's consistency within one checkout.

$ git clone --depth 1 file:///path/to/repo.git

$ stat winner.jpeg
  File: winner.jpeg
  Size: 258243          Blocks: 520        IO Block: 4096   regular file
Device: fd07h/64775d    Inode: 33696       Links: 1
Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
Access: 2022-10-31 16:05:17.756858496 +0000
Modify: 2022-10-31 16:05:17.756858496 +0000
Change: 2022-10-31 16:05:17.756858496 +0000
 Birth: -

$ stat winner.svg
  File: winner.svg
  Size: 52685           Blocks: 112        IO Block: 4096   regular file
Device: fd07h/64775d    Inode: 33697       Links: 1
Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
Access: 2022-10-31 16:05:17.766859030 +0000
Modify: 2022-10-31 16:05:17.766859030 +0000
Change: 2022-10-31 16:05:17.766859030 +0000
 Birth: -

Elsewhere in the repository, it's clear the timestamps are not consistent:

$ stat Makefile
  File: Makefile
  Size: 8369            Blocks: 24         IO Block: 4096   regular file
Device: fd07h/64775d    Inode: 33655       Links: 1
Access: (0644/-rw-r--r--)  Uid: (  106/ luthier)   Gid: (  106/ luthier)
Access: 2022-10-31 16:05:51.628660212 +0000
Modify: 2022-10-31 16:05:17.746857963 +0000
Change: 2022-10-31 16:05:17.746857963 +0000
 Birth: -

-- 
Mark
