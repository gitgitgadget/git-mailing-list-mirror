From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] pack-objects: split implications of --all-progress from
 progress activation
Date: Mon, 23 Nov 2009 12:43:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Petr Baudis <pasky@suse.cz>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCcyO-0004Q5-94
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbZKWRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 12:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbZKWRoD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:44:03 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27437 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbZKWRnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 12:43:55 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KTK008LQP92WEB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Nov 2009 12:43:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091123164319.GA23011@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133514>

Currently the --all-progress flag is used to use force progress display 
during the writing object phase even if output goes to stdout which is 
primarily the case during a push operation.  This has the unfortunate 
side effect of forcing progress display even if stderr is not a 
terminal.

Let's introduce the --all-progress-implied argument which has the same 
intent except for actually forcing the activation of any progress 
display.  With this, progress display will be automatically inhibited 
whenever stderr is not a terminal, or full progress display will be 
included otherwise.  This should let people use 'git push' within a cron 
job without filling their logs with useless percentage displays.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Mon, 23 Nov 2009, Jeff King wrote:

> We could also leave --all-progress as-is and add new option to mean "if
> you are already doing progress, do all progress".

Actually, that's what I was working on when I saw the above.

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 2e49929..f54d433 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,8 +9,9 @@ git-pack-objects - Create a packed archive of objects
 SYNOPSIS
 --------
 [verse]
-'git pack-objects' [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty]
-	[--local] [--incremental] [--window=N] [--depth=N] [--all-progress]
+'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
+	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
+	[--local] [--incremental] [--window=N] [--depth=N]
 	[--revs [--unpacked | --all]*] [--stdout | base-name]
 	[--keep-true-parents] < object-list
 
@@ -137,7 +138,7 @@ base-name::
 
 --all-progress::
 	When --stdout is specified then progress report is
-	displayed during the object count and deltification phases
+	displayed during the object count and compression phases
 	but inhibited during the write-out phase. The reason is
 	that in some cases the output stream is directly linked
 	to another command which may wish to display progress
@@ -146,6 +147,11 @@ base-name::
 	report for the write-out phase as well even if --stdout is
 	used.
 
+--all-progress-implied::
+	This is used to imply --all-progress whenever progress display
+	is activated.  Unlike --all-progress this flag doesn't actually
+	force any progress display by itself.
+
 -q::
 	This flag makes the command not to report its progress
 	on the standard error stream.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4c91e94..4429d53 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -24,6 +24,7 @@
 
 static const char pack_usage[] =
   "git pack-objects [{ -q | --progress | --all-progress }]\n"
+  "        [--all-progress-implied]\n"
   "        [--max-pack-size=N] [--local] [--incremental]\n"
   "        [--window=N] [--window-memory=N] [--depth=N]\n"
   "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]\n"
@@ -2124,6 +2125,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
 	int thin = 0;
+	int all_progress_implied = 0;
 	uint32_t i;
 	const char **rp_av;
 	int rp_ac_alloc = 64;
@@ -2223,6 +2225,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			progress = 2;
 			continue;
 		}
+		if (!strcmp("--all-progress-implied", arg)) {
+			all_progress_implied = 1;
+			continue;
+		}
 		if (!strcmp("-q", arg)) {
 			progress = 0;
 			continue;
@@ -2326,6 +2332,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 
+	if (progress && all_progress_implied)
+		progress = 2;
+
 	prepare_packed_git();
 
 	if (progress)
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d26997b..8fffdbf 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -40,7 +40,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	 */
 	const char *argv[] = {
 		"pack-objects",
-		"--all-progress",
+		"--all-progress-implied",
 		"--revs",
 		"--stdout",
 		NULL,
diff --git a/bundle.c b/bundle.c
index e04ab49..ff97adc 100644
--- a/bundle.c
+++ b/bundle.c
@@ -343,7 +343,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write pack */
 	argv_pack[0] = "pack-objects";
-	argv_pack[1] = "--all-progress";
+	argv_pack[1] = "--all-progress-implied";
 	argv_pack[2] = "--stdout";
 	argv_pack[3] = "--thin";
 	argv_pack[4] = NULL;
