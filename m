From: Jeff King <peff@peff.net>
Subject: Re: tag format and tests
Date: Mon, 30 May 2011 12:02:03 -0400
Message-ID: <20110530160203.GB24431@sigill.intra.peff.net>
References: <db6ec478a7cb9b963d90651f5315ffec@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr
To: David Glesser <glesserd@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon May 30 18:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR4v8-0007w6-CO
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab1E3QCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 12:02:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37542
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410Ab1E3QCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 12:02:06 -0400
Received: (qmail 16814 invoked by uid 107); 30 May 2011 16:02:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 12:02:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 12:02:03 -0400
Content-Disposition: inline
In-Reply-To: <db6ec478a7cb9b963d90651f5315ffec@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174757>

On Mon, May 30, 2011 at 04:12:30PM +0200, David Glesser wrote:

> This error comes from libgit2 and how it writes the timestamp, see below:
> 
> $ cat tag && echo
> object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
> type blob
> tag hellotag
> tagger SpongeBob <spongebob.square@crusty-crabs.com> 0000000000 +0000
> 
> cheeseburger
> $ git mktag < tag
> 7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6
> $ echo 7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6 | git cat-file --batch
> 7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6 tag 154
> object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
> type blob
> tag hellotag
> tagger SpongeBob <spongebob.square@crusty-crabs.com> 0000000000 +0000
> 
> cheeseburger
> 
> 
> And now using libgit2 :
> 
> $ git2 mktag < tag
> 49bc784cd2071c97a14841b3eab1181dd1c8fbcd
> $ echo 49bc784cd2071c97a14841b3eab1181dd1c8fbcd | git cat-file --batch
> 49bc784cd2071c97a14841b3eab1181dd1c8fbcd tag 145
> object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
> type blob
> tag hellotag
> tagger SpongeBob <spongebob.square@crusty-crabs.com> 0 +0000
> 
> cheeseburger
> 
> Both formats are accepted by git.

Yes, both are valid timestamps. And git itself, when creating a tag via
"git tag", will not write silly leading zeroes. But in this test, we are
using mktag, which is creating a tag object from already-formatted
input. So the question is not whether the date-formatting is a problem,
but rather whether mktag should do be doing _any_ modification or
canonicalization of its input at all.

And I think the answer is "no", because we may be handing gpg-signed
contents to mktag, and any change could invalidate that signature. So
libgit2 is wrong to munge the data.

I imagine your code parses the buffer into a tag object, checks that it
parsed properly, then writes out that object. I think instead you need
to parse the buffer into a tag object, check that it parsed, and then
write the _original_ buffer into a tag object.

-Peff
