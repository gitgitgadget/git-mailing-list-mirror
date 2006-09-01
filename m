From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support author and commiter based revision list limiting
Date: Thu, 31 Aug 2006 17:07:09 -0700
Message-ID: <7vhczs78lu.fsf@assigned-by-dhcp.cox.net>
References: <200608281459.26643.kai.blin@gmail.com>
	<20060828181626.GB2950@coredump.intra.peff.net>
	<Pine.LNX.4.64.0608281147420.27779@g5.osdl.org>
	<20060831225714.GD482@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 02:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIwXx-00054i-3r
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 02:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWIAAGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWIAAGF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 20:06:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55956 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932498AbWIAAGD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 20:06:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901000601.HYVV13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 Aug 2006 20:06:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Go621V00E1kojtg0000000
	Thu, 31 Aug 2006 20:06:02 -0400
To: Jonas Fonseca <fonseca@diku.dk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26291>

Jonas Fonseca <fonseca@diku.dk> writes:

> Adds the two options: --author=string and --committer=string, which can
> be used to limit the set of interesting commits to the ones matching the
> given idents.
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index d6c86db..4d5f5ab 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -12,6 +12,8 @@ SYNOPSIS
>  'git-rev-list' [ \--max-count=number ]
>  	     [ \--max-age=timestamp ]
>  	     [ \--min-age=timestamp ]
> +	     [ \--author=string ]
> +	     [ \--committer=string ]
>  	     [ \--sparse ]
>  	     [ \--no-merges ]
>  	     [ \--remove-empty ]

These two separate options are Ok at the level of front-end,
but...

> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index 402af8e..09e3d37 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> @@ -352,7 +352,8 @@ int cmd_rev_list(int argc, const char **
>  	    revs.diff)
>  		usage(rev_list_usage);
>  
> -	save_commit_buffer = revs.verbose_header;
> +	if (!revs.author_pattern && !revs.committer_pattern)
> +		save_commit_buffer = revs.verbose_header;
>  	track_object_refs = 0;
>  	if (bisect_list)
>  		revs.limited = 1;

I wonder if it is simpler and yet more powerful to internally
use a regex to match the contents of commit buffer, not just
specific its header fields.

When --author or --committer is given, you internally synthesize
a regex "^author Jonas Fonseca <fonseca@" from the string.

And then, instead of doing commit_match_ident() twice like this:

> @@ -1074,6 +1123,10 @@ struct commit *get_revision(struct rev_i
>  		if (revs->no_merges &&
>  		    commit->parents && commit->parents->next)
>  			continue;
> +		if (!commit_match_ident(commit, "author", revs->author_pattern))
> +			continue;
> +		if (!commit_match_ident(commit, "committer", revs->committer_pattern))
> +			continue;

you would just do:

	if (revs->commit_filter_pattern &&
            commit_search_message(commit, revs->commit_filter_pattern))
		continue;

instead.

For an extra bonus point, the matching logic might want to steal
from builtin-grep to allow multiple regular expressions, case
insensitive match and other bells and whistles.  You probably
could lift the whole grep_buffer() -- add another option that
behaves similarly to opt->name_only (name it opt->status_only)
but make it not even print anything upon hit, so that you can
tell from the return value if it found the pattern in the
buffer, like this:

diff --git a/builtin-grep.c b/builtin-grep.c
index 8213ce2..714ad50 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -128,6 +128,7 @@ struct grep_opt {
 	unsigned linenum:1;
 	unsigned invert:1;
 	unsigned name_only:1;
+	unsigned status_only:1;
 	unsigned unmatch_name_only:1;
 	unsigned count:1;
 	unsigned word_regexp:1;
@@ -492,6 +493,8 @@ static int grep_buffer(struct grep_opt *
 		}
 		if (hit) {
 			count++;
+			if (opt->status_only)
+				return 1;
 			if (binary_match_only) {
 				printf("Binary file %s matches\n", name);
 				return 1;



Hmm?
