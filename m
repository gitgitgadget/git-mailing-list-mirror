From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCHv4 10/12] notes.c: Implement simple memory pooling of leaf 
	nodes
Date: Thu, 27 Aug 2009 09:39:31 +0200
Message-ID: <81b0412b0908270039l7a937c3bmd745274c71526ce1@mail.gmail.com>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
	 <1251337437-16947-11-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 09:39:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgZa8-0005iH-HH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 09:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZH0Hjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZH0Hjb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 03:39:31 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57276 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZH0Hjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 03:39:31 -0400
Received: by bwz19 with SMTP id 19so780605bwz.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SLlJu1v9FmewU3ZsMXXTqwivvGQt0/1cu6X12DjpcrA=;
        b=R6cBbWx4ClCfOIipgRhfLJkO3FkEreylk+kECuVceWzhxvvrt4qS77LfcLms7lnILG
         SwjTmBc1ZjcXR/G77Bo1zgZJgj5PMMDUlCqryWFUGJG6pHtVQFuxHdH9e6os6fPXZ6hI
         E/2WzFjsdpexU77YUvmuc1zlxP9geFiHVTXkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FHeDmZjVqz3p+tz6t0j5bGDxtK33r+Wb+EQlaqjdnATezw1ZeimErz7WTc9aA0LTl7
         wwNi2R+fvapc2GCuclF97fJh3IJnn0Wl4tfnOATXUwm4keL0S7d2CILpUz8Pq0FZw/dE
         L5RgGzlElGzN9SdfduTbVz/C/ElBNtC9Dd/to=
Received: by 10.204.34.197 with SMTP id m5mr4553648bkd.46.1251358771830; Thu, 
	27 Aug 2009 00:39:31 -0700 (PDT)
In-Reply-To: <1251337437-16947-11-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127146>

On Thu, Aug 27, 2009 at 03:43, Johan Herland<johan@herland.net> wrote:
> When allocating a new memory pool, the older pool is leaked, but this=
 is
> no worse than the current situation, where (pretty much) all leaf_nod=
es
> are leaked anyway.

Could you return the unused nodes back into tghe mempool?
By making the pool a preallocated list, perhaps?

And then it is trivial to provide a deallocation function for the mempo=
ol,
which something really concerned about the memleak can call (like when
or if libgit get more usable in an application context).

> @@ -95,7 +112,6 @@ static struct leaf_node *note_tree_find(struct int=
_node *tree, unsigned char n,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* unpack tree and resume search */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0tree->a[i] =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0load_subtree(l, tree, n);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 free(l);

free_leaf_node(l), which returns the node into mempool

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return note_tree_find(tree, n, key_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> @@ -118,7 +134,6 @@ static struct leaf_node *note_tree_find(struct in=
t_node *tree, unsigned char n,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* unpack tree=
 and resume search */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tree->a[0] =3D=
 NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_subtree(l=
, tree, n);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(l);

free_leaf_node(l);

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return note_tr=
ee_find(tree, n, key_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
