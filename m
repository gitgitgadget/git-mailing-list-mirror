From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH/RFC] Encapsulating isatty(2) calls into new progress_is_desired()
Date: Wed, 29 Jun 2011 13:28:25 +0200
Message-ID: <3d6b6818cfc542a3acf7a7a43ac6842fd74ddcee.1309342095.git.sdaoden@gmail.com>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 13:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbsxU-0000cK-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 13:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab1F2L3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 07:29:24 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:55285 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1F2L3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 07:29:22 -0400
Received: by fxd18 with SMTP id 18so1137365fxd.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Dn/vxuLX18biGQ6KiLVkmWGRScbuvlftar7WbxOX1rw=;
        b=YRvGRMjm9ZjohfXr5ajpKW1SAl6YdBRJVchq6Sfls659hhwtrKOjYKFT5j29thUx3h
         RdliPWC6b13Ta2yh40ix+DoaD04zBAZn6UGwVujSi0CPMSJKQFh/snq9p9WAxYFCystr
         P+LRqB8tXD58U6wRkhT0q160kT20FOjwocci0=
Received: by 10.223.132.207 with SMTP id c15mr1086394fat.73.1309346960954;
        Wed, 29 Jun 2011 04:29:20 -0700 (PDT)
Received: from localhost.localdomain ([89.204.153.232])
        by mx.google.com with ESMTPS id g12sm780555fai.8.2011.06.29.04.29.17
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 04:29:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1.ge79e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176440>

Adds a progress_is_desired() function and replaces most calls of
isatty(2) in the codebase with it.

Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
Ok, i yelled at it and here you have a patch which performs the
encapsulation, just in case you agree.
I'm using static init, the short glance i had at the code made me
think thread safety is not an issue once this is called?
I think caching the value is worth an .align; it's a syscall
AFAIK.  (It's not used yet, however.)

And regardless of the fact that i'm stupid  Jeff King is right,
frontend parsing is important, and then CR plays an important role.
It's painful when you try to get some usable info out of these
closed proprietary status messages.  Sorry, really sorry.
I *really* love 'git add -i' and 'git rebase -i', these are
*fantastic* features!  Not scriptable through cron(8) though. :-)
Line tagging is also nice for parsing, by the way, as in

> wx-account: message 42/1 (6837/6837 bytes) .. sync
@ xy-account: xy@z.com -> pop.gmail.com/74.125.39.109:995
- xy-account: 0 messages (0 bytes) [action=seen]
< org.kernel.git: 22 tickets ok (0 errors).
< org.openbsd.misc: 20 tickets ok (0 errors).
= Dispatched 42 tickets to 2 targets.

 builtin/merge.c          |    5 +++--
 builtin/pack-objects.c   |    2 +-
 builtin/prune-packed.c   |    2 +-
 builtin/unpack-objects.c |    2 +-
 progress.c               |    8 ++++++++
 progress.h               |    1 +
 remote-curl.c            |    2 +-
 transport.c              |    7 ++++---
 transport.h              |    2 +-
 9 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..51fe030 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -695,8 +695,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			o.subtree_shift = "";
 
 		o.renormalize = option_renormalize;
-		o.show_rename_progress =
-			show_progress == -1 ? isatty(2) : show_progress;
+		o.show_rename_progress = ((show_progress == -1)
+						? progress_is_desired()
+						: show_progress);
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f402a84..f3ee648 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2138,7 +2138,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
-	progress = isatty(2);
+	progress = progress_is_desired();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..cc48807 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -71,7 +71,7 @@ void prune_packed_objects(int opts)
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts = isatty(2) ? VERBOSE : 0;
+	int opts = progress_is_desired() ? VERBOSE : 0;
 	const struct option prune_packed_options[] = {
 		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
 		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..14cea36 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -501,7 +501,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	quiet = !isatty(2);
+	quiet = !progress_is_desired();
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/progress.c b/progress.c
index c548de4..6baadd6 100644
--- a/progress.c
+++ b/progress.c
@@ -209,6 +209,14 @@ int display_progress(struct progress *progress, unsigned n)
 	return progress ? display(progress, n, NULL) : 0;
 }
 
+int progress_is_desired(void)
+{
+	static long eitty /*= 0*/;
+	if (!eitty)
+		eitty = isatty(2) ? 1 : -1;
+	return (eitty == 1);
+}
+
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay)
 {
diff --git a/progress.h b/progress.h
index 611e4c4..d7020d3 100644
--- a/progress.h
+++ b/progress.h
@@ -5,6 +5,7 @@ struct progress;
 
 void display_throughput(struct progress *progress, off_t total);
 int display_progress(struct progress *progress, unsigned n);
+int progress_is_desired(void);
 struct progress *start_progress(const char *title, unsigned total);
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay);
diff --git a/remote-curl.c b/remote-curl.c
index b5be25c..b47097a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -841,7 +841,7 @@ int main(int argc, const char **argv)
 	}
 
 	options.verbosity = 1;
-	options.progress = !!isatty(2);
+	options.progress = progress_is_desired();
 	options.thin = 1;
 
 	remote = remote_get(argv[1]);
diff --git a/transport.c b/transport.c
index c9c8056..8c67cfa 100644
--- a/transport.c
+++ b/transport.c
@@ -883,7 +883,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
-	ret->progress = isatty(2);
+	ret->progress = progress_is_desired();
 
 	if (!remote)
 		die("No remote provided to transport_get()");
@@ -998,9 +998,10 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	 *
 	 *   1. Report progress, if force_progress is 1 (ie. --progress).
 	 *   2. Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
-	 *   3. Report progress if isatty(2) is 1.
+	 *   3. Report progress if progress default policies apply.
 	 **/
-	transport->progress = force_progress || (verbosity >= 0 && isatty(2));
+	transport->progress = (force_progress ||
+				(verbosity >= 0 && progress_is_desired()));
 }
 
 int transport_push(struct transport *transport,
diff --git a/transport.h b/transport.h
index 161d724..6b73240 100644
--- a/transport.h
+++ b/transport.h
@@ -82,7 +82,7 @@ struct transport {
 	signed verbose : 3;
 	/**
 	 * Transports should not set this directly, and should use this
-	 * value without having to check isatty(2), -q/--quiet
+	 * value without having to check progress_is_desired(), -q/--quiet
 	 * (transport->verbose < 0), etc. - checking has already been done
 	 * in transport_set_verbosity().
 	 **/
-- 
1.7.6.1.ge79e.dirty
