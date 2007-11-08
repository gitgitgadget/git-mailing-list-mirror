From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH DIFF-CLEANUP 1/2] Make the diff_options bitfields be an unsigned with explicit masks.
Date: Wed, 07 Nov 2007 22:39:02 -0800
Message-ID: <7vy7d95ji1.fsf@gitster.siamese.dyndns.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
	<1194430832-6224-2-git-send-email-madcoder@debian.org>
	<1194430832-6224-3-git-send-email-madcoder@debian.org>
	<1194430832-6224-4-git-send-email-madcoder@debian.org>
	<1194430832-6224-5-git-send-email-madcoder@debian.org>
	<1194430832-6224-6-git-send-email-madcoder@debian.org>
	<1194430832-6224-7-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 07:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq132-0004qR-9k
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 07:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbXKHGjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 01:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXKHGjJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 01:39:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39388 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXKHGjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 01:39:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DE8D72EF;
	Thu,  8 Nov 2007 01:39:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A0FF8E6D5;
	Thu,  8 Nov 2007 01:39:26 -0500 (EST)
In-Reply-To: <1194430832-6224-7-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 7 Nov 2007 11:20:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63937>

Pierre Habouzit <madcoder@debian.org> writes:

> reverse_diff was a bit-value in disguise, it's merged in the flags now.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

Just my first impression, as I am in the middle of unrelated
bisect.  I haven't read beyond diff-lib.c changes.

> diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
> index 0b591c8..e71841a 100644
> --- a/builtin-diff-tree.c
> +++ b/builtin-diff-tree.c
> @@ -118,12 +118,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (!read_stdin)
> -		return opt->diffopt.exit_with_status ?
> -		    opt->diffopt.has_changes: 0;
> +		return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
> +			&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);

Had to think a bit about this, although it is correct.

>  	if (opt->diffopt.detect_rename)
>  		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
> -				       DIFF_SETUP_USE_CACHE);
> +							   DIFF_SETUP_USE_CACHE);

I wonder what this is about.

> diff --git a/combine-diff.c b/combine-diff.c
> index fe5a2a1..3cab04b 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -664,7 +664,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  	int mode_differs = 0;
>  	int i, show_hunks;
>  	int working_tree_file = is_null_sha1(elem->sha1);
> -	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
> +        int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;

Indent?

> diff --git a/diff-lib.c b/diff-lib.c
> index da55713..69b5dc9 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -188,8 +188,7 @@ static int handle_diff_files_args(struct rev_info *revs,
>  		else if (!strcmp(argv[1], "-n") ||
>  				!strcmp(argv[1], "--no-index")) {
>  			revs->max_count = -2;
> -			revs->diffopt.exit_with_status = 1;
> -			revs->diffopt.no_index = 1;
> +			revs->diffopt.flags |= DIFF_OPT_EXIT_WITH_STATUS | DIFF_OPT_NO_INDEX;
>  		}

Now this looks harder to read that everybody else uses
DIFF_OPT_SET() for this, without DIFF_OPT_ prefix for the
bitmask names.
