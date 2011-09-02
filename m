From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand
 option
Date: Fri, 02 Sep 2011 11:21:48 -0700
Message-ID: <7vmxemls8z.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 20:21:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYNJ-0000Da-UO
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1IBSVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:21:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab1IBSVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 14:21:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED4553B7;
	Fri,  2 Sep 2011 14:21:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ewV0oAMI0WUJnGUEUfgHtlch1SU=; b=vNyJSe
	sJ3x90xrZaMAryfk3ODLyHyZljQNW+f/yvrk83eudLyHX75nypgbL2ktlSX7icQL
	VHbG+zb4yuUTgpE3NdqhzHMXi38P5O8xYSluRJZSCIOZdeIPGiUNJ+y4ibsCFPYm
	oyUiZNtePpmeylfGUvTmABtZuSjmNS1F0YN8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXZyCut5JQpq9PZ0vbhTvf6HpkINFgsE
	1b/BYfvVwE6lLHQP9i7iIl5V4aKzS4p2ksiVG61o3puAk7nKGs7pPxgjOb8O7lDB
	zePc7MNnW9fP3rhnZ/DjOulFchazYgaDG+RXhS973fQZmQLXZakAdLHC5Cg+1229
	0jU+ni1ZB/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1617453B6;
	Fri,  2 Sep 2011 14:21:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB93B53B5; Fri,  2 Sep 2011
 14:21:49 -0400 (EDT)
In-Reply-To: <1313791728-11328-3-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Sat, 20 Aug 2011 00:08:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CD65BC8-D590-11E0-9E93-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180628>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 45f508c..dc95498 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -8,7 +8,10 @@
>  #include "diffcore.h"
>  #include "refs.h"
>  #include "string-list.h"
> +#include "transport.h"
>  
> +typedef int (*needs_push_func_t)(const char *path, const unsigned char sha1[20],
> +		void *data);
>  static struct string_list config_name_for_path;
>  static struct string_list config_fetch_recurse_submodules_for_name;
>  static struct string_list config_ignore_for_name;
> @@ -308,21 +311,24 @@ void set_config_fetch_recurse_submodules(int value)
>  	config_fetch_recurse_submodules = value;
>  }
>  
> +typedef int (*module_func_t)(const char *path, const unsigned char sha1[20], void *data);
> +
>  static int has_remote(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
>  {
>  	return 1;
>  }
>  
> -static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
> +int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
>  {
> +	int *needs_pushing = data;
> +
>  	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> -		return 0;
> +		return 1;
>
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>  		struct child_process cp;
>  		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
>  		struct strbuf buf = STRBUF_INIT;
> -		int needs_pushing = 0;
>  
>  		argv[1] = sha1_to_hex(sha1);
>  		memset(&cp, 0, sizeof(cp));
> @@ -336,41 +342,74 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
>  			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
>  				sha1_to_hex(sha1), path);
>  		if (strbuf_read(&buf, cp.out, 41))
> -			needs_pushing = 1;
> +			*needs_pushing = 1;
>  		finish_command(&cp);
>  		close(cp.out);
>  		strbuf_release(&buf);
> -		return needs_pushing;
> +		return !*needs_pushing;
>  	}
> -	return 0;
> +	return 1;
> +}

It appears to me that this patch is flipping the meaning of the function,
and the returned value from here is no longer "do we know that this
submodule needs to be pushed (yes/no)?".  The function needs to be renamed
to describe what it does better.

Also you would need to give a comment before the function to describe the
semantics of these two return values (one from the function, the other
from the value placed via the callback data pointer).

The latter is especially important because the caller that gets 1 from
this function would not be able to tell if the value in the callback data
pointer is valid (only happens if "rev-list" said something) or undefined
(no assignment is ever done via *needs_pushing pointer to zero it when
"rev-list" is silent, or if no submodule is checked out at path).

