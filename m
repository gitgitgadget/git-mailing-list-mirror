From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 06:25:04 -0500
Message-ID: <20080213112504.GA26627@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <20080213105051.GA26522@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:25:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFkG-0007vX-VZ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbYBMLZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbYBMLZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:25:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbYBMLZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:25:08 -0500
Received: (qmail 14089 invoked by uid 111); 13 Feb 2008 11:25:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 06:25:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 06:25:04 -0500
Content-Disposition: inline
In-Reply-To: <20080213105051.GA26522@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73775>

On Wed, Feb 13, 2008 at 05:50:51AM -0500, Jeff King wrote:

> And here it is. I think this is a more sane approach in general than the
> last patch. The only ugly thing is the empty tree hack, but that can be
> addressed with a patch to allow referencing the empty tree without it
> existing in the object db.

And this patch hard-codes the empty tree. I _think_ this shouldn't cause
us any problems, as it just reuses the existing pretend_sha1_file
infrastructure. However that infrastructure is very rarely used.

This patch also contains the matching fix to git-add--interactive (on
top of my last patch). They should probably just be squashed together,
but I can submit a cleaned up 2-patch series if people agree that this
is a good idea.

-- >8 --
hard-code the empty tree object

Now any commands may reference the empty tree object by its
sha1 (4b825dc642cb6eb9a060e54bf8d69288fbee4904). This is
useful for showing some diffs, especially for initial
commits.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   13 ++-----------
 sha1_file.c               |   11 +++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bae631e..a0a81f1 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -91,17 +91,8 @@ my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
 	}
 }
 
-{
-	my $sha1;
-	sub get_empty_tree {
-		if (!$sha1) {
-			local $ENV{GIT_INDEX_FILE} = "$GIT_DIR/empty_index";
-			$sha1 = run_cmd_pipe(qw(git write-tree));
-			chomp $sha1;
-			unlink($ENV{GIT_INDEX_FILE});
-		}
-		return $sha1;
-	}
+sub get_empty_tree {
+	return '4b825dc642cb6eb9a060e54bf8d69288fbee4904';
 }
 
 # Returns list of hashes, contents of each of which are:
diff --git a/sha1_file.c b/sha1_file.c
index 4179949..1a6c7c8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1845,6 +1845,15 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
+static struct cached_object empty_tree = {
+	/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
+	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60"
+	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04",
+	OBJ_TREE,
+	"",
+	0
+};
+
 static struct cached_object *find_cached_object(const unsigned char *sha1)
 {
 	int i;
@@ -1854,6 +1863,8 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 		if (!hashcmp(co->sha1, sha1))
 			return co;
 	}
+	if (!hashcmp(sha1, empty_tree.sha1))
+		return &empty_tree;
 	return NULL;
 }
 
-- 
1.5.4.1.1297.g3482b-dirty
