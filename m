From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply,
 index-pack and bundle
Date: Tue, 24 Apr 2012 19:19:53 +0700
Message-ID: <20120424121953.GA25944@do>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 14:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMem8-0001An-9r
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 14:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab2DXMXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 08:23:15 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:57159 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab2DXMXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 08:23:13 -0400
Received: by dadz8 with SMTP id z8so851144dad.10
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0jXETuHfVeRek7HRHw/JRqjOYHd74LWFhvpkRFg6ZWk=;
        b=xZFuUQpQany+mufsvLpEu3xVWbhOblrCatWk1EGJi6WKzLw17Pdt2+zRXm0Z3BcVos
         1+G43epd5QgXpuUnZD3n9fe8hJjpcNyPdqx4qg7awQluDRLxmxrCWQY71U81rAnsejo8
         eoY6+fJOizw6kXeV1uvNlf5Yg6QefgfHDT6732Pj077cHQzt8frsyjHgyN1GiG92ufAb
         DvYdfhQVZtae2TBUETksGeRC6xjmzEkX/ndSCpL3czpomHut5bn+RbqEySNbkm0myxit
         qXBjz7vCza8tqyl85YnSi3r1EqxcIdyCQP0j8izMVF3tQ74OuYWEdTVME5pKBOKlPuFr
         E2MA==
Received: by 10.68.222.67 with SMTP id qk3mr3508497pbc.137.1335270192507;
        Tue, 24 Apr 2012 05:23:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.101])
        by mx.google.com with ESMTPS id i8sm17282523pbf.72.2012.04.24.05.23.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 05:23:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 24 Apr 2012 19:19:53 +0700
Content-Disposition: inline
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196221>

On Mon, Apr 23, 2012 at 07:30:20PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> I attempted to
> convert all struct option, and it turned into a huge series [2]. Not
> sure how to submit that series yet.
>
> [2] https://github.com/pclouds/git/tree/parseopt-i18n

The 62 patch series looks lame compared to this approach, but cross
compile guys, including myself, will hate me in principle.

The idea is modify all git commands and output all marked strings in
"struct option" and usage strings, instead of manually marking them
one by one. The marked strings will be collected by xgettext just like
another source file.

This adds a runnable git as a dependency to git.pot. But changes are
much cleaner and devs don't need to care about i18n when they update
"struct option". Big plus to me. Introduction of new parse_options()
call sites still require attention though.

Just a PoC patch for string generation (about 1000 new strings by the
way). When GIT_I18N is set, git will print then quit. Good to go?

-- 8< --
diff --git a/Makefile b/Makefile
index dab7362..5de3f1f 100644
--- a/Makefile
+++ b/Makefile
@@ -2306,8 +2306,18 @@ LOCALIZED_SH +=3D t/t0200/test.sh
 LOCALIZED_PERL +=3D t/t0200/test.perl
 endif
=20
+I18N_CMDS =3D
+I18N_CMDS +=3D add apply archive bisect--helper branch cat-file check-=
attr checkout checkout-index
+I18N_CMDS +=3D cherry cherry-pick clean clone commit config count-obje=
cts describe fast-export fetch
+I18N_CMDS +=3D fmt-merge-msg for-each-ref format-patch fsck gc grep ha=
sh-object init-db log ls-files
+I18N_CMDS +=3D ls-tree merge merge-base merge-file mktree mv name-rev =
notes pack-objects pack-refs
+I18N_CMDS +=3D prune prune-packed push read-tree remote replace rerere=
 reset revert rm shortlog show-branch
+I18N_CMDS +=3D show-ref status symbolic-ref tag update-index update-re=
f update-server-info verify-pack
+I18N_CMDS +=3D verify-tag write-tree
+
 po/git.pot: $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
+	for cmd in $(I18N_CMDS); do GIT_I18N=3D1 ./git $$cmd; done > text.c
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)=
 text.c
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_S=
H) \
 		$(LOCALIZED_SH)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_P=
ERL) \
diff --git a/archive.c b/archive.c
index 1ee837d..311fd18 100644
--- a/archive.c
+++ b/archive.c
@@ -361,6 +361,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 		OPT_END()
 	};
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__, opts, archive_usage=
))
+		exit(0);
 	argc =3D parse_options(argc, argv, NULL, opts, archive_usage, 0);
