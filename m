From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 14:01:08 -0700
Message-ID: <20110816210108.GA13710@sigill.intra.peff.net>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 23:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtQlC-0003Es-CY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab1HPVBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 17:01:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40025
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab1HPVBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 17:01:12 -0400
Received: (qmail 6309 invoked by uid 107); 16 Aug 2011 21:01:51 -0000
Received: from 206.111.142.135.ptr.us.xo.net (HELO sigill.intra.peff.net) (206.111.142.135)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 17:01:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 14:01:08 -0700
Content-Disposition: inline
In-Reply-To: <7vippxgm6y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179477>

On Tue, Aug 16, 2011 at 01:01:41PM -0700, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > What I want is a quick way to modify index content without changing
> > worktree, then I can continue adding more hunks to the index.
>=20
> Why would you even want to do that?
>=20
> Suppose you want to update hello.c in the index but not in the workin=
g
> tree for whatever reason I do not understand.  Presumably you would w=
ith
> this patch do this:
>=20
> 	edit hello.c
>         git update-index --swap hello.c
>=20
> assuming that the state of hello.c _before_ the edit was pristine.  B=
ut
> then after that what would you do?  Probably you would commit that
> untested change, and rebase-i to clean them up later, which is fine.

I suspect (or at least, this is how I would use it) it is more about
having some changes in the index and some changes in the working tree,
but realizing that what's in the index needs tweaked. Something like:

  # add some content with an error
  echo 'printf("hello word!\n")' >hello.c
  git add hello.c

  # work on it more, realizing the error
  echo 'printf("goodbye world!\n") >hello.c

  # now what? you want to stage the s/word/world/ fixup,
  # but you want to keep the hello/goodbye thing as a separate change.
  # Using anything line-based is going to conflate the two.
  # The change is simple, though, so you can just as easily edit the
  # index file, if only you could get to it. So you do:
  git update-index --swap hello.c
  sed -i s/word/world/ hello.c
  git update-index --swap hello.c

So the swap really functions as a toggle of "I would like to work on
the index version for a minute", and then you toggle back when you're
done.

I can think of two ways to do the same thing that are a little less
confusing or error-prone, though:

  1. A command to dump the index version to a tempfile, run $EDITOR on
     it, and then read it back in. Technically this restricts you to
     using $EDITOR to make the changes, but in practice that is probabl=
y
     fine.

  2. You can dump the file to a pipe yourself, but getting it back into
     the index is a little bit awkward. You have to do something like:

       blob=3D`git cat-file blob :hello.c |
             sed 's/word/world/ |
             git hash-object --stdin -w`
       mode=3D`git ls-files -s hello.c | cut -d' ' -f1`
       git update-index --cacheinfo $mode $blob hello.c

     it would be much nicer if this was:

       git cat-file blob :hello.c |
       sed 's/word/world/ |
       git add --stdin-contents hello.c

     However, I expect this sort of piping is the minority case, and
     most people would be happy with (1).

-Peff
