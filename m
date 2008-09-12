From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] git rm: Support for removing submodules
Date: Fri, 12 Sep 2008 14:49:56 -0700
Message-ID: <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
References: <20080912210817.31628.69014.stgit@localhost>
 <20080912210902.31628.7325.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 23:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGY6-0007MZ-3r
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997AbYILVuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757980AbYILVuO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:50:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757943AbYILVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:50:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DDD47EE42;
	Fri, 12 Sep 2008 17:50:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 707247EE40; Fri, 12 Sep 2008 17:49:59 -0400 (EDT)
In-Reply-To: <20080912210902.31628.7325.stgit@localhost> (Petr Baudis's
 message of "Fri, 12 Sep 2008 23:09:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4BE7718-8114-11DD-9C30-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95773>

Petr Baudis <pasky@suse.cz> writes:

> @@ -20,7 +20,8 @@ and no updates to their contents can be staged in the index,
>  though that default behavior can be overridden with the `-f` option.
>  When '--cached' is given, the staged content has to
>  match either the tip of the branch or the file on disk,
> -allowing the file to be removed from just the index.
> +allowing the file to be removed from just the index;
> +this is always the case when removing submodules.

Sorry, I read this three times but "this" is unclear to me.  Different and
mutually incompatible interpretations I tried to understand it are:

 (1) When removing submodules, whether --cached or not, the index can
     match either HEAD or the work tree; this is different from removing
     regular blobs where the index must match with HEAD without --cached
     nor -f;

 (2) When removing submodules with --cached, the index can match either
     HEAD or the work tree and it is removed only from the index.  You
     cannot remove submodules without --cached;

 (3) When removing submodules, the index can match either HEAD or the work
     tree and it is removed only from the index, even if you did not give
     --cached;

It later becomes clear that you meant (3) in the second hunk, but the
first time reader of the resulting document (not this patch) won't be
reading from bottom to top.

This is a leftover issue from ealier documentation 25dc720 (Clarify and
fix English in "git-rm" documentation, 2008-04-16), but the description is
unclear what should happen while working towards the initial commit
(i.e. no HEAD yet).  I think check_local_mod() allows removal in such a
case.  Perhaps you can clarify the point while at it, please?

> diff --git a/builtin-rm.c b/builtin-rm.c
> index 6bd8211..7475de2 100644
> --- a/builtin-rm.c
> +++ b/builtin-rm.c
> ...
> -static void add_list(const char *name)
> +static void add_list(const char *name, int is_gitlink)
>  {
>  	if (list.nr >= list.alloc) {
>  		list.alloc = alloc_nr(list.alloc);
> -		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
> +		list.info = xrealloc(list.info, list.alloc * sizeof(*list.info));
>  	}

ALLOC_GROW()?

> @@ -38,6 +44,13 @@ static int remove_file(const char *name)
>  	if (ret && errno == ENOENT)
>  		/* The user has removed it from the filesystem by hand */
>  		ret = errno = 0;
> +	if (ret && errno == EISDIR) {
> +		/* This is a gitlink entry; try to remove at least the
> +		 * directory if the submodule is not checked out; we always
> +		 * leave the checked out ones as they are */

	/*
	 * Style?
         * for a multi-line comment.
         */

> +static void remove_submodule(const char *name)
> +{
> +	char *key = submodule_by_path(name);
> +	char *sectend = strrchr(key, '.');
> +
> +	assert(sectend);
> +	*sectend = 0;

Here is one caller I questioned in my comments on [1/6].  It is clear this
caller wants to use "submodule.xyzzy" out of "submodule.xyzzy.path".  The
function returning "submodule.xyzzy.path" does not feel like a clean and
reusable interface to me.  I'd suggest either returning "submodule.xyzzy"
(that's too specialized only for this caller to my taste, though), or just
"xyzzy" and have the caller synthesize whatever string it wants to use
(yes, it loses microoptimization but do we really care about it in this
codepath?), if you have other callers that want different strings around
"xyzzy".

> @@ -140,7 +169,7 @@ static struct option builtin_rm_options[] = {
>  
>  int cmd_rm(int argc, const char **argv, const char *prefix)
>  {
> -	int i, newfd;
> +	int i, newfd, subs;

Perhaps hoist "int removed" up one scope level and reuse it?  I misread
that you are counting the number of gitlinks in the index, not the number
of gitlinks that is being removed, on my first read.  The variable is used
for the latter.

Other than that I did not see anything questionable in [2/6].
