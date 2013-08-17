From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCHv2] repack: rewrite the shell script in C.
Date: Sat, 17 Aug 2013 15:34:22 +0200
Message-ID: <520F7BDE.9090902@web.de>
References: <7v8v02swnc.fsf@alter.siamese.dyndns.org> <1376611978-13189-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 15:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAgek-0004G6-DP
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 15:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab3HQNet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 09:34:49 -0400
Received: from mout.web.de ([212.227.15.4]:64351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab3HQNes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 09:34:48 -0400
Received: from [192.168.2.102] ([79.253.157.147]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MVcdn-1VbERW23hP-00Z0uu for <git@vger.kernel.org>;
 Sat, 17 Aug 2013 15:34:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376611978-13189-1-git-send-email-stefanbeller@googlemail.com>
X-Provags-ID: V03:K0:vsBvQxWnM2/62/jKMJVhbTxHqjIDZflpl5pumpuverdYK+UEaUL
 m62Q5ssBtjLyUaY+6P3rA4VgsNyAhiANGwqfDKqeZ8PBxX0BTjPLgngko8hShviARSBsc8K
 qegToj07YX5pt/ZuvMIlnSrkEowOfm8ZySz+cMgvTDGSVVFTJPwHBE1/6OyXyPtKTKJGr67
 bXdMRQM2LP2XINJcSpOYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232456>

>
>
> This is the beginning of the rewrite of the repacking.
>
>  * Removed unneeded system header files
>  * corrected remove_pack to really remove any pack files with the given
>    sha1
>  * fail if pack-objects fails
>  * Only test t7701 (2nd) fails now  with this patch.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  Makefile                                        |   2 +-
>  builtin.h                                       |   1 +
>  builtin/repack.c                                | 411 ++++++++++++++++++++++++
>  git-repack.sh => contrib/examples/git-repack.sh |   0
>  git.c                                           |   1 +
>  5 files changed, 414 insertions(+), 1 deletion(-)
>  create mode 100644 builtin/repack.c
>  rename git-repack.sh => contrib/examples/git-repack.sh (100%)
>
> diff --git a/Makefile b/Makefile
> index ef442eb..4ec5bbe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -464,7 +464,6 @@ SCRIPT_SH += git-pull.sh
>  SCRIPT_SH += git-quiltimport.sh
>  SCRIPT_SH += git-rebase.sh
>  SCRIPT_SH += git-remote-testgit.sh
> -SCRIPT_SH += git-repack.sh
>  SCRIPT_SH += git-request-pull.sh
>  SCRIPT_SH += git-stash.sh
>  SCRIPT_SH += git-submodule.sh
> @@ -972,6 +971,7 @@ BUILTIN_OBJS += builtin/reflog.o
>  BUILTIN_OBJS += builtin/remote.o
>  BUILTIN_OBJS += builtin/remote-ext.o
>  BUILTIN_OBJS += builtin/remote-fd.o
> +BUILTIN_OBJS += builtin/repack.o
>  BUILTIN_OBJS += builtin/replace.o
>  BUILTIN_OBJS += builtin/rerere.o
>  BUILTIN_OBJS += builtin/reset.o
> diff --git a/builtin.h b/builtin.h
> index 8afa2de..b56cf07 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -102,6 +102,7 @@ extern int cmd_reflog(int argc, const char **argv, const char *prefix);
>  extern int cmd_remote(int argc, const char **argv, const char *prefix);
>  extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
>  extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
> +extern int cmd_repack(int argc, const char **argv, const char *prefix);
>  extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
>  extern int cmd_rerere(int argc, const char **argv, const char *prefix);
>  extern int cmd_reset(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/repack.c b/builtin/repack.c
> new file mode 100644
> index 0000000..f72911d
> --- /dev/null
> +++ b/builtin/repack.c
> @@ -0,0 +1,411 @@
> +/*
> + * The shell version was written by Linus Torvalds (2005) and many others.
> + * This is a translation into C by Stefan Beller (2013)
> + */
> +
> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +#include "string-list.h"
> +
> +static const char *const git_repack_usage[] = {
> +	N_("git repack [options]"),
> +	NULL
> +};
> +
> +/* enabled by default since 22c79eab (2008-06-25) */
> +static int delta_base_offset = 1;
> +
> +static int repack_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "repack.usedeltabaseoffset")) {
> +		delta_base_offset = git_config_bool(var, value);
> +		return 0;
> +	}
> +	return git_default_config(var, value, cb);
> +}
> +
> +static void remove_temporary_files() {
> +	DIR *dir;
> +	struct dirent *e;
> +	char *prefix, *path, *fname;
> +
> +	prefix = xmalloc(strlen(".tmp-10000-pack") + 1);
> +	sprintf(prefix, ".tmp-%d-pack", getpid());

This will overflow for PIDs with more than five digits. Better use a 
strbuf and build the string with strbuf_addf.  Or better, use mkpathdup, 
which does that under the hood.

> +
> +	path = xmalloc(strlen(get_object_directory()) + strlen("/pack") + 1);
> +	sprintf(path, "%s/pack", get_object_directory());

mkpathdup?

> +
> +	fname = xmalloc(strlen(path) + strlen("/")
> +		+ strlen(prefix) + strlen("/")
> +		+ 40 + strlen(".pack") + 1);
> +
> +	dir = opendir(path);
> +	while ((e = readdir(dir)) != NULL) {
> +		if (!prefixcmp(e->d_name, prefix)) {
> +			sprintf(fname, "%s/%s", path, e->d_name);

If someone has a directory entry that begins with 'prefix' but is longer 
than expected this will overflow.  That's unlikely, but lets avoid it 
outright.  You could use a strbuf instead and reset it to the length of 
the prefix at the start of the loop (with strbuf_setlen), before adding 
the entry's name.

> +			unlink(fname);
> +		}
> +	}
> +	free(fname);
> +	free(prefix);
> +	free(path);
> +	closedir(dir);
> +}
> +
> +static void remove_pack_on_signal(int signo)
> +{
> +	remove_temporary_files();
> +	sigchain_pop(signo);
> +	raise(signo);
> +}
> +
> +void get_pack_sha1_list(char *packdir, struct string_list *sha1_list)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	char *path, *suffix;
> +
> +	path = xmalloc(strlen(get_object_directory()) + strlen("/pack") + 1);
> +	sprintf(path, "%s/pack", get_object_directory());

