From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: regression in  92392b4
Date: Tue, 22 Jul 2008 19:41:08 -0500
Message-ID: <20080723004108.GB14668@spearce.org>
References: <20080722231745.GD11831@artemis.madism.org> <alpine.DEB.1.00.0807230033000.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSQl-00042E-3U
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbYGWAlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2008 20:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbYGWAlK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:41:10 -0400
Received: from george.spearce.org ([209.20.77.23]:43138 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYGWAlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:41:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6043C383A5; Wed, 23 Jul 2008 00:41:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807230033000.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89579>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 23 Jul 2008, Pierre Habouzit wrote:
>=20
> >   Hi, here is a manual painful down-secting (opposed to a bisect ;P=
) I
> > did, since git in next cannot fetch on a regular basis for me. The
> > culprit seems to be commit  92392b4:
> >=20
> >     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b=
4...>=E2=94=80=E2=94=80
> >     =E2=94=94[artemis] git fetch
> >     remote: Counting objects: 461, done.
> >     remote: Compressing objects: 100% (141/141), done.
> >     remote: Total 263 (delta 227), reused 155 (delta 121)
> >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> >     fatal: Out of memory, malloc failed
> >     fatal: index-pack failed
> >     [2]    16674 abort (core dumped)  git fetch
=2E..
>=20
> Just a guess:
=2E..
> diff --git a/index-pack.c b/index-pack.c
> index ac20a46..19c39e5 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -257,6 +257,7 @@ static void unlink_base_data(struct base_data *c)
>  		base_cache =3D NULL;
>  	if (c->data) {
>  		free(c->data);
> +		c->data =3D NULL;
>  		base_cache_used -=3D c->size;
>  	}
>  }

Oh.  This is a pointless assignment.  If you look at any call sites
for unlink_base_data() you will find that the struct passed in as
"c" here is going out of scope after unlink_base_data() returns.  In
no such case does the value of c->data get tested once this free is
complete.

We need the if (c->data) guard because we only want to decrement
base_cache_used if the memory is still allocated.  It may have been
released earlier, in which case base_cache_used has already been
decreased and we don't want to double-decrement it.

This patch makes the code more obvious, so Ack I guess, but it is
not a solution to Pierre's woes.  Something else is wrong.

Reading above shows we got a "fatal: Out of memory, malloc failed"
right before the segfault.  What's odd is we segfaulted after we
ran out of memory and should have die'd.

There's at least two bugs in the above output:

a) index-pack ran out of memory on a small pull (95 KiB).
b) fetch segfaulted when index-pack failed.

And this patch will unfortunately address neither of them.  :-|

I've had a long past couple of days, and another one tomorrow.
I'm not going to be able to debug this myself until perhaps Thursday
or Friday.  Sorry.  If nobody beats me to it, I will put this on
the top of the pile and try to fix it once I get back online at my
new home.

--=20
Shawn.