=20
 	if (remote)
diff --git a/builtin/add.c b/builtin/add.c
index b79336d..2d886f6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -375,6 +375,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	git_config(add_config, NULL);
=20
+	GEN_PARSEOPT(builtin_add_options, builtin_add_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..1d02cf7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3916,6 +3916,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
=20
+	GEN_PARSEOPT(builtin_apply_options, apply_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
=20
diff --git a/builtin/archive.c b/builtin/archive.c
index 931956d..545f82e 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -97,6 +97,12 @@ int cmd_archive(int argc, const char **argv, const c=
har *prefix)
 		OPT_END()
 	};
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__, local_opts, NULL)) =
{
+		/* dummy args just enough to get to parse_archive_args() */
+		write_archive(0, NULL, NULL, 0, NULL, 0);
+		assert(!"archive.c:parse_archive_args() should have called exit(0)")=
;
+		return 0;
+	}
 	argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
=20
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8d325a5..4155f31 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,6 +20,7 @@ int cmd_bisect__helper(int argc, const char **argv, c=
onst char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_bisect_helper_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
=20
diff --git a/builtin/blame.c b/builtin/blame.c
index a9845bb..1431ea0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2322,6 +2322,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 	save_commit_buffer =3D 0;
 	dashdash_pos =3D 0;
=20
+	GEN_PARSEOPT(options, blame_opt_usage);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
diff --git a/builtin/branch.c b/builtin/branch.c
index d8cccf7..488e643 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -734,6 +734,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		OPT_END(),
 	};
=20
+	GEN_PARSEOPT(options, builtin_branch_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 36a9104..8ea3891 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -282,6 +282,7 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
=20
 	git_config(git_cat_file_config, NULL);
=20
+	GEN_PARSEOPT(options, cat_file_usage);
 	if (argc !=3D 3 && argc !=3D 2)
 		usage_with_options(cat_file_usage, options);
=20
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 44c421e..e31acba 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -96,6 +96,7 @@ int cmd_check_attr(int argc, const char **argv, const=
 char *prefix)
=20
 	git_config(git_default_config, NULL);
=20
+	GEN_PARSEOPT(check_attr_options, check_attr_usage);
 	argc =3D parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
=20
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c16d82b..8b784de 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -220,6 +220,7 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 		die("invalid cache");
 	}
=20
+	GEN_PARSEOPT(builtin_checkout_index_options, builtin_checkout_index_u=
sage);
 	argc =3D parse_options(argc, argv, prefix, builtin_checkout_index_opt=
ions,
 			builtin_checkout_index_usage, 0);
 	state.force =3D force;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6b9061f..58c27b4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -964,6 +964,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
=20
 	opts.track =3D BRANCH_TRACK_UNSPECIFIED;
=20
+	GEN_PARSEOPT(options, checkout_usage);
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..77bb90d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -67,6 +67,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	else
 		config_set =3D 1;
=20
+	GEN_PARSEOPT(options, builtin_clean_usage);
 	argc =3D parse_options(argc, argv, prefix, options, builtin_clean_usa=
ge,
 			     0);
=20
diff --git a/builtin/clone.c b/builtin/clone.c
index bbd5c96..b8837ef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -632,6 +632,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	junk_pid =3D getpid();
=20
 	packet_trace_identity("clone");
+	GEN_PARSEOPT(builtin_clone_options, builtin_clone_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 7808be3..7de09ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1229,6 +1229,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_END(),
 	};
