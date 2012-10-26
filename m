From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move try_merge_command and checkout_fast_forward to
 libgit.a
Date: Fri, 26 Oct 2012 08:02:54 -0400
Message-ID: <20121026120253.GA1455@sigill.intra.peff.net>
References: <1350959091-30030-1-git-send-email-pclouds@gmail.com>
 <20121025094500.GJ8390@sigill.intra.peff.net>
 <CACsJy8D1_c9NP_nwvp6uJyKikG+_jqnm1hVEs_t_wnsYTLZ4Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 14:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRid8-0006SI-9W
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 14:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab2JZMDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 08:03:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37767 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465Ab2JZMDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 08:03:00 -0400
Received: (qmail 21969 invoked by uid 107); 26 Oct 2012 12:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 08:03:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 08:02:54 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8D1_c9NP_nwvp6uJyKikG+_jqnm1hVEs_t_wnsYTLZ4Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208435>

On Thu, Oct 25, 2012 at 07:50:26PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Thu, Oct 25, 2012 at 4:45 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Oct 23, 2012 at 09:24:51AM +0700, Nguyen Thai Ngoc Duy wrot=
e:
> >
> >> These functions are called in sequencer.c, which is part of
> >> libgit.a. This makes libgit.a potentially require builtin/merge.c =
for
> >> external git commands.
> >>
> >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
> >> ---
> >>  I made some unrelated changes in sequencer.c and this problem sho=
wn
> >>  up. merge-recursive.c is probably not the best place for these
> >>  functions. I just don't want to create merge.c for them.
> >
> > I'm fine with this conceptually, but merge-recursive really is the =
wrong
> > place. I'd much rather see a new merge.c to collect merge-related h=
elper
> > functions that are not strategy-specific.
>=20
> OK. I checked around for similar issues and found these used by
> libgit.a but stay in builtin/ instead:

Yeah, we have traditionally been kind of lazy about the distinction,
because it doesn't really matter for our build system (i.e., libgit.a i=
s
not _really_ a library, but just a convenience in the build process). S=
o
one option is just not caring about these. I'm also fine with fixing.

> estimate_bisect_steps: bisect.c and builtin/rev-list.c
> print_commit_list: bisect.c and builtin/rev-list.c
>=20
>  -> move them to bisect.c? another candidate is revision.c.

I'd probably say bisect.c for the first, and commit.c for the latter
(that is where commit_list functions are defined, and it is really abou=
t
that).

> fetch_pack: transport.c and builtin/fetch-pack.c
> send_pack: transport.c and builtin/send-pack.c
>=20
>  -> move them to transport.c? or new files fetch-pack.c and
> send-pack.c? I haven't check how many functions they may pull
> together.

I think I'd rather have fetch-pack.c and send-pack.c than putting them
into transport.c (which is getting kind of bloated already).

> setup_diff_pager: diff-no-index.c and builtin/diff.c
>=20
>  -> to diff-lib.c?

I'm not sure (to be honest, I am not even sure of the intended
difference between diff.c and diff-lib.c). That function is really not
for general diffing, but for diff-like commands. Probably it would be O=
K
in diff.c.

-Peff
