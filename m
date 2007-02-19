From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 12:07:30 -0800
Message-ID: <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEnP-00082Z-HY
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXBSUHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbXBSUHc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:07:32 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60995 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbXBSUHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:07:31 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219200732.KITW21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 15:07:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RY7W1W00Q1kojtg0000000; Mon, 19 Feb 2007 15:07:31 -0500
In-Reply-To: <200702191839.05784.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 19 Feb 2007 18:39:05 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40143>

Andy Parkins <andyparkins@gmail.com> writes:

> Changed repeated use of the same constants for the ref paths to be
> symbolic constants.  I've defined them in refs.h
>
>   refs/ is now PATH_REFS
>   refs/heads/ is now PATH_REFS_HEADS
>   refs/tags/ is now PATH_REFS_TAGS
>   refs/remotes/ is now PATH_REFS_REMOTES

Your example:

> ...  This has clarified the code in some places; for
> example:
>
>  - len = strlen(refs[i]) + 11;
>  + len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;

shows that you've carefully looked at what the code does,
instead of mindlessly replacing, which is a very good sign, but
how much testing has this seen, I wonder.

> diff --git a/builtin-describe.c b/builtin-describe.c
> index bcc6456..0f78363 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> @@ -52,7 +52,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
>  	 * If --tags, then any tags are used.
>  	 * Otherwise only annotated tags are used.
>  	 */
> -	if (!strncmp(path, "refs/tags/", 10)) {
> +	if (!strncmp(path, PATH_TAGS, STRLEN_PATH_TAGS)) {
>  		if (object->type == OBJ_TAG)
>  			prio = 2;
>  		else

This is PATH_REFS_TAGS isn't it?

> @@ -231,7 +232,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  	strcpy(path + len, "HEAD");
>  	reinit = !read_ref("HEAD", sha1);
>  	if (!reinit) {
> -		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
> +		if (create_symref("HEAD", PATH_REFS_HEADS "master", NULL) < 0)
>  			exit(1);
>  	}
>  

I mildly mind this one, as it hurts grep-ability.  I know this is one
of the the only two places in git that 'master' branch is treated
specially (and I think we would like to keep it that way --- that's
why I want to be able to grep for "refs/heads/master" and see very few
hits), so introducing PATH_REFS_HEADS_MASTER is probably not very
productive either, but...  hmmmm.

> diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
> index 3de9b3e..ac7543d 100644
> --- a/builtin-pack-refs.c
> +++ b/builtin-pack-refs.c
> @@ -36,7 +36,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  	/* Do not pack the symbolic refs */
>  	if ((flags & REF_ISSYMREF))
>  		return 0;
> -	is_tag_ref = !strncmp(path, "refs/tags/", 10);
> +	is_tag_ref = !strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS);

These repeated strncmp(p, X, STRLEN_X) almost makes me wonder if we
want to introduce:

	inline int prefixcmp(a, b)
        {
        	return (strncmp(a, b, strlen(b));
        }

with clever preprocessor optimization to have compiler do strlen()
when b is a string literal.
