From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 13:01:37 -0700
Message-ID: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT14Y-00081H-IK
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbXIEUBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbXIEUBw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:01:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbXIEUBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:01:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D3D4512F118;
	Wed,  5 Sep 2007 16:02:05 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> (Nicolas
	Pitre's message of "Wed, 05 Sep 2007 14:54:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Not only that.  Currently the "Counting objects" phase when running 
> git-gc on the Linux repo takes a significant amount of time, even if 
> there is little to repack.
>
> If any kind of automatic repack is implemented, it should be an 
> incremental repacking only, not the full thing, i.e. git-repack without 
> -a, or git-pack-objects with --unpacked.  The idea is to be the least 
> intrusive as possible.  Also, object walking should be limited to 
> objects linked to a commit object which is itself unpacked in order to 
> cut on the time required to fully enumerate all objects.
>
> This way a semi-packed state will always be preserved and should be good 
> enough.  The full repacking should probably be left to manual execution 
> of git-gc.

Ok, how about doing something like this?

-- >8 -- snipsnap -- >8 -- clipcrap -- >8 --
Implement git gc --auto

This implements a new option "git gc --auto".  When gc.auto is
set to a positive value, and the object database has accumulated
roughly that many number of loose objects, this runs a
lightweight version of "git gc".  The primary difference from
the full "git gc" is that it does not pass "-a" option to "git
repack", which means we do not try to repack _everything_, but
only repack incrementally.  We still do "git prune-packed".  The
default threshold is arbitrarily set by yours truly to:

 - not trigger it for fully unpacked git v0.99 history;

 - do trigger it for fully unpacked git v1.0.0 history;

 - not trigger it for incremental update to git v1.0.0 starting
   from fully packed git v0.99 history.

This patch does not add invocation of the "auto repacking".  It
is left to key Porcelain commands that could produce tons of
loose objects to add a call to "git gc --auto" after they are
done their work.  Obvious candidates are:

	git add
	git fetch
        git merge
        git rebase        

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-gc.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 9397482..093b3dd 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -20,6 +20,7 @@ static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
 
 static int pack_refs = 1;
 static int aggressive_window = -1;
+static int gc_auto_threshold = 6700;
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
@@ -28,6 +29,8 @@ static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
+static const char *argv_repack_auto[] = {"repack", "-d", "-l", NULL};
+
 static int gc_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -41,6 +44,10 @@ static int gc_config(const char *var, const char *value)
 		aggressive_window = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.auto")) {
+		gc_auto_threshold = git_config_int(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -57,10 +64,49 @@ static void append_option(const char **cmd, const char *opt, int max_length)
 	cmd[i] = NULL;
 }
 
+static int need_to_gc(void)
+{
+	/*
+	 * Quickly check if a "gc" is needed, by estimating how
+	 * many loose objects there are.  Because SHA-1 is evenly
+	 * distributed, we can check only one and get a reasonable
+	 * estimate.
+	 */
+	char path[PATH_MAX];
+	const char *objdir = get_object_directory();
+	DIR *dir;
+	struct dirent *ent;
+	int auto_threshold;
+	int num_loose = 0;
+	int needed = 0;
+
+	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
+		warning("insanely long object directory %.*s", 50, objdir);
+		return 0;
+	}
+	dir = opendir(path);
+	if (!dir)
+		return 0;
+
+	auto_threshold = (gc_auto_threshold + 255) / 256;
+	while ((ent = readdir(dir)) != NULL) {
+		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
+		    ent->d_name[38] != '\0')
+			continue;
+		if (++num_loose > auto_threshold) {
+			needed = 1;
+			break;
+		}
+	}
+	closedir(dir);
+	return needed;
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int prune = 0;
+	int auto_gc = 0;
 	char buf[80];
 
 	git_config(gc_config);
@@ -82,12 +128,28 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			}
 			continue;
 		}
-		/* perhaps other parameters later... */
+		if (!strcmp(arg, "--auto")) {
+			if (gc_auto_threshold <= 0)
+				return 0;
+			auto_gc = 1;
+			continue;
+		}
 		break;
 	}
 	if (i != argc)
 		usage(builtin_gc_usage);
 
+	if (auto_gc) {
+		/*
+		 * Auto-gc should be least intrusive as possible.
+		 */
+		prune = 0;
+		for (i = 0; i < ARRAY_SIZE(argv_repack_auto); i++)
+			argv_repack[i] = argv_repack_auto[i];
+		if (!need_to_gc())
+			return 0;
+	}
+
 	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_pack_refs[0]);
 