=20
+	GEN_PARSEOPT(builtin_status_options, builtin_status_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
=20
@@ -1416,6 +1417,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	struct commit *current_head =3D NULL;
 	struct commit_extra_header *extra =3D NULL;
=20
+	GEN_PARSEOPT(builtin_commit_options, builtin_commit_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
=20
diff --git a/builtin/config.c b/builtin/config.c
index 33c8820..3389778 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -369,6 +369,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
=20
 	given_config_file =3D getenv(CONFIG_ENVIRONMENT);
=20
+	GEN_PARSEOPT(builtin_config_options, builtin_config_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..5c2756e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -83,6 +83,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 		OPT_END(),
 	};
=20
+	GEN_PARSEOPT(opts, count_objects_usage);
 	argc =3D parse_options(argc, argv, prefix, opts, count_objects_usage,=
 0);
 	/* we do not take arguments other than flags for now */
 	if (argc)
diff --git a/builtin/describe.c b/builtin/describe.c
index 9f63067..11b5858 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -421,6 +421,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, describe_usage);
 	argc =3D parse_options(argc, argv, prefix, options, describe_usage, 0=
);
 	if (abbrev < 0)
 		abbrev =3D DEFAULT_ABBREV;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 19509ea..88ff132 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -651,6 +651,7 @@ int cmd_fast_export(int argc, const char **argv, co=
nst char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, fast_export_usage);
 	if (argc =3D=3D 1)
 		usage_with_options (fast_export_usage, options);
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..f8c624b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -953,6 +953,7 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 	for (i =3D 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
=20
+	GEN_PARSEOPT(builtin_fetch_options, builtin_fetch_usage);
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c81a7fe..98917f5 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -451,6 +451,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, =
const char *prefix)
 	struct fmt_merge_msg_opts opts;
=20
 	git_config(fmt_merge_msg_config, NULL);
+	GEN_PARSEOPT(options, fmt_merge_msg_usage);
 	argc =3D parse_options(argc, argv, prefix, options, fmt_merge_msg_usa=
ge,
 			     0);
 	if (argc > 0)
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..26b9404 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1005,6 +1005,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
 		OPT_END(),
 	};
=20
+	GEN_PARSEOPT(opts, for_each_ref_usage);
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a710227..51fccd1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -633,6 +633,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 	errors_found =3D 0;
 	read_replace_refs =3D 0;
=20
+	GEN_PARSEOPT(fsck_opts,  fsck_usage);
 	argc =3D parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
=20
 	if (show_progress =3D=3D -1)
diff --git a/builtin/gc.c b/builtin/gc.c
index 271376d..49e57ee 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -197,6 +197,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	if (pack_refs < 0)
 		pack_refs =3D !is_bare_repository();
