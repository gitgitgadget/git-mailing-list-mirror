From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 3 Jul 2012 03:19:40 -0400
Message-ID: <20120703071940.GB16679@sigill.intra.peff.net>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:19:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlxOm-00018h-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 09:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470Ab2GCHTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 03:19:45 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52111
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206Ab2GCHTo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 03:19:44 -0400
Received: (qmail 18978 invoked by uid 107); 3 Jul 2012 07:19:50 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 03:19:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 03:19:40 -0400
Content-Disposition: inline
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200903>

On Mon, Jul 02, 2012 at 03:33:51PM -0700, Junio C Hamano wrote:

> This is take 4.  The earlier rounds were $gmane/200165, 200387, and
> 200506.
> 
> Compared to the previous round, it has more patches in the clean-up
> phase.  Most notably, patch 03/18 gets rid of get_sha1_with_mode_1()
> and replaces the only external caller of it with a call to a more
> straightforward die_on_misspelt_object_name().  The test suite added
> by patch 12/18 has more patterns that we can potentially improve on.
> 
> The disambiguation logic can now be asked to pick only committish,
> which can be used in places like "git commit -C deadbeef".  It also
> knows that A and B in "git log A..B" can only be committishes.
> 
> Adding support for treeish, if anybody is tempted to do so, should
> now be pretty straightforward.

I finally took a moment to read over this series. I really like the
cleanups in the early part (reducing the number of get_sha1_* functions
especially), and the design of the disambiguate_state code is nice and
clean. I didn't notice anything wrong while reading the patches
themselves.

I do see one slight regression. If you feed an unambiguous partial sha1
and it does not match the hint, we still select it, which is good. So
you still get:

  $ git show 000379^{commit}
  error: 000379^{commit}: expected commit type, but the object dereferences to blob type
  error: 000379^{commit}: expected commit type, but the object dereferences to blob type
  fatal: ambiguous argument '000379^{commit}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

So far so good (aside from the duplicated error message, but that is
unrelated). However, if you feed a partial sha1 for which there are
multiple matches, none of which satisfy the disambiguation hint, then we
used to say "short SHA1 is ambiguous", and now we don't.

  [before]
  $ git show 0003
  error: short SHA1 0003 is ambiguous.
  error: short SHA1 0003 is ambiguous.
  fatal: ambiguous argument '0003': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

  $ git show 0003^{commit}
  error: short SHA1 0003 is ambiguous.
  error: short SHA1 0003 is ambiguous.
  fatal: ambiguous argument '0003^{commit}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

  [after]
  $ git show 0003
  error: short SHA1 0003 is ambiguous.
  error: short SHA1 0003 is ambiguous.
  fatal: ambiguous argument '0003': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

  $ git show 0003^{commit}
  fatal: ambiguous argument '0003^{commit}': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

I think the code is right not to return an object at all (since it is
ambiguous), but it might be helpful to say "your sha1 was ambiguous, but
none of the possibilities matched our criteria" or similar. Otherwise
the error message looks exactly like the "there is no such object at
all" case. I don't think this is a huge problem, but I can see it being
surprising if somebody is trying to debug an issue where they expect an
object to be of a different type.

Other than that, the series looks good to me.

-Peff
