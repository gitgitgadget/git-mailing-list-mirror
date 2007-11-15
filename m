From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-commit: fix "git add x y && git commit y"
	committing x, too
Date: Thu, 15 Nov 2007 12:01:34 -0500
Message-ID: <1195146094.21076.6.camel@hinata.boston.redhat.com>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
	 <1195138198-24511-1-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711151611090.30886@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsiAS-0006Fb-2y
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762339AbXKORF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762121AbXKORF6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:05:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52095 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761680AbXKORF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:05:57 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAFH1iIT002538;
	Thu, 15 Nov 2007 12:01:44 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAFH1iXC008655;
	Thu, 15 Nov 2007 12:01:44 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAFH1dB1019429;
	Thu, 15 Nov 2007 12:01:39 -0500
In-Reply-To: <Pine.LNX.4.64.0711151611090.30886@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65139>

On Thu, 2007-11-15 at 16:11 +0000, Johannes Schindelin wrote:
> Earlier, builtin commit would implicitly commit also the staged
> changes.
> 
> This patch fixes that.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	The function reset_index_to_head() could be moved to somewhere
> 	more central and be reused in builtin-reset.c instead of
> 	reset_index_file() later...
> 
>  builtin-add.c     |    1 +
>  builtin-commit.c  |   30 +++++++++++++++++++++++++++++-
>  t/t7500-commit.sh |   10 ++++++++++
>  3 files changed, 40 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index 77dcde6..017c8f2 100644
> --- a/builtin-add.c
> +++ b/builtin-add.c
> @@ -100,6 +100,7 @@ static void update_callback(struct diff_queue_struct *q,
>  		case DIFF_STATUS_UNMERGED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
> +		case DIFF_STATUS_ADDED:
>  			add_file_to_cache(path, verbose);
>  			break;
>  		case DIFF_STATUS_DELETED:
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 535039c..0dc6e1c 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -19,6 +19,7 @@
>  #include "strbuf.h"
>  #include "utf8.h"
>  #include "parse-options.h"
> +#include "unpack-trees.h"
>  
>  static const char * const builtin_commit_usage[] = {
>  	"git-commit [options] [--] <filepattern>...",
> @@ -77,6 +78,31 @@ static struct option builtin_commit_options[] = {
>  	OPT_END()
>  };
>  
> +static int reset_index_to_head(void)
> +{
> +	struct unpack_trees_options opts;
> +	struct tree_desc tree_desc;
> +	struct tree *tree;
> +	unsigned char sha1[20];
> +
> +	/* ignore if it is an initial commit */
> +	if (get_sha1("HEAD", sha1))
> +		return 0;
> +	tree = parse_tree_indirect(sha1);
> +	if (!tree || parse_tree(tree))
> +		return error("Could not get HEAD's tree");
> +	init_tree_desc(&tree_desc, tree->buffer, tree->size);
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.index_only = 1;
> +	opts.merge = 1;
> +	opts.head_idx = 1;
> +	opts.fn = oneway_merge;
> +	if (unpack_trees(1, &tree_desc, &opts))
> +		return error("Could not reset temporary index to HEAD");
> +	return 0;
> +}
> +
>  static char *prepare_index(const char **files, const char *prefix)
>  {
>  	int fd;
> @@ -120,12 +146,14 @@ static char *prepare_index(const char **files, const char *prefix)
>  			die("failed to read HEAD tree object");
>  	}
>  
> +	if (reset_index_to_head())
> +		die ("failed to reset temporary index to HEAD");
> +

If you look just above where you added these lines, there is code to
deal with this case, except it doesn't work.  I was trying to fix this
too by adding a discard_cache() call before building the temp index, but
then I couldn't add the files in question because the index was now
newer than those files.  Anyway, I don't know if your code is better
that just doing read_tree(), but we should only have one or the other in
there.

Kristian
