From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rewriting git-repack.sh in C
Date: Fri, 2 Aug 2013 23:36:59 +0700
Message-ID: <20130802163659.GA28693@lanh>
References: <51FBB8CB.8020600@googlemail.com>
 <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 18:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ILB-0002UZ-AW
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 18:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab3HBQg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Aug 2013 12:36:29 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46109 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab3HBQg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 12:36:27 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so871392pbc.21
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/MrIWTxKVRqcHGx9++tZjnpz2MF/LQ9Erl5ZQdejA94=;
        b=ChRY2LMvaZuupD376p5lUOiVjSgP9/59GhCs6uAqvqo21POtvdIISgl4eM8Yn0aqo1
         vpAh5swhU1jzgcC2ia19fxSH1l4+UHgbC03Lm6sI+drUAPSJxVU0rk0xmsrh+tXdwTgE
         JsQ37XmZiNN0TE0f3pnHpLFvBZykUUe1VizWDafeianf66eduCYaN9qkDUHDdyJ3iadl
         YDlS3HbplYVVcGvS0If7/vVrdhMGmwkMSkwUyf2LUKBwVC10S5K2536JaRGlLWua0UFB
         Lkb/HHX9z+WL1vRMwJN6kbXJtzw/17SO5ISrU9jTdiQ0SHZ3F+Zw+eCVbLJpXZK7UcnO
         4SgQ==
X-Received: by 10.68.235.102 with SMTP id ul6mr8880398pbc.14.1375461386223;
        Fri, 02 Aug 2013 09:36:26 -0700 (PDT)
Received: from lanh ([115.73.207.46])
        by mx.google.com with ESMTPSA id kc8sm8544514pbc.18.2013.08.02.09.36.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 09:36:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 02 Aug 2013 23:36:59 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231530>

On Fri, Aug 02, 2013 at 09:10:59PM +0700, Duy Nguyen wrote:
> On Fri, Aug 2, 2013 at 8:48 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
> > Hello,
> >
> > I'd like to rewrite the repack shell script in C.
> > So I tried the naive approach reading the man page and
> > the script itself and write C program by matching each block/line
> > of the script with a function in C
> >
> > ...
> >
> > So my question is, how you'd generally approach rewriting a
> > shell script in C.
>=20
> Start a new process via start_command/run_command interface. It's
> safer to retain the process boundary at this stage. You can try to
> integrate further later.

I was in the middle of something and somehow read this as "rewriting
git-rebase.sh" :-X

=46or git-repack, because it ends with a single pack-objects call, we
might not need a new process after all (very much like tail call
optimization). This is what I got for some time, but still not polish
it for submission (and it may be a bit broken after the last
rebase). Maybe you can work off this, or from scratch if you think
it's too messy. It basically teaches pack-objects extra features that
repack needs, then make repack a wrapper of pack-objects.

-- 8< --
commit 25569a3958c3272b3eb5fa50dea680948f7a2768 (build-in-repack)
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Wed Nov 9 19:21:39 2011 +0700

    Build in git-repack
   =20
    pack-objects learns a few more options to take over what's been don=
e
    by git-repack.sh. cmd_repack() becomes a wrapper around
    cmd_pack_objects().

diff --git a/Makefile b/Makefile
index 0f931a2..b4010a6 100644
--- a/Makefile
+++ b/Makefile
@@ -460,7 +460,6 @@ SCRIPT_SH +=3D git-mergetool.sh
 SCRIPT_SH +=3D git-pull.sh
 SCRIPT_SH +=3D git-quiltimport.sh
 SCRIPT_SH +=3D git-rebase.sh
-SCRIPT_SH +=3D git-repack.sh
 SCRIPT_SH +=3D git-request-pull.sh
 SCRIPT_SH +=3D git-stash.sh
 SCRIPT_SH +=3D git-submodule.sh
@@ -584,6 +583,7 @@ BUILT_INS +=3D git-init$X
 BUILT_INS +=3D git-merge-subtree$X
 BUILT_INS +=3D git-peek-remote$X
 BUILT_INS +=3D git-repo-config$X
