From: Jeff King <peff@peff.net>
Subject: Re: "add -p" + filenames with UTF-8 multibyte characters = "No
	changes"
Date: Sun, 15 Feb 2009 22:36:34 -0500
Message-ID: <20090216033634.GA12461@coredump.intra.peff.net>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com> <87tz6vr0g4.fsf@iki.fi> <2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com> <87prhjqzwb.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:38:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYuJ2-0000Pz-Fx
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 04:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbZBPDgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 22:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755546AbZBPDgh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 22:36:37 -0500
Received: from peff.net ([208.65.91.99]:56493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbZBPDgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 22:36:36 -0500
Received: (qmail 12809 invoked by uid 107); 16 Feb 2009 03:36:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 22:36:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 22:36:34 -0500
Content-Disposition: inline
In-Reply-To: <87prhjqzwb.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110126>

On Sun, Feb 15, 2009 at 09:11:00PM +0200, Teemu Likonen wrote:

> "core.quotepath=3Dfalse" is good for other purposes too. It prints UT=
=46-8
> filenames in diff headers in form that is actually readable. I think =
it
> would be better default.

I am not opposed to setting this as a default, but I think there may be
some encoding issues to be dealt with. At the very least, format-patch
generates messages without a content-type header. E.g.,:

  $ touch f=C3=B6=C3=B6 && git add . && git commit -m one
  $ echo content >f=C3=B6=C3=B6 && git commit -a -m two

  $ git format-patch --stdout HEAD^ | sed '/^$/q'

     vs

  $ git config core.quotepath false
  $ git format-patch --stdout HEAD^ | sed '/^$/q'

So now we have non-ascii in our email, but no header specifying
encoding. Previous experience has shown that intermediate MTAs (like
vger) will add their own header with whatever encoding they think is
sensible (in the case of vger, iso8859-1), corrupting the mail if they
guess wrong.

But what is the right encoding to specify? We can guess that it is
whatever the commit message is in (defaulting to utf-8). It is by no
means correct, but it would probably work pretty well in practice.

On the other hand, we already have the same problem for encoded file
_contents_. So maybe it is not a big problem in practice.

-Peff
