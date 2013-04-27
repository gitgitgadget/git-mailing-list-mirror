From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] merge-tree: don't print entries that match "local"
Date: Sat, 27 Apr 2013 13:55:40 +0100
Message-ID: <20130427125540.GD472@serenity.lan>
References: <0a6a0c978569906b8c8d9209a85338554e503236.1364419952.git.john@keeping.me.uk>
 <7vk3osjwgv.fsf@alter.siamese.dyndns.org>
 <20130327225739.GT2286@serenity.lan>
 <20130328093458.GV2286@serenity.lan>
 <7vk3oe2j85.fsf@alter.siamese.dyndns.org>
 <20130407210751.GM2222@serenity.lan>
 <517BB81D.10909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Apr 27 14:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW4fW-0005hk-7M
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 14:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab3D0Mzv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 08:55:51 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:56257 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab3D0Mzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 08:55:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 3C6AB22C34;
	Sat, 27 Apr 2013 13:55:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J06BYPqLxE7M; Sat, 27 Apr 2013 13:55:49 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 908C322EC3;
	Sat, 27 Apr 2013 13:55:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <517BB81D.10909@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222641>

On Sat, Apr 27, 2013 at 01:35:57PM +0200, Ren=E9 Scharfe wrote:
> Am 07.04.2013 23:07, schrieb John Keeping:
> > The documentation says:
> >
> > 	the output from the command omits entries that match the
> > 	<branch1> tree.
> >
> > But currently "added in branch1" and "removed in branch1" (both whi=
le
> > unchanged in branch2) do print output.  Change this so that the
> > behaviour matches the documentation.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >   builtin/merge-tree.c  | 26 +++++++++++++-------------
> >   t/t4300-merge-tree.sh | 10 ----------
> >   2 files changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index bc912e3..ed25d81 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -155,6 +155,11 @@ static int same_entry(struct name_entry *a, st=
ruct name_entry *b)
> >   		a->mode =3D=3D b->mode;
> >   }
> >
> > +static int both_empty(struct name_entry *a, struct name_entry *b)
> > +{
> > +	return !(a->sha1 || b->sha1);
> > +}
> > +
> >   static struct merge_list *create_entry(unsigned stage, unsigned m=
ode, const unsigned char *sha1, const char *path)
> >   {
> >   	struct merge_list *res =3D xcalloc(1, sizeof(*res));
> > @@ -297,13 +302,10 @@ static void unresolved(const struct traverse_=
info *info, struct name_entry n[3])
> >   static int threeway_callback(int n, unsigned long mask, unsigned =
long dirmask, struct name_entry *entry, struct traverse_info *info)
> >   {
> >   	/* Same in both? */
> > -	if (same_entry(entry+1, entry+2)) {
> > -		if (entry[0].sha1) {
> > -			/* Modified identically */
> > -			resolve(info, NULL, entry+1);
> > -			return mask;
> > -		}
> > -		/* "Both added the same" is left unresolved */
> > +	if (same_entry(entry+1, entry+2) || both_empty(entry+0, entry+2))=
 {
>=20
> Shouldn't this zero be a one instead?

Yes, that's a typo.

> > +		/* Modified, added or removed identically */
> > +		resolve(info, NULL, entry+1);
> > +		return mask;
> >   	}
> >
> >   	if (same_entry(entry+0, entry+1)) {
> > @@ -319,12 +321,10 @@ static int threeway_callback(int n, unsigned =
long mask, unsigned long dirmask, s
> >   		 */
> >   	}
> >
> > -	if (same_entry(entry+0, entry+2)) {
> > -		if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
> > -			/* We modified, they did not touch -- take ours */
> > -			resolve(info, NULL, entry+1);
> > -			return mask;
> > -		}
> > +	if (same_entry(entry+0, entry+2) || both_empty(entry+0, entry+2))=
 {
>=20
> Otherwise the both_empty check here can be removed because we'd have=20
> already returned above if it was true.
>=20
> But do we actually want to resolve the removal of a file on both side=
s=20
> silently?  The added comment above says so, but the commit message=20
> doesn't mention it.

I think so.  The rule is that we omit things that match the branch1
tree.  So if it is removed in branch1 and there isn't a conflict with
branch2 then we shouldn't be printing any output.

> > +		/* We added, modified or removed, they did not touch -- take our=
s */
> > +		resolve(info, NULL, entry+1);
> > +		return mask;
> >   	}
> >
> >   	unresolved(info, entry);
> > diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> > index d0b2a45..bd43b3d 100755
> > --- a/t/t4300-merge-tree.sh
> > +++ b/t/t4300-merge-tree.sh
> > @@ -26,8 +26,6 @@ EXPECTED
> >
> >   test_expect_success 'file add !A, B' '
> >   	cat >expected <<\EXPECTED &&
> > -added in local
> > -  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> >   EXPECTED
> >
> >   	git reset --hard initial &&
> > @@ -38,9 +36,6 @@ EXPECTED
> >
> >   test_expect_success 'file add A, B (same)' '
> >   	cat >expected <<\EXPECTED &&
> > -added in both
> > -  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> > -  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> >   EXPECTED
> >
> >   	git reset --hard initial &&
> > @@ -181,9 +176,6 @@ AAA" &&
> >
> >   test_expect_success 'file remove A, !B' '
> >   	cat >expected <<\EXPECTED &&
> > -removed in local
> > -  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> > -  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
> >   EXPECTED
> >
> >   	git reset --hard initial &&
> > @@ -283,8 +275,6 @@ test_expect_success 'turn tree to file' '
> >   	test_commit "make-file" "dir" "CCC" &&
> >   	git merge-tree add-tree add-another-tree make-file >actual &&
> >   	cat >expect <<-\EOF &&
> > -	added in local
> > -	  our    100644 ba629238ca89489f2b350e196ca445e09d8bb834 dir/anot=
her
> >   	removed in remote
> >   	  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/pat=
h
> >   	  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d dir/pat=
h
> >
>=20
