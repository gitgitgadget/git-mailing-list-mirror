From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] cherry-pick: handle root commits with external strategies
Date: Thu, 12 May 2011 07:09:46 -0400
Message-ID: <20110512110946.GA5292@sigill.intra.peff.net>
References: <20110512110855.GA5240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 13:09:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTmD-0006RO-5f
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 13:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab1ELLJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 07:09:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53674
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab1ELLJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 07:09:48 -0400
Received: (qmail 12739 invoked by uid 107); 12 May 2011 11:11:46 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 07:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 07:09:46 -0400
Content-Disposition: inline
In-Reply-To: <20110512110855.GA5240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173458>

The merge-recursive strategy already handles root commits;
it cherry-picks the difference between the empty tree and
the root commit's tree.

However, for external strategies, we dereference NULL and
segfault while building the argument list. Instead, let's
handle this by passing the empty tree sha1 to the merge
script.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9661c8f..5098bf6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -599,6 +599,14 @@ static void write_tree_trivial(unsigned char *sha1)
 		die(_("git write-tree failed to write a tree"));
 }
 
+static const char *merge_argument(struct commit *commit)
+{
+	if (commit)
+		return sha1_to_hex(commit->object.sha1);
+	else
+		return EMPTY_TREE_SHA1_HEX;
+}
+
 int try_merge_command(const char *strategy, size_t xopts_nr,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
@@ -619,11 +627,11 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 		args[i++] = s;
 	}
 	for (j = common; j; j = j->next)
-		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+		args[i++] = xstrdup(merge_argument(j->item));
 	args[i++] = "--";
 	args[i++] = head_arg;
 	for (j = remotes; j; j = j->next)
-		args[i++] = xstrdup(sha1_to_hex(j->item->object.sha1));
+		args[i++] = xstrdup(merge_argument(j->item));
 	args[i] = NULL;
 	ret = run_command_v_opt(args, RUN_GIT_CMD);
 	strbuf_release(&buf);
-- 
1.7.5.1.12.ga7abed
