From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-clean: Display more accurate delete messages
Date: Wed, 09 Jan 2013 18:56:10 -0800
Message-ID: <7vk3rl3fw5.fsf@alter.siamese.dyndns.org>
References: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 03:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt8Jo-0003uH-7R
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 03:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171Ab3AJC4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 21:56:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758150Ab3AJC4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 21:56:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C65BFF1;
	Wed,  9 Jan 2013 21:56:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=638H5XGaYAV+p/qVKPpr/PeTLWg=; b=gKEcgp
	V1VE1Q+ndESsyvAKp7/YkT0Jt5j+/8/Tqh7DljPMfONwM8zjft37PB/FKY2ID74L
	jf2BXm7FPEbAYoXOIeu79mWmdoRxsamURoQ/7QcmstaJEwwW1HQwOhEf+nOzPOmW
	FDSvWckQBFR3jRxynuvT3tcjAKEpO/U+YqDhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yGYf4uW2dSjlgoRkMuuvJzZXso5GyJB/
	oMmETSRVVilryzxNyLnkhSa5wmZbMi1da/DHm49ALIWorNXDJ08Zwp0bH7ZoMNir
	JroWEBRCSN8rTSIfSGOmqoEkJbSigrxop0Q1xgxxv450x06b0vS7bKasoxuekX5Z
	suKOC2qvXbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1879DBFF0;
	Wed,  9 Jan 2013 21:56:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14916BFED; Wed,  9 Jan 2013
 21:56:11 -0500 (EST)