mkpathdup again.

Or would it make sense to cd into the pack directory and avoid these 
string manipulations outright?  Probably not if we need to call other 
git functions later on.

> +
> +	suffix = ".pack";
> +
> +	dir = opendir(path);
> +	while ((e = readdir(dir)) != NULL) {
> +		if (!suffixcmp(e->d_name, suffix)) {
> +			char buf[255], *sha1;
> +			strcpy(buf, e->d_name);
> +			buf[strlen(e->d_name) - strlen(suffix)] = '\0';
> +			sha1 = &buf[strlen(e->d_name) - strlen(suffix) - 40];
> +			string_list_append(sha1_list, sha1);

You could avoid the need for a temporary buffer by using xmemdupz and 
string_list_append_nodup instead.

> +		}
> +	}
> +	free(path);
> +	closedir(dir);
> +}
> +
> +/*
> + * remove_pack will remove any files following the pattern *${SHA1}.{EXT}
> + * where EXT is one of {pack, idx, keep}. The SHA1 consists of 40 chars and
> + * is specified by the sha1 parameter.
> + * path is specifying the directory in which all found files will be deleted.
> + */
> +void remove_pack(char *path, char* sha1)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +
> +	dir = opendir(path);
> +	while ((e = readdir(dir)) != NULL) {
> +

Extra newline.

> +		char *sha_begin, *sha_end;
> +		sha_end = e->d_name + strlen(e->d_name);
> +		while (sha_end > e->d_name && *sha_end != '.')
> +			sha_end--;
> +
> +		/* do not touch files not ending in .pack, .idx or .keep */
> +		if (strcmp(sha_end, ".pack") &&
> +			strcmp(sha_end, ".idx") &&
> +			strcmp(sha_end, ".keep"))
> +			continue;
> +
> +		sha_begin = sha_end - 40;
> +
> +		if (sha_begin >= e->d_name && !strncmp(sha_begin, sha1, 40)) {
> +			char *fname;
> +			fname = xmalloc(strlen(path) + 1 + strlen(e->d_name));
> +			sprintf(fname, "%s/%s", path, e->d_name);

mkpathdup..

> +			unlink(fname);
> +			/*TODO: free(fname); fails here sometimes, needs investigation*/

Strange.  Perhaps valgrind can tell you what's wrong.

> +		}
> +	}
> +	closedir(dir);
> +}

Hmm, stepping back a bit, why not just build the paths and call unlink 
for them right away, without readdir?  The shell version only ever 
deletes existing .pack files (those in $existing alias existing_packs) 
as well as their .idx and .keep files, if present.  It doesn't use a 
glob pattern, unlike remove_pack here.

