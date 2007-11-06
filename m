From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Tue, 6 Nov 2007 07:59:41 +0100
Message-ID: <20071106065941.GA6423@atjola.homenet>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpIPu-0002Vm-Hq
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbXKFG7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 01:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbXKFG7r
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 01:59:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:58789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755601AbXKFG7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 01:59:46 -0500
Received: (qmail invoked by alias); 06 Nov 2007 06:59:43 -0000
Received: from i577BBDA2.versanet.de (EHLO localhost) [87.123.189.162]
  by mail.gmx.net (mp003) with SMTP; 06 Nov 2007 07:59:43 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19GXV8BitlGBSckRS5C5Dq4AoZ3lAhDzuSwNbqE2B
	kP1D0MjRr/uFF/
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711052317170.4362@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63630>

On 2007.11.05 23:18:36 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 5 Nov 2007, Bj?rn Steinbrink wrote:
>=20
> > On 2007.11.05 13:57:53 -0500, Kristian H?gsberg wrote:
> >
> > > The shell script just has
> > >=20
> > > case "$all,$interactive,$also,$#" in
> > > *t,*t,*)
> > >         die "Cannot use -a, --interactive or -i at the same time.=
" ;;
> > >=20
> > > which doesn't seem to care about the value of $also.  As far as I=
=20
> > > understand git commit, it doesn't make sense to pass any of -a, -=
i, -o=20
> > > or --interactive at the same time so I guess I could join the che=
cks
> >=20
> > Note that there are only two commas. The asterisks catch everything=
 and
> > $# won't be "t", so that catches anything with at least two t's.
>=20
> So shouldn't it be
>=20
> 	if (!!all + !!interactive + !!also > 1)
>=20
> Hmm?

Ah, yeah, that's the short and sweet version, I always forget about the
conversion to bool giving you 0/1 values... ;-)

Note though, that Kristian had a similar check at the end of his email,
that included "only" (but lacked the bool conversion). The original
reason why I thought that it would be better was that for example
"git commit --all --only foo" didn't care about "only" at all. But that
actually was because the --all + paths usage check was broken. So the
fixed version actually refuses to use accept that, but with a (IMHO) no=
t
so good error message:

$ git commit -a -o file
Paths with -a does not make sense.

Given that some people are used to just pass -a all the time, they migh=
t
just automatically pass it together with -o. And I think that we
actually want to tell them that -a + -o makes no sense instead. Just
like we do for -a + -i, which is kind of the complementary usage error.

So I'd go for a correct version of Kristian's suggestion:

if (!!also + !!only + !!all + !!interactive > 1)
	die("Only one of --include/--only/--all/--interactive can be used.");

Bj=F6rn
