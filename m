From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Mon, 11 Feb 2008 08:22:08 +0100
Message-ID: <200802110822.08902.chriscool@tuxfamily.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vbq6oe98y.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOSuY-00025K-PX
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbYBKHQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 02:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYBKHQO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:16:14 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58226 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbYBKHQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 02:16:13 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 251DD1AB2DA;
	Mon, 11 Feb 2008 08:16:12 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D4D811AB2DF;
	Mon, 11 Feb 2008 08:16:11 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73473>

Le lundi 11 f=E9vrier 2008, Linus Torvalds a =E9crit :
> On Sun, 10 Feb 2008, Junio C Hamano wrote:
> >
> > My answer to your question is: "It is not different
> > from checking against NULL at all."
>
> Of course it is.
>
> Not using NULL means that things like
>
> 	strcmp()
> 	atoi()
> 	..
>
> all work and automatically get the right answer and don't need to car=
e.

I agree.

> Take a look at the NULL-compare patches. 90% of them are just noise.

That's right.

Now the 10% are only when we have a boolean variable and we want it to=20
be "false" when there is:

[foo]
	var =3D

while:

[foo]
	var

is considered "true".

And let's face it, it's not obvious at all why it should be false if th=
ere=20
is "var =3D" and true when there is only "var". Is it a Microsoft stand=
ard ?
Do we really care about it ?

I also doubt that many users willingly use "var =3D" to mean "false". I=
n my=20
opinion it is much more likely (95% against 5%) to be a typo than someo=
ne=20
so lazy as to prefer only "var =3D" over "var =3D false".

So let's do them (and ourself too) a favor and deprecate "var =3D" to m=
ean=20
false. I will post my patch to do this.

By the way deprecating does not mean breaking it and not fixing where i=
t=20
breaks. It just means we think it's bad and it should not be used. We c=
an=20
even decide to keep the same boolean meaning (that is "false") for "var=
 =3D"
latter if we have a good way to deal with the cruft and if we really do=
n't=20
want to break things.

And even if we latter change "var =3D" to mean "true", we can still kee=
p a=20
warning by checking using Linus' trick:

int git_config_bool(const char *name, const char *value)
{
        if (value =3D=3D config_true)
                return 1;
        if (!*value) {
                fprintf(stderr,
                        "Warning: using an empty value for boolean conf=
ig "
                        "variables is deprecated and dangerous.\n"
                        "An empty value now means 'true' as a "
                        "boolean, but meant 'false' in previous git "
                        "versions!\n"
                        "Please consider using a 'true' (or 'false') va=
lue "
                        "explicitely for variable '%s', so that your "
                        "config is git version independant. "
                        "You can do that using for example:\n"
                        "\tgit config %s true\n", name, name);
               return 1;
       }
       if (!strcasecmp(value, "true") || !strcasecmp(value, "yes"))
               return 1;
       if (!strcasecmp(value, "false") || !strcasecmp(value, "no"))
		return 0;
	return git_config_int(name, value) !=3D 0;
}

Or we could even (using Linus' trick) make it an error and just "die" i=
n=20
this case.

Christian (now urgently looking for a flame proof suit).