=20
+	GEN_PARSEOPT(builtin_gc_options, builtin_gc_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
 	if (argc > 0)
diff --git a/builtin/grep.c b/builtin/grep.c
index 643938d..5808242 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -790,6 +790,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
 	 */
+	GEN_PARSEOPT(options, grep_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(grep_usage, options);
=20
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 33911fd..50af09e 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -86,6 +86,7 @@ int cmd_hash_object(int argc, const char **argv, cons=
t char *prefix)
=20
 	type =3D blob_type;
=20
+	GEN_PARSEOPT(hash_object_options, hash_object_usage);
 	argc =3D parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
=20
diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..b189d3f 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -419,6 +419,7 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
=20
+	GEN_PARSEOPT(builtin_help_options, builtin_help_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format =3D help_format;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0dacb8b..f63a7de 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -495,6 +495,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(init_db_options, init_db_usage);
 	argc =3D parse_options(argc, argv, prefix, init_db_options, init_db_u=
sage, 0);
=20
 	if (real_git_dir && !is_absolute_path(real_git_dir))
diff --git a/builtin/log.c b/builtin/log.c
index 02d070b..28b4706 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -103,6 +103,8 @@ static void cmd_log_init_finish(int argc, const cha=
r **argv, const char *prefix,
 		OPT_END()
 	};
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__, builtin_log_options=
, builtin_log_usage))
+		exit(0);
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
@@ -1165,6 +1167,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
 	 * possibly a valid SHA1.
 	 */
+	GEN_PARSEOPT(builtin_format_patch_options, builtin_format_patch_usage=
);
 	argc =3D parse_options(argc, argv, prefix, builtin_format_patch_optio=
ns,
 			     builtin_format_patch_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
@@ -1500,6 +1503,7 @@ int cmd_cherry(int argc, const char **argv, const=
 char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, cherry_usage);
 	argc =3D parse_options(argc, argv, prefix, options, cherry_usage, 0);
=20
 	switch (argc) {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..7cc7b98 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -500,6 +500,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(builtin_ls_files_options, ls_files_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6b666e1..41d7940 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -150,6 +150,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (prefix && *prefix)
 		chomp_prefix =3D strlen(prefix);
=20
+	GEN_PARSEOPT(ls_tree_options, ls_tree_usage);
 	argc =3D parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
 	if (full_tree) {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 4f30f1b..6e663a6 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -86,6 +86,7 @@ int cmd_merge_base(int argc, const char **argv, const=
 char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, merge_base_usage);
 	argc =3D parse_options(argc, argv, prefix, options, merge_base_usage,=
 0);
 	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 237abd3..31336c4 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -57,6 +57,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 			xmp.style =3D git_xmerge_style;
 	}
=20
+	GEN_PARSEOPT(options, merge_file_usage);
 	argc =3D parse_options(argc, argv, prefix, options, merge_file_usage,=
 0);
 	if (argc !=3D 3)
 		usage_with_options(merge_file_usage, options);
diff --git a/builtin/merge.c b/builtin/merge.c
index 08e01e8..8c0fc7f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1153,6 +1153,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit_list **remotes =3D &remoteheads;
 	void *branch_to_free;
=20
+	GEN_PARSEOPT(builtin_merge_options, builtin_merge_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
=20
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4ae1c41..d842fee 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -156,6 +156,7 @@ int cmd_mktree(int ac, const char **av, const char =
*prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(option, mktree_usage);
 	ac =3D parse_options(ac, av, prefix, option, mktree_usage, 0);
=20
 	while (!got_eof) {
diff --git a/builtin/mv.c b/builtin/mv.c
index 2a144b0..c3a4efa 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -72,6 +72,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
=20
 	git_config(git_default_config, NULL);
=20
+	GEN_PARSEOPT(builtin_mv_options, builtin_mv_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_mv_options,
 			     builtin_mv_usage, 0);
 	if (--argc < 1)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 1b37458..5b4fc54 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -240,6 +240,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(opts, name_rev_usage);
 	argc =3D parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (!!all + !!transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..33eca95 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -492,6 +492,7 @@ static int list(int argc, const char **argv, const =
char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_list_usage);
 	if (argc)
 		argc =3D parse_options(argc, argv, prefix, options,
 				     git_notes_list_usage, 0);
@@ -547,6 +548,7 @@ static int add(int argc, const char **argv, const c=
har *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_add_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_notes_add_usa=
ge,
 			     PARSE_OPT_KEEP_ARGV0);
=20
@@ -619,6 +621,7 @@ static int copy(int argc, const char **argv, const =
char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_copy_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_notes_copy_us=
age,
 			     0);
=20
@@ -705,6 +708,7 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
 	int edit =3D !strcmp(argv[0], "edit");
=20
 	usage =3D edit ? git_notes_edit_usage : git_notes_append_usage;
+	GEN_PARSEOPT(options, usage);
 	argc =3D parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_ARGV0);
=20
@@ -752,6 +756,7 @@ static int show(int argc, const char **argv, const =
char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_show_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_notes_show_us=
age,
 			     0);
=20
@@ -878,6 +883,7 @@ static int merge(int argc, const char **argv, const=
 char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_merge_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_notes_merge_usage, 0);
=20
@@ -989,6 +995,7 @@ static int remove_cmd(int argc, const char **argv, =
const char *prefix)
 	struct notes_tree *t;
 	int retval =3D 0;
=20
+	GEN_PARSEOPT(options, git_notes_remove_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_notes_remove_usage, 0);
=20
@@ -1026,6 +1033,7 @@ static int prune(int argc, const char **argv, con=
st char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_notes_prune_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_notes_prune_u=
sage,
 			     0);
=20
@@ -1047,6 +1055,7 @@ static int prune(int argc, const char **argv, con=
st char *prefix)
 static int get_ref(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] =3D { OPT_END() };
+	GEN_PARSEOPT(options, git_notes_get_ref_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_notes_get_ref_usage, 0);
=20
@@ -1069,6 +1078,23 @@ int cmd_notes(int argc, const char **argv, const=
 char *prefix)
 		OPT_END()
 	};
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__,
+				      options, git_notes_usage)) {
+		const char *edit_cmd[] =3D { "edit", NULL };
+		const char *append_cmd[] =3D { "append", NULL };
+		list(0, NULL, NULL);
+		add(0, NULL, NULL);
+		copy(0, NULL, NULL);
+		append_edit(0, edit_cmd, NULL);
+		append_edit(0, append_cmd, NULL);
+		show(0, NULL, NULL);
+		merge(0, NULL, NULL);
+		remove_cmd(0, NULL, NULL);
+		prune(0, NULL, NULL);
+		get_ref(0, NULL, NULL);
+		return 0;
+	}
+
 	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7b07c09..05665ad 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2413,6 +2413,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		pack_compression_level =3D core_compression_level;
=20
 	progress =3D isatty(2);
+	GEN_PARSEOPT(pack_objects_options, pack_usage);
 	argc =3D parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
=20
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39a9d89..f3292c4 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -15,6 +15,7 @@ int cmd_pack_refs(int argc, const char **argv, const =
char *prefix)
 		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_=
PRUNE),
 		OPT_END(),
 	};
+	GEN_PARSEOPT(opts, pack_refs_usage);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 	return pack_refs(flags);
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index b58a2e1..222a726 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -78,6 +78,7 @@ int cmd_prune_packed(int argc, const char **argv, con=
st char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(prune_packed_options, prune_packed_usage);
 	argc =3D parse_options(argc, argv, prefix, prune_packed_options,
 			     prune_packed_usage, 0);
=20
diff --git a/builtin/prune.c b/builtin/prune.c
index b99b635..faac378 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -142,6 +142,7 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	read_replace_refs =3D 0;
 	init_revisions(&revs, prefix);
=20
+	GEN_PARSEOPT(options, prune_usage);
 	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0);
 	while (argc--) {
 		unsigned char sha1[20];
diff --git a/builtin/push.c b/builtin/push.c
index d315475..fb00e0b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -268,6 +268,7 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
=20
 	packet_trace_identity("push");
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, push_usage);
 	argc =3D parse_options(argc, argv, prefix, options, push_usage, 0);
=20
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_P=
USH_MIRROR))))
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index df6c4c8..b6c5c58 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -145,6 +145,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
=20
 	git_config(git_default_config, NULL);