> +int push_submodule(const char *path, const unsigned char sha1[20], void *data)
> +{
> +	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
> +		return 1;
> +
> +	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
> +		struct child_process cp;
> +		const char *argv[] = {"push", NULL};
> +
> +		memset(&cp, 0, sizeof(cp));
> +		cp.argv = argv;
> +		cp.env = local_repo_env;
> +		cp.git_cmd = 1;
> +		cp.no_stdin = 1;
> +		cp.out = -1;

Is this correct? Nobody seems to read from this pipe from the "git push"
output. Don't you either want to send it to the end user, or squelch it by
sending it to /dev/null? You could of course read its output between the
following run_command() and close() and do something intelligent depending
on what the command tells you, if you wanted to, but I somehow doubt that
is what you had in mind here...

> +		cp.dir = path;
> +		if (run_command(&cp))
> +			die("Could not run 'git push' command in submodule %s", path);
> +		close(cp.out);
> +	}
> +
> +	return 1;
>  }

Do you really want to "die" here? You would definitely do if the failure
was due to corruption of your submodule repository, but wouldn't you want
to continue pushing other submodules if you couldn't push this submodule
due to non-fast-forward (i.e. somebody else pushed there first), for
example?

> +struct collect_submodules_data {
> +	module_func_t func;
> +	void *data;
> +	int ret;
> +};

What are the meaning of these fields? Document them.

Do you really need a double indirection like this, I wonder...

>  static void collect_submodules_from_diff(struct diff_queue_struct *q,
>  					 struct diff_options *options,
>  					 void *data)
>  {
>  	int i;
> -	int *needs_pushing = data;
> +	struct collect_submodules_data *me = data;
>  
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		if (!S_ISGITLINK(p->two->mode))
>  			continue;
> -		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
> -			*needs_pushing = 1;
> +		if (!(me->ret = me->func(p->two->path, p->two->sha1, me->data)))
>  			break;
> -		}
>  	}
>  }
>  
> -
> -static void commit_need_pushing(struct commit *commit, struct commit_list *parent, int *needs_pushing)
> +static int commit_need_pushing(struct commit *commit, struct commit_list *parent,
> +	module_func_t func, void *data)
>  {
>  	const unsigned char (*parents)[20];
>  	unsigned int i, n;
>  	struct rev_info rev;
>  
> +	struct collect_submodules_data cb;
> +	cb.func = func;

Just a style thing, but because we do not allow decl-after-statement, it
is customary to have the blank line _after_ the last decl, not in between
the declarations.

> +	cb.data = data;
> +	cb.ret = 1;
> +
>  	n = commit_list_count(parent);
>  	parents = xmalloc(n * sizeof(*parents));
>  
> @@ -382,21 +421,23 @@ static void commit_need_pushing(struct commit *commit, struct commit_list *paren
>  	init_revisions(&rev, NULL);
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = collect_submodules_from_diff;
> -	rev.diffopt.format_callback_data = needs_pushing;
> +	rev.diffopt.format_callback_data = &cb;
>  	diff_tree_combined(commit->object.sha1, parents, n, 1, &rev);
>  
>  	free(parents);
> +	return cb.ret;
>  }
>  
> -int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
> +static int inspect_superproject_commits(unsigned char new_sha1[20], const char *remotes_name,
> +	module_func_t func, void *data)

Contrast your new name with "check-submodule-needs-pushing".  "inspect"
(or "check" for that matter) is a poor word to use in function names, as
the word by itself does not convey what aspect of the object of the verb
is being inspected or checked. The old name was fine because other words
in the name described what it was checking. The new name does not tell us
anything useful. First try to explain to yourself at high level what the
function does in a few lines, and then a more appropriate name would come
to you.

>  {
>  	struct rev_info rev;
>  	struct commit *commit;
>  	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};

What is this string "NULL" doing here???

>  	int argc = ARRAY_SIZE(argv) - 1;
>  	char *sha1_copy;
> -	int needs_pushing = 0;
>  	struct strbuf remotes_arg = STRBUF_INIT;
> +	int do_continue = 1;
>  
>  	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
>  	init_revisions(&rev, NULL);
> @@ -407,13 +448,25 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
>  	if (prepare_revision_walk(&rev))
>  		die("revision walk setup failed");
>  
> -	while ((commit = get_revision(&rev)) && !needs_pushing)
> -		commit_need_pushing(commit, commit->parents, &needs_pushing);
> +	while ((commit = get_revision(&rev)) && do_continue)
> +		do_continue = commit_need_pushing(commit, commit->parents, func, data);

A funny way to write

	white ((commit = get_revision(&rev)) != NULL) {
               if (!commit_need_pushing(commit, commit->parents, func, data))
			break;
	}

or even:

	white ((commit = get_revision(&rev)) != NULL &&
        	commit_need_pushing(commit, commit->parents, func, data))
		 ; /* nothing */

No caller of this function uses its return value (one caller uses its
return value left in "data" pointer), so I do not think you would need the
"do_continue" variable, which is misnamed (the name makes sense only as
the loop control inside this function, but does not make any sense as the
return value from this function---it does not tell the caller to continue).

As there is only this calling site of commit_need_pushing(), I wonder why
the function needs to be able to take commit and commit->parents as
separate parameters. Does it even make sense in other contexts to compare
a commit with list of commits that are not its parents and decide if the
commit needs pushing based on that comparison?

>  
>  	free(sha1_copy);
>  	strbuf_release(&remotes_arg);
>  
> -	return needs_pushing;
> +	return do_continue;
> +}
> +
> +int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
> +{
> +	int needs_push = 0;
> +	inspect_superproject_commits(new_sha1, remotes_name, submodule_needs_pushing, &needs_push);
> +	return needs_push;
> +}
> +
> +void push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
> +{
> +	inspect_superproject_commits(new_sha1, remotes_name, push_submodule, NULL);
>  }

