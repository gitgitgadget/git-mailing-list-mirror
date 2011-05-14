From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add log.abbrev-commit config option
Date: Sat, 14 May 2011 14:01:22 -0500
Message-ID: <20110514190122.GA16851@elie>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLK5o-0006eF-NH
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 21:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab1ENTBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 15:01:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab1ENTB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 15:01:29 -0400
Received: by iwn34 with SMTP id 34so3011860iwn.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=30IdnnMBp6DlRRRJeJEy/SSL8RA0MSGMDfkloTdUHt4=;
        b=LnzxZmNiiyXZdlGpyr7bkObbKfhKs50ZQaSjO0cZj5py6n0Sb2E/LX7JlekgOf3Wm3
         zMxrrLlYJdsgswN7ZsTzBPdNyNxLPGjN4OJucChpgCCu/IwFgbyjE1uHTqWE+KJ/m10z
         4RE9jeevZBqz6b06/7Gq7+5yH55n3g0ub2FrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wwo7KhwPtFWLZnXcBCI4EwKpcSb9ewc06I4LF0vm35w6Q5femaT3kPYIUVdRHwsPdm
         42xRZcskfv5dAVuVkWSeRof1hfE30Jx/+i+M6KEk2s1fdykNN1krwN8iBblJNvgTHOZ2
         qQt/URFlEEltsuYYBoKMHUyrlChs+5+5S/46Q=
Received: by 10.231.208.142 with SMTP id gc14mr2063182ibb.115.1305399688924;
        Sat, 14 May 2011 12:01:28 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id c6sm226366ibj.4.2011.05.14.12.01.26
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 12:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173600>

Hi,

I like the idea.

Jay Soffian wrote:

> Add log.abbrev-commit (and log.abbrevCommit synonym)

Why two options?  It would be more conventional to provide just
log.abbrevCommit.  The existing "[add] ignore-errors" is explained in
the manual to be a mistake and "[add] ignoreerrors" is the fixed
version; adding more configuration variables with dashes in the name
would seem to make guessing variable names even more hit-or-miss.

> config option as
> a convenience for users who often use --abbrev-commit with git log and
> git show (but not git whatchanged, as its output is more likely to be
> parsed even though it is not technically plumbing).

Hm, that wouldn't have been my hunch.  Are you aware of any scripts
that parse "git whatchanged" output?

More worrying is "git log --format=raw".  I think as long as we're
cautious about rolling this out slowly and noticing breakage early it
should be okay.  It might even be nice to find out if there are
scripts or tests that care deeply about "git log"'s output format
(which would be more reliable if they had been written to use
"git rev-list | git diff-tree -s --stdin").

> Allow the option to be overridden via --no-abbrev-commit.

Good idea anyway.  Once parse_revision_opt learns to use parse_options
these negated options would be automatic (though that's a long way
away).

Unfortunately this wouldn't help scripts much until the option has
been around for a while.  Maybe it would be safer to have two patches
--- one to add --no-abbrev-commit which could be included in "maint"
and widely deployed, and one to add the new configuration only after
--no-abbrev-commit can be relied on?  But on the other hand, scripts
can be updated today to use rev-list | diff-tree, so maybe that's not
worth the trouble.

People using git by hand would certainly appreciate
--no-abbrev-commit, I suspect.  Thanks for thinking about these
things.

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1314,6 +1314,12 @@ interactive.singlekey::
>  	linkgit:git-checkout[1]. Note that this setting is silently
>  	ignored if portable keystroke input is not available.
>  
> +log.abbrev-commit::
> +log.abbrevCommit::
> +	If true, act as if --abbrev-commit were specified on the command
> +	line. May be overridden with --no-abbrev-commit. Note that this setting
> +	is ignored by rev-list.

Style: most of that page is written from the point of view of the
user, like:

	Tells 'git apply' how to handle whitespace.  Set this to
	"ignore" if you don't want to be bothered.  See
	linkgit:git-apply[1] for details.

So maybe something like:

	Whether to abbreviate hexadecimal commit object names in
	output from the 'log' family of commands.  The number of
	digits shown is determined by the `--abbrev` command-line
	option and `core.abbrev` configuration variable.  Can be
	overridden on the command line by --abbrev-commit /
	--no-abbrev-commit.  The default is false.
 +
 This does not affect the 'git diff-tree' and 'git rev-list'
 commands.

> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -38,6 +38,9 @@ OPTIONS
>  	Continue listing the history of a file beyond renames
>  	(works only for a single file).
>  
> +--no-abbrev-commit::
> +	Don't abbreviate commit name. Useful for overridding log.abbrevCommit.

Also useful for overriding --abbrev-commit from aliases. :)

Shouldn't it be documented next to --abbrev-commit?

> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -23,6 +23,7 @@
>  /* Set a default date-time format for git log ("log.date" config variable) */
>  static const char *default_date_mode = NULL;
>  
> +static int default_abbrev_commit = 0;
>  static int default_show_root = 1;
>  static int decoration_style;

Style: we try to avoid unnecessary zero initializers for variables in
the BSS section.

[...]
> @@ -89,11 +91,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  			 struct rev_info *rev, struct setup_revision_opt *opt)
>  {
>  	struct userformat_want w;
> -	int quiet = 0, source = 0;
> +	int quiet = 0, source = 0, no_abbrev_commit = 0;
>  
>  	const struct option builtin_log_options[] = {
> -		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
> +		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
>  		OPT_BOOLEAN(0, "source", &source, "show source"),
> +		OPT_BOOLEAN(0, "no-abbrev-commit", &no_abbrev_commit,
> +			    "don't abbreviate commit name"),

What happens if I do

	git log --no-abbrev-commit --abbrev-commit

?  How about

	git log --no-abbrev-commit --no-no-abbrev-commit --abbrev-commit

? :)  The behavior should be nicer if this is implemented in revision.c.

[...]
> @@ -323,6 +330,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		return git_config_string(&fmt_pretty, var, value);
>  	if (!strcmp(var, "format.subjectprefix"))
>  		return git_config_string(&fmt_patch_subject_prefix, var, value);
> +	if (!strcasecmp(var, "log.abbrevcommit") ||
> +	    !strcasecmp(var, "log.abbrev-commit")) {

No need to use strcasecmp --- the vars passed to config functions
already have the section and variable names in lowercase.

> @@ -347,6 +359,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
>  	struct setup_revision_opt opt;
>  
>  	git_config(git_log_config, NULL);
> +	default_abbrev_commit = 0;

Puzzling as mentioned above.

> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -450,6 +450,14 @@ test_expect_success 'log.decorate configuration' '
>  
>  '
>  
> +test_expect_success 'log.abbrev-commit configuration' '
> +	test_might_fail git config --remove-section log &&
> +	git log --abbrev-commit >expect &&
> +	git config log.abbrev-commit true &&
> +	git log >actual &&
> +	test_cmp expect actual
> +'

To avoid polluting the configuration, it would be nicest to do:

	git config log.abbrev-commit true &&
	test_when_finished "git config --unset log.abbrev-commit" &&
	git log >actual &&

though it looks like some tests already protect themselves.

Just because I'm curious: what happens if you do

	git config log.abbrev-commit true

in test_create_repo in test-lib.sh?  (I.e., are there many tests that
would be confused by this?)  Tests tend to be more picky than user
scripts about the output of git but it might still be an ok way to
get a vague sense of the impact.

Hope that helps, and thanks for a pleasant read.

Regards,
Jonathan
