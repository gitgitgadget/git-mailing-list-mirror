Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBA9207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbdECK1L (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:27:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:50810 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbdECK1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:27:03 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoVja-1dhfLy2mao-00gaqY for
 <git@vger.kernel.org>; Wed, 03 May 2017 12:27:00 +0200
Date:   Wed, 3 May 2017 12:27:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
Subject: RFA: untracked cache vs git reset --hard
Message-ID: <alpine.DEB.2.20.1705031202470.3480@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UGcC5FwDO0KlqcFZ5UwLlGcqNYmfX1OVnakhGgIE3Bj76hojsjk
 06apWNHFi98LEjeCuwgYIY9EbKlDviw7t57DqzQ6jUohk5rZ7Jmq6Ay6xh2bUf9xQoO+HBS
 goYpBiYa2Isc4ub23ELxm6okWxB/WHnaZalKMikl0DDuv4ikhhuiHoH213V1kctSP8BII4J
 dWrykx3sjgduj9jDenAXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GxF+EiOGERc=:WFh+EWK9pD7E+3RHB+XjOC
 0D5+RfO1QfsGaxKMKy0S2/ZL/09SDlDAh3pvBOHgC2WlyAngzW7gAKWrppgTQIYWlyvA0p0ja
 /8YkDfrJgNKceIFz9iBMFCtvf+g+dYwKkVnj2m0YY8wjkM45DOdMYeBROh5T3ndo6Nj3tLukp
 heqo3ktyAmq/4s2Eey0dcmF+n54yYBSj5mtOx2iA5RCncugiwhZfFye0m9L1KpQchj2cvbGGu
 X/iz5sG+a4zG20OlejwOhCN/pd+tOnBbm3fI+zA1cjqjURPyI2mapckdUcgs2To/O9DWnxnh9
 9OwIU4cPu6M9//1aayPzlqjXGTt7XnqCatA/A+OE7xWeGQfNZJrVI9YsqxIwSclhD/HQKdEsF
 ZnYVXY8uImlxuoMJn1IAoeMoXc0wOaod4igMrt8vQoowtM65/q9XrgVN5O6Z48trBglD169GT
 RU3vWeNvtdhJ8cj56iAqMwZ1xWrdmDftpPMcjVV4X7Rqx4yYaQ0wbUiD+3gv3dQk5qyWm9cOo
 4w3DU/8lIzZ1szS2mXtPWyzWrtMQu4jq2TUenNw21r8UtpayvHam+ap3n9HBZvE40FiGITSAb
 sv16Cf2ob6rDVYrn5J7ufNL19KItLjhmLMfp9FkHtIBzHginIDzP3+Dgw+ot9hdKWvNBUzdav
 L1rHc5HwS0f/5M+47qkCcu+0AhJfgPlh1j01HeWpQeGJeJhYwFtul2o56CVk2eCk2qHSWOx9n
 5a4egoBe9oE6z3clOXb+/p7NaSSqwZV24cRn3OTJfs3dCKbzuPs2CwP5SG7J+rHal13eHMbWQ
 adUwNt7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have a problem and would like to solicit advice how to fix it.

The untracked cache has made a real difference on rather large
repositories with tons of directories, and it is really, really useful.

But. One innocuous `git reset --hard` will just blow it away.

How? reset_index() calls unpack_trees() which in turn tries to populate a
new index and then discards the old one:

	https://github.com/git/git/blob/v2.12.2/unpack-trees.c#L1293

That discard_index() unfortunately also blows away each and every index
extension that had been read carefully before.

All users of `git reset --hard` (including `git stash`) suffer this.

In fact, it looks as if *any* caller of unpack_trees() would suffer the
same problem: git-am, git-checkout, git-commit, git-merge, etc

Now, I could imagine that maybe we could just "move"
o->dst_index.untracked to o->result.untracked, and that the machinery then
would do the right thing.

However, I am far from an expert in this area, so I would appreciate all
the helpful advice I could get.

Thoughts?

Thanks,
Johannes