+BUILT_INS +=3D git-repack$X
 BUILT_INS +=3D git-show$X
 BUILT_INS +=3D git-stage$X
 BUILT_INS +=3D git-status$X
diff --git a/builtin.h b/builtin.h
index 64bab6b..feb958f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -117,6 +117,7 @@ extern int cmd_reflog(int argc, const char **argv, =
const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_remote_ext(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *pref=
ix);
+extern int cmd_repack(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_repo_config(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..1742ea1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -18,10 +18,17 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "sigchain.h"
=20
 static const char *pack_usage[] =3D {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-lis=
t]"),
 	N_("git pack-objects [options...] base-name [< ref-list | < object-li=
st]"),
+	N_("git pack-objects --repack [options...]"),
+	NULL
+};
+
+static char const * const repack_usage[] =3D {
+	N_("git repack [options]"),
 	NULL
 };
=20
@@ -103,6 +110,15 @@ static struct object_entry *locate_object_entry(co=
nst unsigned char *sha1);
 static uint32_t written, written_delta;
 static uint32_t reused, reused_delta;
=20
+#define REPACK_IN_PROGRESS		(1 << 0)
+#define REPACK_UPDATE_INFO		(1 << 1)
+#define REPACK_ALL_INTO_ONE		(1 << 2)
+#define REPACK_REMOVE_REDUNDANT		(1 << 3)
+
+static int repack_flags, nr_written_packs;
+static int repack_usedeltabaseoffset;
+static struct string_list written_packs;
+static struct string_list backup_files;
=20
 static void *get_delta(struct object_entry *entry)
 {
@@ -792,9 +808,19 @@ static void write_pack_file(void)
 			snprintf(tmpname, sizeof(tmpname), "%s-", base_name);
 			finish_tmp_packfile(tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, sha1);
+					    &pack_idx_opts, sha1,
+					    repack_flags & REPACK_IN_PROGRESS ?
+					    &backup_files : NULL);
 			free(pack_tmp_name);
-			puts(sha1_to_hex(sha1));
+			if (repack_flags & REPACK_IN_PROGRESS) {
+				int len =3D strlen(tmpname);
+				char *s =3D xmalloc(len + 2);
+				memcpy(s, tmpname, len - 4);
+				memcpy(s + len - 4, ".pack", 6);
+				string_list_append(&written_packs, s);
+				nr_written_packs++;
+			} else
+				puts(sha1_to_hex(sha1));
 		}
=20
 		/* mark written objects as written to previous pack */
@@ -2359,7 +2385,8 @@ static void get_object_list(int ac, const char **=
av)
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
-	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
+	while (!(repack_flags & REPACK_IN_PROGRESS) &&
+	       fgets(line, sizeof(line), stdin) !=3D NULL) {
 		int len =3D strlen(line);
 		if (len && line[len - 1] =3D=3D '\n')
 			line[--len] =3D 0;
@@ -2387,6 +2414,30 @@ static void get_object_list(int ac, const char *=
*av)
 		loosen_unused_packed_objects(&revs);
 }
=20
+static void rollback_repack(void)
+{
+	struct strbuf dst =3D STRBUF_INIT;
+	int i, ret;
+	for (i =3D 0; i < backup_files.nr; i++) {
+		const char *src =3D backup_files.items[i].string;
+		strbuf_addstr(&dst, src);
+		strbuf_setlen(&dst, dst.len - 4); /* remove .old */
+		ret =3D rename(src, dst.buf);
+		if (ret)
+			warning("failed to restore %s: %s", src, strerror(errno));
+		strbuf_setlen(&dst, 0);
+	}
+	strbuf_release(&dst);
+	string_list_clear(&backup_files, 0);
+}
+
+static void rollback_repack_on_signal(int signo)
+{
+	rollback_repack();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -2436,11 +2487,12 @@ static int option_parse_ulong(const struct opti=
on *opt,
=20
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf repack_base_name =3D STRBUF_INIT;
 	int use_internal_rev_list =3D 0;
 	int thin =3D 0;
 	int all_progress_implied =3D 0;
 	const char *rp_av[6];
-	int rp_ac =3D 0;
+	int i, rp_ac =3D 0;
 	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D =
0;
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -2505,6 +2557,16 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
 			    N_("do not hide commits by grafts"), 0),
+
+		OPT_BIT(0, "repack", &repack_flags,
+			N_("repack mode"), REPACK_IN_PROGRESS),
+		OPT_BIT(0, "repack-all", &repack_flags,
+			N_("repack everything into one pack"), REPACK_ALL_INTO_ONE),
+		OPT_BIT(0, "remove-redundant", &repack_flags,
+			N_("remove redundant objects after repack"), REPACK_REMOVE_REDUNDAN=
T),
+		OPT_BIT(0, "update-info", &repack_flags,
+			N_("run git-update-server-info after repack"), REPACK_UPDATE_INFO),
+
 		OPT_END(),
 	};
=20
@@ -2556,6 +2618,36 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 	if (delta_search_threads !=3D 1)
 		warning("no threads support, ignoring --threads");
 #endif
+	if ((repack_flags & REPACK_IN_PROGRESS) =3D=3D 0 &&
+	    (repack_flags & ~REPACK_IN_PROGRESS))
+		die("--repack must be given for any repack related options");
+	if (repack_flags & REPACK_IN_PROGRESS) {
+		if (pack_to_stdout)
+			die("--stdout cannot be used with --repack");
+		if (argc)
+			die("base name cannot be used with --repack");
+
+		rp_av[rp_ac++] =3D "--all";
+		rp_av[rp_ac++] =3D "--reflog";
+		use_internal_rev_list =3D 1;
+
+		grafts_replace_parents =3D 0; /* --keep-true-parents */
+		ignore_packed_keep =3D 1;	    /* --honor-pack-keep */
+		non_empty =3D 1;		    /* --non-empty */
+
+		if (!(repack_flags & REPACK_ALL_INTO_ONE)) {
+			incremental =3D 1; /* --incremental */
+			rp_av[rp_ac++] =3D "--unpacked";
+		}
+
+		strbuf_addf(&repack_base_name,
+			    "%s/pack/pack", get_object_directory());
+		base_name =3D repack_base_name.buf;
+
+		sigchain_push_common(rollback_repack_on_signal);
+		atexit(rollback_repack);
+	}
+
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit =3D pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
@@ -2598,5 +2690,184 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
 		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
 			" reused %"PRIu32" (delta %"PRIu32")\n",
 			written, written_delta, reused, reused_delta);
