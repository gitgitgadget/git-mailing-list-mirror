From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv14 5/7] git submodule update: have a dedicated helper for
 cloning
Date: Fri, 19 Feb 2016 15:07:40 -0800
Message-ID: <20160219230740.GM28749@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
 <1455905833-7449-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:08:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWuA4-00062a-U4
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 00:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbcBSXIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 18:08:13 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33470 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162022AbcBSXH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 18:07:57 -0500
Received: by mail-pf0-f181.google.com with SMTP id q63so58495384pfb.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=18JIddeR5nEU08RW8EdygEadinuKm+k6Mrl2gRoJaDk=;
        b=uUYvDDvdX9NfFQaD2+I3umjLpyuKTu5UwBXp74jh0gRgPFUbADiVOKuMCzI2GmHz+p
         fei2VrD6z9FW3VwsO6Iyp1B+WItMLcInsB74HfAryqvkSi0QbUvL7JcuCzbbugB36s7C
         0XFXqU+6yEpcSFJpHMSzdq5JqHmM4ilftS3D311nNcjCeJCYDtQUNMQgIg1gwIQ4DeAl
         MZx7+lAohpDlohwO7XVjHwTgT2cYupK9n926rB+1LBSEjOg8a0g4Ep+LswkTXO1cWU0s
         qfVRYDGCMQPbYzWVKO05FUlM+hjlXuzkAKmuKWoBE+lyJzyej4KBXQkFF6aUoi3FdKLF
         dxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=18JIddeR5nEU08RW8EdygEadinuKm+k6Mrl2gRoJaDk=;
        b=axlmGL39iBFwgicbshIkVU7GkJpWK4o12IOFKGSuvt0QCCiQU6r8nZC3gbYw47/GfC
         3EP8YDMpnbKwA3KvXi4rnwdiHbUftSILIwsJDPXM0gbPDhCM0s7ppRZ0aKUMYoHnMRxC
         v8ee3NEpR8EaHG2Py+4v798DS5YB2K1huBwhuNGOmYIttJnNwXryNiY0TWw8TmiSMHrC
         OiEPAU/C5Y1y1+g9F1SWuPqCuOlOl6XUUv1KLg0ymoTLj4iR6LXeFFgyVnJqMDdmlY41
         3ux6qvMYE+mz67KmDNSvdpE3qHgyo+7HgKO83fy3BsblkemNO++w2VLwp8x41fJSYeBt
         Io0A==
X-Gm-Message-State: AG10YOTVtn1iF+mNIVYWoi2aWKGOezRbrgQk0UNlqSvCEHnjuGGx0kh0b1rIWIFbymuorQ==
X-Received: by 10.98.66.138 with SMTP id h10mr21736626pfd.89.1455923277297;
        Fri, 19 Feb 2016 15:07:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c115:884b:f4c6:61dc])
        by smtp.gmail.com with ESMTPSA id 79sm20027267pfq.65.2016.02.19.15.07.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Feb 2016 15:07:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455905833-7449-6-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286758>

Hi,

Stefan Beller wrote:

> This introduces a new helper function in git submodule--helper
> which takes care of cloning all submodules, which we want to
> parallelize eventually.

Patches 1-4 are still
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I still have trouble reading this patch (patch 5).  Some musing below
to figure out what could change to make it more readable (perhaps in a
patch on top).

[...]
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -255,6 +255,234 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct submodule_update_clone {
> +	/* states */
> +	int count;
> +	int print_unmatched;
> +	/* configuration */
> +	int quiet;
> +	const char *reference;
> +	const char *depth;
> +	const char *recursive_prefix;
> +	const char *prefix;
> +	struct module_list list;
> +	struct string_list projectlines;
> +	struct submodule_update_strategy update;
> +	struct pathspec pathspec;
> +};
> +#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP, SUBMODULE_UPDATE_STRATEGY_INIT}

I think these struct fields need some comments.  It's not clear what
most of them represent.

[...]
> +static int update_clone_inspect_next_task(struct child_process *cp,

What is being inspected here?  What does the return value represent?

Would a name like 'prepare_to_clone_next_submodule' make sense?  A
comment could say that 'ce' points to the candidate submodule to clone,
that the return value represents whether we want to clone it, and
that the first parameter is an output parameter representing a command
to run to carry out the clone.

[...]
> +	if (ce_stage(ce)) {
> +		if (pp->recursive_prefix)
> +			strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
> +				    pp->recursive_prefix, ce->name);
> +		else
> +			strbuf_addf(err, "Skipping unmerged submodule %s\n",
> +				    ce->name);

Nit: this would be easier to scan with braces.

[...]
> +	sub = submodule_from_path(null_sha1, ce->name);

It's common to call submodule_from_path with null_sha1 as a parameter
but I have trouble continuing to remember what that means.  Maybe
there should be a separate function that handles that?  As a
side-effect, the name and docstring of that function could explain
what it means, which I still am not sure about. :)


> +	if (pp->recursive_prefix)
> +		displaypath = relative_path(pp->recursive_prefix,
> +					    ce->name, &displaypath_sb);

Nit: could use braces.

