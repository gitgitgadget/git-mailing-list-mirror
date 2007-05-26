From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] improve delta long block matching with big files
Date: Sat, 26 May 2007 17:19:09 +0200
Message-ID: <20070526151909.GA9429@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 26 17:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hry36-0005f0-Il
	for gcvg-git@gmane.org; Sat, 26 May 2007 17:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbXEZPTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 26 May 2007 11:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbXEZPTO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 11:19:14 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60498 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbXEZPTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 11:19:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id EAF977B77D3D;
	Sat, 26 May 2007 17:19:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80u+xjSnThA1; Sat, 26 May 2007 17:19:09 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 7DDAA73D8DD3; Sat, 26 May 2007 17:19:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48476>

Nicolas Pitre wrote:
> Martin Koegler noted that create_delta() performs a new hash lookup
> after every block copy encoding which are currently limited to 64KB.
>=20
> In case of larger identical blocks, the next hash lookup would normal=
ly
> point to the next 64KB block in the reference buffer and multiple blo=
ck
> copy operations will be consecutively encoded.
>=20
> It is however possible that the reference buffer be sparsely indexed =
if
> hash buckets have been trimmed down in create_delta_index() when hash=
ing
> of the reference buffer isn't well balanced.  In that case the hash
> lookup following a block copy might fail to match anything and the fa=
ct
> that the reference buffer still matches beyond the previous 64KB bloc=
k
> will be missed.
>=20
> Let's rework the code so that buffer comparison isn't bounded to 64KB
> anymore.  The match size should be as large as possible up front and
> only then should multiple block copy be encoded to cover it all.
> Also, fewer hash lookups will be performed in the end.
>=20
> According to Martin, this patch should reduce his 92MB pack down to 7=
5MB
> with the dataset he has.
>=20
> Tests performed on the Linux kernel repo show a slightly smaller pack=
 and
> a slightly faster repack.
>
Acked-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
---

The patch results in a 75 MB pack file for my repository and is
faster:

Total 6452 (delta 4581), reused 1522 (delta 0)
10073.11user 5200.33system 4:14:36elapsed 99%CPU (0avgtext+0avgdata 0ma=
xresident)k
0inputs+0outputs (0major+1371504760minor)pagefaults 0swaps

mfg Martin K=F6gler
