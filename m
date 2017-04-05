Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5154920966
	for <e@80x24.org>; Wed,  5 Apr 2017 23:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756300AbdDEXvn (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 19:51:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56375 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752824AbdDEXvm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 19:51:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 649B120549
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 19:51:41 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 05 Apr 2017 19:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=i9Ohv4xRxDw+1MH+zx
        cnP/ShAs5sJurG0H2LAmJXMzk=; b=ruhVwVUpJrxspVjamSjmsL25vO1Y+3/Hdd
        rITj9CtTyxQJ60FKBZn9NPZ3M22bhoq5CClhZKXavDgbTug15tkU7IbFx5MWkUP7
        VzgHUBpv7o6trIGi4lLnSCv6M5eTf8Q5blXT27j3XFYB57O39mIfJdiicgcMBA7E
        8XE4bWB2nnMs+6voO7FSy4MJCNsk18cN5PZ8LLCthDq7Nq75sPzbNXcQrFsHX4tT
        kQ0Mk+6i793l9H+DiZsKXXIy7LfQpP5darNr+LJoqcmLczBvRs6sIYtCFbaeINKa
        w6AxswQtU2ZCZ2piDz+gRRMq5vtkTvKyq0Cryvt8JfS/eMFg55hw==
X-ME-Sender: <xms:DYPlWI9sDptsmV0V1q3jx6Lstqd673o7gUP5Z9a9Y4UQsNk3mh9-MQ>
X-Sasl-enc: d9aJUTjnSrZKaOvv+2BRJ0teWBnCddW1RUODPFe9Dzj5 1491436301
Received: from [10.5.101.228] (unknown [216.64.185.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1995B24371
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 19:51:41 -0400 (EDT)
From:   Dan Fabulich <dan@fabulich.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Why does git-checkout accept a tree-ish?
Message-Id: <EA993AC0-022C-423D-ABD7-4747FA09E7FE@fabulich.com>
Date:   Wed, 5 Apr 2017 16:51:40 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was looking back through git's history, trying to figure out why =
git-checkout has so many features. I was struck by this commit by Junio =
in 2005.

=
https://github.com/git/git/commit/4aaa702794447d9b281dd22fe532fd61e02434e1=


> git-checkout: revert specific paths to either index or a given =
tree-ish.
> When extra paths arguments are given, git-checkout reverts only those
> paths to either the version recorded in the index or the version
> recorded in the given tree-ish.
>=20
> This has been on the TODO list for quite a while.

Prior to this commit, git-checkout would only switch branches; you could =
use git-checkout-index to copy files from the index to the working tree. =
But in this commit, git-checkout not only subsumes the functionality of =
git-checkout-index but also learns the ability to copy files from an =
arbitrary branch (now an arbitrary tree-ish) into the working copy *and* =
the the index. (That was important because git-reset didn't accept =
<paths> in 2005.)

I think the "UNIX philosophy" would have advocated that a new command be =
created to handle this case, perhaps something like git-checkout-tree. =
(That would also have eliminated the need to use -- to disambiguate the =
tree-ish from the paths.)

And so I wonder if anybody knows just why git-checkout gained these two =
features in one commit, without creating a separate command.

I have two guesses:

1) It was pretty easy for Junio to implement as part of git-checkout; =
just 20 lines of code and a small test.

2) git at the time was distributed as a collection of files, =
git-checkout, git-reset, etc. and so there was some pressure not to =
create a new command for fear that it would clutter the filesystem.

Are those the actual reasons? (This seems like it might be a FAQ, but =
Google failed me searching for git faqs or "why does git checkout do so =
many things.")

-Dan

P.S. I would make a similar argument about adding <paths> support to =
git-reset, rather than creating a separate command like git-unadd.

=
https://github.com/git/git/commit/2ce633b928f78224a37308f45810e76fefe8df56=

It was documented a couple of weeks later on Dec 26.
=
https://github.com/git/git/commit/6934dec89538e054823aadcce08af040bc8dcf79=
