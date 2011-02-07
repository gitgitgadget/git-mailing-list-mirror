From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 03:17:40 -0600
Message-ID: <20110207091740.GA5391@elie>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 10:19:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmNG4-000825-IQ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 10:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1BGJRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 04:17:55 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50379 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab1BGJRx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 04:17:53 -0500
Received: by iwn9 with SMTP id 9so4357297iwn.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 01:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q5MKja7u/2ksHKjQSFdeJqwb/mdzNkYq28v+T+8hLTI=;
        b=u3TcbEmAjkYcGHba/wFy/BhrbqI/gkiRRzWVi1I2omfK/AEHNI34oaojRZeS2mvIk6
         ZiLxKwShJwqGQbn7tmstHwFiZbOC1R6B1K9OwpoQJr7AHNPHt/YzFcA0YzueBsnq91o0
         SvQEHhkzYQuARmnEP9gP26uFagm28gjjJ/OJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zh+Of4kfPRHtYs7thB2I3C1HCJULAIiY1HILvvRDF5w+bg+BJC7uei60a8QTukoyqB
         8L7iwKn92v5L1OzmDkK0JY92PT6LT2iFfd3JWT5uUzrkYb7i2IBfu0g1YmAdh6/xtFmo
         EFRPV6cxiQRO26dLdxRQCTopMqAItM+fdfk5Q=
Received: by 10.42.239.133 with SMTP id kw5mr18218913icb.511.1297070273229;
        Mon, 07 Feb 2011 01:17:53 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id 8sm3628025iba.10.2011.02.07.01.17.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 01:17:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296914835-808-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166244>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Let's do it in a consistent way, always disregard empty trees in
> index. If users choose to create empty trees their own way, they
> should not use index at all.

While this violates some seeming invariants, like

1.
	git reset --hard
	git commit --allow-empty
	git rev-parse HEAD^^{tree} >expect
	git rev-parse HEAD^{tree} >actual
	test_cmp expect actual

2.
	git reset --hard
	git revert HEAD
	if git rev-parse HEAD~2
	then
		git rev-parse HEAD~2^{tree} >expect
		git rev-parse HEAD^{tree} >actual
		test_cmp expect actual
	fi

, I think it's a good change.  Malformed modes in trees already break
those false invariants iiuc.

Thanks.

> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -621,9 +621,18 @@ static void prime_cache_tree_rec(struct cache_tr=
ee *it, struct tree *tree)
>  			struct tree *subtree =3D lookup_tree(entry.sha1);
>  			if (!subtree->object.parsed)
>  				parse_tree(subtree);
> +			if (!hashcmp(entry.sha1, (unsigned char *)EMPTY_TREE_SHA1_BIN)) {
> +				warning("empty tree detected! Will be removed in new commits");
> +				cnt =3D -1;
> +				break;
> +			}

Aside from the warning, this part is an optimization, right?

>  			sub =3D cache_tree_sub(it, entry.path);
>  			sub->cache_tree =3D cache_tree();
>  			prime_cache_tree_rec(sub->cache_tree, subtree);
> +			if (sub->cache_tree->entry_count =3D=3D -1) {
> +				cnt =3D -1;
> +				break;
> +			}

Would be nice to include a test for this, like so:

	subdir/
		empty1/
		subsubdir/
			empty2/
			empty3/

> --- /dev/null
> +++ b/t/t1013-read-tree-empty.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +test_description=3D'read-tree with empty trees'
> +
> +. ./test-lib.sh
> +
> +EMPTY_TREE=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904

If we _have_ to hard-code this (why?) then I'd prefer to do so
in test-lib.sh.

[...]
> +test_expect_success 'write-tree removes empty tree' '
> +	git read-tree `cat tree` &&
> +	git write-tree >actual
> +	echo $EMPTY_TREE >expected
> +	test_cmp expected actual

Broken &&-chain.  Not sure why this test relies on virtual objects
and another (independently nice) patch instead of adding the empty
tree to the object db --- is there something subtle I am missing?

The test does not distinguish between success due to git read-tree
omitting empty trees and success due to git mktree omitting empty
trees.

Hope that helps,
Jonathan
