From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: [PATCH, 4th version] git-branch: register where to merge from, when
 branching off a remote branch
Date: Fri, 02 Mar 2007 09:50:06 +0100
Message-ID: <45E7E53E.5020704@gnu.org>
References: <es450f$d58$1@sea.gmane.org> <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com> <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com> <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com> <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DC04.5010701@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3T1-0006R2-1n
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbXCBIuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbXCBIuO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:50:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:36448 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422699AbXCBIuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:50:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1208705nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 00:50:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mTSL7tct3+ZFj31ClO4YMbje/9vpm5zJXZBONyGCUTaETory2XKZZ8NvNuTG/2qYbMaOfZ1LZyJFU+oS0mQYn3TBQeQuGHnOq3/+brA9jdygxu8wpq5AepaFNqyBz0uQ7SQB5TNbzyOSIEYowohZy1BvXjxeB2hA4+mp6IxqbpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=p1dA4a2TH/OGRNwl2+IQ3uRxuu7jjmLgG1zXQGaX+vuGqztS5BcmmE2aWYnPg9dEtYrbYG/whkQNsAR7zBVUjtLHDSTe5BGjnoegDmSqRWiTrcWp4ITFSVHHq2IzPsu05cOl4gv5SwekjiXk4EF2/oiGgctu0MKVKUF+Ka93BA8=
Received: by 10.49.92.18 with SMTP id u18mr7296885nfl.1172825409816;
        Fri, 02 Mar 2007 00:50:09 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id y6sm4233448mug.2007.03.02.00.50.07;
        Fri, 02 Mar 2007 00:50:08 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <45E7DC04.5010701@lu.unisi.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41169>

A rather standard (in 1.5) procedure for branching off a remote archive
is:

  git checkout -b branchname remote/upstreambranch
  git config --add branch.branchname.remote remote
  git config --add branch.branchname.merge refs/heads/upstreambranch

In this case, we can save the user some effort if "git branch" (and
"git checkout -b") automatically do the two "git-config --add"s when the
source branch is remote.  There is a good chance that some user wants
to merge something different, but in that case they have to specify what
to merge _anyway_.

The behavior is controlled by core.trackremotebranches (off by default;
subject to review later), and can be fine-grained to a specific invocation
of "git branch" using the new --track and --no-track options.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/git-branch.txt |    9 ++++++
 builtin-branch.c             |   56 ++++++++++++++++++++++++++++++++++++-------
 cache.h                      |    1 
 config.c                     |    5 +++
 environment.c                |    1 
 5 files changed, 63 insertions(+), 9 deletions(-)

	Includes comments by Johannes Schindelin on not using xmalloc for
	buffers, and better variable names.  Default is "false" in this
	version, unlike previous versions.

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index aa1fdd4..4ccbb3c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]
-'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
@@ -25,6 +25,13 @@ It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
 
+When a local branch is started off a remote branch, git can setup
+the branch so that gitlink:git-pull[1] will appropriately merge from
+that remote branch.  If this behavior is desired, it is possible
+to make it the default using the `core.trackremotebranches` option.
+Otherwise, it can be chosen per-branch using the `--track` and
+`--no-track` options.
+
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
diff --git a/builtin-branch.c b/builtin-branch.c
index d0179b0..96658ff 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -308,15 +308,34 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
+static void register_pull (const char *name, const char *remote_branch_name)
+{
+	char *slash = strchr(remote_branch_name, '/');
+	char key[1024], value[1024];
+
+	if (strlen(remote_branch_name) >= 1024 - 11
+	    || strlen(name) >= 1024 - 15)
+		die ("what a long branch name you have!");
+
+	snprintf(key, sizeof(key), "branch.%s.remote", name);
+	snprintf(value, sizeof(value), "%.*s", slash - remote_branch_name,
+		 remote_branch_name);
+	git_config_set(key, value);
+
+	snprintf(key, sizeof(key), "branch.%s.merge", name);
+	snprintf(value, sizeof(value), "refs/heads/%s", slash + 1);
+	git_config_set(key, value);
+}
+
 static void create_branch(const char *name, const char *start_name,
 			  unsigned char *start_sha1,
-			  int force, int reflog)
+			  int force, int reflog, int track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
-	int forcing = 0;
+	char *real_ref = NULL, ref[PATH_MAX], msg[PATH_MAX + 20];
+	int forcing = 0, remote = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -333,7 +354,9 @@ static void create_branch(const char *name, const char *start_name,
 	if (start_sha1)
 		/* detached HEAD */
 		hashcpy(sha1, start_sha1);
-	else if (get_sha1(start_name, sha1))
+	else if (dwim_ref(start_name, strlen (start_name), sha1, &real_ref))
+		remote = !prefixcmp(real_ref, "refs/remotes/");
+	else
 		die("Not a valid object name: '%s'.", start_name);
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
@@ -354,8 +377,16 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  */
+	if (remote && track)
+		register_pull (name, real_ref + 13);
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free (real_ref);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -397,11 +428,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
 	git_config(git_branch_config);
+	track = track_remote_branches;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -412,6 +444,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			i++;
 			break;
 		}
+		if (!strcmp(arg, "--track")) {
+			track = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-track")) {
+			track = 0;
+			continue;
+		}
 		if (!strcmp(arg, "-d")) {
 			delete = 1;
 			continue;
@@ -490,9 +530,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
 	else if (i == argc - 1)
-		create_branch(argv[i], head, head_sha1, force_create, reflog);
+		create_branch(argv[i], head, head_sha1, force_create, reflog,
+			      track);
 	else if (i == argc - 2)
-		create_branch(argv[i], argv[i+1], NULL, force_create, reflog);
+		create_branch(argv[i], argv[i+1], NULL, force_create, reflog,
+			      track);
 	else
 		usage(builtin_branch_usage);
 
diff --git a/cache.h b/cache.h
index 8bbc142..585a9b4 100644
--- a/cache.h
+++ b/cache.h
@@ -205,6 +205,7 @@ extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
+extern int track_remote_branches;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
diff --git a/config.c b/config.c
index 0ff413b..49df7bd 100644
--- a/config.c
+++ b/config.c
@@ -294,6 +294,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.trackremotebranches")) {
+		track_remote_branches = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.legacyheaders")) {
 		use_legacy_headers = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 570e32a..e440d05 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@ int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
+int track_remote_branches = 0;
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char *git_commit_encoding;
