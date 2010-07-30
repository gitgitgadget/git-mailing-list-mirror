From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Thu, 29 Jul 2010 20:35:34 -0500
Message-ID: <20100730013534.GB2182@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 03:37:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeeX0-0007Hd-UT
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 03:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab0G3Bgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 21:36:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56098 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab0G3Bgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 21:36:47 -0400
Received: by gwb20 with SMTP id 20so406734gwb.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 18:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a4awu3Cc1jGJ2mZcRMdy7W/5xfq0BFo+1vpc8NycJvU=;
        b=kxgr8dL1wcovvf6pQNiTPYtGPDUf+QJSGIueD/hdsRLa6DvxWO51AaQCkza88KecBH
         wLM3AY0RoQEd3Juqt8SRA00tgjqX/SDuMVE+kFxwsfxv2Vh7OuQVTPT/73/Lhh3smp4y
         50o8VBYZL/avQwyupbeUU8w6KvDdWX/HKsgI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=x/IU8utm/jtI6bSyKvt5TXHozuIZTWaB2Y6XWAP+M6HY/e/c5N1JP2iWKjeVeo0hBB
         iakK5+zFCfG7Os/bLQRads63BLg8dGFQol/I36WKrqHl6o/oZ5x1l1ijiFOF8n8/bXj0
         i8S3IDAvevbsC6kUxQEn7uVcipKLj1M74Jjmc=
Received: by 10.150.202.9 with SMTP id z9mr2174384ybf.211.1280453806180;
        Thu, 29 Jul 2010 18:36:46 -0700 (PDT)
Received: from burratino ([64.107.0.124])
        by mx.google.com with ESMTPS id u42sm1593550yba.0.2010.07.29.18.36.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 18:36:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152214>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The log message left me confused.  Let=E2=80=99s see if the code is eas=
ier.

> +++ b/cache.h
> @@ -179,8 +179,7 @@ struct cache_entry {
>  #define CE_UNHASHED  (0x200000)
>  #define CE_CONFLICTED (0x800000)
> =20
> -/* Only remove in work directory, not index */
> -#define CE_WT_REMOVE (0x400000)
> +#define CE_WT_REMOVE (0x400000) /* remove in work directory */

Before[1], CE_REMOVE was used by read-tree et al in core to represent
something to be removed from the index file and work tree (e.g., when
switching branches).

In the new order, one uses CE_REMOVE|CE_WT_REMOVE for that, right?

> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -147,4 +147,11 @@ test_expect_success 'read-tree adds to worktree,=
 dirty case' '
>  	grep -q dirty sub/added
>  '
> =20
> +test_expect_success 'read-tree --reset removes outside worktree' '
> +	echo init.t > .git/info/sparse-checkout &&
> +	git checkout -f top &&
> +	git reset --hard removed &&
> +	test -z "$(git ls-files sub/added)"
> +'
> +

Using reset --hard to remove a file outside the sparse checkout.
A sane, simple test; thanks.  (Nitpick: I would have used

	>empty &&
	git ls-files sub/added >output &&
	test_cmp empty output

even though that does not produce any more helpful output in this
case.)

> +++ b/unpack-trees.c
> @@ -53,6 +53,9 @@ static void add_entry(struct unpack_trees_options *=
o, struct cache_entry *ce,
> =20
>  	clear |=3D CE_HASHED | CE_UNHASHED;
> =20
> +	if (set & CE_REMOVE)
> +		set |=3D CE_WT_REMOVE;
> +

A bridge between the old and new worlds.

I would have added CE_WT_REMOVE to callers instead (they all pass
constants more or less), but I suppose this way makes the patch
shorter.

[...]
> @@ -84,7 +87,7 @@ static int check_updates(struct unpack_trees_option=
s *o)
>  	if (o->update && o->verbose_update) {
>  		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
>  			struct cache_entry *ce =3D index->cache[cnt];
> -			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE | CE_WT_REMOVE))
> +			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))

Only entries marked CE_WT_REMOVE will be touched by read-tree -u.

> @@ -104,12 +107,6 @@ static int check_updates(struct unpack_trees_opt=
ions *o)
>  				unlink_entry(ce);
>  			continue;
>  		}
> -
> -		if (ce->ce_flags & CE_REMOVE) {
[...]

and the CE_WT_REMOVE case takes care of that.  Makes sense.

> @@ -799,10 +796,15 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>  			/*
>  			 * Merge strategies may set CE_UPDATE|CE_REMOVE outside checkout
>  			 * area as a result of ce_skip_worktree() shortcuts in
> -			 * verify_absent() and verify_uptodate(). Clear them.
> +			 * verify_absent() and verify_uptodate().
> +			 * Make sure they don't modify worktree.
>  			 */
> -			if (ce_skip_worktree(ce))
> -				ce->ce_flags &=3D ~(CE_UPDATE | CE_REMOVE);
> +			if (ce_skip_worktree(ce)) {
> +				ce->ce_flags &=3D ~CE_UPDATE;
> +
> +				if (ce->ce_flags & CE_REMOVE)
> +					ce->ce_flags &=3D ~CE_WT_REMOVE;
> +			}
>  			else
>  				empty_worktree =3D 0;

Ah, and at last we come to the fix. :)

This is a little tricky: the CE_WT_REMOVE case (without CE_REMOVE)
represents a narrowing of the checkout and should be preserved,
while CE_WT_REMOVE|CE_REMOVE represents a removed index entry and
should be changed to just CE_REMOVE.

But it is a clear improvement over the code from before and should
behave as advertised now.  So aside from the log message,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[1] v1.6.6.1~23^2~1 (Make on-disk index representation separate from
in-core one, 2008-01-14) and v0.99~295 (git-read-tree: remove deleted
files in the working directory, 2005-06-09).
