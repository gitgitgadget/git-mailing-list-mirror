Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DAC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 08:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiFFIFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiFFIFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 04:05:35 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578F40A2B
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 01:05:31 -0700 (PDT)
Received: from 77.116.2.81.in-addr.arpa ([81.2.116.77] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1ny7jt-0003sS-RX
        for git@vger.kernel.org; Mon, 06 Jun 2022 09:05:29 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1ny7js-000I6q-Sr
        for git@vger.kernel.org; Mon, 06 Jun 2022 09:05:29 +0100
Date:   Mon, 6 Jun 2022 09:05:28 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Subject: git push --delete <url> <branch> fails if run outside a repository
Message-ID: <20220606080528.rfugporpazoujceq@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="od6sgriocqfibnjh"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--od6sgriocqfibnjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When using `git push`, rather than specifying a remote by name, one can
also specify a remote by URL, and this includes when the only operations
being performed are to delete refs on the remote.  This doesn't require
any information about any local repository, but it fails unless the
command is run from within an existing local Git repo.

This seems like a bug to me: there's no reason this shouldn't work.
Clearly low priority, though, as this is a rare use case, and there's a
simple workaround: just `cd` into any existing Git repo, or create a
temporary empty repo to run the command from.

Simple test case attached; I've verified the behaviour the test script
demonstrates on Git v2.36.1 on Cygwin, and on Git v2.34.1 (strictly,
v2.34.1-1~bpo11) on Debian 11.

Cheers,

Adam

--od6sgriocqfibnjh
Content-Type: application/x-sh
Content-Disposition: attachment; filename="git-push-delete-bug.sh"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/env bash=0A=0Aset -xeu=0A=0Amkdir testdir=0Acd testdir=0A=0Agit =
init remotedir=0A(=0A	cd remotedir=0A	git commit --allow-empty -m 'Initial =
commit'=0A	git branch deleteme=0A)=0A=0Aremotepath=3D"$(pwd)/remotedir"=0A=
=0Agit push --delete "$remotepath" deleteme || echo 'Expected remote branch=
 deletion failed'=0A=0Agit init pointlessrepo=0A(=0A	cd pointlessrepo=0A	gi=
t push --delete "$remotepath" deleteme && echo 'But it works here'=0A)=0A
--od6sgriocqfibnjh--