=20
+	GEN_PARSEOPT(read_tree_options, read_tree_usage);
 	argc =3D parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
=20
diff --git a/builtin/remote.c b/builtin/remote.c
index fec92bc..97da0d5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -175,6 +175,7 @@ static int add(int argc, const char **argv)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, builtin_remote_add_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_add_=
usage,
 			     0);
=20
@@ -627,6 +628,8 @@ static int mv(int argc, const char **argv)
 	struct rename_info rename;
 	int i, refspec_updated =3D 0;
=20
+	GEN_PARSEOPT(options, builtin_remote_rename_usage);
+
 	if (argc !=3D 3)
 		usage_with_options(builtin_remote_rename_usage, options);
=20
@@ -784,6 +787,7 @@ static int rm(int argc, const char **argv)
 	cb_data.skipped =3D &skipped;
 	cb_data.keep =3D &known_remotes;
=20
+	GEN_PARSEOPT(options, builtin_remote_rm_usage);
 	if (argc !=3D 2)
 		usage_with_options(builtin_remote_rm_usage, options);
=20
@@ -1087,6 +1091,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list =3D STRING_LIST_INIT_NODUP;
 	struct show_info info;
=20
+	GEN_PARSEOPT(options, builtin_remote_show_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_show=
_usage,
 			     0);
=20
@@ -1190,6 +1195,7 @@ static int set_head(int argc, const char **argv)
 			    "delete refs/remotes/<name>/HEAD"),
 		OPT_END()
 	};
+	GEN_PARSEOPT(options, builtin_remote_sethead_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_seth=
ead_usage,
 			     0);
 	if (argc)
@@ -1243,6 +1249,7 @@ static int prune(int argc, const char **argv)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, builtin_remote_prune_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_prun=
e_usage,
 			     0);
