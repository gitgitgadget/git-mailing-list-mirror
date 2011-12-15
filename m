From: Jeff King <peff@peff.net>
Subject: Re: [BUG] in rev-parse
Date: Thu, 15 Dec 2011 02:05:21 -0500
Message-ID: <20111215070521.GB1327@sigill.intra.peff.net>
References: <20111214184926.GB18335@llunet.cs.wisc.edu>
 <20111214210157.GA8990@sigill.intra.peff.net>
 <7vk45yplkm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: nathan.panike@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 08:05:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb5Ng-0007vg-Mx
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 08:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab1LOHFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 02:05:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50353
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261Ab1LOHFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 02:05:23 -0500
Received: (qmail 6024 invoked by uid 107); 15 Dec 2011 07:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 02:12:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 02:05:21 -0500
Content-Disposition: inline
In-Reply-To: <7vk45yplkm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187192>

On Wed, Dec 14, 2011 at 07:20:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On the other hand, it has been like this since it was introduced in
> > 2006, and I wonder if scripts rely on the --verify side effect.
> 
> It would have been nicer if it did not to imply --verify at all; a long
> hexdigit that do not name an existing object at all will be shortened to
> its prefix that still do not collide with an abbreviated object name of an
> existing object, and even in such a case, the command should not error out
> only because it was fed a non-existing object (of course, if "--verify" is
> given at the same time, its "one input that names existing object only"
> rule should also kick in).

Dropping the implied verify is easy (see below). But handling
non-existant sha1s is a much more complicated change, as the regular
abbreviation machinery assumes that they exist. E.g., with the patch
below:

  $ good=73c6b3575bc638b7096ec913bd91193707e2265d
  $ bad=${good#d}e
  $ git rev-parse --short $good
  73c6b35
  $ git rev-parse --short $bad
  [no output]

Anyway, I'm not sure it's worth changing at this point. It's part of the
plumbing API that has been that way forever, it's kind of a rare thing
to ask for, and I've already shown a workaround using rev-list.

-Peff

---
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 98d1cbe..b365ca0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -545,7 +545,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--short") ||
 			    !prefixcmp(arg, "--short=")) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
-				verify = 1;
 				abbrev = DEFAULT_ABBREV;
 				if (arg[7] == '=')
 					abbrev = strtoul(arg + 8, NULL, 10);
