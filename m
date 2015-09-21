From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add test_repo_expect_success for running tests in a
 new repository
Date: Mon, 21 Sep 2015 14:23:00 -0400
Message-ID: <20150921182300.GA32514@sigill.intra.peff.net>
References: <1442712302-7912-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 20:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze5k7-0002xB-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 20:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbbIUSXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 14:23:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:34044 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932550AbbIUSXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 14:23:03 -0400
Received: (qmail 29006 invoked by uid 102); 21 Sep 2015 18:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 13:23:02 -0500
Received: (qmail 29147 invoked by uid 107); 21 Sep 2015 18:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 14:23:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Sep 2015 14:23:00 -0400
Content-Disposition: inline
In-Reply-To: <1442712302-7912-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278323>

On Sun, Sep 20, 2015 at 08:25:02AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This could be convenient when tests are independent from the rest in =
the
> same file. Normally we would do this
>=20
> test_expect_success '...' '
> 	git init foo &&
> 	(
> 		cd foo &&
> 		<script>
> 	)
> '
>=20
> Now we can write a shorter version
>=20
> test_repo_expect_success '...' '
> 	<script>
> '

I dunno. Like Junio, I would prefer to see some proposed conversions to
be able to evaluate it.

But I do not find the first one all that bad. Sure, it is more lines,
but it is also a lot more _flexible_. You can "init --bare". You can
create a repo, do some setup in it, then do some more stuff outside, an=
d
then do some more setup inside it.

I also find it weird to happen at the "test_expect_success" layer,
rather than inside, as it seems somewhat orthogonal. E.g., how do I
expect failure?

It seems like it would be more flexible as a helper inside the test
snippet. But then I cannot think of a way to write it that is much
shorter than "(cd x && ...)".

=46or single git commands, I do find myself increasingly writing the fi=
rst
one as:

  test_expect_success '...' '
	git init foo &&
	git -C foo something
  '

which is pretty short and clear, I think. It also keeps ancillary files
at the top-level. So if you do:

  git clone . foo &&
  git rev-parse refs/heads/master >expect &&
  git -C foo rev-parse refs/remotes/origin/master >actual &&
  test_cmp expect actual

all of the "expect" and "actual" appear at the same top-level, and you
do not have to worry about mentioning "../expect", etc.

My biggest problem with that technique is that you cannot run test_*
functions this way, so:

  git -C foo test_commit bar

does not work, and you have to write:

  (cd foo && test_commit bar)

though IMHO that is not so bad.

Like I said, though, I'd reserve judgement until I saw some proposed
conversions.

If we have a whole series of tests that are all supposed to be inside
"foo", I wonder if it would be that distasteful to simply "cd foo", run
the tests, and then cd back. Of course we'd want to notice if the "cd"
failed for whatever reason. Perhaps something like:

  test_pushdir foo
  test_expect_success ...
  test_popdir

where "pushdir" would set an "error" flag if it fails, and any tests
inside it would auto-fail without running (which is much safer than
trying to run them in the wrong directory!).

This could also be extended to any other type of state mutation besides
"cd" if we wanted, though I do not have anything in mind (I guess we
could set env variables, but we usually just do that inside a
test_expect and assume it worked in subsequent tests).

-Peff