> +
> +int cmd_repack(int argc, const char **argv, const char *prefix) {
> +
> +	int pack_everything = 0;
> +	int pack_everything_but_loose = 0;
> +	int delete_redundant = 0;
> +	unsigned long unpack_unreachable = 0;
> +	int window = 0, window_memory = 0;
> +	int depth = 0;
> +	int max_pack_size = 0;
> +	int no_reuse_delta = 0, no_reuse_object = 0;
> +	int no_update_server_info = 0;
> +	int quiet = 0;
> +	int local = 0;
> +	char *packdir, *packtmp;
> +	const char *cmd_args[20];
> +	int cmd_i = 0;
> +	struct child_process cmd;
> +	struct string_list_item *item;
> +	struct string_list existing_packs = STRING_LIST_INIT_DUP;
> +	struct stat statbuffer;
> +	char window_str[64], window_mem_str[64], depth_str[64], max_pack_size_str[64];
> +
> +	struct option builtin_repack_options[] = {
> +		OPT_BOOL('a', "all", &pack_everything,
> +				N_("pack everything in a single pack")),
> +		OPT_BOOL('A', "all-but-loose", &pack_everything_but_loose,
> +				N_("same as -a, and turn unreachable objects loose")),
> +		OPT_BOOL('d', "delete-redundant", &delete_redundant,
> +				N_("remove redundant packs, and run git-prune-packed")),
> +		OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
> +				N_("pass --no-reuse-delta to git-pack-objects")),
> +		OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
> +				N_("pass --no-reuse-object to git-pack-objects")),
> +		OPT_BOOL('n', NULL, &no_update_server_info,
> +				N_("do not run git-update-server-info")),
> +		OPT__QUIET(&quiet, N_("be quiet")),
> +		OPT_BOOL('l', "local", &local,
> +				N_("pass --local to git-pack-objects")),
> +		OPT_DATE(0, "unpack-unreachable", &unpack_unreachable,
> +				N_("with -A, do not loosen objects older than this Packing constraints")),
> +		OPT_INTEGER(0, "window", &window,
> +				N_("size of the window used for delta compression")),
> +		OPT_INTEGER(0, "window-memory", &window_memory,
> +				N_("same as the above, but limit memory size instead of entries count")),
> +		OPT_INTEGER(0, "depth", &depth,
> +				N_("limits the maximum delta depth")),
> +		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
> +				N_("maximum size of each packfile")),
> +		OPT_END()
> +	};
> +
> +	git_config(repack_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, builtin_repack_options,
> +				git_repack_usage, 0);
> +
> +	sigchain_push_common(remove_pack_on_signal);
> +
> +	packdir = mkpath("%s/pack", get_object_directory());

Ah, mkpath is already used.  That function is a bit tricky because you 
can only use it with four paths concurrently and some internal functions 
might already need one (or more) of the slots for itself.  It's better 
to consume its output on the spot (like in printf("my path is %s\n", 
mkpath(...));) or use mkpathdup.

> +	packtmp = xmalloc(strlen(packdir) + strlen("/.tmp-10000-pack") + 1);
> +	sprintf(packtmp, "%s/.tmp-%d-pack", packdir, getpid());

mkpathdup again..

> +
> +	remove_temporary_files();
> +
> +	cmd_args[cmd_i++] = "pack-objects";
> +	cmd_args[cmd_i++] = "--keep-true-parents";
> +	cmd_args[cmd_i++] = "--honor-pack-keep";
> +	cmd_args[cmd_i++] = "--non-empty";
> +	cmd_args[cmd_i++] = "--all";
> +	cmd_args[cmd_i++] = "--reflog";
> +
> +	if (window) {
> +		sprintf(window_str, "--window=%u", window);
> +		cmd_args[cmd_i++] = window_str;
> +	}
> +	if (window_memory) {
> +		sprintf(window_mem_str, "--window-memory=%u", window_memory);
> +		cmd_args[cmd_i++] = window_str;
> +	}
> +	if (depth) {
> +		sprintf(depth_str, "--depth=%u", depth);
> +		cmd_args[cmd_i++] = depth_str;
> +	}
> +	if (max_pack_size) {
> +		sprintf(max_pack_size_str, "--max_pack_size=%u", max_pack_size);
> +		cmd_args[cmd_i++] = max_pack_size_str;
> +	}


You can simplify that part by using argv_array and argv_array_pushf.