=20
@@ -1312,6 +1319,7 @@ static int update(int argc, const char **argv)
=20
 	fetch_argv =3D xmalloc(sizeof(char *) * (argc+5));
=20
+	GEN_PARSEOPT(options, builtin_remote_update_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_upda=
te_usage,
 			     PARSE_OPT_KEEP_ARGV0);
=20
@@ -1393,6 +1401,7 @@ static int set_branches(int argc, const char **ar=
gv)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, builtin_remote_setbranches_usage);
 	argc =3D parse_options(argc, argv, NULL, options,
 			     builtin_remote_setbranches_usage, 0);
 	if (argc =3D=3D 0) {
@@ -1425,6 +1434,7 @@ static int set_url(int argc, const char **argv)
 			    "delete URLs"),
 		OPT_END()
 	};
+	GEN_PARSEOPT(options, builtin_remote_seturl_usage);
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_setu=
rl_usage,
 			     PARSE_OPT_KEEP_ARGV0);
=20
@@ -1556,6 +1566,21 @@ int cmd_remote(int argc, const char **argv, cons=
t char *prefix)
 	};
 	int result;
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__,
+				      options, builtin_remote_usage)) {
+
+		/* these just generate strings and do nothing */
+		add(0, NULL);
+		mv(0, NULL);
+		prune(0, NULL);
+		rm(0, NULL);
+		set_branches(0, NULL);
+		set_head(0, NULL);
+		set_url(0, NULL);
+		show(0, NULL);
+		update(0, NULL);
+		return 0;
+	}
 	argc =3D parse_options(argc, argv, prefix, options, builtin_remote_us=
age,
 		PARSE_OPT_STOP_AT_NON_OPTION);
=20
diff --git a/builtin/replace.c b/builtin/replace.c
index 4a8970e..e4ec1c2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -121,6 +121,7 @@ int cmd_replace(int argc, const char **argv, const =
char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, git_replace_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_replace_usage=
, 0);
=20
 	if (list && delete)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 08213c7..bef1b0a 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -57,6 +57,7 @@ int cmd_rerere(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END(),
 	};
=20
+	GEN_PARSEOPT(options, rerere_usage);
 	argc =3D parse_options(argc, argv, prefix, options, rerere_usage, 0);
=20
 	if (autoupdate =3D=3D 1)
diff --git a/builtin/reset.c b/builtin/reset.c
index 8c2c1d5..7d56fb9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -251,6 +251,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
=20
 	git_config(git_default_config, NULL);
=20
+	GEN_PARSEOPT(options, git_reset_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
=20
diff --git a/builtin/revert.c b/builtin/revert.c
index e6840f2..8d7bb74 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -126,6 +126,8 @@ static void parse_args(int argc, const char **argv,=
 struct replay_opts *opts)
 			die(_("program error"));
 	}
=20
+	if (generate_parseopt_strings(__FILE__, __LINE__, options, usage_str)=
)
+		exit(0);
 	argc =3D parse_options(argc, argv, NULL, options, usage_str,
 			PARSE_OPT_KEEP_ARGV0 |
 			PARSE_OPT_KEEP_UNKNOWN);
diff --git a/builtin/rm.c b/builtin/rm.c
index 90c8a50..126efc6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -148,6 +148,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
=20
 	git_config(git_default_config, NULL);
=20
+	GEN_PARSEOPT(builtin_rm_options, builtin_rm_usage);
 	argc =3D parse_options(argc, argv, prefix, builtin_rm_options,
 			     builtin_rm_usage, 0);
 	if (!argc)
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 37f3193..bf46bf3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -265,6 +265,7 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
+	GEN_PARSEOPT(options, shortlog_usage);
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
=20
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index a59e088..7e2dd31 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -691,6 +691,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
 		av =3D default_arg;
 	}
