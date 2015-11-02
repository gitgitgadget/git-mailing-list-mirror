From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] setup: do not create $X/gitdir unnecessarily when
 accessing git file $X
Date: Mon, 2 Nov 2015 15:35:07 -0500
Message-ID: <20151102203507.GB10722@sigill.intra.peff.net>
References: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
 <1446491306-13493-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rappazzo@gmail.com, kyle@kyleam.com, sunshine@sunshineco.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:35:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtLp3-0008Q5-1u
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbKBUfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 15:35:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:51637 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752973AbbKBUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:35:09 -0500
Received: (qmail 13511 invoked by uid 102); 2 Nov 2015 20:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 14:35:09 -0600
Received: (qmail 16810 invoked by uid 107); 2 Nov 2015 20:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 15:35:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 15:35:07 -0500
Content-Disposition: inline
In-Reply-To: <1446491306-13493-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280715>

On Mon, Nov 02, 2015 at 08:08:26PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> $X/gitdir is created, or refreshed, in order to keep a linked worktre=
e
> from being pruned. But while git file is used as the foundation for
> linked worktrees, it's used for other purposes as well and we should
> not create $X/gitdir in those cases.
>=20
> Tighten the check. Only update an existing file, which is an
> indication this is a linked worktree.

Hrm. I think this fixes the immediate problem, but it seems odd for us
to rely on "does the file exist"[1].

We trigger this code unconditionally from read_gitfile_gently(). But
=2Egit files are a general-purpose mechanism.  Shouldn't we be doing th=
is
only if we suspect we are working with a linked working tree directory
in the first place?

Or we do not know at all, because we are operating in the linked dir,
and seeing the presence of the "gitdir" file is the only way we say "ah=
,
it turns out we are linked, so we should take the opportunity to do som=
e
maintenance"?

If the latter, then I guess this is the only way to do it. It does seem
a bit strange to me that an otherwise read-only operation (reading the
file) might involve writing[2].

-Peff

[1] You check only !stat(), so it is not really "does it exist", but
    "can we stat it". I think that is OK, because this is an
    opportunistic update, and failing the stat should just mean we don'=
t
    do the update.

[2] I suspect this code should use write_file_gently(). What happens if
    I have a read-only linked checkout?
