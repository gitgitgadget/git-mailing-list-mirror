From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Teach commit about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 16:43:50 -0600
Message-ID: <20110216224349.GE2615@elie>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppq6V-0002UN-Hp
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab1BPWn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 17:43:59 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45991 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1BPWn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 17:43:58 -0500
Received: by qwa26 with SMTP id 26so1796022qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 14:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ilgzl9jGrPgDG8TRAlUgIZjmIMqHMMP3IWXluxjI70g=;
        b=HbQBABVfCdIMttEL/O2Xfli30pM7mhOUFoVLZ0VXtpl/f9a1VKL+GQSy8wtJXhoJc9
         +wfnhd2ef8M80nklmI1sAWKwSKave04jmIcRkNF0q7+9TLzzRNKQFzCELfJsegrg7NE2
         XuyylakLCqugUpkMPlbNgCwNFXpTIU5dPS8KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EIpktckM55iT4U/kr1NHtVIn3HyeQK9xZqzdp6uETcqIzWCeheO4p+1ar31R7B6ubn
         PD2G8M/XtZOu25u7ASQA0YcMNPLAxr9YpR92DSs8hvRnEJqxSffoHgD9vgr1qqKChKK0
         /iA00BGfx7lLlJQ+kFpsVqncfA2C2z9gIkfIE=
Received: by 10.224.47.80 with SMTP id m16mr1605397qaf.165.1297896237100;
        Wed, 16 Feb 2011 14:43:57 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id nb15sm190729qcb.38.2011.02.16.14.43.54
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 14:43:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297850903-65038-3-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167015>

Jay Soffian wrote:

> This change fixes that situation. A bare 'commit' will now take the
> authorship from CHERRY_PICK_HEAD and the commit message from MERGE_MSG.
> If the user wishes to reset authorship, that must now be done explicitly
> via --reset-author.

Might also be worth mentioning that it makes --amend fail in such a
situation (a change worth celebrating).

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -56,8 +56,10 @@ static const char empty_amend_advice[] =
>  
>  static unsigned char head_sha1[20];
>  
> -static char *use_message_buffer;
> +static const char *use_message_buffer;
>  static const char commit_editmsg[] = "COMMIT_EDITMSG";
> +static const char cherry_pick_head[] = "CHERRY_PICK_HEAD";
> +static const char merge_head[] = "MERGE_HEAD";

Hmm, these variables but not MERGE_MSG, MERGE_MODE, and SQUASH_MSG?

> @@ -68,6 +70,7 @@ static enum {
>  
>  static const char *logfile, *force_author;
>  static const char *template_file;
> +static const char *author_message, *author_message_buffer;

That's not a message at all, is it?  On first reading I thought it
would be a message about the author.  Maybe a comment can help.

	/* name and content of commit from which to copy authorship */

> @@ -88,7 +91,8 @@ static enum {
>  } cleanup_mode;
>  static char *cleanup_arg;
>  
> -static int use_editor = 1, initial_commit, in_merge, include_status = 1;
> +static enum commit_whence whence;
> +static int use_editor = 1, initial_commit, include_status = 1;

The name "whence" is not so self-explanatory but I don't have any
better ideas (I probably would have written "merge_or_cherry_pick"; we
can be glad you came up with something better).

> @@ -163,6 +167,36 @@ static struct option builtin_commit_options[] = {
>  	OPT_END()
>  };
>  
> +static void determine_whence(struct wt_status *s)
> +{
> +	if (file_exists(git_path(merge_head)))
> +		whence = FROM_MERGE;

Micronit: maybe COMMITTING_A_MERGE or COMMIT_DURING_MERGE to avoid
using valuable namespace?

> @@ -644,7 +678,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	 * This final case does not modify the template message,
>  	 * it just sets the argument to the prepare-commit-msg hook.
>  	 */
> -	else if (in_merge)
> +	else if (whence == FROM_MERGE)
>  		hook_arg1 = "merge";

Perhaps:

	else if (whence == CHERRY_PICK) {
		hook_arg1 = "commit";
		hook_arg2 = author_message;
	}

> @@ -694,16 +728,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
[...]
>  				"# If this is not correct, please remove the file\n"
>  				"#	%s\n"
>  				"# and try again.\n"
>  				"#\n",
> +				whence_s(),
> +				git_path(whence == FROM_MERGE
> +					 ? merge_head
> +					 : cherry_pick_head));

Ok.  We probably should move away from having to suggest
"rm -f .git/whatever" in the future (maybe

	git update-ref -d %s

is simpler advice?  I dunno).

> @@ -898,6 +934,27 @@ static void handle_untracked_files_arg(struct wt_status *s)
>  		die("Invalid untracked files mode '%s'", untracked_files_arg);
>  }
>  
> +static const char *read_commit_message(const char *name) {

Nice.  Opening '{' should be in the first column.

> +++ b/builtin/revert.c
[...]
> @@ -284,9 +233,7 @@ static void print_advice(void)
>  
>  	advise("after resolving the conflicts, mark the corrected paths");
>  	advise("with 'git add <paths>' or 'git rm <paths>'");
> -
> -	if (action == CHERRY_PICK)
> -		advise("and commit the result with 'git commit -c CHERRY_PICK_HEAD'");
> +	advise("and commit the result with 'git commit'");

Hoorah!

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -60,7 +60,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
>  	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
>  	if (!advice_status_hints)
>  		return;
> -	if (s->in_merge)
> +	if (s->whence != FROM_COMMIT)
>  		;
>  	else if (!s->is_initial)
>  		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);

Isn't the advice of using "git reset -- <paths>" still good in the
CHERRY_PICK case?

> @@ -77,7 +77,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
>  	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
>  	if (!advice_status_hints)
>  		return;
> -	if (s->in_merge)
> +	if (s->whence != FROM_COMMIT)
>  		; /* NEEDSWORK: use "git reset --unresolve"??? */

Likewise here.

> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -24,6 +24,12 @@ enum untracked_status_type {
>  	SHOW_ALL_UNTRACKED_FILES
>  };
>  
> +enum commit_whence {
> +  FROM_COMMIT,
> +  FROM_MERGE,
> +  FROM_CHERRY_PICK
> +};

Style: please use tabs to indent.

> @@ -40,7 +46,7 @@ struct wt_status {
>  	const char **pathspec;
>  	int verbose;
>  	int amend;
> -	int in_merge;
> +	enum commit_whence whence;

Might benefit from a comment.

	/* whether a merge or cherry-pick is in progress */
	enum commit_whence whence;

Thanks, very readable.
