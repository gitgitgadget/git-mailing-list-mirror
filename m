From: Jeff King <peff@peff.net>
Subject: Re: howto handle name clashes
Date: Fri, 23 Mar 2012 14:29:52 -0400
Message-ID: <20120323182941.GA14236@sigill.intra.peff.net>
References: <4F6C7539.3080607@tu-clausthal.de>
 <20120323171219.GB12881@sigill.intra.peff.net>
 <4F6CB649.8080006@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:30:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9FR-000572-7N
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab2CWS34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:29:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57638
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab2CWS34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:29:56 -0400
Received: (qmail 17528 invoked by uid 107); 23 Mar 2012 18:30:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 14:30:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 14:29:52 -0400
Content-Disposition: inline
In-Reply-To: <4F6CB649.8080006@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193788>

On Fri, Mar 23, 2012 at 06:43:37PM +0100, Sven Strickroth wrote:

> Really problematic is checkout:
> "git checkout heads/foo" creates a detached HEAD (is this intended).
> However, "git checkout heads/foo -B foo" can be used.

Checkout is unlike regular ref lookup in that it prefers branches to
other forms (because it is fundamentally a branch operation). So "git
checkout foo" should always choose "refs/heads/foo". We do still seem to
give the ambiguity warning, though, which seems like overkill.

I think that generally people would want to get rid of ambiguous refs as
soon as they notice them, as they are a recipe for disaster. So the
warning being annoying has not been considered a huge problem.

> Is there a git command to find out if a name is ambiguous?
> "git rev-parse foo" outputs "warning: refname 'test' is ambiguous.", but
> the return code is zero.

I think you could do:

  case "$(git show-ref --tags --heads $name | wc -l)" in
  0) echo "$name does not exist" ;;
  1) echo "$name is unambiguous" ;;
  *) echo "$name is ambiguous" ;;
  esac

You could also get a list of all ambiguous refs like this:

  git for-each-ref --format='%(refname:short)' refs/heads refs/tags |
  egrep '^(heads|tags)'

The ":short" modifier will shorten names unambiguously, so it ends up
leaving the "heads" and "tags" in for ambiguous names.

-Peff
