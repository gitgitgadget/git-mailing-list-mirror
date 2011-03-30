From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] remote: disallow some nonsensical option combinations
Date: Wed, 30 Mar 2011 15:52:52 -0400
Message-ID: <20110330195252.GA30624@sigill.intra.peff.net>
References: <20110330195139.GA814@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51Rt-0008Nn-W5
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab1C3Tw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:52:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44331
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab1C3Tw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:52:56 -0400
Received: (qmail 21030 invoked by uid 107); 30 Mar 2011 19:53:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 15:53:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 15:52:53 -0400
Content-Disposition: inline
In-Reply-To: <20110330195139.GA814@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170417>

It doesn't make sense to use "-m" on a mirror, since "-m"
sets up the HEAD symref in the remotes namespace, but with
mirror, we are by definition not using a remotes namespace.

Similarly, it does not make much sense to specify refspecs
with --mirror. For a mirror you plan to push to, those
refspecs will be ignored. For a mirror you are fetching
from, there is no point in mirroring, since the refspec
specifies everything you want to grab.

There is one case where "--mirror -t <X>" would be useful.
Because <X> is used as-is in the refspec, and because we
append it to to refs/, you could mirror a subset of the
hierarchy by doing:

  git remote add --mirror -t 'tags/*'

But using anything besides a single branch as an argument to
"-t" is not documented and only happens to work, so closing
it off is not a serious regression.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b71ecd2..2e25c6a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -161,6 +161,11 @@ static int add(int argc, const char **argv)
 	if (argc < 2)
 		usage_with_options(builtin_remote_add_usage, options);
 
+	if (mirror && master)
+		die("specifying a master branch makes no sense with --mirror");
+	if (mirror && track.nr)
+		die("specifying branches to track makes no sense with --mirror");
+
 	name = argv[0];
 	url = argv[1];
 
-- 
1.7.4.2.8.g3ccd6
