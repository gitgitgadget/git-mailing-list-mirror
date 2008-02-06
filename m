From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Wed, 06 Feb 2008 12:30:57 -0800
Message-ID: <7vy79xvncu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802061141410.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:32:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqwH-0003by-W1
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbYBFUbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756128AbYBFUbK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:31:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbYBFUbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:31:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 145FA2E54;
	Wed,  6 Feb 2008 15:31:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2165C2E53;
	Wed,  6 Feb 2008 15:31:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72847>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 651efe6..7ec01a0 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>                     [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>                     [--ignore-if-in-upstream]
>                     [--subject-prefix=Subject-Prefix]
> +                   [--cover-letter]
>  		   [ <since> | <revision range> ]
>  
>  DESCRIPTION
> @@ -139,6 +140,11 @@ include::diff-options.txt[]
>  	Instead of using `.patch` as the suffix for generated
>  	filenames, use specified suffix.  A common alternative is
>  	`--suffix=.txt`.
> +
> +--cover-letter::
> +	Generate a cover letter template.  You still have to fill in
> +	a description, but the shortlog and the diffstat will be
> +	generated for you.
>  +
>  Note that you would need to include the leading dot `.` if you
>  want a filename like `0001-description-of-my-change.patch`, and

Huh?  Leading dot?  The insertion is one paragraph too low or high.

> diff --git a/builtin-log.c b/builtin-log.c
> index 1f74d66..c6e3f91 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -453,74 +454,77 @@ static int git_format_config(...
> ...
>  static FILE *realstdout = NULL;
>  static const char *output_directory = NULL;
>  
> +static int reopen_stdout(const char *oneline, int nr, int total)
>  {
>  	char filename[PATH_MAX];
>  	int len = 0;
>  	int suffix_len = strlen(fmt_patch_suffix) + 1;
>  
>  	if (output_directory) {
> +		len = snprintf(filename, sizeof(filename), "%s",
> +				output_directory);
> +		if (len >=
>  		    sizeof(filename) - FORMAT_PATCH_NAME_MAX - suffix_len)
>  			return error("name of output directory is too long");
>  		if (filename[len - 1] != '/')
>  			filename[len++] = '/';
>  	}
>  
> +	if (!filename)
> +		len += sprintf(filename + len, "%d", nr);

How can this trigger?  Do you mean "oneline"?

I can understand that you do not want to pass numbered_files
variable separately to the function, but then there should be a
comment at the beginning of this function that says "oneline is
NULL under numbered_files mode, the caller is responsible for
ensuring that".

> +	else {
> +		len += sprintf(filename + len, "%04d-", nr);
> +		len += snprintf(filename + len, sizeof(filename) - len - 1
> +				- suffix_len, "%s", oneline);
>  		strcpy(filename + len, fmt_patch_suffix);
>  	}
>  
> @@ -591,6 +595,74 @@ static void gen_message_id(struct rev_info *info, char *base)
> +	/*
> +	 * We can only do diffstat with a unique reference point, and
> +	 * log is a bit tricky, so just skip it.
> +	 */
> +	if (!origin)
> +		return;

Maybe we would want to leave a note in the output to tell your
users that we punted here.

> +	argv[0] = "shortlog";
> +	argv[1] = head_sha1;
> +	argv[2] = "--not";
> +	argv[3] = origin_sha1;
> +	argv[4] = NULL;
> +	fflush(stdout);
> +	run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	argv[0] = "diff";
> +	argv[1] = "--stat";
> +	argv[2] = "--summary";
> +	argv[3] = head_sha1;
> +	argv[4] = "--not";
> +	argv[5] = origin_sha1;
> +	argv[6] = NULL;
> +	fflush(stdout);
> +	run_command_v_opt(argv, RUN_GIT_CMD);

Makes me wonder if we already have enough infrastructure to do
this without spawning two new processes.  Not complaining, but
just wondering.

> @@ -776,6 +852,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		 * get_revision() to do the usual traversal.
>  		 */
>  	}
> +	if (cover_letter) {
> +		/* remember the range */
> +		int i;
> +		for (i = 0; i < rev.pending.nr; i++) {
> +			struct object *o = rev.pending.objects[i].item;
> +			if (o->flags & UNINTERESTING)
> +				origin = (struct commit *)o;
> +			else
> +				head = (struct commit *)o;
> +		}

What if you have more than one origin or head?  Perhaps the
punting logic should be modified to make sure we only have one
negative and one positive and nothing else?

> +		/* We can't generate a cover letter without any patches */
> +		if (!head)
> +			return 0;
> +	}

That's true, but with or without cover letter we won't have
anything to format if we do not have any positive commit.

> @@ -802,9 +892,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		numbered = 1;
>  	if (numbered)
>  		rev.total = total + start_number - 1;
> -	rev.add_signoff = add_signoff;
>  	if (in_reply_to)
>  		rev.ref_message_id = clean_message_id(in_reply_to);
> +	if (cover_letter) {
> +		if (thread) {
> +			gen_message_id(&rev, "cover");
> +		}
> +		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
> +				  origin, head);
> +		total++;
> +		start_number--;
> +	}
> +	rev.add_signoff = add_signoff;

Nice attention to the detail, moving add_signoff after the cover
letter.
