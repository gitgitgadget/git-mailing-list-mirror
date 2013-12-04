From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: Re: slow git-cherry-pick.
Date: Wed, 04 Dec 2013 13:46:43 +0100
Message-ID: <1827709.rD7YulLKCL@localhost.localdomain>
References: <2142926.gg3W3MsbJZ@localhost.localdomain> <87fvq9n154.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <CACsJy8Be2USmGA--FLT3LERTde327Ue65CCjoLHi5SzNzUX1dw@mail.gmail.com>
Reply-To: pawel.sikora@agmk.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 13:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoBr4-00045d-RS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 13:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289Ab3LDMq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 07:46:58 -0500
Received: from adamg.eu ([91.192.224.99]:46402 "EHLO adamg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab3LDMq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 07:46:58 -0500
Received: from mail.agmk.net ([91.192.224.71]:44019)
	by adamg.eu with esmtp (Exim 4.82)
	(envelope-from <pluto@agmk.net>)
	id 1VoBqu-0002Up-8P; Wed, 04 Dec 2013 13:46:52 +0100
Received: from localhost.localdomain (unknown [185.28.248.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 694B21EE6735;
	Wed,  4 Dec 2013 13:46:36 +0100 (CET)
User-Agent: KMail/4.11.3 (Linux/3.11.10-300.fc20.x86_64; KDE/4.11.3; x86_64; ; )
In-Reply-To: <CACsJy8Be2USmGA--FLT3LERTde327Ue65CCjoLHi5SzNzUX1dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238772>

On Wednesday 04 of December 2013 08:07:23 Duy Nguyen wrote:
> On Wed, Dec 4, 2013 at 3:13 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> > Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:
> >=20
> > Umm, there's a gem here that the thread missed so far:
> >> my git repo isn't very big[1] but it's checked out on the linear l=
vm
> >> where random i/o generally hurts and strace shows that current git
> >> version
> >> performs 2x{lstat}+1x{open,read,close} [2] on whole checkout befor=
e
> >>=20
> >            ^^^^^^^^^
> >=20
> > There's no reason why it should do the lstat() *twice* for every fi=
le.
> > But Pawe=C5=82 is right; the code path roughly goes like this:
> >=20
> > int cmd_cherry_pick(int argc, const char **argv, const char *prefix=
)
> > {
> > [...]
> >=20
> >         res =3D sequencer_pick_revisions(&opts);
> >=20
> > int sequencer_pick_revisions(struct replay_opts *opts)
> > {
> > [...]
> >=20
> >         read_and_refresh_cache(opts);
> >=20
> > [...]
> >=20
> >         return pick_commits(todo_list, opts);
> >=20
> > }
> >=20
> > static int pick_commits(struct commit_list *todo_list, struct repla=
y_opts
> > *opts) {
> > [...]
> >=20
> >         read_and_refresh_cache(opts);
> >=20
> > I'm too tired to dig further, but AFAICT it's just a rather obvious=
 case
> > of duplication of effort.
>=20
> That's something to optimize, but it's single commit picking,
> sequencer_pick_revisions() should call single_pick() instead of
> pick_commits().
>=20
> The read+close on the whole checkout looks like there's problem with
> refresh operation and git decides to read up and verify sha-1 by
> content. Pawel, if you run "strace git update-index --refresh" twice,
> does it still show 1 stat + 1 read for every entry on the second try?

the 'git update-index --refresh' runs quickly and strace shows only lst=
at()
on every file. i see no massive open/read actions in this case.

$ strace -o strace-try1.log git update-index --refresh
hmdb: needs update
$ strace -o strace-try2.log git update-index --refresh
hmdb: needs update

$ grep -c lstat strace-try1.log=20
33793
$ grep -c lstat strace-try2.log
33793

--=20
gpg key fingerprint =3D 60B4 9886 AD53 EB3E 88BB 1EB5 C52E D01B 683B 94=
11
