From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Wed, 21 Aug 2013 13:56:47 -0700
Message-ID: <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com>
References: <5214F816.3010303@googlemail.com>
	<1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFSa-0007bM-3h
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab3HUU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:56:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810Ab3HUU4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E81F63B09A;
	Wed, 21 Aug 2013 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Voj5P9V1HGVQ8Kg7BUBY40TwuQ=; b=QhkJ9T
	azTcwgAAbCstOJ7m8Ziebkp/WJrcbn+bqtBtjRkSJX4rP5BhE9Dy36slAc69ujjW
	RNvT0c9HUSYfNlggvxtzfBsBOBn62hLcXZo092yc5ES+fJu+d9zOt3xOMOV9IOvZ
	ZB8cK5L+Oncct89bWAW866nuqXtmDJ49K4dSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/ONeDTD1Rq0Dpmf7bjexrWagvmJtlR/
	JTINroBs/Dq3vVLiQpDSTgLbcc0IKMPGDav1gH1AU50GRzDO8lqjK52cho0XaG4y
	nMgbs4yC5TU3ZxC6gUDoZ23j0SPu+o5jUBpdwZmBQTgmT10ugXPMBANAEgzkq3By
	99V5i2DmWn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF063B099;
	Wed, 21 Aug 2013 20:56:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF0163B096;
	Wed, 21 Aug 2013 20:56:48 +0000 (UTC)
In-Reply-To: <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 21 Aug 2013 19:28:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32814262-0AA4-11E3-B760-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232736>

Stefan Beller <stefanbeller@googlemail.com> writes:

> The motivation of this patch is to get closer to a goal of being
> able to have a core subset of git functionality built in to git.
> That would mean
>
>  * people on Windows could get a copy of at least the core parts
>    of Git without having to install a Unix-style shell
>
>  * people deploying to servers don't have to rewrite the #! line
>    or worry about the PATH and quality of installed POSIX
>    utilities, if they are only using the built-in part written
>    in C

I am not sure what is meant by the latter.  Rewriting #! is part of
any scripted Porcelain done by the top-level Makefile, and I do not
think we have seen any problem reports on it.

As to "quality of ... utilities", I think the real issue some people
in the thread had was not about "deploying to servers" but about
installing in a minimalistic chrooted environment where standard
tools may be lacking.

> diff --git a/builtin/repack.c b/builtin/repack.c
> new file mode 100644
> index 0000000..fb050c0
> --- /dev/null
> +++ b/builtin/repack.c
> @@ -0,0 +1,376 @@
> +/*
> + * The shell version was written by Linus Torvalds (2005) and many others.
> + * This is a translation into C by Stefan Beller (2013)
> + */

I am not sure if we want to record "ownership" in the code like
this; it will go stale over time.

> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "sigchain.h"
> +#include "strbuf.h"
> +#include "string-list.h"
> +#include "argv-array.h"
> +
> +/* enabled by default since 22c79eab (2008-06-25) */

It may be of some value that by default --delta-base-offset is used,
but that can be read from the initialization.  Do we need this
comment?

> +static int delta_base_offset = 1;
> +char *packdir;

Does this have to be global?

