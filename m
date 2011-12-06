From: Jeff King <peff@peff.net>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Mon, 5 Dec 2011 20:07:49 -0500
Message-ID: <20111206010749.GB12760@sigill.intra.peff.net>
References: <201112041709.32212.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 02:07:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXjVk-0007r9-LI
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 02:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754Ab1LFBHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 20:07:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932724Ab1LFBHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 20:07:51 -0500
Received: (qmail 31446 invoked by uid 107); 6 Dec 2011 01:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 20:14:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 20:07:49 -0500
Content-Disposition: inline
In-Reply-To: <201112041709.32212.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186304>

On Sun, Dec 04, 2011 at 05:09:30PM +0100, Jakub Narebski wrote:

> The correct solution would be of course to respect `gui.encoding`
> per-repository config variable, and `encoding` gitattribute...
> though the latter is hampered by the fact that there is currently
> no way to read attribute with "git check-attr" from a given tree:
> think of a diff of change of encoding of a file!

We deal with the same problem at GitHub.

There really isn't a good way to specify per-file encodings. Something
like gui.encoding is too coarse. As you mentioned, we don't do per-tree
gitattribute lookups, so the encoding attribute has problems when the
encoding of a file changes. But even if we implemented them, you still
have the problem of getting a raw sha1 (e.g., git diff 9624865 e0a3260).
There's no way to look up attributes for that.

It would be nice if you could put an "encoding" header into the blob
object. You could use the .gitattributes in place at "git add" time to
set it. And then at lookup time, you either have the encoding, or you
assume it's in utf8 (if it isn't binary, of course).

But there's no room in the blob format for headers; the content starts
right after the size header.

You can get around this by searching the history for a tree that
contains the blob, and then checking the gitattributes. It's expensive,
but you could build a cache over time. However, it's not guaranteed to
provide a single answer; you could have multiple trees that mention the
blobs, each with different attributes.

And even if you implement all that, we have the problem that older blobs
won't have gotten an encoding header, even if they would have under the
new rules. So rather than assuming utf8, you have to make a guess
anyway.

At GitHub, we talked about a lot of these options and ended up just
using an encoding-detection library to make a best guess. It seems to
work well in practice, but it's only been deployed for a couple of
months.

-Peff
