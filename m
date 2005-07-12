From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 00:50:44 -0600
Message-ID: <m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:51:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsEbl-00029P-OQ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 08:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVGLGvC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 02:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGLGvC
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 02:51:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38549 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261208AbVGLGu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 02:50:58 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C6okdd005840;
	Tue, 12 Jul 2005 00:50:46 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C6oigu005836;
	Tue, 12 Jul 2005 00:50:44 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 11 Jul 2005 22:39:25 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> This patch adds a command git-id for use on
> the command line to see what git will set your id too,
> and for use in scripts (git-tag-script) so they can get your git id.
>
> The common code for computing the git-id is moved to ident.c
>
> Fix parse_date to not mind being passed a constant date
> to parse.
>
> The code to compute the identifier has been restructured
> to at least make a reasonable stab at error handling.  The
> original version had so many unchecked return values it was
> just scary to think about.

Well except for a small bug, but serious bug...

> diff --git a/commit-tree.c b/commit-tree.c
> --- a/commit-tree.c
> +++ b/commit-tree.c
> @@ -184,8 +126,8 @@ int main(int argc, char **argv)
>  		add_buffer(&buffer, &size, "parent %s\n",
> sha1_to_hex(parent_sha1[i]));
>  
>  	/* Person/date information */
> -	add_buffer(&buffer, &size, "author %s <%s> %s\n", gecos, email, date);
> - add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos,
> commitemail, realdate);
> +	add_buffer(&buffer, &size, "author %s <%s> %s\n", author);
> +	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", committer);

This should be:
> +	add_buffer(&buffer, &size, "author %s\n", author);
> +	add_buffer(&buffer, &size, "committer %s\n\n", committer);

>  
>  	/* And add the comment */
>  	while (fgets(comment, sizeof(comment), stdin) != NULL)
> diff --git a/id.c b/id.c
> new file mode 100644
> --- /dev/null
> +++ b/id.c
> @@ -0,0 +1,36 @@
> +#include "cache.h"
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +
> +static char *id_usage = "git-id [--author | --committer]";
> +
> +int main(int argc, char **argv)
> +{
> +	char buf[1000];
> +	int (*ident)(char *buf, size_t bufsize);
> +	int i;
> +
> +	ident = git_committer_ident;

Should this default to git_author_ident or git_committer_ident?
I'm not really certain how we expect to use the different flavors.

Eric