> +
> +	if (pack_everything + pack_everything_but_loose == 0) {
> +		cmd_args[cmd_i++] = "--unpacked";
> +		cmd_args[cmd_i++] = "--incremental";
> +	} else {
> +		if (pack_everything_but_loose)
> +			cmd_args[cmd_i++] = "--unpack-unreachable";
> +
> +		struct string_list sha1_list = STRING_LIST_INIT_DUP;
> +		get_pack_sha1_list(packdir, &sha1_list);
> +		for_each_string_list_item(item, &sha1_list) {
> +			char *fname;
> +			fname = xmalloc(strlen(packdir) + strlen("/") + 40 + strlen(".keep"));
> +			sprintf(fname, "%s/%s.keep", packdir, item->string);

mkpathdup..

Or maybe go through the entries in the pack directory once, like already 
done in get_pack_sha1_list, and instead of just making a list of .pack 
files, make a list of .keep files as well.  Then work with those lists 
instead of accessing the directory again with stat.

> +			if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {
> +				/* when the keep file is there, we're ignoring that pack */
> +			} else {
> +				string_list_append(&existing_packs, item->string);
> +			}
> +		}
> +
> +		if (existing_packs.nr && unpack_unreachable && delete_redundant) {
> +			/*
> +			 * TODO: convert unpack_unreachable (being time since epoch)
> +			 * to an aproxidate again
> +			 */
> +			cmd_args[cmd_i++] = "--unpack-unreachable=$DATE";
> +		}
> +	}
> +
> +	if (local)
> +		cmd_args[cmd_i++] = "--local";
> +
> +	if (delta_base_offset)
> +		cmd_args[cmd_i++] = "--delta-base-offset";
> +
> +	cmd_args[cmd_i++] = packtmp;
> +	cmd_args[cmd_i] = NULL;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.argv = cmd_args;
> +	cmd.git_cmd = 1;
> +	cmd.out = -1;
> +	cmd.no_stdin = 1;
> +
> +	if (run_command(&cmd))
> +		return 1;
> +
> +	struct string_list names = STRING_LIST_INIT_DUP;
> +	struct string_list rollback = STRING_LIST_INIT_DUP;
> +
> +	char line[1024];
> +	int counter = 0;
> +	FILE *out = xfdopen(cmd.out, "r");
> +	while (fgets(line, sizeof(line), out)) {
> +		/* a line consists of 40 hex chars + '\n' */
> +		assert(strlen(line) == 41);
> +		line[40] = '\0';
> +		string_list_append(&names, line);
> +		counter++;
> +	}
> +	if (!counter)
> +		printf("Nothing new to pack.\n");
> +	fclose(out);
> +
> +	char *fname, *fname_old;
> +	fname = xmalloc(strlen(packdir) + strlen("/old-pack-") + 40 + strlen(".pack") + 1);
> +	strcpy(fname, packdir);
> +	strcpy(fname + strlen(packdir), "/");
> +
> +	fname_old = xmalloc(strlen(packdir) + strlen("/old-pack-") + 40 + strlen(".pack") + 1);
> +	strcpy(fname_old, packdir);
> +	strcpy(fname_old + strlen(packdir), "/");
> +	char *exts[2] = {".idx", ".pack"};
> +
> +	int failed = 0;
> +
> +	for_each_string_list_item(item, &names) {
> +		int ext;
> +		for (ext = 0; ext < 1; ext++) {
> +			strcpy(fname + strlen(packdir) + 1, item->string);
> +			strcpy(fname + strlen(packdir) + 41, exts[ext]);
> +			if (!file_exists(fname))
> +				continue;
> +
> +			strcpy(fname_old, packdir);
> +			strcpy(fname_old + strlen(packdir), "/old-");
> +			strcpy(fname_old + strlen(packdir) + 5, item->string);
> +			strcpy(fname_old + strlen(packdir) + 45, exts[ext]);
> +			if (file_exists(fname_old))
> +				unlink(fname_old);
> +
> +			if (rename(fname, fname_old)) {
> +				failed = 1;
> +				break;
> +			}
> +			string_list_append(&rollback, fname);

mkpathdup with string_list_append_nodup instead?

> +		}
> +		if (failed)
> +			/* set to last element to break while loop */
> +			item = names.items + names.nr;
> +	}
> +	if (failed) {
> +		struct string_list rollback_failure;
> +
> +		for_each_string_list_item(item, &rollback) {
> +			sprintf(fname, "%s/%s", packdir, item->string);
> +			sprintf(fname_old, "%s/old-%s", packdir, item->string);
> +			if (rename(fname_old, fname))
> +				string_list_append(&rollback_failure, fname);

Dito.

> +		}
> +
> +		if (rollback.nr) {
> +			int i;
> +			fprintf(stderr,
> +				"WARNING: Some packs in use have been renamed by\n"
> +				"WARNING: prefixing old- to their name, in order to\n"
> +				"WARNING: replace them with the new version of the\n"
> +				"WARNING: file.  But the operation failed, and\n"
> +				"WARNING: attempt to rename them back to their\n"
> +				"WARNING: original names also failed.\n"
> +				"WARNING: Please rename them in $PACKDIR manually:\n");
> +			for (i = 0; i < rollback.nr; i++)
> +				fprintf(stderr, "WARNING:   old-%s -> %s\n",
> +					rollback.items[i].string,
> +					rollback.items[i].string);
> +		}
> +		exit(1);
> +	}
> +
> +	/* Now the ones with the same name are out of the way... */
> +	struct string_list fullbases = STRING_LIST_INIT_DUP;
> +	for_each_string_list_item(item, &names) {
> +		string_list_append(&fullbases, item->string);

Why make a copy of 'names'?  Can't you use it directly instead of 
'fullbases'?  Ah, the Shell version adds a "pack-" at the beginning of 
each string.  We don't need to do that and thus can get rid of that 
extra list, no?

> +
> +		sprintf(fname, "%s/pack-%s.pack", packdir, item->string);
> +		sprintf(fname_old, "%s-%s.pack", packtmp, item->string);
> +		stat(fname_old, &statbuffer);
> +		statbuffer.st_mode &= ~S_IWOTH;
> +		chmod(fname_old, statbuffer.st_mode);
> +		if (rename(fname_old, fname))
> +			die("Could not rename packfile: %s -> %s", fname_old, fname);
> +
> +		sprintf(fname, "%s/pack-%s.idx", packdir, item->string);
> +		sprintf(fname_old, "%s-%s.idx", packtmp, item->string);
> +		stat(fname_old, &statbuffer);
> +		statbuffer.st_mode &= ~S_IWOTH;
> +		chmod(fname_old, statbuffer.st_mode);
> +		if (rename(fname_old, fname))
> +			die("Could not rename packfile: %s -> %s", fname_old, fname);
> +	}
> +
> +	/* Remove the "old-" files */
> +	for_each_string_list_item(item, &names) {
> +		sprintf(fname, "%s/old-pack-%s.idx", packdir, item->string);
> +		if (remove_path(fname))
> +			die("Could not remove file: %s", fname);
> +
> +		sprintf(fname, "%s/old-pack-%s.pack", packdir, item->string);
> +		if (remove_path(fname))
> +			die("Could not remove file: %s", fname);
> +	}
> +
> +	/* End of pack replacement. */
> +	if (delete_redundant) {
> +		sort_string_list(&fullbases);
> +		fname = xmalloc(strlen(packtmp) + strlen("/") + 40 + strlen(".pack") + 1);
> +		for_each_string_list_item(item, &existing_packs) {
> +			if (!string_list_has_string(&fullbases, item->string))
> +				remove_pack(packdir, item->string);
> +		}
> +		free(fname);

Why allocate memory for fname and give it back unused?

> +		cmd_i = 0;
> +		cmd_args[cmd_i++] = "prune-packed";
> +		cmd_args[cmd_i++] = NULL;
> +		/* TODO: pass argument: ${GIT_QUIET:+-q} */
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = cmd_args;
> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}
> +
> +	if (!no_update_server_info) {
> +		cmd_i = 0;
> +		cmd_args[cmd_i++] = "update-server-info";
> +		cmd_args[cmd_i++] = NULL;
> +
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = cmd_args;
> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}
> +	return 0;
> +}
> +
> diff --git a/git-repack.sh b/contrib/examples/git-repack.sh
> similarity index 100%
> rename from git-repack.sh
> rename to contrib/examples/git-repack.sh
> diff --git a/git.c b/git.c
> index 2025f77..03510be 100644
> --- a/git.c
> +++ b/git.c
> @@ -396,6 +396,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "remote", cmd_remote, RUN_SETUP },
>  		{ "remote-ext", cmd_remote_ext },
>  		{ "remote-fd", cmd_remote_fd },
> +		{ "repack", cmd_repack, RUN_SETUP },
>  		{ "replace", cmd_replace, RUN_SETUP },
>  		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
>  		{ "rerere", cmd_rerere, RUN_SETUP },
> -- 1.8.4.rc3.1.gc1ebd90
>
