From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 15:31:08 +0200
Message-ID: <52136F9C.6030308@kdbg.org>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, l.s.r@web.de, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 15:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBm1t-0005kG-LI
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 15:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063Ab3HTNbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 09:31:21 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:23963 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750923Ab3HTNbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 09:31:21 -0400
Received: from [10.73.122.231] (178.115.250.231.wireless.dyn.drei.com [178.115.250.231])
	by bsmtp.bon.at (Postfix) with ESMTP id 973451300B6;
	Tue, 20 Aug 2013 15:31:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232594>

I didn't look at functions above cmd_repack.

Am 20.08.2013 01:23, schrieb Stefan Beller:
> +int cmd_repack(int argc, const char **argv, const char *prefix) {
> +
> +	int pack_everything = 0;
> +	int pack_everything_but_loose = 0;
> +	int delete_redundant = 0;
> +	char *unpack_unreachable = NULL;
> +	int window = 0, window_memory = 0;
> +	int depth = 0;
> +	int max_pack_size = 0;
> +	int no_reuse_delta = 0, no_reuse_object = 0;
> +	int no_update_server_info = 0;
> +	int quiet = 0;
> +	int local = 0;
> +	char *packdir, *packtmp;
> +	struct child_process cmd;
> +	struct string_list_item *item;
> +	struct string_list existing_packs = STRING_LIST_INIT_DUP;
> +	struct stat statbuffer;
> +	int ext;
> +	char *exts[2] = {".idx", ".pack"};
> +
> +	struct option builtin_repack_options[] = {

Are the long forms of options your invention?

> +		OPT_BOOL('a', "all", &pack_everything,
> +				N_("pack everything in a single pack")),
> +		OPT_BOOL('A', "all-but-loose", &pack_everything_but_loose,
> +				N_("same as -a, and turn unreachable objects loose")),

--all-but-loose does not express what the help text says. The long form of 
-A is --all --unpack-unreachable, so it is really just a short option for 
convenience. It does not need its own long form.

> +		OPT_BOOL('d', "delete-redundant", &delete_redundant,
> +				N_("remove redundant packs, and run git-prune-packed")),
> +		OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
> +				N_("pass --no-reuse-delta to git-pack-objects")),
> +		OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
> +				N_("pass --no-reuse-object to git-pack-objects")),

Do we want to allow --no-no-reuse-delta and --no-no-reuse-object?

> +		OPT_BOOL('n', NULL, &no_update_server_info,
> +				N_("do not run git-update-server-info")),

No long option name?

> +		OPT__QUIET(&quiet, N_("be quiet")),
> +		OPT_BOOL('l', "local", &local,
> +				N_("pass --local to git-pack-objects")),

Good.

> +		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
> +				N_("with -A, do not loosen objects older than this Packing constraints")),

"Packing constraints" is a section heading, not a continuation of the 
previous help text.

> +		OPT_INTEGER(0, "window", &window,
> +				N_("size of the window used for delta compression")),

This help text is suboptimal as the option is a count, not a "size" in the 
narrow sense. But that can be changed later (as it would affect other 
tools as well, I guess).

> +		OPT_INTEGER(0, "window-memory", &window_memory,
> +				N_("same as the above, but limit memory size instead of entries count")),
> +		OPT_INTEGER(0, "depth", &depth,
> +				N_("limits the maximum delta depth")),
> +		OPT_INTEGER(0, "max-pack-size", &max_pack_size,
> +				N_("maximum size of each packfile")),
> +		OPT_END()
> +	};

Good.

> +
> +	git_config(repack_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, builtin_repack_options,
> +				git_repack_usage, 0);
> +
> +	sigchain_push_common(remove_pack_on_signal);

Good.

> +	packdir = mkpathdup("%s/pack", get_object_directory());
> +	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, getpid());

Should this not be

	packdir = xstrdup(git_path("pack"));
	packtmp = xstrdup(git_path("pack/.tmp-%d-pack", getpid()));

Perhaps make packdir and packtmp global so that the strings need not be 
duplicated in get_pack_filenames and remove_temporary_files?

> +
> +	remove_temporary_files();

Yes, the shell script had this. But is it really necessary?

> +
> +	struct argv_array cmd_args = ARGV_ARRAY_INIT;

