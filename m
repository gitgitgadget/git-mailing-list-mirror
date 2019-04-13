Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015F520248
	for <e@80x24.org>; Sat, 13 Apr 2019 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDMJVj (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 05:21:39 -0400
Received: from tschil.ethgen.ch ([5.9.7.51]:57682 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfDMJVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 05:21:39 -0400
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hFEqu-0000sB-Ih
        for git@vger.kernel.org; Sat, 13 Apr 2019 11:21:36 +0200
Received: from klaus by ikki.ket with local (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1hFEqu-00080W-CI
        for git@vger.kernel.org; Sat, 13 Apr 2019 11:21:36 +0200
Date:   Sat, 13 Apr 2019 10:21:36 +0100
From:   Klaus Ethgen <Klaus@ethgen.ch>
To:     git@vger.kernel.org
Subject: Re: fatal: unable to read after commit - deeper analysis
Message-ID: <20190413092136.GK12669@ikki.ethgen.ch>
References: <20190411164440.GC12669@ikki.ethgen.ch>
 <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
In-Reply-To: <CAP8UFD0bBBtOOz9ew_2URCp3nY1v0_OHMby1-N+T0nCDW82DRg@mail.gmail.com>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

I did a deep analysis of the problem and found that the trouble finally
was caused of some change in git (I did not search, when this changed.
But maybe you can tell me.)

Finally, the error was a combination of 4 tools, git, vim, the mentioned
vim-addon and task with a task-hook for committing pending.data.

When I do a git commit which invokes vim, then the following variables
are set:
- - GIT_INDEX_FILE
- - GIT_AUTHOR_DATE
- - GIT_PREFIX
- - GIT_EXEC_PATH

And $GIT_INDEX_FILE is the source of trouble here. The task-hook clears
respective sets the variables GIT_DIR and GIT_WORK_TREE. However, the
GIT_INDEX_FILE environment is set (in some cases) to an absolute path
pointing to .git/index.lock or .git/index (I have no idea when it is
taking the .lock variant).

Now we have a mismatch of GIT_DIR and GIT_WORK_TREE on one hand and the
absolute path of GIT_INDEX_FILE on the other. So the trouble is set. The
following "git add pending.data" did break all. It does something to an
index that does not belong to the git repo.

Mystery is when and why this changed in git. It was definitively changed
in some recent version.

Regards
   Klaus
- -- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C
-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAEBCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAlyxqh8ACgkQpnwKsYAZ
9qxXWAv/QI6XeQ4H+Y39K3nLi68JLZo2/VzcI1CfVw42PeckxzxZHg1YUTXrr5Qk
+bQ5drXcfzNMxWkCe1fh9CoHiyJyiAIPNfMjqiUaCB8881Ttr4SYd/lalvYVXPgt
m0g7XO51Kh5LqPP6h7KcjBM0c6OSyQznE8Q6L0FSnDP4gCkBTW75AmxBytUk+sDq
uOajtyOiOr1Fz1krn89VBaLJJPMVo+OInbNwetQUgOGIN7BsHsG68Ilwoimdlt+H
7sd5HJwVrQ/w9VdXzniLPznzkG4l/3YlU8IQWKR13dRFf68LrT1ZR+F4TJpjlm/Y
l/KKF0EcVKbhuJ47gLIUDf3faeLFxdF1iOviKkJ0A0cfg5Z8M4ds8hBoiqhMSr+X
5fgINyhQfMurSTAuspZLJ0xjLu+Wv+h9Xt1jQZpW3YlPgi3O6Dn2K1V9ACaozP8G
0EIIMOvTNvqVw9iLe4a6cBm1M+gXfWRRf7H6wqvDhDuuSVF2h1sGwMMQHiumlqm3
au+0hEGQ
=6ikc
-----END PGP SIGNATURE-----