=20
+	GEN_PARSEOPT(builtin_show_branch_options, show_branch_usage);
 	ac =3D parse_options(ac, av, prefix, builtin_show_branch_options,
 			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (all_heads)
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 3911661..72805a2 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -208,6 +208,7 @@ int cmd_show_ref(int argc, const char **argv, const=
 char *prefix)
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(show_ref_usage, show_ref_options);
=20
+	GEN_PARSEOPT(show_ref_options, show_ref_usage);
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
=20
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..8915c03 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -42,6 +42,7 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, git_symbolic_ref_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
 	if (msg &&!*msg)
diff --git a/builtin/tag.c b/builtin/tag.c
index fe7e5e5..bcc5517 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -478,6 +478,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
=20
 	memset(&opt, 0, sizeof(opt));
=20
+	GEN_PARSEOPT(options, git_tag_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
 	if (keyid) {
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..710b983 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -794,6 +794,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 		OPT_END()
 	};
=20
+	GEN_PARSEOPT(options, update_index_usage);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(update_index_usage[0]);
=20
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 835c62a..ab2bde2 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -23,6 +23,7 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, git_update_ref_usage);
 	argc =3D parse_options(argc, argv, prefix, options, git_update_ref_us=
age,
 			     0);
 	if (msg && !*msg)
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.=
c
index 0d63c44..fbf5e1f 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -16,6 +16,7 @@ int cmd_update_server_info(int argc, const char **arg=
v, const char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(options, update_server_info_usage);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index e841b4a..099ea2a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -71,6 +71,7 @@ int cmd_verify_pack(int argc, const char **argv, cons=
t char *prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(verify_pack_options, verify_pack_usage);
 	argc =3D parse_options(argc, argv, prefix, verify_pack_options,
 			     verify_pack_usage, 0);
 	if (argc < 1)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 986789f..35f9fa4 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -76,6 +76,7 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
=20
 	git_config(git_verify_tag_config, NULL);
=20
+	GEN_PARSEOPT(verify_tag_options, verify_tag_usage);
 	argc =3D parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <=3D i)
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..417c7ac 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -34,6 +34,7 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)
 	};
=20
 	git_config(git_default_config, NULL);
+	GEN_PARSEOPT(write_tree_options, write_tree_usage);
 	argc =3D parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);
=20
diff --git a/gettext.c b/gettext.c
index f75bca7..4ab29cd 100644
--- a/gettext.c
+++ b/gettext.c
@@ -4,6 +4,9 @@
=20
 #include "git-compat-util.h"
 #include "gettext.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "quote.h"
=20
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -129,3 +132,36 @@ void git_setup_gettext(void)
 	textdomain("git");
 }
 #endif
+
+static void strbuf_quote_gettext(struct strbuf *sb, const char *s)
+{
+	if (!*s)		/* do not generate empty strings */
+		return;
+	strbuf_addstr(sb, "_(\"");
+	quote_c_style(s, sb, NULL, 1);
+	strbuf_addstr(sb, "\");\n");
+}
+
+int generate_parseopt_strings(const char *file, int line,
+			      const struct option *opts,
+			      const char * const * usagestr)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+
+	if (!getenv("GIT_I18N"))
+		return 0;
+
+	strbuf_addf(&sb, "/* parseopt %s:%d */\n", file, line);
+	for (; usagestr && *usagestr; usagestr++)
+		strbuf_quote_gettext(&sb, *usagestr);
+	for (; opts->type !=3D OPTION_END; opts++) {
+		if (opts->argh)
+			strbuf_quote_gettext(&sb, opts->argh);
+		if (opts->help)
+			strbuf_quote_gettext(&sb, opts->help);
+	}
+	strbuf_addch(&sb, '\n');
+	fputs(sb.buf, stdout);
+	strbuf_release(&sb);
+	return 1;
+}
diff --git a/gettext.h b/gettext.h
index 57ba8bb..ae5c874 100644
--- a/gettext.h
+++ b/gettext.h
@@ -59,3 +59,12 @@ const char *Q_(const char *msgid, const char *plu, u=
nsigned long n)
 #define N_(msgid) msgid
=20
 #endif
+
+struct option;
+extern int generate_parseopt_strings(const char *file, int line,
+				     const struct option *opts,
+				     const char * const * usagestr);
+#define GEN_PARSEOPT(opts, usage) { \
+	if (generate_parseopt_strings(__FILE__, __LINE__, opts, usage)) \
+		return 0; \
+	}
-- 8< --
--=20
Duy
