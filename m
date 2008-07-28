From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more than 2 arguments
Date: Mon, 28 Jul 2008 07:49:35 +0200
Message-ID: <200807280749.35278.chriscool@tuxfamily.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLZM-0000V0-02
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbYG1Fpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 01:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbYG1Fpv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:45:51 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:43576 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbYG1Fpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 01:45:50 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 7242A32A7DC;
	Mon, 28 Jul 2008 07:45:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 34A6F32A7CC;
	Mon, 28 Jul 2008 07:45:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90407>

Le dimanche 27 juillet 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Sun, 27 Jul 2008, Christian Couder wrote:
> > diff --git a/builtin-merge-base.c b/builtin-merge-base.c
> > index 1cb2925..f2c9756 100644
> > --- a/builtin-merge-base.c
> > +++ b/builtin-merge-base.c
> > @@ -38,15 +48,22 @@ int cmd_merge_base(int argc, const char **argv,
> > const char *prefix) usage(merge_base_usage);
> >  		argc--; argv++;
> >  	}
> > -	if (argc !=3D 3)
> > +	if (argc < 3)
> >  		usage(merge_base_usage);
> > -	if (get_sha1(argv[1], rev1key))
> > -		die("Not a valid object name %s", argv[1]);
> > -	if (get_sha1(argv[2], rev2key))
> > -		die("Not a valid object name %s", argv[2]);
> > -	rev1 =3D lookup_commit_reference(rev1key);
> > -	rev2 =3D lookup_commit_reference(rev2key);
> > -	if (!rev1 || !rev2)
> > +
> > +	rev1 =3D get_commit_reference(argv[1]);
> > +	if (!rev1)
> >  		return 1;
>
> Why do you special case rev1?  Is it so special?  Just handle it toge=
ther
> with all of the other arguments!
>
> IOW have one commit array, and do not call it "prev".

Ok, I have done that in v3.

> > -	return show_merge_base(rev1, rev2, show_all);
> > +	argc--; argv++;
> > +
> > +	do {
> > +		struct commit *rev2 =3D get_commit_reference(argv[1]);
> > +		if (!rev2)
> > +			return 1;
> > +		ALLOC_GROW(prev2, prev2_nr + 1, prev2_alloc);
> > +		prev2[prev2_nr++] =3D rev2;
> > +		argc--; argv++;
> > +	} while (argc > 1);
>
> Now, this is ugly.  You know beforehand the _exact_ number of argumen=
ts,
> and yet you dynamically grow the array?

You are right. I guess I dealt too much with complex parsing of argumen=
ts=20
where you can have options everywhere, and perhaps I also felt somewhat=
=20
guilty for not having used ALLOC_GROW before, or something.

> Also, why do you use a do { }=20
> while(), when a for () would be much, much clearer?

Well, we already know that there are at least 2 commits to parse, so it=
=20
feels a little bit wastefull to check first again. Also the code to par=
se=20
the [--all|-a] option before use a while loop with "argc--; argv++;" at=
 the=20
end, so I think it is more coherent like that.

Thanks,
Christian.

> BTW I seem to recall that get_merge_bases_many() was _not_ the same a=
s
> get_merge_octopus().  Could you please remind me what _many() does?
>
> Ciao,
> Dscho