+
+	if (!(repack_flags & REPACK_IN_PROGRESS))
+		return 0;
+
+	if (!nr_written_packs) {
+		printf(_("Nothing new to pack.\n"));
+		return 0;
+	}
+
+	/* At this point all new packs should be in place. We can
+	   safely remove old ones */
+	for (i =3D 0; i < backup_files.nr; i++) {
+		const char *s =3D backup_files.items[i].string;
+		int ret =3D unlink(s);
+		if (ret)
+			warning("failed to remove %s: %s", s, strerror(errno));
+	}
+	string_list_clear(&backup_files, 0);
+
+	if (repack_flags & REPACK_REMOVE_REDUNDANT) {
+		struct packed_git *p;
+		struct string_list to_be_removed =3D STRING_LIST_INIT_DUP;
+
+		/* free_pack_by_name() may have freed a few packs in
+		   write_pack_file() */
+		reprepare_packed_git();
+		for (p =3D packed_git; p; p =3D p->next) {
+			if (!p->pack_local || p->pack_keep)
+				continue;
+
+			for (i =3D 0; i < written_packs.nr; i++) {
+				char *s =3D written_packs.items[i].string;
+				if (!strcmp(s, p->pack_name))
+					break;
+			}
+			if (i < written_packs.nr)
+				continue;
+
+			string_list_append(&to_be_removed, p->pack_name);
+		}
+		written_packs.strdup_strings =3D 1;
+		string_list_clear(&written_packs, 0);
+
+		for (i =3D 0; i < to_be_removed.nr; i++) {
+			char *path =3D to_be_removed.items[i].string;
+
+			/* Windows limitation on unlink().
+			   See c74faea19e39ca933492f697596310397175c329 */
+			free_pack_by_name(path);
+
+			if (unlink(path))
+				warning("failed to remove %s: %s", path, strerror(errno));
+			strcpy(path + strlen(path)-5, ".idx");
+			if (unlink(path))
+				warning("failed to remove %s: %s", path, strerror(errno));
+		}
+		string_list_clear(&to_be_removed, 0);
+
+		reprepare_packed_git();
+		prune_packed_objects(progress ? PRUNE_PACKED_VERBOSE : 0);
+	}
+
+	if (repack_flags & REPACK_UPDATE_INFO)
+		update_server_info(0);
+
 	return 0;
 }