Declaration after statement.

> +	argv_array_push(&cmd_args, "pack-objects");
> +	argv_array_push(&cmd_args, "--keep-true-parents");
> +	argv_array_push(&cmd_args, "--honor-pack-keep");
> +	argv_array_push(&cmd_args, "--non-empty");
> +	argv_array_push(&cmd_args, "--all");
> +	argv_array_push(&cmd_args, "--reflog");
> +
> +	if (window)
> +		argv_array_pushf(&cmd_args, "--window=%u", window);
> +
> +	if (window_memory)
> +		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
> +
> +	if (depth)
> +		argv_array_pushf(&cmd_args, "--depth=%u", depth);
> +
> +	if (max_pack_size)
> +		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
> +
> +	if (no_reuse_delta)
> +		argv_array_pushf(&cmd_args, "--no-reuse-delta");
> +
> +	if (no_reuse_object)
> +		argv_array_pushf(&cmd_args, "--no-reuse-object");

no_reuse_delta and no_reuse_object are mutually exclusive, according to 
the shell script version.

> +
> +	if (pack_everything + pack_everything_but_loose == 0) {
> +		argv_array_push(&cmd_args, "--unpacked");
> +		argv_array_push(&cmd_args, "--incremental");
> +	} else {
> +		struct string_list fname_list = STRING_LIST_INIT_DUP;
> +		get_pack_filenames(packdir, &fname_list);
> +		for_each_string_list_item(item, &fname_list) {
> +			char *fname;
> +			fname = mkpathdup("%s/%s.keep", packdir, item->string);
> +			if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {

			if (!stat(fname, &statbuffer) && ...

But you are using file_exists() later. That should be good enough here as 
well, no?

> +				/* when the keep file is there, we're ignoring that pack */
> +			} else {
> +				string_list_append(&existing_packs, item->string);
> +			}
> +			free(fname);
> +		}
> +
> +		if (existing_packs.nr && delete_redundant) {
> +			if (unpack_unreachable)
> +				argv_array_pushf(&cmd_args, "--unpack-unreachable=%s", unpack_unreachable);
> +			else if (pack_everything_but_loose)
> +				argv_array_push(&cmd_args, "--unpack-unreachable");
> +		}
> +	}
> +
> +	if (local)
> +		argv_array_push(&cmd_args,  "--local");
> +	if (quiet)
> +		argv_array_push(&cmd_args,  "--quiet");
> +	if (delta_base_offset)
> +		argv_array_push(&cmd_args,  "--delta-base-offset");
> +
> +	argv_array_push(&cmd_args, packtmp);

Otherwise, argument setup looks fine.

> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.argv = argv_array_detach(&cmd_args, NULL);

Is it necessary to detach the arguments?

> +	cmd.git_cmd = 1;
> +	cmd.out = -1;
> +	cmd.no_stdin = 1;
> +
> +	if (run_command(&cmd))
> +		return 1;

You cannot run_command() and then later read its output! You must split it 
into start_command(), read stdout, finish_command().

> +
> +	struct string_list names = STRING_LIST_INIT_DUP;
> +	struct string_list rollback = STRING_LIST_INIT_DUP;

Declaration after statement.

> +
> +	char line[1024];
> +	int counter = 0;
> +	FILE *out = xfdopen(cmd.out, "r");
> +	while (fgets(line, sizeof(line), out)) {
> +		/* a line consists of 40 hex chars + '\n' */
> +		assert(strlen(line) == 41);

You cannot make assertions about input that you read from an external 
command! You can die() if the expectation is not met. But I think that in 
this case the only necessary expectation is that a line is not empty.

BTW, don't we have strbuf functions to read from an fd linewise?

> +		line[40] = '\0';
> +		string_list_append(&names, line);
> +		counter++;
> +	}
> +	if (!counter)
> +		printf("Nothing new to pack.\n");

This was 'say Nothing new to pack.'. say obeys --quiet, IIRC.

> +	fclose(out);
> +
> +	int failed = 0;
> +	for_each_string_list_item(item, &names) {
> +		for (ext = 0; ext < 1; ext++) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
> +			if (!file_exists(fname)) {
> +				free(fname);
> +				continue;
> +			}
> +
> +			fname_old = mkpathdup("%s/old-%s%s", packdir, item->string, exts[ext]);

If you could use git_path() instead of mkpathdup() in these two cases, we 
would not need to free() the names.

> +			if (file_exists(fname_old))
> +				unlink(fname_old);
> +
> +			if (rename(fname, fname_old)) {
> +				failed = 1;
> +				break;
> +			}
> +			free(fname_old);
> +			string_list_append_nodup(&rollback, fname);

Ah, we would need to allocate here then.

> +		}
> +		if (failed)
> +			/* set to last element to break for_each loop */
> +			item = names.items + names.nr;

A mere
			break;
doesn't do it here?

> +	}
> +	if (failed) {
> +		struct string_list rollback_failure;
> +		for_each_string_list_item(item, &rollback) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/%s", packdir, item->string);
> +			fname_old = mkpathdup("%s/old-%s", packdir, item->string);

I think it's possible to attach arbitrary data to each string_list item. 
We could attach the "%s/old-%s" name to the item name, then we wouldn't 
need to re-construct the names here.

> +			if (rename(fname_old, fname))
> +				string_list_append(&rollback_failure, fname);
> +			free(fname);
> +			free(fname_old);
> +		}
> +
> +		if (rollback.nr) {
> +			int i;
> +			fprintf(stderr,
> +				"WARNING: Some packs in use have been renamed by\n"
> +				"WARNING: prefixing old- to their name, in order to\n"
> +				"WARNING: replace them with the new version of the\n"
> +				"WARNING: file.  But the operation failed, and the\n"
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
> +	for_each_string_list_item(item, &names) {
> +		for (ext = 0; ext < 2; ext++) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
> +			fname_old = mkpathdup("%s-%s%s", packtmp, item->string, exts[ext]);

Same here: git_path()?

> +			stat(fname_old, &statbuffer);

We ignore errors during chmod in the shell script. But this doesn't give 
you license to ignore stat() errors completely: If stat() fails, then 
don't chmod() below, either.

> +			statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;

			statbuffer.st_mode &= ~(S_IWUSR|S_IWGRP|S_IWOTH);

> +			chmod(fname_old, statbuffer.st_mode);
> +			if (rename(fname_old, fname))
> +				die("Could not rename packfile: %s -> %s", fname_old, fname);

Use die_errno() here.

> +			free(fname);
> +			free(fname_old);
> +		}
> +	}
> +
> +	/* Remove the "old-" files */
> +	for_each_string_list_item(item, &names) {
> +		char *fname;
> +		fname = mkpathdup("%s/old-pack-%s.idx", packdir, item->string);
> +		if (remove_path(fname))
> +			die("Could not remove file: %s", fname);

die_errno() makes sense here, too.

> +		free(fname);
> +
> +		fname = mkpathdup("%s/old-pack-%s.pack", packdir, item->string);
> +		if (remove_path(fname))
> +			die("Could not remove file: %s", fname);

and here as well.

> +		free(fname);

Again git_path?

> +	}
> +
> +	/* End of pack replacement. */

Nit: A blank line should follow this comment.

> +	if (delete_redundant) {
> +		sort_string_list(&names);
> +		for_each_string_list_item(item, &existing_packs) {
> +			char *sha1;
> +			size_t len = strlen(item->string);
> +			if (len < 40)
> +				continue;
> +			sha1 = item->string + len - 40;
> +			if (!string_list_has_string(&names, sha1))
> +				remove_pack(packdir, item->string);
> +		}

OK.

> +		argv_array_clear(&cmd_args);
> +		argv_array_push(&cmd_args, "prune-packed");
> +		if (quiet)
> +			argv_array_push(&cmd_args, "--quiet");
> +
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = argv_array_detach(&cmd_args, NULL);

Again: is it necessary to detach?

> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}
> +
> +	if (!no_update_server_info) {
> +		argv_array_clear(&cmd_args);
> +		argv_array_push(&cmd_args, "update-server-info");
> +
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = argv_array_detach(&cmd_args, NULL);

Same here?

> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}
> +	return 0;
> +}

In my opinion, it is good that you keep a large function that resembles 
the structure of the shell script because it is easier to review. But 
ultimately, it should be factored into smaller functions.

-- Hannes
