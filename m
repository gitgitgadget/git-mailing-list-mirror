From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] clone: make 'git clone -c
 remote.origin.fetch=<refspec>' work
Date: Mon, 7 Mar 2016 10:33:05 -0500
Message-ID: <20160307153304.GA23010@sigill.intra.peff.net>
References: <1457313062-10073-1-git-send-email-szeder@ira.uka.de>
 <xmqqfuw3rrwb.fsf@gitster.mtv.corp.google.com>
 <20160307161931.Horde.TcdEVtHKgSMvScCDUKLclVq@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 16:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acx9m-00082F-9w
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 16:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbcCGPdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Mar 2016 10:33:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:55739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752858AbcCGPdI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 10:33:08 -0500
Received: (qmail 7158 invoked by uid 102); 7 Mar 2016 15:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 10:33:07 -0500
Received: (qmail 25935 invoked by uid 107); 7 Mar 2016 15:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 10:33:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2016 10:33:05 -0500
Content-Disposition: inline
In-Reply-To: <20160307161931.Horde.TcdEVtHKgSMvScCDUKLclVq@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288392>

On Mon, Mar 07, 2016 at 04:19:31PM +0100, SZEDER G=C3=A1bor wrote:

> >Even though I think the original description did not mean to include
> >the fetch refspecs when it talked about configuration taking effect,
> >I think what this change wants to do probably makes sense.
>=20
> Well, currently one would have to clone, set additional fetch refspec=
s,
> fetch again and repack.  Using 'git clone -c <refspecs>' would do it =
in
> a single step, requiring fewer commands, less time, less data transfe=
r
> and less disk space, which fits the justification of v1.7.7-rc0~90^2
> perfectly.

Yeah, I think your change very much fits the spirit of what the origina=
l
commit was trying for.

> >My knee-jerk reaction is to change the last paragraph of your log
> >message to read more like
> >
> >	Always read the fetch refspecs from the newly created config
> >	file, and use that for the initial fetching.
> >
> >and do so even when running with "--single-branch".
>=20
> Ok, will change the '--single-branch' codepath as well.
>=20
> But before doing so, to avoid a possible misunderstanding on my part:
> I'm not sure how literally you meant that "from the newly created
> config file" part, because it ignores refspecs specified via any
> other means, e.g. 'git -c <fetch-refspec> clone'.  I think the
> initial fetch should be no different from "regular" fetches, and
> should respect all configured fetch refspecs regardless where they
> come from.

IMHO, we should stick to the conceptual model that "git clone" is:

  git init
  git config ... ;# set up remote, etc
  git fetch
  git checkout ;# obviously not for --bare

The implementation has to diverge from that to do certain optimizations=
,
but absent any good reason not to, I think we should aim for behaving
"as if" those commands were run.

It certainly may produce surprising behavior at times, but at least it
is a conceptually simple mental model.  I do admit, though I haven't
thought hard enough to know whether there are any terrible gotchas
there.

-Peff
