X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Shallow clone
Date: Sun, 12 Nov 2006 20:59:09 +0300
Message-ID: <20061112205909.f8951300.vsu@altlinux.ru>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com>
	<45521AE9.7050902@gmail.com>
	<7vac31p8om.fsf@assigned-by-dhcp.cox.net>
	<87zmaynl18.fsf@wine.dyndns.org>
	<7vu015f5av.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__12_Nov_2006_20_59_09_+0300_O3G6O24BS04ZM/dg"
NNTP-Posting-Date: Sun, 12 Nov 2006 17:59:44 +0000 (UTC)
Cc: Alexandre Julliard <julliard@winehq.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vu015f5av.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31268>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjJcG-0002qg-NE for gcvg-git@gmane.org; Sun, 12 Nov
 2006 18:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750961AbWKLR7c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWKLR7c
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 12:59:32 -0500
Received: from master.altlinux.org ([62.118.250.235]:27914 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S1750961AbWKLR7b
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 12:59:31 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id 509C2E3EE6;
 Sun, 12 Nov 2006 20:59:30 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--Signature=_Sun__12_Nov_2006_20_59_09_+0300_O3G6O24BS04ZM/dg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 12 Nov 2006 00:16:40 -0800 Junio C Hamano wrote:

> Alexandre Julliard <julliard@winehq.org> writes:
>
> > There's also a problem with the packing, a clone --depth 1 currently
> > results in a pack that's about 3 times as large as it should be.
>
> That's interesting.
>
>   : gitster; git clone -n --depth 1 git://127.0.0.1/git.git victim-001
[...]
>   -r--r--r-- 1 junio src 9.5M 2006-11-11 23:52 pack-f5f88d83....pack
>
> Repacking immediately after cloning brings it down to what is
> expected.
>
>   : gitster; git repack -a -d -f
[...]
>   -rw-rw-r-- 1 junio src 2.6M 2006-11-11 23:53 pack-f5f88d83....pack

This is due to optimization in builtin-pack-objects.c:try_delta():

	/*
	 * We do not bother to try a delta that we discarded
	 * on an earlier try, but only when reusing delta data.
	 */
	if (!no_reuse_delta && trg_entry->in_pack &&
	    trg_entry->in_pack == src_entry->in_pack)
		return 0;

After removing this part the shallow pack after clone is 2.6M, as it
should be.

The problem with this optimization is that it is only valid if we are
repacking either the same set of objects as we did earlier, or its
superset.  But if we are packing a subset of objects, there will be some
objects in that subset which were delta-compressed in the original pack,
but base objects for that deltas are not included in our subset -
therefore we will be unable to reuse existing deltas, and with that
optimization we will never try to use delta compression for these
objects.  (The optimization assumes that if we will try to use delta
compression, we will try mostly the same base objects as we have tried
when we made the existing pack, and therefore will likely get the same
result - which is close to the truth when we are doing "repack -a", but
is badly wrong when we are doing "git-upload-pack" with a large number
of common commits, and therefore are excluding a lot of objects.)

So any partial fetch (shallow or not) from a mostly packed repository
currently results in a suboptimal pack.  In fact, the fresh "repack -a
-d -f" is probably the worst case for subsequent fetch (not initial
clone) from that repository - objects for the most recent commit are
most likely to be stored without delta compression, and even if deltas
are used, they are likely in the wrong direction for someone who has an
older version and wants to update it.


> In any case, after this "shallow" stuff, repeated "fetch --depth
> 99" seems to fetch 0 object and 3400 objects alternately, and
> the shallow file alternates between 900 bytes and 11000 bytes.

I confirm this - different numbers, but the same problem...

--Signature=_Sun__12_Nov_2006_20_59_09_+0300_O3G6O24BS04ZM/dg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFV2DvW82GfkQfsqIRAqD4AJ4t/PG58sREC3G0LDEPKThLQBKSEQCeLz2Z
4dxL/YuS6fg+4nm1FOYE7/Q=
=qyVp
-----END PGP SIGNATURE-----

