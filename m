From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Thu, 24 May 2007 12:47:00 -0700
Message-ID: <7vd50qvwaz.fsf@assigned-by-dhcp.cox.net>
References: <20070520181447.GA10638@ferdyx.org>
	<7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
	<20070521182052.GB4696@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 24 21:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJH6-00089s-Pq
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbXEXTrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbXEXTrE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:47:04 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34421 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbXEXTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:47:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524194701.XCSW19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 15:47:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 37n11X0071kojtg0000000; Thu, 24 May 2007 15:47:01 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48300>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> ---
>  Documentation/git-am.txt        |    8 ++-
>  Documentation/git-mailsplit.txt |   13 +++-
>  builtin-mailsplit.c             |  139 ++++++++++++++++++++++++++++++++-------
>  builtin.h                       |    2 +-
>  4 files changed, 132 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index ba79773..25cf84a 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -12,7 +12,8 @@ SYNOPSIS
>  'git-am' [--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
>           [--3way] [--interactive] [--binary]
>           [--whitespace=<option>] [-C<n>] [-p<n>]
> -         <mbox>...
> +         <mbox>|<Maildir>...
> +
>  'git-am' [--skip | --resolved]

Does the document still format Ok if you add a blank line there
(not a rhetorical question -- I haven't checked)?

> diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
> index 3bca855..454f943 100644
> --- a/builtin-mailsplit.c
> +++ b/builtin-mailsplit.c
> @@ -6,9 +6,10 @@
>   */
>  #include "cache.h"
>  #include "builtin.h"
> +#include "path-list.h"
>  
>  static const char git_mailsplit_usage[] =
> -"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>...";
> +"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
>  
>  static int is_from_line(const char *line, int len)
>  {
> @@ -96,44 +97,106 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
>  	exit(1);
>  }
>  
> -int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip)
> +static int populate_maildir_list(struct path_list *list, const char *path)
>  {
> -	char *name = xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
> +	DIR *dir;
> +	struct dirent *dent;
> +
> +	if ((dir = opendir(path)) == NULL) {
> +		error("cannot diropen %s (%s)", path, strerror(errno));
> +		return -1;
> +	}

Didn't you just fail opendir, not diropen?

> +
> +	while ((dent = readdir(dir)) != NULL) {
> +		if (dent->d_name[0] == '.')
> +			continue;
> +		path_list_insert(dent->d_name, list);
> +	}
> +
> +	closedir(dir);
> +
> +	return 1;
> +}

Usually we signal success by returning 0.

> +static int split_maildir(const char *maildir, const char *dir,
> +	int nr_prec, int skip)
> +{
> +	char file[PATH_MAX];
> +	char curdir[PATH_MAX];
> +	char name[PATH_MAX];
>  	int ret = -1;
> +	struct path_list list = {NULL, 0, 0, 1};
>  
> +	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
> +	if (populate_maildir_list(&list, curdir) < 0)
> +		goto out;
>  
> +	int i;

Decl-after-statement.

> +	for (i = 0; i < list.nr; i++) {
> +		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
> +		FILE *f = fopen(file, "r");

Likewise.

> @@ -186,9 +249,39 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
> ...
> +		if (ret < 0) {
> +			error("cannot split patches from %s", arg);
> +			return 1;
> +		}
> +		num += ret;
> +	}
> +
> +	printf("%d\n", num);
>  
> -	return ret == -1;
> +	return 0;
>  }

We do not signal error anymore from the command?
