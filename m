From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged'
 options
Date: Thu, 17 Sep 2015 22:36:19 +0100
Message-ID: <20150917213619.GI17201@serenity.lan>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:41:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcgvz-0002OL-K8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 23:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbbIQVlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 17:41:37 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:48106 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbbIQVlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 17:41:35 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2015 17:41:35 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4D840217BE;
	Thu, 17 Sep 2015 22:36:31 +0100 (BST)
X-Quarantine-ID: <OdqMhKr5StJB>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OdqMhKr5StJB; Thu, 17 Sep 2015 22:36:30 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 2A12120165;
	Thu, 17 Sep 2015 22:36:21 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278170>

On Thu, Sep 10, 2015 at 09:52:49PM +0530, Karthik Nayak wrote:
> Use 'ref-filter' APIs to implement the '--merged' and '--no-merged'
> options into 'tag.c'. The '--merged' option lets the user to only list
> tags merged into the named commit. The '--no-merged' option lets the
> user to only list tags not merged into the named commit.  If no object
> is provided it assumes HEAD as the object.
> 
> Add documentation and tests for the same.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-tag.txt |  7 ++++++-
>  builtin/tag.c             |  6 +++++-
>  t/t7004-tag.sh            | 27 +++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 0c7f4e6..3803bf7 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>  	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
> -	[--format=<format>] [<pattern>...]
> +	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
>  'git tag' -v <tagname>...
>  
>  DESCRIPTION
> @@ -165,6 +165,11 @@ This option is only applicable when listing tags without annotation lines.
>  	that of linkgit:git-for-each-ref[1].  When unspecified,
>  	defaults to `%(refname:short)`.
>  
> +--[no-]merged [<commit>]::

We prefer to write --[no-]* as:

	--option::
	--no-option::

although this may be the first instance that we see this combination
with an argument.

I also found the "[<commit>]" syntax confusing and had to go and figure
out what PARSE_OPT_LASTARG_DEFAULT does; I wonder if it's worth
appending something like the following to the help for this option:

	The `commit` may be omitted if this is the final argument.

> +	Only list tags whose tips are reachable, or not reachable
> +	if '--no-merged' is used, from the specified commit ('HEAD'
> +	if not specified).
> +
>  CONFIGURATION
>  -------------
>  By default, 'git tag' in sign-with-default mode (-s) will use your
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 075d90b..081fe84 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
>  	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
>  	N_("git tag -d <tagname>..."),
>  	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
> -		"\n\t\t[--format=<format>] [<pattern>...]"),
> +		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
>  	N_("git tag -v <tagname>..."),
>  	NULL
>  };
> @@ -359,6 +359,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
>  		OPT_CONTAINS(&filter.with_commit, N_("print only tags that contain the commit")),
>  		OPT_WITH(&filter.with_commit, N_("print only tags that contain the commit")),
> +		OPT_MERGED(&filter, N_("print only tags that are merged")),
> +		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
>  		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>  			     N_("field name to sort on"), &parse_opt_ref_sorting),
>  		{
> @@ -417,6 +419,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		die(_("--contains option is only allowed with -l."));
>  	if (filter.points_at.nr)
>  		die(_("--points-at option is only allowed with -l."));
> +	if (filter.merge_commit)
> +		die(_("--merged and --no-merged option are only allowed with -l"));
>  	if (cmdmode == 'd')
>  		return for_each_tag_name(argv, delete_tag);
>  	if (cmdmode == 'v')
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 8987fb1..3dd2f51 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1531,4 +1531,31 @@ test_expect_success '--format should list tags as per format given' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setup --merged test tags' '
> +	git tag mergetest-1 HEAD~2 &&
> +	git tag mergetest-2 HEAD~1 &&
> +	git tag mergetest-3 HEAD
> +'
> +
> +test_expect_success '--merged cannot be used in non-list mode' '
> +	test_must_fail git tag --merged=mergetest-2 foo
> +'
> +
> +test_expect_success '--merged shows merged tags' '
> +	cat >expect <<-\EOF &&
> +	mergetest-1
> +	mergetest-2
> +	EOF
> +	git tag -l --merged=mergetest-2 mergetest-* >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--no-merged show unmerged tags' '
> +	cat >expect <<-\EOF &&
> +	mergetest-3
> +	EOF
> +	git tag -l --no-merged=mergetest-2 mergetest-* >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
