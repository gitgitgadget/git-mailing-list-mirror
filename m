From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/10] unpack-trees: optimize full checkout case
Date: Mon, 15 Nov 2010 14:41:58 -0600
Message-ID: <20101115204158.GG16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 21:42:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI5sw-0004Ew-59
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 21:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266Ab0KOUmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 15:42:37 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36840 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209Ab0KOUmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 15:42:36 -0500
Received: by wyb28 with SMTP id 28so4820947wyb.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Xq78LUCMA68w4GGs00OJHQiNy5MYptgXqHcpZF72kQ=;
        b=VczBd4WDmk84ykm5aCD/mLML1iFBY/lu/eH2X+aeUhVWWhaAQ2Gpkw6VK+OCe6HOzs
         rc4vbkXU6pMbakrd61lEO439kHRUPd5CJ2NBAlLeA/g1ejIIjiwt8B2YLsdFYJGtuKT8
         imyfZ4KrrUOodyWEa41fwNVaNcB0U6dUXUP8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lGl45lZzYOeSNgxpbMtc+iMWtmxGpMr+ppyxhRJYpeC0DZNXPNmTdgTa2KrnyaF71S
         5N7FPjcf67sLNRvC1Hsrj84Gn7MFFWgtTSL8TQYClAxSyYQQSOiUt7Q93G2B2JouIo2e
         9Dtse0dc8R57YAuvYv38NuLeiUYII88C7BWRs=
Received: by 10.216.28.204 with SMTP id g54mr7056977wea.73.1289853754554;
        Mon, 15 Nov 2010 12:42:34 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id p4sm200398wej.28.2010.11.15.12.42.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 12:42:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-6-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161512>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

So, what does it do?  What workflow was not optimized (yes, I know full
checkout means pattern "*", but the reader might not), why ought it to
be optimized, and what are the side-effects, if any?

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -996,6 +996,16 @@ int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
>  			o->el =3D &el;
>  	}
> =20
> +	if (!o->skip_sparse_checkout &&
> +	    o->el->nr =3D=3D 1 &&
> +	    !strcmp(o->el->excludes[0]->pattern, "*")) {
> +		for (i =3D 0; i < o->src_index->cache_nr; i++)
> +			if (ce_skip_worktree(o->src_index->cache[i]))
> +				break;
> +		if (i =3D=3D o->src_index->cache_nr)
> +			o->skip_sparse_checkout =3D 1;

Millinit:

	if (!o->skip_sparse_checkout &&
			checkout_is_whole_tree(o) &&
			index_uses_flag(o->src_index, CE_SKIP_WORKTREE))
		o->skip_sparse_checkout =3D 1;

=46unctions for the two conditions (especially the second) would make
this clearer, I think.

Sensible.
