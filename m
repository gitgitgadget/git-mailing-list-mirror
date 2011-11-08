From: Jeff King <peff@peff.net>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 8 Nov 2011 11:10:15 -0500
Message-ID: <20111108161014.GA14049@sigill.intra.peff.net>
References: <4EB85768.1060508@avtalion.name>
 <20111107225508.GB28188@sigill.intra.peff.net>
 <CAKPyHN1cqG9-g1Q4iGbUOtfiXLc6EPcFH2cWNCep3af4cTdzSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ori Avtalion <ori@avtalion.name>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoFl-0001bR-7w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab1KHQKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 11:10:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37077
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab1KHQKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 11:10:19 -0500
Received: (qmail 5376 invoked by uid 107); 8 Nov 2011 16:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 11:10:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 11:10:15 -0500
Content-Disposition: inline
In-Reply-To: <CAKPyHN1cqG9-g1Q4iGbUOtfiXLc6EPcFH2cWNCep3af4cTdzSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185092>

On Tue, Nov 08, 2011 at 09:52:26AM +0100, Bert Wesarg wrote:

> On Mon, Nov 7, 2011 at 23:55, Jeff King <peff@peff.net> wrote:
> > In the general case, you can't represent all failed hunks with conflict
> > markers, can you? I'm thinking something where we couldn't find any
> > relevant context. You know the lines from the original patch from the
> > hunk header, so you can drop the failed content from the patch in the
> > right spot. But how do you know how big a conflict marker to make for
> > the "current" side? The same number of lines as were in the hunk?
> > I think you'd end up with confusing conflict markers.
> 
> GNU patch can produce conflict markers with the --merge option.

Hmm. Yeah, it does work, but as I feared, it can produce pretty awful
conflicts. Try this fairly straightforward setup (3 lines changed in the
middle of a file):

  git init &&
  seq 1 10 >file && git add file && git commit -m base &&
  sed -i '3,5s/$/ master/' file && git commit -a -m master &&
  git checkout -b other HEAD^ &&
  sed -i '3,5s/$/ other/' file && git commit -a -m other

You can see what a real merge looks like:

  git merge master &&
  $EDITOR file

which is:

  1
  2
  <<<<<<< HEAD
  3 other
  4 other
  5 other
  =======
  3 master
  4 master
  5 master
  >>>>>>> master
  6
  7
  8
  9
  10

If you use "patch --merge", you get the same thing. Which is good. But
now try it with 10 lines changed out of 100:

  rm -rf .git
  git init &&
  seq 1 100 >file && git add file && git commit -m base &&
  sed -i '50,60s/$/ master/' file && git commit -a -m master &&
  git checkout -b other HEAD^ &&
  sed -i '50,60s/$/ other/' file && git commit -a -m other

Doing a merge will get you the same sensible results. But "patch
--merge" produces:

 ...
 45
 46
 <<<<<<<
 =======
 47
 48
 49
 50 master
 ...
 60 master
 61
 62
 63
 >>>>>>>
 47
 48
 49
 50 other
 51 other
 52 other
 53 other
 ...

which is not that helpful. Interestingly, I think it _should_ be able to
do the same thing here as it did on the 3-line case. So I'm not sure
why it doesn't.

But there are even more complex cases, like say "other" had added new
lines of new content at the beginning of the file, and messed up the
context lines that the patch was using. So I think in the general case,
you will end up with patches like the latter one. Just shoving the patch
hunk into the file with an empty preimage section. And that can even
still be useful, but you are relying on line counts then. If they're
off, it's going ot be quite confusing.

-Peff
