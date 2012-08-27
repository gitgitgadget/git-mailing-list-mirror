From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2 PATCH] Teach rm to remove submodules unless they contain
 a git directory
Date: Mon, 27 Aug 2012 13:59:36 -0700
Message-ID: <7v1uisqcef.fsf@alter.siamese.dyndns.org>
References: <503BCD91.6080107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?TWljaGHFgiBHw7Ny?= =?utf-8?B?bnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T66PS-0006EM-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 22:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab2H0U7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 16:59:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2H0U7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 16:59:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E47428EB4;
	Mon, 27 Aug 2012 16:59:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OJEqzoqgT5TUgwQJmuYqMf0JEMU=; b=cOU87E
	fseM95FCcha8WukbynFKrX3v3z9XpMJS1IVj+tn2ckPH75xmSNNuQp+F12Q4K0qA
	XcYRkoku2bzFpi5qDvVBPedMO4JQBRaIkuJf1RDAclPHeosdQO1IJJbzH0GG6wmU
	U9/HhsILQnotZrilTFkb7uTecLUAtnkfYPmwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNd06ysyGyD+7BVuIPN25QlVeOoz0XLq
	MUOqrsai+Klu6igGJQXg7EuMyN//3JSSrG/iWe04Os4yOJNWSnuvluzrxxCJpMW4
	J2Atd8z5BBhLcwFj4FnA6LWPFXQA7Nt1i8DeDl4yIRrPw98YHfM08+KZZEORexpi
	661McZXYoH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD4078EB3;
	Mon, 27 Aug 2012 16:59:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA2F88EB2; Mon, 27 Aug 2012
 16:59:37 -0400 (EDT)
