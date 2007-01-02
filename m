From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix infinite loop when deleting multiple packed refs.
Date: Tue, 2 Jan 2007 03:17:09 -0500
Message-ID: <20070102081709.GA28779@spearce.org>
References: <b566b20c0701012244l21f85472k83970c0c573ce105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 02 09:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1eq0-0006ik-5H
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbXABIRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 03:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbXABIRP
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:17:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51195 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966AbXABIRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:17:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1epa-0008HD-W4; Tue, 02 Jan 2007 03:17:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04EDA20FB65; Tue,  2 Jan 2007 03:17:09 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <b566b20c0701012244l21f85472k83970c0c573ce105@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35778>

Nicholas Miell reported that `git branch -D A B` failed if both refs
A and B were packed into .git/packed-refs.  This happens because the
same pack_lock instance was being enqueued into the lock list twice,
causing the linked list to change from a singly linked list with
a NULL at the end to a circularly linked list with no termination.
This resulted in an infinite loop traversing the list during exit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Nicholas Miell <nmiell@gmail.com> wrote:
 > # this is with 1.4.4.2, spearce says master is also affected.
 > # (not subscribed, please Cc:)
 > 
 > mkdir test
 > cd test
 > git init-db
 > touch blah
 > git add blah
 > git commit -m "blah"
 > git checkout -b A
 > git checkout -b B
 > git checkout master
 > git pack-refs --all --prune
 > git branch -D A B # --> infinite loop in lockfile.c:remove_lock_file()

 Fixed.  ;-)

 Junio, this applies to master, but hopefully could also apply to
 maint, as the bug also shows up there.

 refs.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e88ed8b..f1d1a5d 100644
--- a/refs.c
+++ b/refs.c
@@ -709,10 +709,9 @@ struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *o
 	return lock_ref_sha1_basic(ref, old_sha1, NULL);
 }
 
-static struct lock_file packlock;
-
 static int repack_without_ref(const char *refname)
 {
+	struct lock_file *packlock;
 	struct ref_list *list, *packed_ref_list;
 	int fd;
 	int found = 0;
@@ -726,8 +725,8 @@ static int repack_without_ref(const char *refname)
 	}
 	if (!found)
 		return 0;
-	memset(&packlock, 0, sizeof(packlock));
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
+	packlock = calloc(1, sizeof(*packlock));
+	fd = hold_lock_file_for_update(packlock, git_path("packed-refs"), 0);
 	if (fd < 0)
 		return error("cannot delete '%s' from packed refs", refname);
 
@@ -744,7 +743,7 @@ static int repack_without_ref(const char *refname)
 			die("too long a refname '%s'", list->name);
 		write_or_die(fd, line, len);
 	}
-	return commit_lock_file(&packlock);
+	return commit_lock_file(packlock);
 }
 
 int delete_ref(const char *refname, unsigned char *sha1)
-- 
1.5.0.rc0.gab5a