> +static const char *const git_repack_usage[] = {
> +	N_("git repack [options]"),
> +	NULL
> +};
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
> +/*
> + * Remove temporary $GIT_OBJECT_DIRECTORY/pack/.tmp-$$-pack-* files.
> + */
> +static void remove_temporary_files(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t dirlen, prefixlen;
> +	DIR *dir;
> +	struct dirent *e;
> +
> +	/* .git/objects/pack */

We can read what is in there from two strbuf calls without comment.

> +	strbuf_addstr(&buf, get_object_directory());
> +	strbuf_addstr(&buf, "/pack");

More importantly, you already know what this directory and what
packtmp prefix are.

Also, you can keep &buf empty until opendir() succeeds.

> +	dir = opendir(buf.buf);
> +	if (!dir) {
> +		strbuf_release(&buf);
> +		return;
> +	}
> +
> +	/* .git/objects/pack/.tmp-$$-pack-* */
> +	dirlen = buf.len + 1;

Likewise; it is a good idea to document what "dirlen" points at,
though.

> +	strbuf_addf(&buf, "/.tmp-%d-pack-", (int)getpid());
> +	prefixlen = buf.len - dirlen;

So in summary:

	dir = opendir(packdir);
        if (!dir)
		return;

	strbuf_addf(&buf, "%s-", packtmp);

        /* Point at the slash at the end of ".../objects/pack/" */
	dirlen = strlen(packdir) + 1;
        /* Point at the dash at the end of ".../.tmp-%d-pack-" */
        prefixlen = buf.len - dirlen;

You would need to move the initialization of packdir and packtmp
before sigchain_push() in cmd_repack() if you were to do this.

> +	while ((e = readdir(dir))) {
> +		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
> +			continue;
> +		strbuf_setlen(&buf, dirlen);
> +		strbuf_addstr(&buf, e->d_name);
> +		unlink(buf.buf);

This unlink(2) could fail, but there is not much we could do here.

> +	}
> +	closedir(dir);
> +	strbuf_release(&buf);
> +}
> +
> +static void remove_pack_on_signal(int signo)
> +{
> +	remove_temporary_files();
> +	sigchain_pop(signo);
> +	raise(signo);
> +}
> +
> +static void get_pack_filenames(struct string_list *fname_list)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	char *fname;
> +
> +	if (!(dir = opendir(packdir)))
> +		return;
> +
> +	while ((e = readdir(dir)) != NULL) {
> +		if (suffixcmp(e->d_name, ".pack"))
> +			continue;

We may want to tighten this to ignore cruft that does not match

	/^pack-[0-9a-f]{40}\.pack$/

in a later patch, but this is a faithful rewrite from the original.

> +		size_t len = strlen(e->d_name) - strlen(".pack");

decl-after-stmt.

> +		fname = xmemdupz(e->d_name, len);
> +
> +		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
> +			string_list_append_nodup(fname_list, fname);

mental note: this is getting names of non-kept packs, not all packs.

> +	}
> +	closedir(dir);
> +}
> +
> +static void remove_redundant_pack(const char *path, const char *sha1)

These parameter names may want to be changed to clarify what they
are; see below.

