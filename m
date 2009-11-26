From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv8 08/10] fast-import: Proper notes tree
	manipulation using the notes API
Date: Wed, 25 Nov 2009 18:46:55 -0800
Message-ID: <20091126024655.GR11919@spearce.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <1258681154-2167-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 03:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUNp-0005rO-4P
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbZKZCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZKZCqu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:46:50 -0500
Received: from george.spearce.org ([209.20.77.23]:58918 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbZKZCqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:46:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1547D3842F; Thu, 26 Nov 2009 02:46:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1258681154-2167-9-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133763>

Johan Herland <johan@herland.net> wrote:
> This patch teaches 'git fast-import' to use the notes API to organize
...
> This patch is substantially different from the previous iteration.
> Unloading (and reloading) the notes tree along with its corresponding
> branch was relatively straightforward to fix, but avoiding the
> destroying and re-adding of all the notes in every commit was much
> harder. After 3-4 attempts at a simpler (but fundamentally broken)
> approach, I finally landed on this. I'm not satisfied with the amount
> of code introduced by this patch, and would be happy if someone found
> a better/shorter/more elegant way to solve this problem.

Yea, I agree, I'm not happy with the amount of complex code added
to implement this.  But I can't say there's a better way to do it
and still reuse the notes code.  Maybe its just worth breaking away
from the notes code altogether?  fast-import also implements its
own pack formatting functions because reusing them from pack-objects
was just too ugly.

Aside from a few minor nits below though, I could ACK this, it at
least avoids the nasty corners that can arise when there are a lot
of branches and tries to minimize the cost when there are many notes.
 
> diff --git a/fast-import.c b/fast-import.c
> +
> +static void add_to_replace_list(
> +		struct tree_entry_replace **replace_list,
> +		const char *old_path, const char *new_path)
> +{
> +	struct tree_entry_replace *r = (struct tree_entry_replace *)
> +		xmalloc(sizeof(struct tree_entry_replace));
> +	r->next = (*replace_list)->next;
> +	r->old_path = xstrdup(old_path);
> +	r->new_path = xstrdup(new_path);
> +	(*replace_list)->next = r;
> +	*replace_list = r;

Really?  I don't get why you are replacing the head's next with r
only to then replace head itself with r.

> @@ -2265,6 +2540,18 @@ static void parse_new_commit(void)
>  			break;
>  	}
> 
> +	if (notes) {
> +		/* reconcile diffs between b->branch_tree and the notes tree */
> +		struct reconcile_notes_tree_helper_data d;
> +		struct tree_entry_replace *replace_list =
> +			xcalloc(1, sizeof(struct tree_entry_replace));

Oh, I see.  The issue I had with understanding add_to_replace_list()
is due to this spot allocating a blank header node.  Normally we do
this with a pointer to a pointer and initialize NULL:

	struct tree_entry_replace *list = NULL;
	struct tree_entry_replace **replace_list = &list;

Can we avoid this blank header node?  I think it comlicates the code,
e.g. in process_replace_list() you have to skip over the blank node
by testing for both paths being NULL.

-- 
Shawn.
