From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-clean: Display more accurate delete messages
Date: Wed, 02 Jan 2013 12:11:46 -0800
Message-ID: <7vfw2j2vlp.fsf@alter.siamese.dyndns.org>
References: <1357091159-22080-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 21:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqUfa-00064X-IL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 21:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3ABULv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 15:11:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab3ABULu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 15:11:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A842AC11;
	Wed,  2 Jan 2013 15:11:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S4y1dGmnFfNuS1/XypkvqbKrS1Y=; b=ZjPgXY
	AdfXbBe6B922cuT3oAPKOFJ61WAgqJTNVbCnJ/zTduJN+UcMaF4VZ7aWjDipvS1w
	dei41bbiyAm6iFoS9TsVHPUWeEQZFlabxPcqOcsQDcmGnXq2Qc88o5MQPV+JQl/l
	LS4thPrXqbmAP2YHk/qCzVc9IhFH4pGcWeyaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nx1tdThXtPvXVoQP5gpdpVef6A1HYZC2
	YfOfzw5mN6i6Mu+17vJN6nCulBHh9N6kkyt/B9m452nMvmcDEo8kboj08oihzb9p
	T9YJttYr5Yi6tsK6MutevTjH9AEns4izsIc92ddsBSXReT+LFc/1DUUvfnG35C6X
	mmvs/6mtU9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55675AC10;
	Wed,  2 Jan 2013 15:11:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F70DAC0F; Wed,  2 Jan 2013
 15:11:48 -0500 (EST)
In-Reply-To: <1357091159-22080-1-git-send-email-zoltan.klinger@gmail.com>
 (Zoltan Klinger's message of "Wed, 2 Jan 2013 12:45:59 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A38B92CE-5518-11E2-A2BE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212536>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> +static const char* MSG_REMOVE = "Removing %s\n";
> +static const char* MSG_WOULD_REMOVE = "Would remove %s\n";
> +static const char* MSG_WOULD_NOT_REMOVE = "Would not remove %s\n";
> +static const char* MSG_WOULD_IGNORE_GIT_DIR = "Would ignore untracked git repository %s\n";
> +static const char* MSG_WARN_GIT_DIR_IGNORE = "ignoring untracked git repository %s";
> +static const char* MSG_WARN_REMOVE_FAILED = "failed to remove %s";

"foo* bar" should be "foo *bar".  Also I personally find these
upcased message constants somewhat hard to read in the sites of use
in the code below.

Also gettext machinery needs to be told that these strings may be
asked to be replaced with their translations using _() elsewhere in
the code.  I.e.

	static const char *msg_remove = N_("Removing %s\n");

Aren't WOULD_IGNORE_GIT_DIR and WARN_GIT_DIR_IGNORE named somewhat
inconsistently?  Perhaps the latter is WARN_IGNORED_GIT_DIR or
something?

> @@ -34,11 +42,109 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
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
> +	quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);

Shouldn't this be inside the next if() statement body?  I also think
you could even omit this call when (!dry_run && quiet).  The same
comment applies to all uses of quote_path_relative() in this patch,
including the ones that were kept from the original in clean.c,
which made sense because they were used in all if/else bodies that
followed them but this patch makes it no longer true.

> +	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
> +	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
> +		if (dry_run && !quiet)
> +			printf(_(MSG_WOULD_IGNORE_GIT_DIR), quoted.buf);
> +		else if (!dry_run)
> +			warning(_(MSG_WARN_GIT_DIR_IGNORE), quoted.buf);
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
> +			warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
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
> +		quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +		if (lstat(path->buf, &st))
> +			; /* fall thru */
> +		else if (S_ISDIR(st.st_mode)) {
> +			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
> +				ret = 1;
> +			if (gone)
> +				string_list_append(&dels, quoted.buf);
> +			else
> +				*dir_gone = 0;
> +			continue;
> +		} else {
> +			res = dry_run ? 0 : unlink(path->buf);
> +			if (!res)
> +				string_list_append(&dels, quoted.buf);
> +			else {
> +				warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
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
> +	quote_path_relative(path->buf, strlen(path->buf), &quoted, prefix);
> +	if (*dir_gone) {
> +		res = dry_run ? 0 : rmdir(path->buf);
> +		if (!res)
> +			*dir_gone = 1;
> +		else {
> +			warning(_(MSG_WARN_REMOVE_FAILED), quoted.buf);
> +			*dir_gone = 0;
> +			ret = 1;
> +		}
> +	}
> +
> +	if (!*dir_gone && !quiet) {
> +		for (i = 0; i < dels.nr; i++)
> +			printf(dry_run ?  _(MSG_WOULD_REMOVE) : _(MSG_REMOVE), dels.items[i].string);
> +	}
> +	string_list_clear(&dels, 0);
> +	return ret;
> +}

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
> @@ -49,7 +155,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	char *seen = NULL;
>  	struct option options[] = {
>  		OPT__QUIET(&quiet, N_("do not print names of files removed")),
> -		OPT__DRY_RUN(&show_only, N_("dry run")),
> +		OPT__DRY_RUN(&dry_run, N_("dry run")),
>  		OPT__FORCE(&force, N_("force")),
>  		OPT_BOOLEAN('d', NULL, &remove_directories,
>  				N_("remove whole directories")),
> @@ -77,7 +183,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	if (ignored && ignored_only)
>  		die(_("-x and -X cannot be used together"));
>  
> -	if (!show_only && !force) {
> +	if (!dry_run && !force) {
>  		if (config_set)
>  			die(_("clean.requireForce set to true and neither -n nor -f given; "
>  				  "refusing to clean"));
> @@ -150,38 +256,23 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		if (S_ISDIR(st.st_mode)) {
>  			strbuf_addstr(&directory, ent->name);
>  			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> +			if (remove_directories || (matches == MATCHED_EXACTLY)) {
> +				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
>  					errors++;
> +				if (gone && !quiet)
> +					printf(dry_run ? _(MSG_WOULD_REMOVE) : _(MSG_REMOVE), qname);
>  			}
>  			strbuf_reset(&directory);
>  		} else {
>  			if (pathspec && !matches)
>  				continue;
>  			qname = quote_path_relative(ent->name, -1, &buf, prefix);
> +			res = dry_run ? 0 : unlink(ent->name);
> +			if (res) {
> +				warning(_(MSG_WARN_REMOVE_FAILED), qname);
>  				errors++;
> -			}
> +			} else if (!quiet)
> +				printf(dry_run ? _(MSG_WOULD_REMOVE) :_(MSG_REMOVE), qname);

spaces required around that ':' (ctx:WxV)
#313: FILE: builtin/clean.c:275:
+				printf(dry_run ? _(MSG_WOULD_REMOVE) :_(MSG_REMOVE), qname);

>  		}
>  	}
>  	free(seen);

The updated code structure is much nicer than the previous round,
but I am somewhat puzzled how return value of remove_dirs() and
&gone relate to each other.  Surely when gone is set to zero,
remove_dirs() is reporting that the directory it was asked to remove
recursively did not go away, so it must report failure, no?  Having
the &gone flag looks redundant and checking for gone in some places
while checking for the return value for others feels like an
invitation for future bugs.

Also the remove_dirs() function seems to replace the use of
remove_dir_recurse() from dir.c by copying large part of it, with
error message sprinkled.  Does remove_dir_recurse() still get used
by other codepaths?  If so, do the remaining callsites benefit from
using this updated version?

Thanks; will replace what has been sitting on the 'pu' branch with
this copy.