> +{
> +	const char *exts[] = {".pack", ".idx", ".keep"};
> +	int i;
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t plen;
> +
> +	strbuf_addf(&buf, "%s/%s", path, sha1);

This suggests that path[] has ".../objects/pack/pack-" and sha1[] is
a 40-hex representation of the pack name.  Calling the former
path_prefix[] and the latter hex[] may be clearer.

> +	plen = buf.len;
> +
> +	for (i = 0; i < ARRAY_SIZE(exts); i++) {
> +		strbuf_setlen(&buf, plen);
> +		strbuf_addstr(&buf, exts[i]);
> +		unlink(buf.buf);
> +	}
> +}
> +
> +int cmd_repack(int argc, const char **argv, const char *prefix)
> +{
> +	const char *exts[2] = {".idx", ".pack"};
> +	char *packtmp;
> +	struct child_process cmd;
> +	struct string_list_item *item;
> +	struct argv_array cmd_args = ARGV_ARRAY_INIT;
> +	struct string_list names = STRING_LIST_INIT_DUP;
> +	struct string_list rollback = STRING_LIST_INIT_DUP;
> +	struct string_list existing_packs = STRING_LIST_INIT_DUP;
> +	struct strbuf line = STRBUF_INIT;
> +	int count_packs, ext, ret;
> +	FILE *out;
> +
> +	/* variables to be filled by option parsing */
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
> +
> +	struct option builtin_repack_options[] = {
> +		OPT_BOOL('a', NULL, &pack_everything,
> +				N_("pack everything in a single pack")),
> +		OPT_BOOL('A', NULL, &pack_everything_but_loose,
> +				N_("same as -a, and turn unreachable objects loose")),
> +		OPT_BOOL('d', NULL, &delete_redundant,
> +				N_("remove redundant packs, and run git-prune-packed")),
> +		OPT_BOOL('f', NULL, &no_reuse_delta,
> +				N_("pass --no-reuse-delta to git-pack-objects")),
> +		OPT_BOOL('F', NULL, &no_reuse_object,
> +				N_("pass --no-reuse-object to git-pack-objects")),
> +		OPT_BOOL('n', NULL, &no_update_server_info,
> +				N_("do not run git-update-server-info")),
> +		OPT__QUIET(&quiet, N_("be quiet")),
> +		OPT_BOOL('l', "local", &local,
> +				N_("pass --local to git-pack-objects")),
> +		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
> +				N_("with -A, do not loosen objects older than this")),
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

Nice. In a later patch we might want to allow --delta-base-offset to
be overridden from the command line and doing config first and then
options second like the above would allow us to do so easily.

> +	sigchain_push_common(remove_pack_on_signal);
> +	packdir = mkpathdup("%s/pack", get_object_directory());
> +	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> +
> +	argv_array_push(&cmd_args, "pack-objects");
> +	argv_array_push(&cmd_args, "--keep-true-parents");
> +	argv_array_push(&cmd_args, "--honor-pack-keep");
> +	argv_array_push(&cmd_args, "--non-empty");
> +	argv_array_push(&cmd_args, "--all");
> +	argv_array_push(&cmd_args, "--reflog");
> +	if (window)
> +		argv_array_pushf(&cmd_args, "--window=%u", window);
> +	if (window_memory)
> +		argv_array_pushf(&cmd_args, "--window-memory=%u", window_memory);
> +	if (depth)
> +		argv_array_pushf(&cmd_args, "--depth=%u", depth);
> +	if (max_pack_size)
> +		argv_array_pushf(&cmd_args, "--max_pack_size=%u", max_pack_size);
> +	if (no_reuse_delta)
> +		argv_array_pushf(&cmd_args, "--no-reuse-delta");
> +	if (no_reuse_object)
> +		argv_array_pushf(&cmd_args, "--no-reuse-object");
> +
> +	if (!pack_everything && !pack_everything_but_loose) {
> +		argv_array_push(&cmd_args, "--unpacked");
> +		argv_array_push(&cmd_args, "--incremental");
> +	} else {
> +		get_pack_filenames(&existing_packs);
> +
> +		if (existing_packs.nr && delete_redundant) {
> +			if (unpack_unreachable)
> +				argv_array_pushf(&cmd_args,
> +						"--unpack-unreachable=%s",
> +						unpack_unreachable);
> +			else if (pack_everything_but_loose)
> +				argv_array_push(&cmd_args,
> +						"--unpack-unreachable");
> +		}
> +	}
> +
> +	if (local)
> +		argv_array_push(&cmd_args,  "--local");
> +	if (quiet)
> +		argv_array_push(&cmd_args,  "--quiet");

The original seems to push "-q", but it is probably OK to make it
more readable by spelling it out like this.

> +	if (delta_base_offset)
> +		argv_array_push(&cmd_args,  "--delta-base-offset");
> +
> +	argv_array_push(&cmd_args, packtmp);
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.argv = cmd_args.argv;
> +	cmd.git_cmd = 1;
> +	cmd.out = -1;
> +	cmd.no_stdin = 1;
> +
> +	ret = start_command(&cmd);
> +	if (ret)
> +		return 1;
> +
> +	count_packs = 0;
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline(&line, out, '\n') != EOF) {
> +		if (line.len != 40)
> +			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
> +		strbuf_addstr(&line, "");

What is this addstr() about?

> +		string_list_append(&names, line.buf);
> +		count_packs++;

It probably is more in line with our naming convention to call this
nr_packs, num_packs, etc.  "count_packs" sounds more like a boolean
that instructs the code to either count or not bother counting,
which this thing is not.

> +	}
> +	fclose(out);
> +	ret = finish_command(&cmd);
> +	if (ret)
> +		return 1;
> +	argv_array_clear(&cmd_args);
> +
> +	if (!count_packs && !quiet)
> +		printf("Nothing new to pack.\n");
> +
> +	int failed = 0;

decl-after-stmt.

> +	for_each_string_list_item(item, &names) {
> +		for (ext = 0; ext < 2; ext++) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/%s%s", packdir,
> +						item->string, exts[ext]);
> +			if (!file_exists(fname)) {
> +				free(fname);
> +				continue;
> +			}
> +
> +			fname_old = mkpathdup("%s/old-%s%s", packdir,
> +						item->string, exts[ext]);
> +			if (file_exists(fname_old))
> +				unlink(fname_old);
> +
> +			if (rename(fname, fname_old)) {
> +				failed = 1;
> +				break;

"break"-ing from here leaks fname_old.  As the only out-of-line call
file_exists() is just a thin wrapper around lstat(), I think it is
fine not to pathdup the fname_old here.

> +			}
> +			string_list_append_nodup(&rollback, fname);
> +			free(fname);

This looks bad, doesn't it?  append_nodup() lets &rollback string
list to take the ownership of the piece of memory pointed at by
fname, but then you free it here, no?

If you initialize &rollback with INIT_NODUP, you would not have to
call append_nodup().

> +			free(fname_old);
> +		}
> +		if (failed)
> +			break;
> +	}
> +	if (failed) {
> +		struct string_list rollback_failure;

Initialization?

> +		for_each_string_list_item(item, &rollback) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/%s", packdir, item->string);
> +			fname_old = mkpath("%s/old-%s", packdir, item->string);
> +			if (rename(fname_old, fname))
> +				string_list_append(&rollback_failure, fname);
> +			free(fname);
> +		}
