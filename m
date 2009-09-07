From: Jeff King <peff@peff.net>
Subject: Re: tracking branch for a rebase
Date: Mon, 7 Sep 2009 04:43:25 -0400
Message-ID: <20090907084324.GB17997@coredump.intra.peff.net>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:43:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZp1-0008CF-Vc
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZIGIn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZIGIn0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:43:26 -0400
Received: from peff.net ([208.65.91.99]:34271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbZIGIn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:43:26 -0400
Received: (qmail 15798 invoked by uid 107); 7 Sep 2009 08:43:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Sep 2009 04:43:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Sep 2009 04:43:25 -0400
Content-Disposition: inline
In-Reply-To: <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127906>

On Sun, Sep 06, 2009 at 10:05:21PM -0700, Junio C Hamano wrote:

> At-mark currently is reserved for anything that uses reflog, but we can
> say that it is to specify operations on refs (as opposed to caret and
> tilde are to specify operations on object names).

I assume you meant that @{} is reserved; my reading of the previous
discussion was that "foo@bar" is still valid.

> It specifies what ref to work on with the operand on its left side (and an
> empty string stands for "HEAD"), and what operation is done to it by what
> is in {} on the right side of it.  This view is quite consistent with the
> following existing uses of the notation:
> 
> 	ref@{number}	-- nth reflog entry
>         ref@{time}	-- ref back then
> 	@{-number}	-- nth branch switching
> 
> So perhaps ref@{upstream}, or any string that is not a number and cannot
> be time, can trigger the magic operation on the ref with ref@{magic}
> syntax?

I think using @{} is a reasonable extension format. It's easy to read
and syntactically obvious. We need to watch out for conflicts with
things that might be valid times, but that is an easy thing to check
when adding new keywords. The only danger would be some extension
specifier that used arbitrary input, but that would probably be prefixed
with a keyword (and I can't even think of an example extension that
would want arbitrary input).

My only two complaints with ref@{upstream} are (and I don't think either
is a show-stopper, but maybe something we can improve on).

  1. It is a nice abstraction, but it doesn't save typing in most cases.
     "origin" is shorter than "master@{upstream}". One of the desired
     features in the last thread was that it be very short (which isn't
     to say we can't introduce @{upstream} _now_ and add a shorter
     synonym later on).

  2. I assume @{upstream} will be equivalent to HEAD@{upstream}. What
     should it do? The most useful thing to me would be to find the
     upstream for the current branch. But that is actually quite
     different from how HEAD@{1} works, which looks at the reflog for
     HEAD and not the branch.

     Maybe this is an inconsistency we can live with. The features are,
     after all, only syntactically related. I was just hoping to keep
     things as simple as possible for users to understand (and they
     often take semantic clues from syntax).

And some final thinking out loud in this area (i.e., these ideas are, I
think, somewhat half baked):

We already have some reserved uppercase ref names like HEAD, FETCH_HEAD,
ORIG_HEAD, and MERGE_HEAD.  One option would be to declare all-caps
names as reserved and allow UPSTREAM for the feature in question. I can
think of two arguments against it:

 1. The obvious one, that somebody somewhere is using all-caps and we
    are breaking their setup.

 2. It is not syntactically obvious to the user that it is not a real
    ref, but rather a magic name. Users are accustomed to punctuation
    introducing magic, so @{upstream} is probably better in that regard.

So I think that is a bad idea. But what about allowing "ref aliases"?
Obviously a static one like "f" for "foo" is kind of lame. But if you
could use the extension syntax, like:

  git config refalias.% '@{upstream}'

then we can let people set up whatever shorthand they think is sane (and
without worrying about clobbering unlikely-but-allowed setups, since
they are in control of their setup).

Like I said, I am not sure that is not half-baked. ;)

-Peff
