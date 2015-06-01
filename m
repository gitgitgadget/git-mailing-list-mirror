From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] silence missing-link warnings in some cases
Date: Mon, 1 Jun 2015 05:54:10 -0400
Message-ID: <20150601095410.GA16976@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
 <20150601081450.GA32634@peff.net>
 <556C1A95.9010704@atlas-elektronik.com>
 <20150601085226.GA20537@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 11:54:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMQG-0001eq-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbbFAJyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 05:54:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:38658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751889AbbFAJyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:54:14 -0400
Received: (qmail 22441 invoked by uid 102); 1 Jun 2015 09:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:54:14 -0500
Received: (qmail 27660 invoked by uid 107); 1 Jun 2015 09:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:54:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 05:54:10 -0400
Content-Disposition: inline
In-Reply-To: <20150601085226.GA20537@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270384>

Stefan noticed that running "git gc" with a recent version of git causes
some useless complaints about missing objects.

The reason is that since git d3038d2 (prune: keep objects reachable from
recent objects, 2014-10-15), we will traverse objects that are not
reachable but have recent mtimes (within the 2-week prune expiration
window). Because they are not reachable, we may not actually have all of
their ancestors; we use the revs->ignore_missing_links option to avoid
making this a fatal error. But we still print an error message. This
series suppresses those messages.

The first two patches below implement that. The third one gives the same
treatment to UNINTERESTING parents, which we implicitly ignore when they
are missing. I have slightly mixed feelings on this, just because it
could be a clue that there is repo corruption. E.g., if you do:

  git log foo..bar

and we find that "foo^" is missing, it is the only error message you
get. OTOH, I think the reason we ignore errors with UNINTERESTING
parents is that it does not necessarily mean corruption. E.g., while
serving a fetch, if the client claims to have "x", we check only
"has_sha1_file(x)" before putting the object on the UNINTERESTING side
of our traversal. It might not be reachable at all, but rather just part
of an incomplete segment of unreachable history. Of course, with modern
git (post-d3038d2), we try to avoid getting that situation in the first
place, which means that it _is_ an exceptional situation, and we should
continue to at least print the error message.

Note that post-d3038d2, it is also exceptional to see this in the
ignore_missing_link cases, too. The reason Stefan is seeing it is
probably that the repo was pruned in the past 2 weeks by an older
version of git (so it removed an older "x^", but kept "x"; whereas
modern git would keep both). So yet another possibility is to scrap this
whole series. Within 2 weeks the problem will magically go away on its
own, or sooner if the user runs "git prune".

  [1/3]: add quieter versions of parse_{tree,commit}
  [2/3]: silence broken link warnings with revs->ignore_missing_links
  [3/3]: suppress errors on missing UNINTERESTING links

-Peff
