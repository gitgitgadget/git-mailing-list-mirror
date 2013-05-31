From: John Keeping <john@keeping.me.uk>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 09:32:52 +0100
Message-ID: <20130531083252.GA1072@serenity.lan>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
 <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
 <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
 <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
 <20130530193046.GG17475@serenity.lan>
 <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKlv-0003v8-Av
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab3EaIdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:33:12 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:54492 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3EaIdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:33:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 45A9622EE8;
	Fri, 31 May 2013 09:33:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C65UngKY3HAl; Fri, 31 May 2013 09:33:04 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A7B6122F7C;
	Fri, 31 May 2013 09:32:58 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226081>

On Fri, May 31, 2013 at 09:14:49AM +0100, Alex Benn=E9e wrote:
> On 30 May 2013 20:30, John Keeping <john@keeping.me.uk> wrote:
> > On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
> >> Alex Benn=E9e <kernel-hacker@bennee.com> writes:
> >>
> >> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
> >> >> Alex Benn=E9e <kernel-hacker@bennee.com> writes:
> > <snip>
> >> > Will it be loading the blob for every commit it traverses or jus=
t ones that hit
> >> > a tag? Why does it need to load the blob at all? Surely the comm=
it
> >> > tree state doesn't
> >> > need to be walked down?
> >>
> >> No, my theory is that you tagged *the blobs*.  Git supports this.
>=20
> Wait is this the difference between annotated and non-annotated tags?
> I thought a non-annotated just acted like references to a particular
> tree state?

No, this is something slightly different.  In Git there are four types
of object: tag, commit, tree and blob.  When you have a heavyweight tag=
,
the tag reference points at a tag object (which in turn points at
another object).  With a lightweight tag, the tag reference typically
points at a commit object.

However, there is no restriction that says that a tag object must point
to a commit or that a lightweight tag must point at a commit - it is
equally possible to point directly at a tree or a blob (although a lot
less common).

Thomas is suggesting that you might have a tag that does not point at a
commit but instead points to a blob object.

> > You can see if that is the case by doing something like this:
> >
> >     eval $(git for-each-ref --shell --format '
> >         test $(git cat-file -t %(objectname)^{}) =3D commit ||
> >         echo %(refname);')
> >
> > That will print out the name of any ref that doesn't point at a
> > commit.
>=20
> Hmm that didn't seem to work.

You mean there was no output?  In that case it's likely that all your
references do indeed point at commits.

>                               But looking at the output by hand I
> certainly have a mix of tags that are commits vs tags:
>=20
>=20
> 09:08 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
> | grep "commit" | wc -l
> 1345
> 09:12 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
> | grep -v "commit" | wc -l
> 66

This means that you have 1345 lightweight tags and 66 heavyweight tags,
assuming that all of the lines that don't say "commit" do say "tag".

By the way, I don't remember if you said which version of Git you're
using.  If it's an older version then it's possible that something has
changed.
