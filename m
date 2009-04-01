From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Wed, 1 Apr 2009 08:09:40 +0200
Message-ID: <200904010809.41110.chriscool@tuxfamily.org>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <200903310845.23674.chriscool@tuxfamily.org> <alpine.DEB.1.00.0903311117400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:12:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LotgW-0007Iz-NY
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 08:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbZDAGKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZDAGKs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 02:10:48 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60312 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbZDAGKr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 02:10:47 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 29308D4804B;
	Wed,  1 Apr 2009 08:10:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 45D6CD480C3;
	Wed,  1 Apr 2009 08:10:34 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903311117400.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115339>

Le mardi 31 mars 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Tue, 31 Mar 2009, Christian Couder wrote:
> > Le lundi 30 mars 2009, Johannes Schindelin a =E9crit :
> > > On Mon, 30 Mar 2009, Christian Couder wrote:
> > > > Le jeudi 26 mars 2009, Junio C Hamano a =E9crit :
> > > > > I've learned to suspect without reading a qsort() callback th=
at
> > > > > does not derefence its arguments.  Is this doing the right th=
ing?
> > > >
> > > > I think so.
> > >
> > > I suspect something much worse: you are trying to build a list of
> > > sha1s of commits that need to be skipped, later to look up every
> > > commit via binary search.
> > >
> > > But it has been proven a lot of times that using a hash set is
> > > superior to that approach, and even better: we already have the
> > > framework in place in the form of struct decorate.
> >
> > I had a look, and "struct decorate" can be used to store objects, b=
ut I
> > want to store only sha1s.
>
> No, you want to _look up_ sha1s.  And struct decorate is not about
> storing objects, but to attach things to objects.=20

The problem is that I don't have any object to attach things to when I =
read=20
the bisect skip refs. I just need to store the sha1 from the skip refs =
in=20
some sha1 container.

Here is the related code:

static int register_ref(const char *refname, const unsigned char *sha1,
			int flags, void *cb_data)
{
	if (!strcmp(refname, "bad")) {
		...
	} else if (!prefixcmp(refname, "good-")) {
		...
	} else if (!prefixcmp(refname, "skip-")) {
		ALLOC_GROW(skipped_sha1, skipped_sha1_nr + 1,
			   skipped_sha1_alloc);
		hashcpy(skipped_sha1[skipped_sha1_nr++], sha1);
	}

	return 0;
}

static int read_bisect_refs(void)
{
	return for_each_bisect_ref(register_ref, NULL);
}

Best regards,
Christian.
