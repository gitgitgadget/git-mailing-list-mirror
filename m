From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv6 13/14] Allow flexible organization of notes trees,
 using both commit date and SHA1
Date: Sun, 13 Sep 2009 00:33:28 +0200
Message-ID: <200909130033.28666.johan@herland.net>
References: <200909121752.07523.johan@herland.net>
 <1252771728-27206-14-git-send-email-johan@herland.net>
 <7viqfof1kc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbAs-0003PZ-Uo
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbZILWd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbZILWd2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:33:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:50810 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751770AbZILWd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 18:33:28 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV001HXQNUW280@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 00:33:30 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV00MFXQNT1L40@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 13 Sep 2009 00:33:30 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.221829
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <7viqfof1kc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128307>

On Saturday 12 September 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > This is a major expansion of the notes lookup code to allow for
> > variations in the notes tree organization. The variations allowed
> > include mixing fanout schemes based on the commit dates of the
> > annotated commits (aka. date-based fanout) with fanout schemes based on
> > the SHA1 of the annotated commits (aka. SHA1-based fanout).

Note that this patch is about to be removed from this series, cf. today's 
discussion with Shawn elsewhere in this thread.

> Will squash this in.

I agree with the attempt, but not all of the hunks are good:

> @@ -281,20 +281,20 @@ static int note_tree_insert(struct int_node *tree,
>  unsigned char n, /* Free the entire notes data contained in the given
>  tree */
>  static void note_tree_free(struct int_node *tree)
>  {
> -	if (tree->magic == (void *) ~0) {
> -		if (tree->prev) {
> -			note_tree_free(tree->prev);
> -			free(tree->prev);
> +	if (tree->u.s.magic == (void *) ~0) {
> +		if (tree->u.s.prev) {
> +			note_tree_free(tree->u.s.prev);
> +			free(tree->u.s.prev);
>  		}
> -		if (tree->child) {
> -			note_tree_free(tree->child);
> -			free(tree->child);
> +		if (tree->u.s.magic) {
> +			note_tree_free(tree->u.s.magic);
> +			free(tree->u.s.magic);

Here, you are replacing tree->child with tree->u.s.magic. Shouldn't that be 
tree->u.s.child instead?

> @@ -439,12 +439,12 @@ static void load_date_subtree(struct tree_desc
>  *tree_desc, else  /* this is the last entry, store directly into node */
>  			new_node = node;
> 
> -		new_node->magic = (void *) ~0;
> -		new_node->child = NULL;
> -		new_node->prev = cur_node;
> -		new_node->parent = parent;
> -		hashcpy(new_node->tree_sha1, entry.sha1);
> -		strcpy(new_node->period, period);
> +		new_node->u.s.magic = (void *) ~0;
> +		new_node->u.s.magic = NULL;

Same as above: new_node->u.s.child

> +		new_node->u.s.prev = cur_node;
> +		new_node->u.s.parent = parent;
> +		hashcpy(new_node->u.s.tree_sha1, entry.sha1);
> +		strcpy(new_node->u.s.period, period);
>  		cur_node = new_node;
>  	}
>  	assert(!cur_node || cur_node == node);
> @@ -552,38 +552,38 @@ static unsigned char *lookup_notes(const struct
>  commit *commit) /* Convert commit->date to YYYY-MM-DD format */
>  	short_date = show_date(commit->date, 0, DATE_SHORT);
> 
> -	while (node->magic == (void *) ~0) {  /* date-based node */
> -		int cmp = SUBTREE_DATE_PREFIXCMP(short_date, node->period);
> +	while (node->u.s.magic == (void *) ~0) {  /* date-based node */
> +		int cmp = SUBTREE_DATE_PREFIXCMP(short_date, node->u.s.period);
>  		if (cmp == 0) {
>  			/* Search inside child node */
> -			if (!node->child) {
> +			if (!node->u.s.magic) {
>  				/* Must unpack child node first */
> -				node->child = (struct int_node *)
> +				node->u.s.magic = (struct int_node *)
>  					xcalloc(sizeof(struct int_node), 1);
> -				load_subtree(node->tree_sha1,
> -					(const unsigned char *) node->period,
> -					strlen(node->period), node->child,
> +				load_subtree(node->u.s.tree_sha1,
> +					(const unsigned char *) node->u.s.period,
> +					strlen(node->u.s.period), node->u.s.magic,
>  					node, -1);
>  			}
>  			seen_node = node;
> -			node = node->child;
> +			node = node->u.s.magic;

Same again, 4 times in the above hunk.

> @@ -591,15 +591,15 @@ static unsigned char *lookup_notes(const struct
>  commit *commit) }
>  	}
>  	while (cur_node &&
> -	       SUBTREE_DATE_PREFIXCMP(cur_node->period, seen_node->period) < 0)
> +	       SUBTREE_DATE_PREFIXCMP(cur_node->u.s.period,
>  seen_node->u.s.period) < 0) {
>  		/*
>  		 * We're about to move cur_node backwards in history. We are
>  		 * unlikely to need this cur_node in the future, so free() it.
>  		 */
> -		note_tree_free(cur_node->child);
> -		cur_node->child = NULL;
> -		cur_node = cur_node->parent;
> +		note_tree_free(cur_node->u.s.magic);
> +		cur_node->u.s.magic = NULL;

...and another one here.

> +		cur_node = cur_node->u.s.parent;
>  	}
>  	cur_node = seen_node;
> 


But as I said above, you may want to drop 13/14 and 14/14 completely, 
instead.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
