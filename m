From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Remove now unnecessary 'sync()' calls
Date: Fri, 30 May 2008 09:11:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805300908200.3141@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <20080530152527.GF4032@redhat.com> <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 30 18:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K27Eq-0003mT-Ks
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 18:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYE3QNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 12:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYE3QNE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 12:13:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58909 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752219AbYE3QND (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 12:13:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UGBugG001229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 May 2008 09:11:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4UGBtES000439;
	Fri, 30 May 2008 09:11:55 -0700
In-Reply-To: <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.897 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83315>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 May 2008 08:54:46 -0700

Since the pack-files are now always created stably on disk, there is no
need to sync() before pruning lose objects or old stale pack-files.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This literally just removes the syncs. The only thing they wanted to 
protect were the pack-files, that are now created stably.

Yes, you can screw this up by doing direct filesystem operations on the 
pack-files (ie rsync/http walkers etc), but let's face it - those 
operations are pretty much fundamentally more problematic than anything we 
can do anyway, so I canno bring myself to care.

Also, maybe I missed some case where we should fsync. I think this is all 
good, but having other people look at and think about this would be better 
still.

 builtin-prune-packed.c |    1 -
 builtin-prune.c        |    1 -
 git-repack.sh          |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 23faf31..241afbb 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -85,7 +85,6 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		/* Handle arguments here .. */
 		usage(prune_packed_usage);
 	}
-	sync();
 	prune_packed_objects(opts);
 	return 0;
 }
diff --git a/builtin-prune.c b/builtin-prune.c
index 25f9304..bd3d2f6 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -156,7 +156,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	mark_reachable_objects(&revs, 1);
 	prune_object_dir(get_object_directory());
 
-	sync();
 	prune_packed_objects(show_only);
 	remove_temporary_files();
 	return 0;
diff --git a/git-repack.sh b/git-repack.sh
index 10f735c..072d1b4 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -125,7 +125,6 @@ then
 	# We know $existing are all redundant.
 	if [ -n "$existing" ]
 	then
-		sync
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
-- 
1.5.6.rc0.48.g5eea
