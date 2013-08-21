From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 10:49:11 +0200
Message-ID: <vpqhaeje8e0.fsf@anie.imag.fr>
References: <5213EF74.7020408@googlemail.com>
	<1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 10:50:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC47C-0008Of-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 10:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab3HUIuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 04:50:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34180 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab3HUIt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 04:49:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7L8nBqj008281
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 10:49:11 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VC46J-0005Xa-U3; Wed, 21 Aug 2013 10:49:11 +0200
In-Reply-To: <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Wed, 21 Aug 2013 00:38:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 10:49:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7L8nBqj008281
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377679752.3454@4+QgMD0U5lpGnHNPwg1yEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232694>

Stefan Beller <stefanbeller@googlemail.com> writes:

> All tests are constantly positive now.

Cool!

> +/*
> + * Fills the filename list with all the files found in the pack directory

Detail: "filename list" could be "fname_list" to match the actual
argument below.

> + * ending with .pack, without that extension.
> + */
> +void get_pack_filenames(char *packdir, struct string_list *fname_list)
> +{
> +	DIR *dir;
> +	struct dirent *e;
> +	char *path, *suffix, *fname;
> +
> +	path = mkpath("%s/pack", get_object_directory());
> +	suffix = ".pack";
> +
> +	dir = opendir(path);

I think you should test and complain if dir is NULL ("cannot open pack
directory: ...")

> +void remove_pack(char *path, char* sha1)
> +{
> +	char *exts[] = {".pack", ".idx", ".keep"};
> +	int ext = 0;
> +	for (ext = 0; ext < 3; ext++) {
> +		char *fname;
> +		fname = mkpath("%s/%s%s", path, sha1, exts[ext]);
> +		unlink(fname);

Here also, the return value from unlink is not checked. Probably not
serious (mistakenly deleting a pack file would be very serious, but
keeping it around by mistake shouldn't harm), but a warning message may
be welcome.

These kinds of warnings are never shown in normal usage, but may be
welcome when something goes really wrong with the repo, as a diagnosis
tool for the user. The shell version had these warnings implicitly since
"rm" displays the message on stderr when it fails.

> +	struct child_process cmd;
> +	struct argv_array cmd_args = ARGV_ARRAY_INIT;

Since the command is going to be "pack-objects", you may call the
variables pack_cmd and pack_cmd_args or so.

> +	if (local)
> +		argv_array_push(&cmd_args,  "--local");
> +	if (quiet)
> +		argv_array_push(&cmd_args,  "--quiet");
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
> +	if (start_command(&cmd))
> +		return 1;

A warning message would be welcome in addition to returning 1.

> +	if (!count_packs && !quiet)
> +		printf("Nothing new to pack.\n");
> +
> +	int failed = 0;

Don't declare variables inside code, it's not C90.

> +	for_each_string_list_item(item, &names) {
> +		for (ext = 0; ext < 2; ext++) {
> +			char *fname, *fname_old;
> +			fname = mkpathdup("%s/%s%s", packdir, item->string, exts[ext]);
> +			if (!file_exists(fname)) {
> +				free(fname);
> +				continue;
> +			}
> +
> +			fname_old = mkpath("%s/old-%s%s", packdir, item->string, exts[ext]);
> +			if (file_exists(fname_old))
> +				unlink(fname_old);

Unchecked returned value.

> +			if (rename(fname, fname_old)) {
> +				failed = 1;
> +				break;
> +			}
> +			string_list_append_nodup(&rollback, fname);
> +			free(fname);
> +		}
> +		if (failed)
> +			break;
> +	}

I tend to dislike these "set a variable and break twice" to exit nested
loops. Using an auxiliary function, you could just do

int f()
{
	for_each {
		for () {
			...
			if ()
				return 1;
			...
		}
	}
	return 0;
}

(Matter of taste, though. Some people may disagree)

A good side effect would be to move some code out of cmd_repack, which
is rather long.

> +	/* Now the ones with the same name are out of the way... */
> +	for_each_string_list_item(item, &names) {
> +		for (ext = 0; ext < 2; ext++) {
> +			char *fname, *fname_old;
> +			struct stat statbuffer;
> +			fname = mkpathdup("%s/pack-%s%s", packdir, item->string, exts[ext]);
> +			fname_old = mkpath("%s-%s%s", packtmp, item->string, exts[ext]);
> +			if (!stat(fname_old, &statbuffer)) {
> +				statbuffer.st_mode &= ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
> +				chmod(fname_old, statbuffer.st_mode);

Unchecked return value.

> +	/* Remove the "old-" files */
> +	for_each_string_list_item(item, &names) {
> +		char *fname;
> +		fname = mkpath("%s/old-pack-%s.idx", packdir, item->string);
> +		if (remove_path(fname))
> +			die_errno(_("removing '%s' failed"), fname);
> +
> +		fname = mkpath("%s/old-pack-%s.pack", packdir, item->string);
> +		if (remove_path(fname))
> +			die_errno(_("removing '%s' failed"), fname);

Does this have to be a fatal error? If I read correctly, it wasn't fatal
in the shell version.

Any reason why you duplicate the code for .idx and .pack here, while you
iterate over an ext array in other places of the code?

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
> +		argv_array_clear(&cmd_args);
> +		argv_array_push(&cmd_args, "prune-packed");
> +		if (quiet)
> +			argv_array_push(&cmd_args, "--quiet");
> +
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = cmd_args.argv;
> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}

It's tempting to call prune_packed_objects() directly here, but it's
implemented in builtin/ so it would require a refactoring patch to be
moved to libgit.a before I guess.

> +	if (!no_update_server_info) {
> +		argv_array_clear(&cmd_args);
> +		argv_array_push(&cmd_args, "update-server-info");
> +
> +		memset(&cmd, 0, sizeof(cmd));
> +		cmd.argv = cmd_args.argv;
> +		cmd.git_cmd = 1;
> +		run_command(&cmd);
> +	}
> +	return 0;
> +}

Any reason to fork a new process instead of just calling
update_server_info() directly?

Not that efficiency matters here, but the code would be a bit simpler.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
