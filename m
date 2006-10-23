From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Mon, 23 Oct 2006 15:34:00 -0700
Message-ID: <7vk62qwtk7.fsf@assigned-by-dhcp.cox.net>
References: <11616396262982-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com
X-From: git-owner@vger.kernel.org Tue Oct 24 00:34:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8Mx-0002Hl-QN
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWJWWeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWJWWeE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:34:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18652 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1752009AbWJWWeB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 18:34:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061023223401.PGRA18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Oct 2006 18:34:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dyZk1V00Y1kojtg0000000
	Mon, 23 Oct 2006 18:33:45 -0400
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <11616396262982-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Mon, 23 Oct 2006 23:40:26 +0200, Mon, 23 Oct 2006 23:27:45
	+0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29893>

Lars Hjemli <hjemli@gmail.com> writes:

> This replaces git-branch.sh with builtin-branch.c

> +static const char builtin_branch_usage[] =
> +"git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r";

Probably needs a matching change to your recent clean-up here.

> +static int append_ref(const char *refname, const unsigned char *sha1, int flags, 
> +		void *cb_data)
> +{
> +	if (ref_index >= ref_alloc) {
> +		ref_alloc = ref_alloc > 0 ? ref_alloc * 2 : 16;
> +		ref_list = xrealloc(ref_list, ref_alloc * sizeof(char *));
> +	}

It would be more consistent to use alloc_nr() from cache.h here
unless you have a specific need for allocation growing pattern,
which you don't.  Other parts of the system even just grows by
one and let xrealloc() (and in turn underlying realloc()) take
care of the optimization of repeated reallocations, which may
also be fine.

> +static void create_branch(const char *name, const char *start,
> +			  int force, int reflog)
> +{
> +	struct ref_lock *lock;
> +	unsigned char sha1[20];
> +	char ref[PATH_MAX], msg[PATH_MAX + 20];
> +
> +	snprintf(ref, sizeof ref, "refs/heads/%s", name);
> +	if (check_ref_format(ref))
> +		die("'%s' is not a valid branch name.", name);
> +
> +	if (resolve_ref(ref, sha1, 1, NULL)) {
> +		if (!force)
> +			die("A branch named '%s' already exists.", name);
> +		else if (!strcmp(head, name))
> +			die("Cannot force update the current branch.");
> +	}
> +
> +	if (get_sha1(start, sha1))
> +		die("Not a valid branch point: '%s'.", start);
> +
> +	lock = lock_any_ref_for_update(ref, NULL);
> +	if (!lock)
> +		die("Failed to lock ref for update: %s.", strerror(errno));

This is not enough.  "$2^0" in git-branch.sh makes sure the
"start" specified dereferences to a commit object, and object
name we use to initialize the new branch is of the commit object
(IOW, test your code with "git branch new v1.0.0" and make sure
"git rev-parse new" returns the commit object not the tag that
points at it).

> +		
> +	if (reflog){

Style; (1) remove trailing TAB on the empty line; (2) one SP
between ')' and '{' please.

> diff --git a/builtin.h b/builtin.h
> index 9683a7c..144d299 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -15,6 +15,7 @@ extern int write_tree(unsigned char *sha
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
>  extern int cmd_annotate(int argc, const char **argv, const char *prefix);
>  extern int cmd_apply(int argc, const char **argv, const char *prefix);
> +extern int cmd_branch(int argc, const char **argv, const char *prefix);
>  extern int cmd_archive(int argc, const char **argv, const char *prefix);
>  extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
>  extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);

Style; order them alphabetically please...

> diff --git a/git.c b/git.c
> index 308252a..671b212 100644
> --- a/git.c
> +++ b/git.c
> @@ -222,6 +222,7 @@ static void handle_internal_command(int 
>  		{ "annotate", cmd_annotate, },
>  		{ "apply", cmd_apply },
>  		{ "archive", cmd_archive },
> +		{ "branch", cmd_branch },
>  		{ "cat-file", cmd_cat_file, RUN_SETUP },
>  		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
>  		{ "check-ref-format", cmd_check_ref_format },

In other words, match this.

We may someday want to do binary search into the command list,
and before that happens we should make sure this list is really
ordered.
