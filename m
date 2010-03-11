From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 02/13] Support showing notes from more than one notes
 tree
Date: Thu, 11 Mar 2010 11:03:22 +0100
Message-ID: <201003111103.22671.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <e69a916ca6afb53fb665951d499d7e6543007008.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpfEr-0007VR-On
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab0CKKD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:03:28 -0500
Received: from smtp.getmail.no ([84.208.15.66]:34337 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809Ab0CKKD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:03:26 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400ICU3XPA0E0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:03:25 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ40069Q3XNOZ20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:03:24 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.94823
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <e69a916ca6afb53fb665951d499d7e6543007008.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141946>

On Wednesday 10 March 2010, Thomas Rast wrote:
> With this patch, you can set notes.displayRef to a glob that points at
> your favourite notes refs, e.g.,
> 
> [notes]
> 	displayRef = refs/notes/*
> 
> Then git-log and friends will show notes from all trees.
> 
> Thanks to Junio C Hamano for lots of feedback, which greatly
> influenced the design of the entire series and this commit in
> particular.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johan Herland <johan@herland.net>

...except for the following small niggles:

> diff --git a/Documentation/pretty-options.txt
> b/Documentation/pretty-options.txt index aa96cae..1d56926 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -30,9 +30,18 @@ people using 80-column terminals.
>  	defaults to UTF-8.
> 
>  --no-notes::
> ---show-notes::
> +--show-notes[=<ref>]::
>  	Show the notes (see linkgit:git-notes[1]) that annotate the
>  	commit, when showing the commit log message.  This is the default
>  	for `git log`, `git show` and `git whatchanged` commands when
>  	there is no `--pretty`, `--format` nor `--oneline` option is
>  	given on the command line.
> ++
> +With an optional argument, add this ref to the list of notes.  The ref
> +is taken to be in `refs/notes/` if it is not qualified.
> +
> +--[no-]standard-notes::
> +	Enable or disable populating the notes ref list from the
> +	'core.notesRef' and 'notes.displayRef' variables (or
> +	corresponding environment overrides).  See
> +	linkgit:git-config[1].

Should probably mention that --standard-notes describes the default 
behaviour.

> diff --git a/notes.c b/notes.c
> index a4f9926..0d4b892 100644
> --- a/notes.c
> +++ b/notes.c
> +static int notes_display_config(const char *k, const char *v, void *cb)
> +{
> +	int *load_refs = cb;
> +
> +	if (*load_refs && !strcmp(k, "notes.displayref")) {
> +		if (!v)
> +			config_error_nonbool(k);
> +		string_list_add_refs_by_glob(&display_notes_refs, v);
> +		return 0;

This "return 0" is unnecessary

> +static int string_list_add_refs_from_list(struct string_list_item *item,
> +					  void *cb)
> +{
> +	struct string_list *list = cb;
> +	string_list_add_refs_by_glob(list, item->string);
> +	return 0;
> +}

Shouldn't string_list_add_refs_from_list() be placed up with the other 
string_list_add_* functions? 

> +void init_display_notes(struct display_notes_opt *opt)
> +{
> +	char *display_ref_env;
> +	int load_config_refs = 0;
> +	display_notes_refs.strdup_strings = 1;
> +
> +	assert(!display_notes_trees);
> +
> +	if (!opt || !opt->suppress_default_notes) {
> +		string_list_append(default_notes_ref(), &display_notes_refs);
> +		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
> +		if (display_ref_env) {
> +			string_list_add_refs_from_colon_sep(&display_notes_refs,
> +							    display_ref_env);
> +			load_config_refs = 0;
> +		} else {
> +			load_config_refs = 1;
> +		}

Drop unnecessary braces in the 'else'

> @@ -1030,3 +1178,14 @@ void format_note(struct notes_tree *t, const
> unsigned char *object_sha1,
> 
>  	free(msg);
>  }
> +
> +void format_display_notes(const unsigned char *object_sha1,
> +			  struct strbuf *sb, const char *output_encoding, int flags)
> +{
> +	int i;
> +	if (!display_notes_trees)
> +		init_display_notes(NULL);

Not sure I like this "fallback" call to init_display_notes(NULL). There's 
already a call from builtin/log.c which passes "&rev->notes_opt", and this 
fallback is at best useless (since init_display_notes() has already been 
called from builtin/log.c), and at worst confusing, since it would _mask_ a 
missing init_display_notes(options) call from elsewhere.

I'd rather suggest that format_display_notes() should fail because of a 
missing init_display_notes(), and not silently compensate for missing 
initialization by self-initializing with default options (thus disregarding 
any notes-related options the user might have passed on the command-line).

> diff --git a/notes.h b/notes.h
> index bad03cc..db47b67 100644
> --- a/notes.h
> +++ b/notes.h
> +/*
> + * Append notes for the given 'object_sha1' from all trees set up by
> + * init_display_notes() to 'sb'.  The 'flags' are a bitwise
> + * combination of
> + *
> + * - NOTES_SHOW_HEADER: add a 'Notes (refname):' header
> + *
> + * - NOTES_INDENT: indent the notes by 4 places
> + *
> + * init_display_notes() is called implicitly for you if you haven't
> + * already.

As I said above, the implicit initialization turns a missing 
init_display_notes(with_approriate_options) call into a 
init_display_notes(NULL) call. This makes it harder to pinpoint future bugs 
in this area (which are likely to crop up as we add notes functionality to 
more Git commands).

But I don't think this is important enough to hold up the patch series.

> + */
> +void format_display_notes(const unsigned char *object_sha1,
> +			  struct strbuf *sb, const char *output_encoding, int flags);
> +
> +/*
> + * Load the notes tree from each ref listed in 'refs'.  The output is
> + * an array of notes_tree*, terminated by a NULL.
> + */
> +struct notes_tree **load_notes_trees(struct string_list *refs);

Although this looks like a useful utility function, I'm not sure how useful 
it is in practice: What would you really _do_ with the returned struct 
notes_tree **? You can't pass it to format_display_notes() (which only uses 
the internal display_notes_trees)...

> +/*
> + * Add all refs that match 'glob' to the 'list'.
> + */
> +void string_list_add_refs_by_glob(struct string_list *list, const char
> *glob); +
> +/*
> + * Add all refs from a colon-separated glob list 'globs' to the end of
> + * 'list'.  Empty components are ignored.  This helper is used to
> + * parse GIT_NOTES_DISPLAY_REF style environment variables.
> + */
> +void string_list_add_refs_from_colon_sep(struct string_list *list,
> +					 const char *globs);

The same goes for these. Do they have actual outside callers? AFAICS we only 
ever use the internal display_notes_refs and display_notes_trees lists in 
notes.c, so there's limited potential for external use.


Otherwise, it all looks good to me. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
