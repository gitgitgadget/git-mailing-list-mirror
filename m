From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] added --batch option to mktree
Date: Wed, 13 May 2009 23:18:15 -0700
Message-ID: <7vhbzoxl5k.fsf@alter.siamese.dyndns.org>
References: <loom.20090514T050424-673@post.gmane.org>
	<loom.20090514T051004-665@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Micich <josh.micich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UGu-0000sd-MB
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZENGSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZENGSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:18:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56565 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZENGSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:18:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514061816.LMDP20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 May 2009 02:18:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rJJG1b0024aMwMQ03JJGkn; Thu, 14 May 2009 02:18:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=ytj-zW1PikoA:10 a=bIIiVhviu7cA:10
 a=pGLkceISAAAA:8 a=6NAcMvj00m2CsWtbfC0A:9 a=_xVxUviKqxvHSs5asykA:7
 a=yxEmGYS6LIpiQE3_Ye2CTkVF5r0A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <loom.20090514T051004-665@post.gmane.org> (Josh Micich's message of "Thu\, 14 May 2009 05\:10\:38 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119146>

Josh Micich <josh.micich@gmail.com> writes:

> This option enables creation of many tree objects with a single process

... which is desirable in what way?  how does this justify the cost of
maintenance?  what is it used for?

>  DESCRIPTION
>  -----------
> @@ -25,6 +25,11 @@ OPTIONS
>  	Allow missing objects.  The default behaviour (without this option)
>  	is to verify that each tree entry's sha1 identifies an existing
>  	object.
> +--batch::
> +	Allow building of more than one tree object before exiting.  Each
> +	tree is separated by as single blank line. The final new-line is
> +	optional.  Note - if the '-z' option is used, lines are terminated
> +	with NUL.

I think you want an blank line before this.

>  Author
>  ------
> diff --git a/builtin-mktree.c b/builtin-mktree.c
> index db647ce..a56c917 100644
> --- a/builtin-mktree.c
> +++ b/builtin-mktree.c
> @@ -63,7 +63,7 @@ static void write_tree(unsigned char *sha1)
>  }
>  
>  static const char *mktree_usage[] = {
> -	"git mktree [-z] [--missing]",
> +	"git mktree [-z] [--missing] [--batch]",
>  	NULL
>  };
>  
> @@ -125,20 +125,42 @@ int cmd_mktree(int ac, const char **av, const char 
> *prefix)

Linewrapped and would not apply.

>  	unsigned char sha1[20];
>  	int line_termination = '\n';
>  	int allow_missing = 0;
> +	int is_batch_mode = 0;
> +
>  	const struct option option[] = {
>  		OPT_SET_INT('z', NULL, &line_termination, "input is NUL 
> terminated", '\0'),
>  		OPT_SET_INT( 0 , "missing", &allow_missing, "allow missing 
> objects", 1),
> +		OPT_SET_INT( 0 , "batch", &is_batch_mode, "interactively create 
> more than one tree", 1),

What do you mean by "interactively"?  Does anybody type from the standard
input?

>  	ac = parse_options(ac, av, option, mktree_usage, 0);
>  
> -	while (strbuf_getline(&sb, stdin, line_termination) != EOF)
> -		mktree_line(sb.buf, sb.len, line_termination, allow_missing);
> -
> +	int got_eof = 0;

Decl-after-statement. 

> +	while (!got_eof) {
> +		while (1) {
> +			if (strbuf_getline(&sb, stdin, line_termination) == 
> EOF) {
> +				got_eof = 1;
> +				break;
> +			}
> +			if (sb.buf[0] == '\0') {
> +				// empty lines denote tree boundaries in batch 
> mode

No C++ comment please;

> +				if (is_batch_mode) {
> +					break;
> +				}

Lose excess {} pair;

> +		if (is_batch_mode && got_eof && used < 1) {
> +			// allow input to finish with a new-line (or not)

Style: have an explicit ";" for an empty statement.

But more importantly, what does this comment mean?  Why do you want to be
loose in input format validation?

> +		} else {
> +			write_tree(sha1);
> +			puts(sha1_to_hex(sha1));
> +			fflush(stdout);
> +		}
> +		used=0; // reset tree entry buffer for re-use in batch mode

	used = 0; /* .... */
