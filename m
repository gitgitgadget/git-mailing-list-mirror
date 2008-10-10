From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH] describe: Make --tags and --all match lightweight tags
	more often
Date: Fri, 10 Oct 2008 09:59:52 -0700
Message-ID: <20081010165952.GI8203@spearce.org>
References: <20080930083940.GA11453@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 19:01:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoLMP-00047n-Oh
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 19:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907AbYJJQ7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756053AbYJJQ7x
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 12:59:53 -0400
Received: from george.spearce.org ([209.20.77.23]:58500 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673AbYJJQ7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 12:59:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 320573835F; Fri, 10 Oct 2008 16:59:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930083940.GA11453@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97949>

If the caller supplies --tags they want the lightweight, unannotated
tags to be searched for a match.  If a lightweight tag is closer
in the history, it should be matched, even if an annotated tag is
reachable further back in the commit chain.

The same applies with --all when matching any other type of ref.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This come out of the discussions earlier last week, where folks
 were confused about the meaning of --tags and wanted to see it
 behave as they expected, which was to match the nearest tag,
 no matter its "type".

 The code is unchanged from what I sent out before, but now it has
 updated test vectors and a commit message.

 Thoughts?

 builtin-describe.c  |    6 ++----
 t/t6120-describe.sh |    8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index ec404c8..fd54fec 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -15,8 +15,8 @@ static const char * const describe_usage[] = {
 };
 
 static int debug;	/* Display lots of verbose info */
-static int all;	/* Default to annotated tags only */
-static int tags;	/* But allow any tags if --tags is specified */
+static int all;	/* Any valid ref can be used */
+static int tags;	/* Either lightweight or annotated tags */
 static int longformat;
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
@@ -112,8 +112,6 @@ static int compare_pt(const void *a_, const void *b_)
 {
 	struct possible_tag *a = (struct possible_tag *)a_;
 	struct possible_tag *b = (struct possible_tag *)b_;
-	if (a->name->prio != b->name->prio)
-		return b->name->prio - a->name->prio;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
 	if (a->found_order != b->found_order)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 16cc635..e6c9e59 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -91,10 +91,10 @@ check_describe D-* HEAD^^
 check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
 
-check_describe A-* --tags HEAD
-check_describe A-* --tags HEAD^
-check_describe D-* --tags HEAD^^
-check_describe A-* --tags HEAD^^2
+check_describe c-* --tags HEAD
+check_describe c-* --tags HEAD^
+check_describe e-* --tags HEAD^^
+check_describe c-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
 
 check_describe B-0-* --long HEAD^^2^
-- 
1.6.0.2.687.g8544f

-- 
Shawn.
