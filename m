From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Wed, 27 May 2009 07:12:36 +0200
Message-ID: <200905270712.36866.chriscool@tuxfamily.org>
References: <20090517153307.6403.73576.> <4A1A621E.10703@viscovery.net> <alpine.DEB.1.00.0905251140320.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 27 07:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9BRn-0002xG-Fs
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 07:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105AbZE0FMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 01:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbZE0FMt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 01:12:49 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:53413 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075AbZE0FMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 01:12:46 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1CEAB4C80BD;
	Wed, 27 May 2009 07:12:39 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 13CAC4C80B9;
	Wed, 27 May 2009 07:12:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0905251140320.4288@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120029>

Hi,

Le Monday 25 May 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Mon, 25 May 2009, Johannes Sixt wrote:
> > Christian Couder schrieb:
> > > +static void unparse_commit_list(struct commit_list *list)
> > > +{
> > > +	for (; list; list =3D list->next)
> > > +		unparse_commit(list->item);
> > > +}
> > > +
> > > +void unparse_commit(struct commit *item)
> > > +{
> > > +	item->object.flags =3D 0;
> > > +	item->object.used =3D 0;
> > > +	if (item->object.parsed) {
> > > +		item->object.parsed =3D 0;
> > > +		if (item->parents) {
> > > +			unparse_commit_list(item->parents);
> > > +			free_commit_list(item->parents);
> > > +			item->parents =3D NULL;
> > > +		}
> > > +	}
> > > +}
> >
> > I see a recursion here. Could this not overflow the stack if there =
is a
> > long ancestry chain?
>
> You mean tail recursion, i.e. something like
>
> void unparse_commit(struct commit *item)
> {
> 	item->object.flags =3D 0;
> 	item->object.used =3D 0;
> 	while (item->object.parsed) {
> 		struct commit *first;
>
> 		item->object.parsed =3D 0;
> 		if (!item->parents)
> 			break;
> 		if (item->parents->next)
> 			unparse_commit_list(item->parents->next);
> 		first =3D item->parents->item;
> 		free_commit_list(item->parents);
> 		item->parents =3D NULL;
> 		item =3D first;
> 	}
> }

Yes, it is better like this. Thanks and sorry about responding late.

> However, I am a bit concerned that this function is dangerous, as it =
just
> assumes that there is no reference to the commits left, which assumpt=
ion
> is _very_ easy to break by mistake.

Anyway I will send a 2 patch series that will use clear_commit_marks in=
stead=20
of this function.

Thanks,
Christian.