In-Reply-To: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
 (Zoltan Klinger's message of "Mon, 7 Jan 2013 10:16:59 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A9BB6EE-5AD1-11E2-9534-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213119>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> Consider the output of the improved version:
>
>   $ git clean -fd
>   Removing tracked_dir/some_untracked_file
>   Removing untracked_file
>   warning: ignoring untracked git repository untracked_foo/frotz.git
>   Removing untracked_foo/bar
>   Removing untracked_foo/emptydir
>   warning: ignoring untracked git repository untracked_some.git/
>
> Now it displays only the file and directory names that got actually
> deleted and shows warnings about ignored untracked git repositories.
>
> Reported-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
> ---

I think the code before this patch used to say "Would not remove"
and "Not removing" in certain cases to report the paths that the
command decided not to remove, but after this patch these two
messages no longer appear in the patch.

Is it expected, are we losing information, or...?

>  builtin/clean.c |  158 +++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 129 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 69c1cda..1714546 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -10,6 +10,7 @@
>  #include "cache.h"
>  #include "dir.h"
>  #include "parse-options.h"
> +#include "refs.h"
>  #include "string-list.h"
>  #include "quote.h"
>  
> @@ -20,6 +21,12 @@ static const char *const builtin_clean_usage[] = {
>  	NULL
>  };
>  
> +static const char *msg_remove = N_("Removing %s\n");
> +static const char *msg_would_remove = N_("Would remove %s\n");
> +static const char *msg_would_ignore_git_dir = N_("Would ignore untracked git repository %s\n");
> +static const char *msg_warn_ignore_git_dir = N_("ignoring untracked git repository %s");
> +static const char *msg_warn_remove_failed = N_("failed to remove %s");
> +
>  static int git_clean_config(const char *var, const char *value, void *cb)
>  {
>  	if (!strcmp(var, "clean.requireforce"))
> @@ -34,11 +41,116 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
> +		int dry_run, int quiet, int *dir_gone)
> +{
> +	DIR *dir;
> +	struct strbuf quoted = STRBUF_INIT;
> +	struct dirent *e;
> +	int res = 0, ret = 0, gone = 1, original_len = path->len, len, i;
> +	unsigned char submodule_head[20];
> +	struct string_list dels = STRING_LIST_INIT_DUP;
> +
> +	*dir_gone = 1;
> +
> +	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> +	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
> +		if (dry_run && !quiet) {
> +			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +			printf(_(msg_would_ignore_git_dir), quoted.buf);
> +		} else if (!dry_run) {
> +			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +			warning(_(msg_warn_ignore_git_dir), quoted.buf);
> +		}
> +
> +		*dir_gone = 0;
> +		return 0;
> +	}
> +
> +	dir = opendir(path->buf);
> +	if (!dir) {
> +		/* an empty dir could be removed even if it is unreadble */
> +		res = dry_run ? 0 : rmdir(path->buf);
> +		if (res) {
> +			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +			warning(_(msg_warn_remove_failed), quoted.buf);
> +			*dir_gone = 0;
> +		}
> +		return res;
> +	}
> +
> +	if (path->buf[original_len - 1] != '/')
> +		strbuf_addch(path, '/');
> +
> +	len = path->len;
> +	while ((e = readdir(dir)) != NULL) {
> +		struct stat st;
> +		if (is_dot_or_dotdot(e->d_name))
> +			continue;
> +
> +		strbuf_setlen(path, len);
> +		strbuf_addstr(path, e->d_name);
> +		if (lstat(path->buf, &st))
> +			; /* fall thru */
> +		else if (S_ISDIR(st.st_mode)) {
> +			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
> +				ret = 1;
> +			if (gone) {
> +				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +				string_list_append(&dels, quoted.buf);
> +			}
> +			else
> +				*dir_gone = 0;
> +			continue;
> +		} else {
> +			res = dry_run ? 0 : unlink(path->buf);
> +			if (!res) {
> +				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +				string_list_append(&dels, quoted.buf);
> +			}
> +			else {
> +				quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +				warning(_(msg_warn_remove_failed), quoted.buf);
> +				*dir_gone = 0;
> +				ret = 1;
> +			}
> +			continue;
> +		}
> +
> +		/* path too long, stat fails, or non-directory still exists */
> +		*dir_gone = 0;
> +		ret = 1;
> +		break;
> +	}
> +	closedir(dir);
> +
> +	strbuf_setlen(path, original_len);
> +
> +	if (*dir_gone) {
> +		res = dry_run ? 0 : rmdir(path->buf);
> +		if (!res)
> +			*dir_gone = 1;
> +		else {
> +			quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +			warning(_(msg_warn_remove_failed), quoted.buf);
> +			*dir_gone = 0;
> +			ret = 1;
> +		}
> +	}
> +
> +	if (!*dir_gone && !quiet) {
> +		for (i = 0; i < dels.nr; i++)
> +			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
> +	}
> +	string_list_clear(&dels, 0);
> +	return ret;
> +}
> +
>  int cmd_clean(int argc, const char **argv, const char *prefix)
>  {
> -	int i;
> -	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
> -	int ignored_only = 0, config_set = 0, errors = 0;
> +	int i, res;
> +	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
> +	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
>  	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
>  	struct strbuf directory = STRBUF_INIT;
>  	struct dir_struct dir;
> @@ -49,7 +161,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	char *seen = NULL;
>  	struct option options[] = {
>  		OPT__QUIET(&quiet, N_("do not print names of files removed")),
> -		OPT__DRY_RUN(&show_only, N_("dry run")),
> +		OPT__DRY_RUN(&dry_run, N_("dry run")),
>  		OPT__FORCE(&force, N_("force")),
>  		OPT_BOOLEAN('d', NULL, &remove_directories,
>  				N_("remove whole directories")),
> @@ -77,7 +189,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	if (ignored && ignored_only)
>  		die(_("-x and -X cannot be used together"));
>  
> -	if (!show_only && !force) {
> +	if (!dry_run && !force) {
>  		if (config_set)
>  			die(_("clean.requireForce set to true and neither -n nor -f given; "
>  				  "refusing to clean"));
> @@ -149,38 +261,26 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  		if (S_ISDIR(st.st_mode)) {
>  			strbuf_addstr(&directory, ent->name);
> -			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -			if (show_only && (remove_directories ||
> -			    (matches == MATCHED_EXACTLY))) {
> -				printf(_("Would remove %s\n"), qname);
> -			} else if (remove_directories ||
> -				   (matches == MATCHED_EXACTLY)) {
> -				if (!quiet)
> -					printf(_("Removing %s\n"), qname);
> -				if (remove_dir_recursively(&directory,
> -							   rm_flags) != 0) {
> -					warning(_("failed to remove %s"), qname);
> +			if (remove_directories || (matches == MATCHED_EXACTLY)) {
> +				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
>  					errors++;
> +				if (gone && !quiet) {
> +					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> +					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>  				}
> -			} else if (show_only) {
> -				printf(_("Would not remove %s\n"), qname);
> -			} else {
> -				printf(_("Not removing %s\n"), qname);
>  			}
>  			strbuf_reset(&directory);
>  		} else {
>  			if (pathspec && !matches)
>  				continue;
> -			qname = quote_path_relative(ent->name, -1, &buf, prefix);
> -			if (show_only) {
> -				printf(_("Would remove %s\n"), qname);
> -				continue;
> -			} else if (!quiet) {
> -				printf(_("Removing %s\n"), qname);
> -			}
> -			if (unlink(ent->name) != 0) {
> -				warning(_("failed to remove %s"), qname);
> +			res = dry_run ? 0 : unlink(ent->name);
> +			if (res) {
> +				qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +				warning(_(msg_warn_remove_failed), qname);
>  				errors++;
> +			} else if (!quiet) {
> +				qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
>  			}
>  		}
>  	}
