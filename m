From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 13:18:12 -0500
Message-ID: <20141223181812.GA27078@peff.net>
References: <20141223084536.GA25190@peff.net>
 <54998949.9090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:18:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3U2E-0006Ut-3l
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbaLWSSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 13:18:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:56718 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751216AbaLWSSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:18:13 -0500
Received: (qmail 2678 invoked by uid 102); 23 Dec 2014 18:18:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 12:18:13 -0600
Received: (qmail 22826 invoked by uid 107); 23 Dec 2014 18:18:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 13:18:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 13:18:12 -0500
Content-Disposition: inline
In-Reply-To: <54998949.9090908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261757>

On Tue, Dec 23, 2014 at 04:24:57PM +0100, Torsten B=C3=B6gershausen wro=
te:

> Don't we have the same possible problem under NTFS?
> Under Linux + VFAT ?
> Under all OS + VFAT ?

I'm not sure what you mean.

This code path is _only_ about checking for HFS+-specific problems. We
check general case-insensitivity in another code path. And we check
NTFS-specific problems in another code path.

(Technically we could make a "check all" function that runs over the
data only once, which would be more efficient. But doing it this way
makes the code much easier to follow).

> And would it make sense to turn this
> >   return (out & 0xffffff00) ? out : tolower(out);
> into this:
> static ucs_char_t unicode_tolower(ucs_char_t ch) {
>    return (ch & 0xffffff00) ? ch : tolower(ch);
> }

Perhaps, but you would need a big warning at the top of that function
that is _only_ downcasing ASCII characters. I.e., it is fine for our us=
e
here, but you would not want other unicode-aware code to call it. The
next_hfs_char already has such a warning at the top.

> And what happens if I export NTFS to Mac OS X?
> (Other combinations possible)
> Shouldn't fsck under all OS warn for NTFS and hfs possible attacks ?

=46sck already warns for all system types, no matter what platform you'=
re
on. And we do case-insensitive blocking of ".git" entering the index fo=
r
all platforms.

We don't turn on filesystem-specific blocking of paths entering the
index on all platforms. You get HFS+ blocking by default on OS X, and
NTFS on Windows. If you are using HFS+ on Linux, you should set
core.protectHFS.

Possibly we should just turn on all checks everywhere. That would be a
safer default, at the cost to Linux folks of:

  1. Some slight inefficiency in each read-tree, as we have to do extra
     processing on each name.

  2. Some names would be disallowed that are otherwise OK. For the most
     part these are not names that would be used in practice, though
     (e.g., losing the ability to create ".git\u200c" is not a big loss
     to anyone). I think Git for Windows has started blocking other
     stuff like "CON" that is not specifically related to .git, though,
     and that is more plausible for somebody to use in real life.

-Peff
