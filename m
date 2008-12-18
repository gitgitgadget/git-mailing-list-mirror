From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new   'strbuf_readlink()'
Date: Thu, 18 Dec 2008 18:41:43 +0100
Message-ID: <494A8B57.6070106@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow> <alpine.LFD.2.00.0812180851120.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Burton <markb@ordern.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 18:43:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMtx-00054w-MP
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 18:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYLRRlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 12:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYLRRlv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 12:41:51 -0500
Received: from india601.server4you.de ([85.25.151.105]:35237 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLRRlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 12:41:51 -0500
Received: from [10.0.1.101] (p57B7E582.dip.t-dialin.net [87.183.229.130])
	by india601.server4you.de (Postfix) with ESMTPSA id 15B042F805F;
	Thu, 18 Dec 2008 18:41:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.LFD.2.00.0812180851120.14014@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103476>

Linus Torvalds schrieb:
>=20
> On Thu, 18 Dec 2008, Mark Burton wrote:
>> Does it need a cast on some architectures?
>=20
> Gaah. My bad. It should work fine ("unsigned long" is physically the =
same=20
> type as "size_t" in your case), but on 32-bit x86, size_t is generall=
y=20
> "unsigned int" - which is the same physical type there (both int and =
long=20
> are 32-bit) but causes a valid warning.
>=20
> I think we should just make the "size" member "size_t". I use "unsign=
ed=20
> long" out of much too long habit, since we traditionally avoided "siz=
e_t"=20
> in the kernel due to it just being another unnecessary architecture-=20
> specific detail.
>=20
> So the proper patch is probably just the following. Sorry about that,
>=20
> 		Linus
> ---
>  diffcore.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/diffcore.h b/diffcore.h
> index 5b63458..16a73e6 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -30,7 +30,7 @@ struct diff_filespec {
>  	void *data;
>  	void *cnt_data;
>  	const char *funcname_pattern_ident;
> -	unsigned long size;
> +	size_t size;
>  	int count;               /* Reference count */
>  	int xfrm_flags;		 /* for use by the xfrm */
>  	int rename_used;         /* Count of rename users */

Yes, but now I get two new warnings:

diff.c: In function `diff_populate_filespec':
diff.c:1809: warning: passing arg 2 of `sha1_object_info' from
incompatible pointer type
diff.c:1811: warning: passing arg 3 of `read_sha1_file' from
incompatible pointer type

If we followed that way along we'd convert just about everything to use
size_t, which is going a bit too far during the -rc phase..

Ren=E9


PS: In the other subthread, I was missing the "t" in "st" in line 1757,
not 1760.  Ahem.
