From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/3] Clean up builtin-update-ref's option parsing
Date: Sun, 25 May 2008 21:32:13 +0200
Message-ID: <20080525193213.GB5674@diana.vm.bytemark.co.uk>
References: <20080525161125.25087.18083.stgit@yoghurt> <20080525161435.25087.82683.stgit@yoghurt> <7vk5hii5wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 21:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0LyS-0005nm-PT
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbYEYTcq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 May 2008 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbYEYTcq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 15:32:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4983 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758318AbYEYTcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 15:32:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K0Lwz-0001lC-00; Sun, 25 May 2008 20:32:13 +0100
Content-Disposition: inline
In-Reply-To: <7vk5hii5wn.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82876>

On 2008-05-25 11:40:24 -0700, Junio C Hamano wrote:

> >  	if (delete) {
> > -		if (oldval)
> > +		if (argc !=3D 2)
> >  			usage_with_options(git_update_ref_usage, options);
> > -		return delete_ref(refname, sha1);
> > +		refname =3D argv[0];
> > +		value =3D NULL;
> > +		oldval =3D argv[1];
> > +	} else {
> > +		if (argc < 2 || argc > 3)
> > +			usage_with_options(git_update_ref_usage, options);
> > +		refname =3D argv[0];
> > +		value =3D argv[1];
> > +		oldval =3D argc > 2 ? argv[2] : NULL;
>
> When (argc =3D=3D 3), argv[2] has the old value string given on the
> command line. When (argc =3D=3D 2), argv[2] has the terminating NULL
> pointer. So either case you can safely use argv[2]. You do not allow
> other cases upfront, so I do not understand why you need this
> conditional expression?
>
> IOW, I do not see "an out-of-bounds argv access" in the original,
> and you are making this assignment harder to follow.

Mmmph. The problem here was that I didn't know that argv is
NULL-terminated. I just assumed it was bad to access anything beyond
the given array length as is usually the case in C. But I really
should have taken a hint from the existing code. Sorry for wasting
your time with this.

> >  	}
> > =20
> > +	if (value && *value && get_sha1(value, sha1))
> > +		die("%s: not a valid SHA1", value);
>=20
> Dropping *value in the sequence may fix it but I think this is wrong.
>=20
> We used to barf if you said "git update-ref refs/heads/master '' mast=
er"
> because it would be nonsense to give an empty string as the new value=
 of
> the ref, didn't we?  Doesn't this change break it?  Does your set of
> additional tests in [1/3] catch it?

Aaah, I see what you mean. Good point. The empty string should
obviously not be allowed as the new ref. In the original code it _is_
allowed as the _old_ value, and interpreted as 0{40}.

I'll update the series. With, among other things, a comment that
explains this.

                                 -+-

Many thanks for the review. I'll be back.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