Again the called function is misnamed as the primary purpose it is used is not
to inspect, but to cause effects. But more importantly...

What does this do, given the loop structure of inspect_superproject_commits()? 
If your superproject is three commits ahead of the remote, the get_revision()
loop may run three times, calling commit_need_pushing() and have it inspect
these superproject commits, and may find that you bound different commits
from the same submodule multiple times during these three superproject commits.
Don't you end up running "git push" multiple times?

I have to say the overall code struction of this patch is simply broken.

How about doing it this way instead?

 - Update check-submodule-needs-pushing that used to stop at the first
   submodule that are not up-to-date not to do that. Instead, loop over
   all the submodules, find and collect which ones needs pushing, and
   return it as a list of submodules. Make sure you have the same
   submodule appear at most once in the result.  You may want to rename it
   to reflect the new role of the function (i.e. collecting submodules
   that needs to be pushed). Perhaps collect_stale_submodules() or
   something.

   For this, I do not think you need to touch the implementation of the
   submodule_needs_pushing() function at all. You do not need to introduce
   the indirection such as module_func_t and collect_submodules_data
   either. The only change needed is to collect_submodules_from_diff()
   that would treat the callback data not as a pointer to int
   (needs-pushing), but as a pointer to the structure to collect the names
   of submodules that need to be pushed (e.g. "struct string_list"), and
   make it not break the loop upon the first submodule that is stale.

 - Instead of adding a call to push-unpushed-submodules before
   check-submodule-needs-pushing in transport_push(), first call
   check-submodule-needs-pushing when on-demand or check is in effect.

   When in check mode, if check-submodule-needs-pushing returned a
   non-empty list, report which ones are stale and die.

   If in on-demand mode, you have a list of submodules you need to run
   "git push" in. Iterate over that list and do your push_submodule().
   You may want to reconsider your "die()" there, though.

Hmm?
