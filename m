From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Thu, 15 Sep 2005 15:02:05 +0400
Message-ID: <20050915150205.65378a65.vsu@altlinux.ru>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__15_Sep_2005_15_02_05_+0400_L1UEXTAHX.QzgTAC"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 13:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFrVk-0005eU-ET
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 13:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVIOLCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 07:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVIOLCV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 07:02:21 -0400
Received: from mivlgu.ru ([81.18.140.87]:2964 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S964800AbVIOLCU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 07:02:20 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id BEA97817A4; Thu, 15 Sep 2005 15:02:08 +0400 (MSD)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8602>

--Signature=_Thu__15_Sep_2005_15_02_05_+0400_L1UEXTAHX.QzgTAC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 14 Sep 2005 21:31:42 -0400 (EDT) Daniel Barkalow wrote:

> Don't assume that any commit we have is complete; assume that any ref
> we have is complete.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> 
> ---
> Only lightly tested, but it seems to work. Marks all of the commits in 
> refs, and their ancestors back as far as the date of the commit it's 
> processing. If the commit it's processing is marked, it doesn't recurse 
> into it.

Seems to work here too (however, previous playing with git-fetch and
old git-http-fetch left .git/refs/heads/origin.remote pointing to an
incomplete commit, and this greatly confused the new git-http-fetch).

Junio, probably you can throw away my patches adding --recover (also I
forgot to add Signed-off-by for them...) - the automatic recovery
provided by this patch is better.  Still there is some room for
improvement...

> This should make it very difficult to get it to produce a situation where 
> it completes without giving you complete information, and it shouldn't 
> process commits that are accessible from refs.
> 
>  fetch.c |   28 ++++++++++++++++++++++++++--
>  1 files changed, 26 insertions(+), 2 deletions(-)
> 
> 39216139abc4f2759f7b55d11fa2f7e7c155898c
> diff --git a/fetch.c b/fetch.c
> --- a/fetch.c
> +++ b/fetch.c
> @@ -62,11 +62,21 @@ static int process_tree(struct tree *tre
>  	return 0;
>  }
>  
> +struct commit_list *complete = NULL;

static

> +
>  static int process_commit(struct commit *commit)
>  {
>  	if (parse_commit(commit))
>  		return -1;
>  
> +	while (complete && complete->item->date >= commit->date) {
> +		pop_most_recent_commit(&complete, 1);
> +	}
> +		
> +
> +	if (commit->object.flags & 1)
> +		return 0;

Hmm, I would define some constant for this flag at the top of file:

/* Object flags */
#define COMPLETE	(1U << 0)

Otherwise it is hard to see what object flags are used in the code
(only one flag is used currently, but we may need more in the future).

> +
>  	memcpy(current_commit_sha1, commit->object.sha1, 20);
>  
>  	if (get_tree) {
> @@ -78,8 +88,6 @@ static int process_commit(struct commit 
>  	if (get_history) {
>  		struct commit_list *parents = commit->parents;
>  		for (; parents; parents = parents->next) {
> -			if (has_sha1_file(parents->item->object.sha1))
> -				continue;
>  			if (process(parents->item->object.sha1,
>  				    commit_type))
>  				return -1;
> @@ -126,6 +134,7 @@ static int process_object(struct object 
>  static int process(unsigned char *sha1, const char *type)
>  {
>  	struct object *obj = lookup_object_type(sha1, type);
> +
>  	if (has_sha1_file(sha1)) {
>  		parse_object(sha1);
>  		/* We already have it, so we should scan it now. */
> @@ -179,6 +188,19 @@ static int interpret_target(char *target
>  	return -1;
>  }
>  
> +static int mark_complete(const char *path, const unsigned char *sha1)
> +{
> +	struct object *obj = parse_object(sha1);
> +	while (obj->type == tag_type) {
> +		obj = ((struct tag *) obj)->tagged;
> +		parse_object(obj->sha1);
> +	}
> +	if (obj->type == commit_type) {
> +		obj->flags |= 1;
> +		insert_by_date((struct commit *) obj, &complete);
> +	}

Dereferencing of tags is already implemented:

	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
	if (commit) {
		commit->object.flags |= 1;
		insert_by_date(commit, &complete);
	}

> +	return 0;
> +}
>  
>  int pull(char *target)
>  {
> @@ -191,6 +213,8 @@ int pull(char *target)
>  			return -1;
>  	}
>  
> +	for_each_ref(mark_complete);
> +
>  	if (interpret_target(target, sha1))
>  		return error("Could not interpret %s as something to pull",
>  			     target);

--Signature=_Thu__15_Sep_2005_15_02_05_+0400_L1UEXTAHX.QzgTAC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDKVSvW82GfkQfsqIRAsr+AJ4zAenI575154YgeJ/DlLs9/Sj06ACeLDYU
iUJ9iQEy08xOLk7qNXsoTDM=
=TdOl
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Sep_2005_15_02_05_+0400_L1UEXTAHX.QzgTAC--
