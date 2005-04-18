From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 10:49:06 +1000
Message-ID: <20050418004906.GA3132@gondor.apana.org.au>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org> <20050417232905.GA2721@gondor.apana.org.au> <20050417233441.GU1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:46:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKPV-0002Uc-GA
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVDRAuX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDRAuX
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:50:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:5133 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261361AbVDRAuQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 20:50:16 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DNKSG-0007u8-00; Mon, 18 Apr 2005 10:49:36 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DNKRm-0000pK-00; Mon, 18 Apr 2005 10:49:06 +1000
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050417233441.GU1461@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 01:34:41AM +0200, Petr Baudis wrote:
>
> No. The collision check is done in the opposite cache - when you want to
> write a blob and there is already a file of the same hash in the tree.
> So either the blob is already in the database, or you have a collision.
> Therefore, the cost is proportional to the size of what stays unchanged.

This is only true if we're calling update-cache on all unchanged files.
If that's what git is doing then we're in trouble anyway.

Remember that prior to the collision check we've already spent the
effort in

1) Compressing the file.
2) Computing a SHA1 hash on the result.

These two steps together (especially the first one) is much more
expensive than a file content comparison of the blob versus what's
already in the tree.

Somehow I have a hard time seeing how this can be at all efficient if
we're compressing all checked out files including those which are
unchanged.

Therefore the only conclusion I can draw is that we're only calling
update-cache on the set of changed files, or at most a small superset
of them.  In that case, the cost of the collision check *is* proportional
to the size of the change.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
