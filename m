From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 13:02:14 -0400
Message-ID: <20110614170214.GB26764@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
 <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
 <201106141202.46720.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:02:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWX0R-00039h-9u
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 19:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab1FNRCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 13:02:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50129
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab1FNRCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 13:02:17 -0400
Received: (qmail 28185 invoked by uid 107); 14 Jun 2011 17:02:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 13:02:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 13:02:14 -0400
Content-Disposition: inline
In-Reply-To: <201106141202.46720.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175783>

On Tue, Jun 14, 2011 at 12:02:46PM +0200, Johan Herland wrote:

> > Wouldn't it be enough to simply create a note on 'r651235' with as
> > contents the git ref?
> 
> Not quite sure what you mean by "create a note on 'r651235'". You could 
> devise a scheme where you SHA1('r651235'), and then create a note on the 
> resulting hash.
> 
> Notes are named by the SHA1 of the object they annotate, but there is no 
> hard requirement (as long as you stay away from "git notes prune") that the 
> SHA1 annotated actually exists as a valid Git object in your repo.
> 
> Hence, you can use notes to annotate _anything_ that can be uniquely reduced 
> to a SHA1 hash.

I lean against that as a solution. I think "git gc" will probably
eventually learn to do "git notes prune", at which point we would start
losing people's data. So I think it is better to keep the definition of
notes a little tighter now, and say "the left-hand side of a notes
mapping must be a referenced object". We can always loosen it later.

On top of that, though, the sha1 solution is not all that pleasant. It
lets you do exact lookups, but you have no way of iterating over the
list of svn revisions.

I also think we can do something a little more lightweight. The user has
already created and is maintaining a mapping in one direction via the
notes. We just need the inverse mapping, which we can generate
programatically. So it can be a straight cache, with the sha1 of the
notes tree determining the cache validity (i.e., if the forward mapping
in the notes tree changes, you regenerate the cache from scratch).

We would want to store the cache in an on-disk format that could be
searched easily. Possibly something like the packed-refs format would be
sufficient, if we mmap'd and binary searched it. It would be dirt simple
if we used an existing key/value store like gdbm or tokyocabinet, but we
usually try to avoid extra dependencies.

-Peff
