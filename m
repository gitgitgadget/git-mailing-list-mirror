From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] Do not create commits whose message contains NUL
Date: Tue, 3 Jan 2012 15:03:31 -0500
Message-ID: <20120103200331.GG20926@sigill.intra.peff.net>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <20111213175932.GA1663@sigill.intra.peff.net>
 <1325435251.4752.104.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAaA-000146-K4
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab2ACUDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:03:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55543
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab2ACUDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:03:33 -0500
Received: (qmail 9573 invoked by uid 107); 3 Jan 2012 20:10:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 15:10:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 15:03:31 -0500
Content-Disposition: inline
In-Reply-To: <1325435251.4752.104.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187886>

On Sun, Jan 01, 2012 at 11:27:31AM -0500, Drew Northup wrote:

> I had already started experimenting with automatically detecting decent
> UTF-16 a long while back so that compatible platforms could handle it
> appropriately in terms of creating diffs and dealing with newline
> munging between platforms. There is no 100% sure-fire check for UTF-16
> if you don't already suspect it is possibly UTF-16. If we really want to
> check for possible UTF-16 specifically I can scrape out the check I
> wrote up and send it along.

I also looked into this recently. You can generally detect UTF-16 by the
BOM at the beginning of the file (which will also tell you the
endian-ness). I did a simple test by integrating it into the check for
binary-ness during diffs. However, as I recall, the result wasn't
particularly useful. Some of the diff code wasn't happy with the
embedded NUL bytes (i.e., there is code that assumes that NUL is the end
of a string). Not to mention that ascii newline (0x0a) can appear as
part of other characters in a wide encoding like utf-16. And since git
outputs straight ascii for all of the diff boilerplate, you end up with
a mish-mash of utf-16 and ascii (this is OK with utf-8, of course,
because utf-8 is a superset of ascii).

If anything, I think you would want to do something like "textconv" to
convert the utf-16 into utf-8, then diff that. Git won't do it
automatically based on encoding, but if you know the filenames of the
utf-16 files in your repository, you can do something like:

  echo 'foo.txt diff=utf16' >.gitattributes
  git config diff.utf16.textconv 'iconv -f utf16 -t utf8'

and get readable diffs. Of course you couldn't use that diff to apply a
patch, though.

I strongly suspect that not many people are really using git for utf-16
files. Git treats them as binary, which makes them unpleasant for
anything except simple storage.

> The is_utf8 check was not written to detect 100% valid UTF-8 per-se. It
> seems to me that it was written as part of the "is this a binary or not"
> check in the add/commit path.

We shouldn't care about binary file content at all in the add or commit
code paths. I would guess we do only if you are using auto-crlf (but
then, I don't think we care about utf8 in that cases, only whether line
endings should be converted or not).

We do check that the commit message itself is utf8, but only to generate
a warning that you should set i81n.commitencoding.

-Peff
