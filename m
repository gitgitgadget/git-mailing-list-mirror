From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more than 2 arguments
Date: Tue, 29 Jul 2008 07:24:15 +0200
Message-ID: <200807290724.16157.chriscool@tuxfamily.org>
References: <20080728065023.743930d6.chriscool@tuxfamily.org> <7vabg2wovf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNheP-0004YP-04
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYG2FUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 01:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYG2FUd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:20:33 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:51340 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbYG2FUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 01:20:32 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 2C5D55FD5B;
	Tue, 29 Jul 2008 07:20:28 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 026105FD45;
	Tue, 29 Jul 2008 07:20:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vabg2wovf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90571>

Le lundi 28 juillet 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
>
> > +static struct commit *get_commit_reference(const char *arg)
> > +{
> > +	unsigned char revkey[20];
> > +	if (get_sha1(arg, revkey))
> > +		die("Not a valid object name %s", arg);
> > +	return lookup_commit_reference(revkey);
> > +}
>
> This returns a NULL when you feed a tree to the command, and...
>
> >  int cmd_merge_base(int argc, const char **argv, const char *prefix=
)
> >  {
> > +	struct commit **rev;
> >  	int show_all =3D 0;
> > +	int rev_nr =3D 0;
> >
> >  	git_config(git_default_config, NULL);
> >
> > @@ -38,15 +48,18 @@ int cmd_merge_base(int argc, const char **argv,
> > const char *prefix) usage(merge_base_usage);
> >  		argc--; argv++;
> >  	}
> > +	if (argc < 3)
> >  		usage(merge_base_usage);
> > +
> > +	rev =3D xmalloc((argc - 1) * sizeof(*rev));
> > +
> > +	do {
> > +		struct commit *r =3D get_commit_reference(argv[1]);
> > +		if (!r)
> > +			return 1;
>
> ... the command silently exits with 1.

In "master" there is:

	rev1 =3D lookup_commit_reference(rev1key);
	rev2 =3D lookup_commit_reference(rev2key);
	if (!rev1 || !rev2)
		return 1;
	return show_merge_base(rev1, rev2, show_all);

so I think you found a bug in the current code.
I will post a patch to fix it soon.

It will "die" (with an error =F9message) in case "lookup_commit_referen=
ce"=20
returns NULL. I hope it's ok.

Thanks,
Christian.