> +	else
> +		displaypath = ce->name;
> +
> +	if (pp->update.type == SM_UPDATE_NONE ||
> +	    (pp->update.type == SM_UPDATE_UNSPECIFIED &&
> +	     sub->update_strategy.type == SM_UPDATE_NONE)) {

Nit: this might be more readable with the operators starting each
line:

	if (pp->update.type == SM_UPDATE_NONE
	    || (pp->update.type == SM_UPDATE_UNSPECIFIED
	        && sub->update_strategy.type == SM_UPDATE_NONE)) {

What does pp stand for?

Is the --update parameter ever set to 'none'?  What does it mean
when someone sets it to none?

> +		strbuf_addf(err, "Skipping submodule '%s'\n",
> +			    displaypath);

Does the caller expect a newline at the end of err?

In the refs code that uses an err strbuf, the convention is to
not end the message with a newline.  That way, a function like
die() can insert a newline and messages are guaranteed to be
newline-terminated even if someone is sloppy and does the wrong thing
when generating an error.

[...]
> +	if (needs_cloning) {

Could de-indent:

	if (!needs_cloning)
		goto cleanup;

> +		cp->git_cmd = 1;
> +		cp->no_stdin = 1;
> +		cp->stdout_to_stderr = 1;
> +		cp->err = -1;
> +		argv_array_push(&cp->args, "submodule--helper");
> +		argv_array_push(&cp->args, "clone");
> +		if (pp->quiet)
> +			argv_array_push(&cp->args, "--quiet");
> +
> +		if (pp->prefix)
> +			argv_array_pushl(&cp->args, "--prefix", pp->prefix, NULL);
> +

Odd whitespace.  I think it would be fine to remove the blank lines.

> +		argv_array_pushl(&cp->args, "--path", sub->path, NULL);
> +		argv_array_pushl(&cp->args, "--name", sub->name, NULL);
> +		argv_array_pushl(&cp->args, "--url", url, NULL);
> +		if (pp->reference)
> +			argv_array_push(&cp->args, pp->reference);
> +		if (pp->depth)
> +			argv_array_push(&cp->args, pp->depth);

What does 'cp' stand for mean?  Would a name like 'child' work?

[...]
> +static int update_clone_get_next_task(struct child_process *cp,
> +				      struct strbuf *err,
> +				      void *pp_cb,
> +				      void **pp_task_cb)
> +{
> +	struct submodule_update_clone *pp = pp_cb;
> +
> +	for (; pp->count < pp->list.nr; pp->count++) {
> +		const struct cache_entry *ce = pp->list.entries[pp->count];
> +		if (update_clone_inspect_next_task(cp, err, pp,
> +						   pp_task_cb, ce)) {
> +			pp->count++;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}

Ah, that clarifies things a bit.

The 'count' variable is more of a cursor than a count.  Would a name +
comment like

	/* index into 'list' representing the next submodule to consider cloning */
	int current;

work?

> +
> +static int update_clone_start_failure(struct child_process *cp,
> +				      struct strbuf *err,
> +				      void *pp_cb,
> +				      void *pp_task_cb)
> +{
> +	struct submodule_update_clone *pp = pp_cb;
> +
> +	strbuf_addf(err, "error when starting a child process");
> +	pp->print_unmatched = 1;

What does print_unmatched mean?

[...]
> +static int update_clone_task_finished(int result,
> +				      struct child_process *cp,
> +				      struct strbuf *err,
> +				      void *pp_cb,
> +				      void *pp_task_cb)
> +{
> +	struct submodule_update_clone *pp = pp_cb;
> +
> +	if (!result) {
> +		return 0;
> +	} else {

No need for an 'else' here --- the 'if' already returned.

> +		strbuf_addf(err, "error in one child process");
> +		pp->print_unmatched = 1;

What does print_unmatched mean?

[...]
> +static int update_clone(int argc, const char **argv, const char *prefix)
> +{
> +	const char *update = NULL;
> +	struct string_list_item *item;
> +	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
> +
> +	struct option module_list_options[] = {

The name looks stale.

> +		OPT_STRING(0, "prefix", &prefix,
> +			   N_("path"),
> +			   N_("path into the working tree")),
> +		OPT_STRING(0, "recursive_prefix", &pp.recursive_prefix,
> +			   N_("path"),
> +			   N_("path into the working tree, across nested "
> +			      "submodule boundaries")),

What do these options represent?  I'm used to the 'prefix' parameter to
a command coming from git machinery that remembers what the path to the
original cwd was relative to the worktree or repository root.  Here
there's an option to set it --- is that intentional?  Would setting the
environment variable GIT_PREFIX (that git already knows how to respect)
work in its place?

What is recursive_prefix relative to?

Nit: it would be more idiomatic to use a dash in place of an underscore
in the second one's name.  But this is an internal interface so it
doesn't matter much.

> +		OPT_STRING(0, "update", &update,
> +			   N_("string"),
> +			   N_("update command for submodules")),

This one is confusing to me because while the script supports --rebase /
--merge / --checkout this option seems to be more general.

If the help string said '(rebase, merge, or checkout)' then I wouldn't
mind.

> +		OPT_STRING(0, "reference", &pp.reference, "<repository>",
> +			   N_("Use the local reference repository "
> +			      "instead of a full clone")),

Is this allowed to be relative?  If so, what is it relative to?

[...]
> +		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),

Typo.

[...]
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),

Is this the 'list' subcommand?

[...]
> +	gitmodules_config();
> +	/* Overlay the parsed .gitmodules file with .git/config */
> +	git_config(submodule_config, NULL);
> +	run_processes_parallel(1, update_clone_get_next_task,
> +				  update_clone_start_failure,
> +				  update_clone_task_finished,
> +				  &pp);

Neat. \o/

> +	if (pp.print_unmatched) {
> +		printf("#unmatched\n");

I'm still confused about this.  I think a comment where
'print_unmatched' is declared would probably clear it up.

[...]
> +	for_each_string_list_item(item, &pp.projectlines)
> +		utf8_fprintf(stdout, "%s", item->string);

(just curious) why are these saved up and printed all at once instead
of being printed as it goes?

[...]
> --- a/git-submodule.sh
> +++ b/git-submodule.sh

Very nice.

Thanks,
Jonathan
