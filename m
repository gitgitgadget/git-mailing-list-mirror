From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 11:23:01 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org> <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:24:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L14HV-00049Q-7y
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 20:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYKNTXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 14:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYKNTXU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 14:23:20 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41479 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953AbYKNTXT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 14:23:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEJN2Ka019082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Nov 2008 11:23:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEJN16r030977;
	Fri, 14 Nov 2008 11:23:01 -0800
In-Reply-To: <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101004>



On Fri, 14 Nov 2008, Brandon Casey wrote:
> 
> I have no explanation for why the diff numbers are different from 
> yesterday. Could be that there was some nightly cron job running last 
> night which slowed things down. Still, the same ~5x speedup is observed!

One of the things I changed (inadvertently - it was just meant to be a 
test) was that the last patch had MAX_PARALLEL set to 100 rather than 10. 
That's definitely overkill.

I also think the thread cost was wrong: it did

	threads = index->cache_nr / 100;

to give a first-order "how many threads do we want", but the thread 
startup is likely to be higher than 100 lstat calls, so we probably want 
fewer threads than that. It doesn't much matter for something like the 
Linux kernel, where there are so many files that we'll end up maxing out 
the threads anyway, but for smaller projects, I suspect a thread cost of 
"one thread per 500 files" is more reasonable. You almost certainly don't 
want to thread anything at all for fewer than a few hundred files.

So here's a slight incremental update to my patch from yesterday. It also 
adds the config variable, and it defaults to off, so to actually see this 
in action, you now need to add

	[core]
		PreloadIndex = true

to your ~/.gitconfig file.

Totally untested. As usual. Maybe it works. Maybe it doesn't.

		Linus

---
 Documentation/config.txt |   12 +++++++++++-
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    3 +++
 preload-index.c          |   18 +++++++++++++-----
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 32dcd64..9260121 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -411,7 +411,17 @@ core.fsyncobjectfiles::
 This is a total waste of time and effort on a filesystem that orders
 data writes properly, but can be useful for filesystems that do not use
 journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+and not file contents (OS X's HFS+, or Linux ext3 with
+"data=writeback").
+
+core.preloadindex::
+	Enable parallel index preload for operations like 'git diff'
++
+This can speed up operations like 'git diff' and 'git status' especially
+on filesystems like NFS that have weak caching semantics and thus
+relatively high IO latencies.  With this set to 'true', git will do the
+index comparison to the filesystem data in parallel, allowing
+overlapping IO's.
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
diff --git a/cache.h b/cache.h
index 64239fb..685a866 100644
--- a/cache.h
+++ b/cache.h
@@ -460,6 +460,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 extern int fsync_object_files;
+extern int core_preload_index;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index 67cc1dc..d2fc8f5 100644
--- a/config.c
+++ b/config.c
@@ -490,6 +490,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.preloadindex")) {
+		core_preload_index = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index bb96ac0..e278bce 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,9 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 
+/* Parallel index stat data preload? */
+int core_preload_index = 0;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
diff --git a/preload-index.c b/preload-index.c
index e322c27..3ce42e0 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -4,9 +4,14 @@
 #include <pthread.h>
 #include "cache.h"
 
-/* Hacky hack-hack start */
-#define MAX_PARALLEL (100)
-int parallel_lstats = 1;
+/*
+ * Mostly randomly chosen maximum thread counts: we
+ * cap the parallelism to 20 threads, and we want
+ * to have at least 500 lstat's per thread for it to
+ * be worth starting a thread.
+ */
+#define MAX_PARALLEL (20)
+#define THREAD_COST (500)
 
 struct thread_data {
 	pthread_t pthread;
@@ -47,10 +52,13 @@ static void *preload_thread(void *_data)
 
 static void preload_index(struct index_state *index, const char **pathspec)
 {
-	int i, work, offset;
-	int threads = index->cache_nr / 100;
+	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
 
+	if (!core_preload_index)
+		return;
+
+	threads = index->cache_nr / THREAD_COST;
 	if (threads < 2)
 		return;
 	if (threads > MAX_PARALLEL)
