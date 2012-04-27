From: Jeff King <peff@peff.net>
Subject: ref-format checking regression
Date: Fri, 27 Apr 2012 07:50:01 -0400
Message-ID: <20120427115000.GA8126@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 27 13:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNjgi-0007l8-DE
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 13:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab2D0LuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 07:50:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49299
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2D0LuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 07:50:03 -0400
Received: (qmail 29156 invoked by uid 107); 27 Apr 2012 11:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Apr 2012 07:50:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Apr 2012 07:50:01 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196466>

I upgraded git on a machine recently, and it created problems for a repo
with a bogus character in a ref name.  Older versions of git never
complained about it. Newer ones, containing your dce4bab ("add_ref():
verify that the refname is formatted correctly") do. That's fine; it's
bogus and git _should_ complain about it.

However, recovering from the situation is unnecessarily hard, as basic
things like fsck stop working, you can't access the ref via rev-parse,
etc. You can reproduce with something like this (in some repo with
actual commits):

  $ evil=$(printf 'foo\177bar')
  $ git rev-parse HEAD >".git/refs/tags/$evil"

  $ git fsck
  fatal: Reference has invalid format: 'refs/tags/foo^?bar'

  [does not even warn about the real reason for the error]
  $ git rev-parse --verify "$evil"
  fatal: Needed a single revision

  [does not let you find broken refs]
  $ git for-each-ref
  fatal: Reference has invalid format: 'refs/tags/foo^?bar'
  $ git tag -l
  fatal: Reference has invalid format: 'refs/tags/foo^?bar'

  [no way to rename or delete the bogus tag]
  $ git tag fixed "$evil"
  fatal: Failed to resolve 'foo^?bar' as a valid ref.

I seem to recall discussing this format-tightening and trying to be sure
that users were left with a way forward for fixing their repos. But I
can't find the discussion, and I don't recall any conclusion we came to.
So maybe we decided not to worry about it. But I thought I'd mention it
as a data point.

-Peff
