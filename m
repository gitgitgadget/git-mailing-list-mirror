From: Jeff King <peff@peff.net>
Subject: [PATCH] fsck: warn about ".git" in trees
Date: Wed, 28 Nov 2012 16:35:29 -0500
Message-ID: <20121128213529.GA16518@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:36:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdpIc-00087l-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 22:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691Ab2K1Vff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 16:35:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34099 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932565Ab2K1Vfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 16:35:32 -0500
Received: (qmail 12624 invoked by uid 107); 28 Nov 2012 21:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 16:36:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 16:35:29 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210782>

On Wed, Nov 28, 2012 at 01:25:05PM -0800, Junio C Hamano wrote:

> >> * jk/fsck-dot-in-trees (2012-11-28) 1 commit
> >>  - fsck: warn about '.' and '..' in trees
> >> 
> >>  Will merge to 'next'.
> >
> > Do you have an opinion on warning about '.git', as well? It probably
> > would make more sense as a patch on top, but I thought I'd ask before
> > this got merged to next.
> 
> Yeah, it would make sense to reject what we would not record
> ourselves when the tools are used in a sane manner.

Here's the patch on top of jk/fsck-dot-in-trees.

-- >8 --
Subject: [PATCH] fsck: warn about ".git" in trees

Having a ".git" entry inside a tree can cause confusing
results on checkout. At the top-level, you could not
checkout such a tree, as it would complain about overwriting
the real ".git" directory. In a subdirectory, you might
check it out, but performing operations in the subdirectory
would confusingly consider the in-tree ".git" directory as
the repository.

The regular git tools already make it hard to accidentally
add such an entry to a tree, and do not allow such entries
to enter the index at all. Teaching fsck about it provides
an additional safety check, and let's us avoid propagating
any such bogosity when transfer.fsckObjects is on.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c          |  5 +++++
 t/t1450-fsck.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fsck.c b/fsck.c
index 31c9a51..99c0497 100644
--- a/fsck.c
+++ b/fsck.c
@@ -144,6 +144,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	int has_empty_name = 0;
 	int has_dot = 0;
 	int has_dotdot = 0;
+	int has_dotgit = 0;
 	int has_zero_pad = 0;
 	int has_bad_modes = 0;
 	int has_dup_entries = 0;
@@ -174,6 +175,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 			has_dot = 1;
 		if (!strcmp(name, ".."))
 			has_dotdot = 1;
+		if (!strcmp(name, ".git"))
+			has_dotgit = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
@@ -227,6 +230,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 		retval += error_func(&item->object, FSCK_WARN, "contains '.'");
 	if (has_dotdot)
 		retval += error_func(&item->object, FSCK_WARN, "contains '..'");
+	if (has_dotgit)
+		retval += error_func(&item->object, FSCK_WARN, "contains '.git'");
 	if (has_zero_pad)
 		retval += error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
 	if (has_bad_modes)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0b5c30b..d730734 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -253,4 +253,19 @@ test_expect_success 'fsck notices "." and ".." in trees' '
 	)
 '
 
+test_expect_success 'fsck notices ".git" in trees' '
+	(
+		git init dotgit &&
+		cd dotgit &&
+		blob=$(echo foo | git hash-object -w --stdin) &&
+		tab=$(printf "\\t") &&
+		git mktree <<-EOF &&
+		100644 blob $blob$tab.git
+		EOF
+		git fsck 2>out &&
+		cat out &&
+		grep "warning.*\\.git" out
+	)
+'
+
 test_done
-- 
1.8.0.207.gdf2154c
