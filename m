From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 13/15] upload-pack: Handle extra rev-list arguments being passed
Date: Sat,  4 Sep 2010 18:14:05 -0600
Message-ID: <1283645647-1891-14-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2ri-0008IQ-GZ
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab0IEAN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57812 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab0IEAN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:27 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so971230pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=L7jNHwmgzsGFn+FQv/L0FTOdov9l3Z9C0ezA4fxXI/0=;
        b=TfvRSRTfmgFsNPWDyYMP+29NygD646TSWY5lPT903Z+Kn+d4W5iwLePNdIgpQ/4O/4
         CeYr4pzhnSnuzU+hk02m/8XmxZzYQOAakcTryts3UyiViW9k9CDnvnMCI0bMVdtDk1em
         UHKByiBmaYjMbCCeJZjrcWmADSB97U0TUf3AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BPGvufsidH+We2gWMNpVwffWiiegrdJOZCDhU8CkulhkEJ+Pe3nMXhh5dpeIkcGjOL
         EEZLhAq5wAoi5o5kTxCVK8AAH0ken92GvApVS0FsQBsbl9Q0fnriO3h1u2XadDg2qcmy
         S5FA9rmvUxXZoOHtrx4XI13lvsr3f9dhoVYO8=
Received: by 10.114.52.8 with SMTP id z8mr341512waz.140.1283645607308;
        Sat, 04 Sep 2010 17:13:27 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155398>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 upload-pack.c |   44 ++++++++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ce27a1a..721197b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -110,6 +110,8 @@ static int do_rev_list(int in, int out, void *user_data)
 {
 	int i;
 	struct rev_info revs;
+	int revlist_argc = 0;
+	const char **revlist_argv = user_data;
 
 	pack_pipe = xfdopen(out, "w");
 	init_revisions(&revs, NULL);
@@ -130,7 +132,10 @@ static int do_rev_list(int in, int out, void *user_data)
 		o->flags |= UNINTERESTING;
 		add_pending_object(&revs, o, NULL);
 	}
-	setup_revisions(0, NULL, &revs, NULL);
+	if (revlist_argv)
+		for (; revlist_argv[revlist_argc]; revlist_argc++)
+			;
+	setup_revisions(revlist_argc, revlist_argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
@@ -144,7 +149,7 @@ static int do_rev_list(int in, int out, void *user_data)
 	return 0;
 }
 
-static void create_pack_file(void)
+static void create_pack_file(const char **revlist_argv)
 {
 	struct async rev_list;
 	struct child_process pack_objects;
@@ -156,11 +161,14 @@ static void create_pack_file(void)
 	ssize_t sz;
 	const char *argv[10];
 	int arg = 0;
+	int run_revlist = shallow_nr || revlist_argv;
 
-	if (shallow_nr) {
+	if (run_revlist) {
 		memset(&rev_list, 0, sizeof(rev_list));
 		rev_list.proc = do_rev_list;
 		rev_list.out = -1;
+		if (revlist_argv)
+			rev_list.data = revlist_argv;
 		if (start_async(&rev_list))
 			die("git upload-pack: unable to fork git-rev-list");
 		argv[arg++] = "pack-objects";
@@ -183,7 +191,7 @@ static void create_pack_file(void)
 	argv[arg++] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
-	pack_objects.in = shallow_nr ? rev_list.out : -1;
+	pack_objects.in = run_revlist ? rev_list.out : -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 	pack_objects.git_cmd = 1;
@@ -193,7 +201,7 @@ static void create_pack_file(void)
 		die("git upload-pack: unable to fork git-pack-objects");
 
 	/* pass on revisions we (don't) want */
-	if (!shallow_nr) {
+	if (!run_revlist) {
 		FILE *pipe_fd = xfdopen(pack_objects.in, "w");
 		if (!create_full_pack) {
 			int i;
@@ -307,7 +315,7 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_nr && finish_async(&rev_list))
+	if (run_revlist && finish_async(&rev_list))
 		goto fail;	/* error was already reported */
 
 	/* flush the data */
@@ -656,7 +664,7 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 	return 0;
 }
 
-static void upload_pack(void)
+static void upload_pack(const char **revlist_argv)
 {
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
@@ -673,13 +681,13 @@ static void upload_pack(void)
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
-		create_pack_file();
+		create_pack_file(revlist_argv);
 	}
 }
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	char *dir;
+	char dir[4096];
 	int i;
 	int strict = 0;
 
@@ -689,7 +697,7 @@ int main(int argc, char **argv)
 	read_replace_refs = 0;
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (arg[0] != '-')
 			break;
@@ -705,6 +713,9 @@ int main(int argc, char **argv)
 			strict = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--help")) {
+			usage(upload_pack_usage);
+		}
 		if (!prefixcmp(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			daemon_mode = 1;
@@ -716,12 +727,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (i != argc-1)
-		usage(upload_pack_usage);
-
 	setup_path();
 
-	dir = argv[i];
+	strcpy(dir, argv[i]); /* enter-repo smudges its argument */
 
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
@@ -729,6 +737,10 @@ int main(int argc, char **argv)
 		die("attempt to fetch/clone from a shallow repository");
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
-	upload_pack();
+	/*
+	 * revlist arguments for revision walking start at argv[i+1], but
+	 * setup_revisions() ignores the first argument.
+	 */
+	upload_pack(argc > i+1 ? &argv[i] : NULL);
 	return 0;
 }
-- 
1.7.2.2.140.gd06af
