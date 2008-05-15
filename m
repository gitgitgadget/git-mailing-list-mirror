From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-clone: fix initial checkout
Date: Thu, 15 May 2008 10:48:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151042570.30431@racer>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org> <20080515044402.GA3517@sigill.intra.peff.net> <20080515045026.GA26161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 15 11:49:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwa5M-0004os-FP
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 11:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbYEOJs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 05:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYEOJs0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 05:48:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:41315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753475AbYEOJsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 05:48:25 -0400
Received: (qmail invoked by alias); 15 May 2008 09:48:23 -0000
Received: from R33f0.r.pppool.de (EHLO racer.local) [89.54.51.240]
  by mail.gmx.net (mp043) with SMTP; 15 May 2008 11:48:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/ipNE52l/Ys8kzi1o4UQbagDCiidInAHxGSVlsJ
	rCMYVWGoBQnMm2
X-X-Sender: gene099@racer
In-Reply-To: <20080515045026.GA26161@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82195>


Somewhere in the process of finishing up builtin-clone, the update of
the working tree was lost.  This was due to not using the option "merge"
for unpack_trees().

Breakage noticed by Kevin Ballard.

Test by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	> On Thu, May 15, 2008 at 12:44:02AM -0400, Jeff King wrote:
	> 
	> > Hmm, builtin-clone does seem to be completely broken. It looks 
	> > like unpack_trees is not doing its job for some reason, but I
	> > haven't looked further. But it surprised me that we aren't 
	> > testing anything as simple as "clone works". The test below
	> > currently fails (though I am getting other test failures which 
	> > are presumably related).

	I did not notice the breakage earlier, because I ran with a 
	"twoway_merge" version of builtin-clone in my personal tree.

 builtin-clone.c  |    3 +++
 t/t5601-clone.sh |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index a7c075d..8713128 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -525,7 +525,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		memset(&opts, 0, sizeof opts);
 		opts.update = 1;
+		opts.merge = 1;
+		opts.fn = oneway_merge;
 		opts.verbose_update = !option_quiet;
+		opts.src_index = &the_index;
 		opts.dst_index = &the_index;
 
 		tree = parse_tree_indirect(remote_head->old_sha1);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index dc9d63d..593d1a3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -23,4 +23,11 @@ test_expect_success 'clone with excess parameters' '
 
 '
 
+test_expect_success 'clone checks out files' '
+
+	git clone src dst &&
+	test -f dst/file
+
+'
+
 test_done
-- 
1.5.5.1.424.g3256b