In-Reply-To: <503BCD91.6080107@web.de> (Jens Lehmann's message of "Mon, 27
 Aug 2012 21:42:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CDF457E-F08A-11E1-BAB1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204370>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 5d31860..3c76f9c 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -107,6 +107,21 @@ as well as modifications of existing paths.
>  Typically you would first remove all tracked files from the working
>  tree using this command:
>
> +Submodules
> +~~~~~~~~~~~~~~~~~~~~

You need to match the underline to the text if you want to make this
a heading.

> diff --git a/builtin/rm.c b/builtin/rm.c
> index 90c8a50..cb927a8 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -9,6 +9,7 @@
>  #include "cache-tree.h"
>  #include "tree-walk.h"
>  #include "parse-options.h"
> +#include "submodule.h"
>
>  static const char * const builtin_rm_usage[] = {
>  	"git rm [options] [--] <file>...",
> @@ -17,9 +18,43 @@ static const char * const builtin_rm_usage[] = {
>
>  static struct {
>  	int nr, alloc;
> -	const char **name;
> +	struct {
> +		const char *name;
> +		char is_submodule;
> +	} *entry;
>  } list;
>
> +static int check_submodules_use_gitfiles()

static int check_submodules_use_gitfiles(void)

> +{
> +	int i;
> +	int errs = 0;
> +
> +	for (i = 0; i < list.nr; i++) {
> +		const char *name = list.entry[i].name;
> +		int pos;
> +		struct cache_entry *ce;
> +		struct stat st;
> +
> +		pos = cache_name_pos(name, strlen(name));
> +		if (pos < 0)
> +			continue; /* ignore unmerged entry */

Would this cause "git rm -f path" for an unmerged submodule bypass
the safety check?

With or without this patch, check_local_mod() will allow you to
remove unmerged entry and the file in the working tree, and that is
perfectly fine for a regular file or a symlink (as the path is
involved in a conflicted merge (or other mergy operation), and its
change from the HEAD can only come from that merge, because we would
not let merge touch a path and leave its index entry unmerged if the
path has local changes in the first place).  Resolving the merge as
a removal at the index level for a submodule is also fine in such a
case, but don't you want to still keep the submodule working tree if
it has its sole copy of the repository?  And as far as I can tell,
this function is the only thing that protects the user in such a
situation.

> +		ce = active_cache[pos];
> +
> +		if (!S_ISGITLINK(ce->ce_mode) ||
> +		    (lstat(ce->name, &st) < 0) ||
> +		    is_empty_dir(name))
> +			continue;
> +
> +		if (!submodule_uses_gitfile(name))
> +			errs = error(_("submodule '%s' (or one of its nested "
> +				     "submodules) uses a .git directory\n"
> +				     "(use 'rm -rf' if you really want to remove "
> +				     "it including all of its history)"), name);
> +	}
> +
> +	return errs;
> +}

The call to this function comes at the very end and gives us yes/no
for the entire set of paths.  After getting this error for one
submodule and bunch of other non-submodule paths, what is the
procedure for the user to remove it that we want to recommend in our
documentation?  Would it go like this?

	$ git rm path1 path2 sub path3
	... get the above error ...
	$ git submodule --to-gitfile sub
        $ rm -fr sub
        $ git rm sub
        ... then finally ...
        $ git rm path1 path2 path3

This is not a complaint about the error message above, by the way.

> @@ -37,7 +72,7 @@ static int check_local_mod(unsigned char *head, int index_only)
>  		struct stat st;
>  		int pos;
>  		struct cache_entry *ce;
> -		const char *name = list.name[i];
> +		const char *name = list.entry[i].name;
>  		unsigned char sha1[20];
>  		unsigned mode;
>  		int local_changes = 0;
> @@ -58,9 +93,10 @@ static int check_local_mod(unsigned char *head, int index_only)
>  			/* if a file was removed and it is now a
>  			 * directory, that is the same as ENOENT as
>  			 * far as git is concerned; we do not track
> -			 * directories.
> +			 * directories unless they are submodules.
>  			 */
> -			continue;
> +			if (!S_ISGITLINK(ce->ce_mode))
> +				continue;
>  		}
>
>  		/*
> @@ -80,8 +116,11 @@ static int check_local_mod(unsigned char *head, int index_only)
>
>  		/*
>  		 * Is the index different from the file in the work tree?
> +		 * If it's a submodule, is its work tree modified?
>  		 */
> -		if (ce_match_stat(ce, &st, 0))
> +		if (ce_match_stat(ce, &st, 0) ||
> +		    (S_ISGITLINK(ce->ce_mode) &&
> +		     !ok_to_remove_submodule(ce->name)))
>  			local_changes = 1;

As noted before, because we also skip these "does it match the
index?  does it match the HEAD?" checks for unmerged paths in this
function, a submodule that has local changes or new files is
eligible for removal during a conflicted merge.  I have a feeling
that this should be tightened a bit; wouldn't we want to check at
least in the checked out version (i.e. stage #2 in the index) if the
path were a submodule, even if we are in the middle of a conflicted
merge?  After all, the top level merge shouldn't have touched the
submodule working tree, so the local modes and new files must have
come from the end user action that was done _before_ the conflicted
merge started, and not expendable, no?



-- >8 --

 Documentation/git-rm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git i/Documentation/git-rm.txt w/Documentation/git-rm.txt
index 3c76f9c..882cb11 100644
--- i/Documentation/git-rm.txt
+++ w/Documentation/git-rm.txt
@@ -108,13 +108,13 @@ Typically you would first remove all tracked files from the working
 tree using this command:
 
 Submodules
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~
 Only submodules using a gitfile (which means they were cloned
 with a git version 1.7.8 or newer) will be removed from the work
 tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
-still use a .git directory, `git rm` will fail - no matter if forced
-or not - to protect the submodules history.
+still uses a .git directory, `git rm` will fail - no matter if forced
+or not - to protect the submodule's history.
 
 A submodule is considered up-to-date when the HEAD is the same as
 recorded in the index, no tracked files are modified and no untracked