+
+static int repack_config(const char *k, const char *v, void *cb)
+{
+	if (!strcasecmp(k, "repack.usedeltabaseoffset")) {
+		repack_usedeltabaseoffset =3D git_config_bool(k, v);
+		return 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
+int cmd_repack(int argc, const char **argv, const char *prefix)
+{
+	int all_in_one =3D 0;
+	int all_in_one_and_unreachable =3D 0;
+	int unpack_unreachable =3D 0;
+	int remove_redundant =3D 0;
+	int no_reuse_delta =3D 0;
+	int no_reuse_object =3D 0;
+	int no_update =3D 0;
+	int quiet =3D 0;
+	int local =3D 0;
+
+	struct option opts[] =3D {
+		OPT_BOOL('a', NULL, &all_in_one,
+			 "pack everything in a single pack"),
+		OPT_BOOL('A', NULL, &all_in_one_and_unreachable,
+			 "same as -a, and turn unreachable objects loose"),
+		OPT_BOOL('d', NULL, &remove_redundant,
+			 "remove redundant packs, and run git-prune-packed"),
+		OPT_BOOL('f', NULL, &no_reuse_delta,
+			 "pass --no-reuse-delta to git-pack-objects"),
+		OPT_BOOL('F', NULL, &no_reuse_object,
+			 "pass --no-reuse-object to git-pack-objects"),
+		OPT_BOOL('n', NULL, &no_update,
+			 "do not run git-update-server-info"),
+		OPT_BOOL('q', NULL, &quiet, "be quiet"),
+		OPT_BOOL('l', NULL, &local,
+			 "pass --local to git-pack-objects"),
+		{ OPTION_ARGUMENT, 0, "window", NULL, "n",
+		 "size of the window used for delta compression", 0 },
+		{ OPTION_ARGUMENT, 0, "window-memory", NULL, "n",
+		  "same as the above, but limit memory size instead of entries count=
", 0 },
+		{ OPTION_ARGUMENT, 0, "depth", NULL, "n",
+		  "limits the maximum delta depth", 0 },
+		{ OPTION_ARGUMENT, 0, "max-pack-size", NULL, "n",
+		  "maximum size of each packfile", 0},
+		OPT_END(),
+	};
+
+	const char *av[] =3D { "pack-objects", "--repack",
+			     NULL, /* --[no-]update-info */
+			     NULL, /* --delta-base-offset */
+			     NULL, /* --repack-all */
+			     NULL, /* --remove-redundant */
+			     NULL, /* --no-reuse-delta */
+			     NULL, /* --no-reuse-object */
+			     NULL, /* --local */
+			     NULL, /* -q */
+			     NULL, /* --unpack-unreachable */
+			     NULL, /* --window */
+			     NULL, /* --window-memory */
+			     NULL, /* --depth */
+			     NULL, /* --max-pack-size */
+			     NULL
+	};
+	int ac =3D 2;
+
+	git_config(repack_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, opts, repack_usage, 0);
+
+	if (no_update)
+		av[ac++] =3D "--no-update-info";
+	else
+		av[ac++] =3D "--update-info";
+	if (repack_usedeltabaseoffset)
+		av[ac++] =3D "--delta-base-offset";
+	if (all_in_one_and_unreachable) {
+		av[ac++] =3D "--repack-all";
+		all_in_one =3D 1;
+		unpack_unreachable =3D 1;
+	}
+	if (all_in_one)
+		av[ac++] =3D "--repack-all";
+	if (remove_redundant)
+		av[ac++] =3D "--remove-redundant";
+	if (no_reuse_delta)
+		av[ac++] =3D "--no-reuse-delta";
+	if (no_reuse_object)
+		av[ac++] =3D "--no-reuse-object";
+	if (local)
+		av[ac++] =3D "--local";
+	if (quiet)
+		av[ac++] =3D "-q";
+	if ((ac + argc) * sizeof(*av) > sizeof(av))
+		die("Too many options");
+	memcpy(av + ac, argv, argc * sizeof(*argv));
+	ac +=3D argc;
+
+	if (all_in_one && remove_redundant) {
+		struct packed_git *p;
+
+		prepare_packed_git();
+		for (p =3D packed_git; p; p =3D p->next) {
+			if (!p->pack_keep &&
+			    unpack_unreachable && remove_redundant) {
+				av[ac++] =3D "--unpack-unreachable";
+				break;
+			}
+		}
+	}
+
+	return cmd_pack_objects(ac, av, prefix);
+}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6b0b6d4..3ca3c55 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -46,7 +46,7 @@ static void finish_bulk_checkin(struct bulk_checkin_s=
tate *state)
 	sprintf(packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, sha1);
+			    &state->pack_idx_opts, sha1, NULL);
 	for (i =3D 0; i < state->nr_written; i++)
 		free(state->written[i]);
=20
diff --git a/git-repack.sh b/contrib/examples/git-repack.sh
similarity index 100%
rename from git-repack.sh
rename to contrib/examples/git-repack.sh
diff --git a/git.c b/git.c
index 1ada169..db4e4b3 100644
--- a/git.c
+++ b/git.c
@@ -389,6 +389,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
+		{ "repack", cmd_repack, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..e6aa7e3 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "string-list.h"
=20
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -348,10 +349,12 @@ void finish_tmp_packfile(char *name_buffer,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char sha1[])
+			 unsigned char sha1[],
+			 struct string_list *backup_files)
 {
 	const char *idx_tmp_name;
 	char *end_of_name_prefix =3D strrchr(name_buffer, 0);
+	struct stat st;
=20
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -368,6 +371,14 @@ void finish_tmp_packfile(char *name_buffer,
 		die_errno("unable to rename temporary pack file");
=20
 	sprintf(end_of_name_prefix, "%s.idx", sha1_to_hex(sha1));
+	if (backup_files && !stat(name_buffer, &st)) {
+		struct strbuf old =3D STRBUF_INIT;
+		strbuf_addf(&old, "%s.old", name_buffer);
+		if (rename(name_buffer, old.buf))
+			die_errno("unable to rename pack %s", name_buffer);
+		string_list_append(backup_files, strbuf_detach(&old, NULL));
+	}
+	backup_file(name_buffer);
 	if (rename(idx_tmp_name, name_buffer))
 		die_errno("unable to rename temporary index file");
=20
diff --git a/pack.h b/pack.h
index aa6ee7d..d3f92ad 100644
--- a/pack.h
+++ b/pack.h
@@ -90,7 +90,9 @@ extern int encode_in_pack_object_header(enum object_t=
ype, uintmax_t, unsigned ch
 #define PH_ERROR_PROTOCOL	(-3)
 extern int read_pack_header(int fd, struct pack_header *);
=20
+struct string_list;
+
 extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(char *name_buffer, const char *pack_tm=
p_name, struct pack_idx_entry **written_list, uint32_t nr_written, stru=
ct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+extern void finish_tmp_packfile(char *name_buffer, const char *pack_tm=
p_name, struct pack_idx_entry **written_list, uint32_t nr_written, stru=
ct pack_idx_option *pack_idx_opts, unsigned char sha1[], struct string_=
list *backup_files);
=20
 #endif
-- 8< --
