From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 01 Jun 2016 09:00:34 -0700
Message-ID: <xmqqwpm8zyot.fsf@gitster.mtv.corp.google.com>
References: <20160531220818.GB46739@zoidberg>
	<xmqqtwhd3lht.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606010919360.5761@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:00:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88ZX-000054-Qy
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcFAQAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:00:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970AbcFAQAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:00:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A54561F3AE;
	Wed,  1 Jun 2016 12:00:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKpmJ5KSe+Ev3p62KtddEorX7Qo=; b=r9g+Kw
	cnYXtzPjHzKKDMws0woXcqtcMkcSs6XyghY5+kA8trXBdk96Sj5qCUmafwsFJiVe
	Vy7e4gLqNTSd3SFQ3BoNph+jBOELiSbmmVe0n7UXDV6M63ikKggr3EI2WJRlOn0i
	InqNNpAucIyCFB+4Ni4cy75hUVgusiv5It7xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DY1sHh61ZtfPowdVg1TOW0DmCAx6/Vsb
	ppEmccoZF2gdY+sln+hwDwIwTYd5iwZWA8tKijnjFU/Kd7AovsfCr2Y3i2Pc9+E9
	WlWToumcT0yrTOc/GcO7LcxG6npVoXjpsCeI+e9DK+gOfzs7pMYoiHjER6mAt7Q7
	uiAX8b14210=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9650B1F3AD;
	Wed,  1 Jun 2016 12:00:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E45E1F3AC;
	Wed,  1 Jun 2016 12:00:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1606010919360.5761@virtualbox> (Johannes
	Schindelin's message of "Wed, 1 Jun 2016 09:23:21 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA5D2F7A-2811-11E6-8110-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296092>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & Ed,
>
> On Tue, 31 May 2016, Junio C Hamano wrote:
>
>> Edward Thomson <ethomson@edwardthomson.com> writes:
>> 
>> > +static char *chmod_arg = NULL;
>> > +
>> 
>> I'll drop " = NULL", as it is our convention to let BSS take care of
>> the zero initialization for global variables as much as possible.
>> 
>> Other than that, I did not see anything objectionable in this round,
>> but I did notice that you kept the "this takes two bits out of 32"
>> Dscho mentioned--I do not have a strong preference either way, so
>> I'll queue it (at least tentatively) on 'pu'.
>
> And here is an add-on patch (Ed, feel free to squash) that avoids those
> two bits, and even saves one line overall:

Unlike the "something like this" we saw earlier, this draws the
boundary of responsibility between the caller and the API at a much
more sensible place.

The difference between the versions with and without this update
essentially is that the original had two bits in flags (among 32
total, 5 bits are currently used and the patch uses 2 more bits),
and this instead changes the function signature of functions that
took "flags" so that lal of them take one additional word.  So in
that sense, because we have enough bits to use, this is not a great
improvement.

However.

The filemode that we force is not two independent bits, but a
tristate: do not force, force executable and force non-executable.
And from that point of view, the two seemingly-independent bits
looked a bit strange, and I prefer the separation this update gives
us slightly more for that reason.  I didn't think carefully about
the change to add_to_index(), but doing it this way _may_ make it
easier for us to later extend it to force "this is file on
filesystem but record it as a symlink", in which case, even if we do
not plan to implement such an enhancement in a near future, I think
this is the right direction to go in.

Thanks.

>
> -- snipsnap --
> diff --git a/builtin/add.c b/builtin/add.c
> index 44b6c97..b1dddb4 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -26,7 +26,7 @@ static int patch_interactive, add_interactive, edit_interactive;
>  static int take_worktree_changes;
>  
>  struct update_callback_data {
> -	int flags;
> +	int flags, force_mode;
>  	int add_errors;
>  };
>  
> @@ -65,7 +65,8 @@ static void update_callback(struct diff_queue_struct *q,
>  			die(_("unexpected diff status %c"), p->status);
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
> -			if (add_file_to_index(&the_index, path, data->flags)) {
> +			if (add_file_to_index(&the_index, path,
> +					data->flags, data->force_mode)) {
>  				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
>  					die(_("updating files failed"));
>  				data->add_errors++;
> @@ -83,14 +84,15 @@ static void update_callback(struct diff_queue_struct *q,
>  	}
>  }
>  
> -int add_files_to_cache(const char *prefix,
> -		       const struct pathspec *pathspec, int flags)
> +int add_files_to_cache(const char *prefix, const struct pathspec *pathspec,
> +	int flags, int force_mode)
>  {
>  	struct update_callback_data data;
>  	struct rev_info rev;
>  
>  	memset(&data, 0, sizeof(data));
>  	data.flags = flags;
> +	data.force_mode = force_mode;
>  
>  	init_revisions(&rev, prefix);
>  	setup_revisions(0, NULL, &rev, NULL);
> @@ -238,7 +240,7 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
>  static int addremove = ADDREMOVE_DEFAULT;
>  static int addremove_explicit = -1; /* unspecified */
>  
> -static char *chmod_arg = NULL;
> +static char *chmod_arg;
>  
>  static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
>  {
> @@ -279,7 +281,7 @@ static int add_config(const char *var, const char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
>  
> -static int add_files(struct dir_struct *dir, int flags)
> +static int add_files(struct dir_struct *dir, int flags, int force_mode)
>  {
>  	int i, exit_status = 0;
>  
> @@ -292,7 +294,8 @@ static int add_files(struct dir_struct *dir, int flags)
>  	}
>  
>  	for (i = 0; i < dir->nr; i++)
> -		if (add_file_to_cache(dir->entries[i]->name, flags)) {
> +		if (add_file_to_index(&the_index, dir->entries[i]->name,
> +				flags, force_mode)) {
>  			if (!ignore_add_errors)
>  				die(_("adding files failed"));
>  			exit_status = 1;
> @@ -305,7 +308,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	int exit_status = 0;
>  	struct pathspec pathspec;
>  	struct dir_struct dir;
> -	int flags;
> +	int flags, force_mode;
>  	int add_new_files;
>  	int require_pathspec;
>  	char *seen = NULL;
> @@ -339,10 +342,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	if (!show_only && ignore_missing)
>  		die(_("Option --ignore-missing can only be used together with --dry-run"));
>  
> -	if (chmod_arg) {
> -		if (strcmp(chmod_arg, "-x") && strcmp(chmod_arg, "+x"))
> -			die(_("--chmod param must be either -x or +x"));
> -	}
> +	if (!chmod_arg)
> +		force_mode = 0;
> +	else if (!strcmp(chmod_arg, "-x"))
> +		force_mode = 0666;
> +	else if (!strcmp(chmod_arg, "+x"))
> +		force_mode = 0777;
> +	else
> +		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
>  
>  	add_new_files = !take_worktree_changes && !refresh_only;
>  	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
> @@ -354,9 +361,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
>  		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
>  		 (!(addremove || take_worktree_changes)
> -		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
> -		 (chmod_arg && *chmod_arg == '+' ? ADD_CACHE_FORCE_EXECUTABLE : 0) |
> -		 (chmod_arg && *chmod_arg == '-' ? ADD_CACHE_FORCE_NOTEXECUTABLE : 0);
> +		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
>  
>  	if (require_pathspec && argc == 0) {
>  		fprintf(stderr, _("Nothing specified, nothing added.\n"));
> @@ -436,10 +441,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	plug_bulk_checkin();
>  
> -	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
> +	exit_status |= add_files_to_cache(prefix, &pathspec, flags, force_mode);
>  
>  	if (add_new_files)
> -		exit_status |= add_files(&dir, flags);
> +		exit_status |= add_files(&dir, flags, force_mode);
>  
>  	unplug_bulk_checkin();
>  
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3398c61..c3486bd 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -548,7 +548,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 * entries in the index.
>  			 */
>  
> -			add_files_to_cache(NULL, NULL, 0);
> +			add_files_to_cache(NULL, NULL, 0, 0);
>  			/*
>  			 * NEEDSWORK: carrying over local changes
>  			 * when branches have different end-of-line
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 443ff91..163dbca 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -386,7 +386,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  	 */
>  	if (all || (also && pathspec.nr)) {
>  		hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
> +		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, 0);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
>  		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
> diff --git a/cache.h b/cache.h
> index da03cd9..c73becb 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -367,8 +367,8 @@ extern void free_name_hash(struct index_state *istate);
>  #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
>  #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
>  #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
> -#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
> -#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
> +#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags), 0)
> +#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags), 0)
>  #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
>  #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
>  #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
> @@ -581,10 +581,8 @@ extern int remove_file_from_index(struct index_state *, const char *path);
>  #define ADD_CACHE_IGNORE_ERRORS	4
>  #define ADD_CACHE_IGNORE_REMOVAL 8
>  #define ADD_CACHE_INTENT 16
> -#define ADD_CACHE_FORCE_EXECUTABLE 32
> -#define ADD_CACHE_FORCE_NOTEXECUTABLE 64
> -extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
> -extern int add_file_to_index(struct index_state *, const char *path, int flags);
> +extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags, int force_mode);
> +extern int add_file_to_index(struct index_state *, const char *path, int flags, int force_mode);
>  extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
>  extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
>  extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
> @@ -1774,7 +1772,7 @@ void packet_trace_identity(const char *prog);
>   * return 0 if success, 1 - if addition of a file failed and
>   * ADD_FILES_IGNORE_ERRORS was specified in flags
>   */
> -int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
> +int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, int force_mode);
>  
>  /* diff.c */
>  extern int diff_auto_refresh_index;
> diff --git a/read-cache.c b/read-cache.c
> index d12d143..db27766 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -630,7 +630,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
>  	hashcpy(ce->sha1, sha1);
>  }
>  
> -int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
> +int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags, int force_mode)
>  {
>  	int size, namelen, was_same;
>  	mode_t st_mode = st->st_mode;
> @@ -641,8 +641,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	int intent_only = flags & ADD_CACHE_INTENT;
>  	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
> -	int force_executable = flags & ADD_CACHE_FORCE_EXECUTABLE;
> -	int force_notexecutable = flags & ADD_CACHE_FORCE_NOTEXECUTABLE;
>  
>  	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
>  		return error("%s: can only add regular files, symbolic links or git-directories", path);
> @@ -661,14 +659,11 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	else
>  		ce->ce_flags |= CE_INTENT_TO_ADD;
>  
> -	if (S_ISREG(st_mode) && (force_executable || force_notexecutable)) {
> -		if (force_executable)
> -			ce->ce_mode = create_ce_mode(0777);
> -		else
> -			ce->ce_mode = create_ce_mode(0666);
> -	} else if (trust_executable_bit && has_symlinks) {
> +	if (S_ISREG(st_mode) && force_mode)
> +		ce->ce_mode = create_ce_mode(force_mode);
> +	else if (trust_executable_bit && has_symlinks)
>  		ce->ce_mode = create_ce_mode(st_mode);
> -	} else {
> +	else {
>  		/* If there is an existing entry, pick the mode bits and type
>  		 * from it, otherwise assume unexecutable regular file.
>  		 */
> @@ -727,12 +722,13 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	return 0;
>  }
>  
> -int add_file_to_index(struct index_state *istate, const char *path, int flags)
> +int add_file_to_index(struct index_state *istate, const char *path,
> +	int flags, int force_mode)
>  {
>  	struct stat st;
>  	if (lstat(path, &st))
>  		die_errno("unable to stat '%s'", path);
> -	return add_to_index(istate, path, &st, flags);
> +	return add_to_index(istate, path, &st, flags, force_mode);
>  }
>  
>  struct cache_entry *make_cache_entry(unsigned int mode,
