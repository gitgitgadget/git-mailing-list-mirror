From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Wed, 16 Mar 2016 12:55:28 -0400
Message-ID: <20160316165527.GA4039@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
 <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
 <xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:55:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEjP-0000Uw-PY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbcCPQzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 12:55:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:60656 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752890AbcCPQzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:55:31 -0400
Received: (qmail 6973 invoked by uid 102); 16 Mar 2016 16:55:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 12:55:30 -0400
Received: (qmail 15460 invoked by uid 107); 16 Mar 2016 16:55:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 12:55:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 12:55:28 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288993>

On Thu, Mar 17, 2016 at 12:40:59AM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> > Is it better to have the fallback in /tmp, and not in
> > ~/.git-credential-cache/, and why?
> >
> > Is it because the wish is to always use /tmp/git-$uid/ as a fallbac=
k
> > for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
> > is specific to the credential-cache and would look strange if we
> > used it for other "runtime" things)?
>=20
> Yes, I mean to use it as a general fallback for git.
>=20
> xdg base dir spec does not specify where to fallback when
> $XDG_RUNTIME_DIR is not defined. It just says:
>=20
> If $XDG_RUNTIME_DIR is not set applications should fall back to
> a replacement directory with similar capabilities and print a warning
> message. Applications should use this directory for communication
> and synchronization purposes and should not place larger files in it,
> since it might reside in runtime memory and cannot necessarily be
> swapped out to disk.
>=20
> tmpfs is just like what it describes. And many other applications
> put socket under which, such as tmux.
>=20
> On the other hand, I think, falling back to $HOME/.git-credential-cac=
he/socket
> doesn't make any sense for back-compability cannot be ensured.

If we are going to use a publicly accessible directory like /tmp, I
think we need to start worrying about tmp-races with malicious users.

Right now we make sure that an existing socket directory is mode 0700.
That's just a courtesy check that the user didn't create it themselves
with a permissive mode. But we don't check the owner of the directory,
and our check is racy with accessing the directory.

So if we blindly use an existing /tmp/git-$uid, I think an attacker can
race with:

    dir=3D/tmp/git-$victimuid
    mkdir $dir
    while true; do
        chmod 0700 $dir
	chmod 0777 $dir
    done

If the victim does their mode check while the 0700 is in effect, but
then creates the socket during the 0777 moment, they won't notice
anything amiss. And the attacker will have access to their credential
socket.

This is a classic /tmp race.  I imagine it's less of an issue in this
day and age when people mostly have their own machines and their own
/tmp, but we still should not recreate the mistakes of the past.

-Peff
