From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-write-error with cherry-pick -n usages
Date: Sun, 3 Feb 2008 10:11:03 +0100
Message-ID: <20080203091103.GA4415@atjola.homenet>
References: <20080111054811.GA7476@atjola.homenet> <7vr6go501s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 10:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLatL-00080m-7V
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 10:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759366AbYBCJLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 04:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759949AbYBCJLL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 04:11:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:59740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754429AbYBCJLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 04:11:07 -0500
Received: (qmail invoked by alias); 03 Feb 2008 09:11:04 -0000
Received: from i577BA19D.versanet.de (EHLO atjola.local) [87.123.161.157]
  by mail.gmx.net (mp005) with SMTP; 03 Feb 2008 10:11:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19cpcBPJ61c4ahK7Ua6936Uc4mohIm0+PhKxvLMzt
	Zlk/HZ3JiBF6ah
Content-Disposition: inline
In-Reply-To: <7vr6go501s.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72340>

On 2008.01.10 22:49:35 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > when you cherry-pick -n a commit that has changes to a file missing=
 in
> > the current tree, that file will be added as "Unmerged". A subseque=
nt
> > cherry-pick that tries to pick a commit that has changes to that fi=
le
> > will then fail with:
> >
> > fatal: git-write-tree: error building trees
>=20
> Yeah, this was because the original "rewrite in C" did somewhat
> a sloppy job while stealing code from git-write-tree.
>=20
> The caller pretends as if the write_tree() function would return
> an error code and being able to issue a sensible error message
> itself, but write_tree() function just calls die() and never
> returns an error.  Worse yet, the function claims that it was
> running git-write-tree (which is no longer true after
> cherry-pick stole it).
>=20
> I think you would need to do something like this patch.  I will
> not apply it during the -rc period, but testing and resending
> with "Tested-by:" would be helpful after post 1.5.4 cycle opens.

Sorry for the delay, that mail got lost somewhere in the noise of my
inbox and real life. Successfully tested the patch to generate an usefu=
l
error message, as well as surviving the test suite and working correctl=
y
on a random set of cherry-picks in some of my repos.

Thanks!

Tested-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

