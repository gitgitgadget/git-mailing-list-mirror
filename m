From: Jeff King <peff@peff.net>
Subject: Re: git format-patch doesn't add Content-type for UTF-8 diffs
Date: Mon, 30 Jun 2014 13:30:52 -0400
Message-ID: <20140630173052.GB16747@sigill.intra.peff.net>
References: <53B127DD.8000807@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Eggert <eggert@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1fPu-0001Wi-39
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbaF3Ray convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 13:30:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:53699 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751184AbaF3Rax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:30:53 -0400
Received: (qmail 9542 invoked by uid 102); 30 Jun 2014 17:30:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 12:30:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 13:30:52 -0400
Content-Disposition: inline
In-Reply-To: <53B127DD.8000807@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252693>

On Mon, Jun 30, 2014 at 02:03:25AM -0700, Paul Eggert wrote:

> I've been having trouble sending my Git-generated patches to the tz m=
ailing
> list.  Patches containing UTF-8 text are garbled, e.g., if you visit
> <http://mm.icann.org/pipermail/tz/2014-June/021086.html> you'll see
> "=C3=83=C5=93r=C3=83=C2=BCmqi" where the patch actually had "=C3=9Cr=C3=
=BCmqi".
>=20
> I've tracked this down to the fact that "git format-patch" isn't outp=
utting
> a Content-Type: line in the outgoing email.  I thought it was suppose=
d to do
> that; the man page implies that it does.

format-patch will add a content-type header if the commit message
contains non-ascii characters, and is marked as an alternate encoding
(usually this is utf8, but you can use i18n.commitEncoding to store the=
m
in a different format).

However, it doesn't look at the filenames or diff contents at all. If i=
t
were to do so, it would have to guess at the correct encoding, since gi=
t
doesn't know anything about the encoding of filenames or contents.
Worse, you could actually have several different encodings, across
multiple files in the same diff.

Typically, the next stage in the pipeline is to give the output to
send-email, or to a MUA. Send-email will detect high-bit characters in
this case and ask you which encoding you want. Many MUAs will do some
kind of auto-detection and fill in the content-type (e.g., I know that
mutt handles this correctly).

How do you send the mails after they come out of format-patch?

> Here's how I can reproduce the bug with the git 1.9.3 that's shipped =
with
> Fedora 20.  Notice that the patch is missing the line "Content-Type:
> text/plain; charset=3DUTF-8" that the git-format-patch man page impli=
es it
> should be generating, and this causes the ICANN email software to
> misinterpret the patch's character set encoding.
> [...]

Thanks for the reproduction recipe. While I think we have to accept tha=
t
some hard cases (e.g., multiple encodings in a single diff) can't be
handled cleanly, it would be really nice if this all-utf8 case worked
out of the box. And perhaps the complex cases could use binary diffs
when we see multiple encodings.

One tricky thing about the implementation is that we stream the output
from format-patch, and write the content-type header (if any) before we
start opening the blobs for diff.

I wonder if it would be enough to do:

  1. Always add a content-type header, even if the commit is utf-8 and
     contains only ascii characters. This _shouldn't_ hurt anything,
     though I suppose it would if you have latin1 (for example) commit
     messages and did not correctly set the encoding header in your
     commits.

  2. When producing diff header lines do not respect core.quotepath if
     the filename does is not valid for the encoding we claimed earlier=
=2E

  3. When producing lines of textual diff, use a binary diff if the
     contents are not valid for the encoding we claimed earlier.

That would make the utf-8 case "just work", and would prevent us from
ever sending malformed contents (i.e., mismatched encodings in the
commit message and diff contents). However, it is not perfect:

  1. Right now if you send a diff for a latin1 file but do not use any
     non-ascii characters in your commit message (and do not set
     i18n.commitEncoding, so it is "utf8"), you get no claimed encoding
     in the email. If your receiving end is OK with that, everything
     works, and you get to see text diffs.

     So my scheme would be a slight regression there. But it is somewha=
t
     of an accident waiting to happen. If you ever use a utf-8 characte=
r
     in your commit message, that particular email will be marked as
     utf-8, and your diff will be broken.

  2. We can only check "is it valid?" for the encoding. That works well
     with utf-8, which has rules. But for something like latin1 versus
     another "use a code page for the high-bit bytes" type of encoding,
     we cannot really tell the difference. However, I do not think we
     are making anything _worse_ there. You'd already get mojibake in
     such a case.

-Peff
