From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Tue, 14 Jan 2014 04:50:02 -0500
Message-ID: <20140114095002.GA32258@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235953.GD10657@sigill.intra.peff.net>
 <52CD7835.2020708@alum.mit.edu>
 <20140110094120.GB17443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 14 10:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W30dR-0000si-Qb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 10:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaANJuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 04:50:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:60362 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbaANJuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 04:50:05 -0500
Received: (qmail 30578 invoked by uid 102); 14 Jan 2014 09:50:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jan 2014 03:50:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jan 2014 04:50:02 -0500
Content-Disposition: inline
In-Reply-To: <20140110094120.GB17443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240393>

On Fri, Jan 10, 2014 at 04:41:20AM -0500, Jeff King wrote:

> That being said, we could further optimize this by not opening the files
> at all (and make that the responsibility of do_one_ref, which we are
> avoiding here). I am slightly worried about the open() cost of my
> solution. It's amortized away in a big call, but it is probably
> noticeable for something like `git rev-parse <40-hex>`.

I took a look at this. It gets a bit hairy. My strategy is to add a flag
to ask read_loose_refs to create REF_INCOMPLETE values. We currently use
this flag for loose REF_DIRs to mean "we haven't opendir()'d the
subdirectory yet". This would extend it to the non-REF_DIR case to mean
"we haven't opened the loose ref file yet". We'd check REF_INCOMPLETE
before handing the ref_entry to a callback, and complete it if
necessary.

It gets ugly, though, because we need to pass that flag through quite a
bit of callstack. get_ref_dir() needs to know it, which means all of
find_containing_dir, etc need it, meaning it pollutes all of the
packed-refs code paths too.

I have a half-done patch in this direction if that doesn't sound too
nasty.

> > This doesn't correctly handle the rule
> > 
> > 	"refs/remotes/%.*s/HEAD"
> [...]

> I'll see how painful it is to make it work.

It's actually reasonably painful. I thought at first we could get away
with more cleverly parsing the rule, find the prefix (up to the
placeholder), and then look for the suffix ("/HEAD") inside there. But
it can never work with the current do_for_each_* code. That code only
triggers a callback when we see a concrete ref. It _never_ lets the
callbacks see an intermediate directory.

So a NO_RECURSE flag is not sufficient to handle this case. I'd need to
teach do_for_each_ref to recurse based on pathspecs, or a custom
callback function. And that is getting quite complicated.

I think it might be simpler to just do my own custom traversal. What I
need is much simpler than what do_for_each_entry provides. I don't need
recursion, and I don't actually need to look at the loose and packed
refs together. It's OK for me to do them one at a time because I don't
care about the actual value; I just want to know about which refs exist.

-Peff
