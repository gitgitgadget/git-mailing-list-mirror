From: Jeff King <peff@peff.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 15:26:51 -0500
Message-ID: <20160126202651.GA1090@sigill.intra.peff.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net>
 <20160126152941.GA31951@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Jan 26 21:27:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOACY-0006Dn-D3
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcAZU0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 15:26:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:60911 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751229AbcAZU0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 15:26:54 -0500
Received: (qmail 12097 invoked by uid 102); 26 Jan 2016 20:26:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jan 2016 15:26:53 -0500
Received: (qmail 2707 invoked by uid 107); 26 Jan 2016 20:27:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jan 2016 15:27:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jan 2016 15:26:51 -0500
Content-Disposition: inline
In-Reply-To: <20160126152941.GA31951@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284853>

On Tue, Jan 26, 2016 at 10:29:42AM -0500, Santiago Torres wrote:

> > If you cannot trust those with write access to a repo that you are
> > pulling and installing from you might want to re-check where you are
> > pulling or installing from ;)
> 
> Yeah, I see your point, but mechanisms to ensure the server's origin can
> be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
> source pointed to is the source itself. The tag signature can help us do
> this.

Right. I think the more interesting use case here is "I trust the
upstream repository owner, but I do not trust their hosting site of
choice."

> > Your best bet is checking the signature of signed tags. Now, if you're
> > worried about someone maliciously pointing you to the wrong, correctly
> > signed tag then you should verify that the tag object contains the tag
> > "name" that you expect (for example by using "git verify-tag -v" or "git
> > cat-file -p"), since that is part of the signed content.
> 
> Yep, this is my intuition behind my proposal. While someone can manually
> inspect a tag (git tag -v [ref]) to ensure he's getting the correct one,
> there's no mechanism to ensure that the ref is pointing to the intended
> tag. I do believe that package managers and git submodules could check
> whether the ref is pointing to the right tag with a small change in the
> tag header. Although it would be up to each tool to implement this
> check.
> 
> I don't think that an addition like this would get in the way of any
> existing git workflow, and should be backwards-compatible right?

Doesn't this already exist?

  $ git cat-file tag v2.0.0
  object e156455ea49124c140a67623f22a393db62d5d98
  type commit
  tag v2.0.0
  tagger Junio C Hamano <gitster@pobox.com> 1401300269 -0700

  Git 2.0
  -----BEGIN PGP SIGNATURE-----
  [...]
  -----END PGP SIGNATURE-----

Tag objects already have a "tag" header, which is part of the signed
content. If you use "git verify-tag -v", you can check both that the
signature is valid and that the tag is the one you are expecting.

Of course, "verify-tag" could do this for you if you give it a refname,
too, but I think that may be the tip of the iceberg in terms of
automatic verification. In particular, verify-tag knows it was signed by
_somebody_, but it doesn't know what the signing policy is. As a human,
_I_ know that Junio is the right person to be signing the release tag,
but no tool does.

Git pretty much punts on all of these issues and assumes either a human
or a smarter tool is looking at the verification output. But I don't
think it would hurt to build in some features to let git automatically
check some things, if only to avoid callers duplicating work to
implement the checks themselves.

-Peff