>=20
> ---
>  builtin-revert.c     |    5 ++-
>  builtin-write-tree.c |   74 +++++++++++-----------------------------=
----------
>  builtin.h            |    1 -
>  cache-tree.c         |   59 +++++++++++++++++++++++++++++++++++++++
>  cache-tree.h         |    5 +++
>  5 files changed, 83 insertions(+), 61 deletions(-)
>=20
> diff --git a/builtin-revert.c b/builtin-revert.c
> index 4bf8eb2..d71f414 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -8,6 +8,7 @@
>  #include "exec_cmd.h"
>  #include "utf8.h"
>  #include "parse-options.h"
> +#include "cache-tree.h"
> =20
>  /*
>   * This implements the builtins revert and cherry-pick.
> @@ -270,7 +271,7 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  		 * that represents the "current" state for merge-recursive
>  		 * to work on.
>  		 */
> -		if (write_tree(head, 0, NULL))
> +		if (write_cache_as_tree(head, 0, NULL))
>  			die ("Your index file is unmerged.");
>  	} else {
>  		struct wt_status s;
> @@ -357,7 +358,7 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  	if (merge_recursive(sha1_to_hex(base->object.sha1),
>  				sha1_to_hex(head), "HEAD",
>  				sha1_to_hex(next->object.sha1), oneline) ||
> -			write_tree(head, 0, NULL)) {
> +			write_cache_as_tree(head, 0, NULL)) {
>  		add_to_msg("\nConflicts:\n\n");
>  		read_cache();
>  		for (i =3D 0; i < active_nr;) {
> diff --git a/builtin-write-tree.c b/builtin-write-tree.c
> index b89d02e..e838d01 100644
> --- a/builtin-write-tree.c
> +++ b/builtin-write-tree.c
> @@ -11,66 +11,12 @@
>  static const char write_tree_usage[] =3D
>  "git-write-tree [--missing-ok] [--prefix=3D<prefix>/]";
> =20
> -int write_tree(unsigned char *sha1, int missing_ok, const char *pref=
ix)
> -{
> -	int entries, was_valid, newfd;
> -
> -	/* We can't free this memory, it becomes part of a linked list pars=
ed atexit() */
> -	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file)=
);
> -
> -	newfd =3D hold_locked_index(lock_file, 1);
> -
> -	entries =3D read_cache();
> -	if (entries < 0)
> -		die("git-write-tree: error reading cache");
> -
> -	if (!active_cache_tree)
> -		active_cache_tree =3D cache_tree();
> -
> -	was_valid =3D cache_tree_fully_valid(active_cache_tree);
> -
> -	if (!was_valid) {
> -		if (cache_tree_update(active_cache_tree,
> -				      active_cache, active_nr,
> -				      missing_ok, 0) < 0)
> -			die("git-write-tree: error building trees");
> -		if (0 <=3D newfd) {
> -			if (!write_cache(newfd, active_cache, active_nr)
> -					&& !close(newfd)) {
> -				commit_lock_file(lock_file);
> -				newfd =3D -1;
> -			}
> -		}
> -		/* Not being able to write is fine -- we are only interested
> -		 * in updating the cache-tree part, and if the next caller
> -		 * ends up using the old index with unupdated cache-tree part
> -		 * it misses the work we did here, but that is just a
> -		 * performance penalty and not a big deal.
> -		 */
> -	}
> -
> -	if (prefix) {
> -		struct cache_tree *subtree =3D
> -			cache_tree_find(active_cache_tree, prefix);
> -		if (!subtree)
> -			die("git-write-tree: prefix %s not found", prefix);
> -		hashcpy(sha1, subtree->sha1);
> -	}
> -	else
> -		hashcpy(sha1, active_cache_tree->sha1);
> -
> -	if (0 <=3D newfd)
> -		close(newfd);
> -	rollback_lock_file(lock_file);
> -
> -	return 0;
> -}
> -
>  int cmd_write_tree(int argc, const char **argv, const char *unused_p=
refix)
>  {
>  	int missing_ok =3D 0, ret;
>  	const char *prefix =3D NULL;
>  	unsigned char sha1[20];
> +	const char *me =3D "git-write-tree";
> =20
>  	git_config(git_default_config);
>  	while (1 < argc) {
> @@ -87,8 +33,20 @@ int cmd_write_tree(int argc, const char **argv, co=
nst char *unused_prefix)
>  	if (argc > 2)
>  		die("too many options");
> =20
> -	ret =3D write_tree(sha1, missing_ok, prefix);
> -	printf("%s\n", sha1_to_hex(sha1));
> -
> +	ret =3D write_cache_as_tree(sha1, missing_ok, prefix);
> +	switch (ret) {
> +	case 0:
> +		printf("%s\n", sha1_to_hex(sha1));
> +		break;
> +	case WRITE_TREE_UNREADABLE_INDEX:
> +		die("%s: error reading the index", me);
> +		break;
> +	case WRITE_TREE_UNMERGED_INDEX:
> +		die("%s: error building trees; the index is unmerged?", me);
> +		break;
> +	case WRITE_TREE_PREFIX_ERROR:
> +		die("%s: prefix %s not found", me, prefix);
> +		break;
> +	}
>  	return ret;
>  }
> diff --git a/builtin.h b/builtin.h
> index cb675c4..3d1628c 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -8,7 +8,6 @@ extern const char git_usage_string[];
> =20
>  extern void list_common_cmds_help(void);
>  extern void help_unknown_cmd(const char *cmd);
> -extern int write_tree(unsigned char *sha1, int missing_ok, const cha=
r *prefix);
>  extern void prune_packed_objects(int);
> =20
>  extern int cmd_add(int argc, const char **argv, const char *prefix);
> diff --git a/cache-tree.c b/cache-tree.c
> index 50b3526..69d0b46 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -529,3 +529,62 @@ struct cache_tree *cache_tree_find(struct cache_=
tree *it, const char *path)
>  	}
>  	return it;
>  }
> +
> +int write_cache_as_tree(unsigned char *sha1, int missing_ok, const c=
har *prefix)
> +{
> +	int entries, was_valid, newfd;
> +
> +	/*
> +	 * We can't free this memory, it becomes part of a linked list
> +	 * parsed atexit()
> +	 */
> +	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file)=
);
> +
> +	newfd =3D hold_locked_index(lock_file, 1);
> +
> +	entries =3D read_cache();
> +	if (entries < 0)
> +		return WRITE_TREE_UNREADABLE_INDEX;
> +
> +	if (!active_cache_tree)
> +		active_cache_tree =3D cache_tree();
> +
> +	was_valid =3D cache_tree_fully_valid(active_cache_tree);
> +
> +	if (!was_valid) {
> +		if (cache_tree_update(active_cache_tree,
> +				      active_cache, active_nr,
> +				      missing_ok, 0) < 0)
> +			return WRITE_TREE_UNMERGED_INDEX;
> +		if (0 <=3D newfd) {
> +			if (!write_cache(newfd, active_cache, active_nr)
> +					&& !close(newfd)) {
> +				commit_lock_file(lock_file);
> +				newfd =3D -1;
> +			}
> +		}
> +		/* Not being able to write is fine -- we are only interested
> +		 * in updating the cache-tree part, and if the next caller
> +		 * ends up using the old index with unupdated cache-tree part
> +		 * it misses the work we did here, but that is just a
> +		 * performance penalty and not a big deal.
> +		 */
> +	}
> +
> +	if (prefix) {
> +		struct cache_tree *subtree =3D
> +			cache_tree_find(active_cache_tree, prefix);
> +		if (!subtree)
> +			return WRITE_TREE_PREFIX_ERROR;
> +		hashcpy(sha1, subtree->sha1);
> +	}
> +	else
> +		hashcpy(sha1, active_cache_tree->sha1);
> +
> +	if (0 <=3D newfd)
> +		close(newfd);
> +	rollback_lock_file(lock_file);
> +
> +	return 0;
> +}
> +
> diff --git a/cache-tree.h b/cache-tree.h
> index 8243228..44aad42 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -30,4 +30,9 @@ int cache_tree_update(struct cache_tree *, struct c=
ache_entry **, int, int, int)
> =20
>  struct cache_tree *cache_tree_find(struct cache_tree *, const char *=
);
> =20
> +#define WRITE_TREE_UNREADABLE_INDEX (-1)
> +#define WRITE_TREE_UNMERGED_INDEX (-2)
> +#define WRITE_TREE_PREFIX_ERROR (-3)
> +
> +int write_cache_as_tree(unsigned char *sha1, int missing_ok, const c=
har *prefix);
>  #endif
