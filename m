From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 17:00:15 -0600
Message-ID: <20110215230015.GA17812@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:00:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTsj-0002vW-2F
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab1BOXAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:00:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48989 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab1BOXAX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 18:00:23 -0500
Received: by qyj19 with SMTP id 19so2826800qyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6s6Ugp0UiR14TX4E5GFPsU/6mu5YGPJwuoKVlzbjLD0=;
        b=ldDhR7vZ01Jazzu6lvvoE3Dh6aRoGhbf+58XGh8vfp49AkL0csvhnuP+UD/YFS1Jrs
         yqtIHE+0J1BFS8rMlhevd2DPvvhNp6uTgNfQWw4iGxM9+zkDH07WIOaRKdW89PKCaW8N
         yTKsvSSeBHU9xjybdMIEwEt6HtXMv31Mv7eJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MCEhse5T5T3jhgIJA29U0PzR8vYgE0TNlWwH04hzBt3R+E/VO75qFz1DAzUdc/QHAa
         Kld9i6oaZgk+D8u+XJzt8HlFBmNC4vMWtumpAyxkWJlfBF53YCsrr7JMPZrMwJnvw3bg
         K8vRsvstY3X5davT1nZRzSan/MME73T3JOzR8=
Received: by 10.229.95.19 with SMTP id b19mr4505744qcn.179.1297810822851;
        Tue, 15 Feb 2011 15:00:22 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id q12sm3040816qcu.6.2011.02.15.15.00.20
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:00:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166893>

Hi,

Some quick thoughts.

Jay Soffian wrote:

> Now that cherry-pick records the original commit id in CHERRY_HEAD
> following a conflict, we can teach commit to handle it automatically.
> 
> The primary difference between this and 'commit -c CHERRY_HEAD'
> (besides saving the user some typing) is that we take only the
> authorship from CHERRY_HEAD, while taking the commit message
> from MERGE_MSG

This answers my question from before.

[...]
> For example, it should probably be an error to use --squash/--fixup when
> there's a CHERRY_HEAD, but then again, it should probably be an error to
> use those options when there's a MERGE_HEAD (but it's not).

I see what you're saying about MERGE_HEAD --- it is not clear what is
intended when a person asks "rebase --autosquash" to squash in a merge
commit.  With CHERRY_PICK_HEAD, it means "after dealing with the
conflict, I understand this commit better, and it ought to have been
squashed in with commit X", no?

There is some potential for confusion from another direction.  The
uncareful patch series maintainer can be tempted to try, after
conflict resolution,

 - "git commit --amend" to say "I'm done fixing the broken thing".

 - "git commit --fixup=HEAD/--squash=HEAD" to say "done fixing;
   let's look at this again later and squash it when I am less
   confused".

Both are mistakes if HEAD is the previous and good commit rather than
the broken one.  Maybe there is some simple safety that could protect
against them?

> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -84,9 +84,10 @@ OPTIONS
>  	linkgit:git-rebase[1] for details.
>
>  --reset-author::
> -	When used with -C/-c/--amend options, declare that the
> -	authorship of the resulting commit now belongs of the committer.
> -	This also renews the author timestamp.
> +	When used with -C/-c/--amend options, or when committing after a
> +	a conflicting cherry-pick,

or when committing after a conflicted merge, no?

>                                  declare that the authorship of the
> +	resulting commit now belongs of the committer. This also renews
> +	the author timestamp.

How does it interact with --author?

> +++ b/builtin/commit.c
[...]
> @@ -609,7 +609,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			die_errno("could not read log file '%s'",
>  				  logfile);
>  		hook_arg1 = "message";
> -	} else if (use_message) {
> +	} else if (use_message && !cherry_pick) {

Wouldn't this make

	git commit -C foo

after a failed cherry-pick use MERGE_MSG instead of the message the
user requested?

> @@ -704,6 +704,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				"#\n",
>  				git_path("MERGE_HEAD"));
>  
> +		if (cherry_pick)
> +			fprintf(fp,
> +				"#\n"
> +				"# It looks like you may be committing a cherry-pick.\n"

Aside: shouldn't we suggest some porcelain-ish command (git merge
--clear?  git commit --no-merge?) to remove .git/MERGE_HEAD instead of
asking the committer to do it?

This section is used to give a preview and sanity check for the
commit.

 - if we are on the wrong branch, that might be a mistake.
 - if the author is someone else, that might be a mistake.
 - if there are multiple parents, that might be a mistake.
 - if there are changes included, some might be mistakes.
 - if there are changes excluded, some might be mistakes,
 - if there are untracked files, some might be mistakes.

Where does committing a cherry-pick fall into that picture?  Maybe

	# Author:    A U Thor <author@example.com>
	# Date:      Tue Beb 9 01:23:45 1911 -0500
	#
	# If this is not correct, please try again using the
	# --author and --date or --reset-author options.

> @@ -898,6 +907,7 @@ static void handle_untracked_files_arg(struct wt_status *s)
>  		die("Invalid untracked files mode '%s'", untracked_files_arg);
>  }
>  
> +

Stray whitespace change?

> @@ -929,6 +939,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die("You have nothing to amend.");
>  	if (amend && in_merge)
>  		die("You are in the middle of a merge -- cannot amend.");
> +	if (amend && cherry_pick)
> +		die("You are in the middle of a cherry-pick -- cannot amend.");

Ah, this addresses the worry mentioned above.

How can I get out of this state if I really do want to amend?

> @@ -943,11 +955,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die("Only one of -c/-C/-F/--fixup can be used.");
>  	if (message.len && f > 0)
>  		die("Option -m cannot be combined with -c/-C/-F/--fixup.");
> +	if (cherry_pick) {
> +		/* Let message-specifying options override CHERRY_HEAD */
> +		if (f > 0 || message.len)
> +			cherry_pick = 0;
> +		else
> +			/* used for authorship side-effect only */
> +			use_message = "CHERRY_HEAD";
> +	}

Hmm, what if I have commits F and F' and after trying to cherry-pick F
I decide I want the message from F'?

> @@ -1118,6 +1138,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	gitmodules_config();
>  	git_config(git_status_config, &s);
>  	in_merge = file_exists(git_path("MERGE_HEAD"));
> +	cherry_pick = file_exists(git_path("CHERRY_HEAD"));

Is it possible to be both in_merge and cherry_pick?

> @@ -1369,7 +1391,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			parents = reduce_heads(parents);
>  	} else {
>  		if (!reflog_msg)
> -			reflog_msg = "commit";
> +			reflog_msg = cherry_pick ? "commit (cherry-pick)"
> +						 : "commit";

Nice.  Probably worth mentioning in the commit message.

> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -246,6 +246,8 @@ __git_ps1 ()
>  				fi
>  			elif [ -f "$g/MERGE_HEAD" ]; then
>  				r="|MERGING"
> +			elif [ -f "$g/CHERRY_HEAD" ]; then
> +				r="|CHERRY-PICKING"

Likewise.
