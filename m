From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] fetch: refuse to fetch into the current branch in a
 non-bare repository
Date: Sun, 12 Oct 2008 16:37:28 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 22:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp7i8-0007Hc-Pb
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 22:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbYJLUha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYJLUha
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 16:37:30 -0400
Received: from iabervon.org ([66.92.72.58]:57159 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbYJLUh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 16:37:29 -0400
Received: (qmail 8362 invoked by uid 1000); 12 Oct 2008 20:37:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Oct 2008 20:37:28 -0000
In-Reply-To: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98053>

On Sat, 11 Oct 2008, Johannes Schindelin wrote:

> Some confusing tutorials suggest that it would be a good idea to call
> something like this:
> 
> 	git pull origin master:master
> 
> While it might make sense to store what you want to merge, it typically
> is plain wrong.  Especially so when the current branch is "master".
> 
> Be at least a little bit helpful by refusing to fetch something into
> the current branch.

I think this is the right thing to do.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-fetch.c   |   20 ++++++++++++++++++++
>  t/t5505-remote.sh |    2 +-
>  t/t5510-fetch.sh  |    6 ++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index ee93d3a..d701550 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -534,6 +534,25 @@ static void find_non_local_tags(struct transport *transport,
>  	string_list_clear(&new_refs, 0);
>  }
>  
> +static void check_ref_map(struct ref *ref_map)
> +{
> +	int flag;
> +	unsigned char sha1[20];
> +	const char *HEAD;
> +
> +	if (is_bare_repository())
> +		return;
> +
> +	HEAD = resolve_ref("HEAD", sha1, 1, &flag);
> +
> +	if (!HEAD || !(flag & REF_ISSYMREF))
> +		return;

remote.h has a function for getting "the current branch", which would save 
5 lines here:

	struct branch *current_branch = branch_get(NULL);
	if (!current_branch || is_bare_repository())
		return;

> +
> +	for (; ref_map; ref_map = ref_map->next)
> +		if (ref_map->peer_ref && !strcmp(HEAD, ref_map->peer_ref->name))

		!strcmp(current_branch->ref_name, ref_map->peer_ref->name)

(untested, and might be off by a "refs/" or something)

> +			die("Refusing to fetch into current branch");
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *refs, int ref_count)
>  {
> @@ -558,6 +577,7 @@ static int do_fetch(struct transport *transport,
>  	}
>  
>  	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
> +	check_ref_map(ref_map);
>  
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		if (rm->peer_ref)
