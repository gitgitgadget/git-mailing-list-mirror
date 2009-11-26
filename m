From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv8 08/10] fast-import: Proper notes tree manipulation using the notes API
Date: Thu, 26 Nov 2009 12:10:47 +0100
Message-ID: <200911261210.48138.johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <1258681154-2167-9-git-send-email-johan@herland.net> <20091126024655.GR11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 12:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDcHC-0008Ri-P7
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 12:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbZKZLMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 06:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbZKZLMa
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 06:12:30 -0500
Received: from smtp.opera.com ([213.236.208.81]:42449 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbZKZLM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 06:12:29 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAQB9JkI015171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Nov 2009 11:09:25 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20091126024655.GR11919@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133784>

On Thursday 26 November 2009, Shawn O. Pearce wrote:
> Johan Herland <johan@herland.net> wrote:
> > This patch teaches 'git fast-import' to use the notes API to
> > organize
>
> ...
>
> > This patch is substantially different from the previous iteration.
> > Unloading (and reloading) the notes tree along with its
> > corresponding branch was relatively straightforward to fix, but
> > avoiding the destroying and re-adding of all the notes in every
> > commit was much harder. After 3-4 attempts at a simpler (but
> > fundamentally broken) approach, I finally landed on this. I'm not
> > satisfied with the amount of code introduced by this patch, and
> > would be happy if someone found a better/shorter/more elegant way
> > to solve this problem.
>
> Yea, I agree, I'm not happy with the amount of complex code added
> to implement this.  But I can't say there's a better way to do it
> and still reuse the notes code.  Maybe its just worth breaking away
> from the notes code altogether?  fast-import also implements its
> own pack formatting functions because reusing them from pack-objects
> was just too ugly.

Ok, I will attempt to redo the patch without reusing the notes code. I 
have couple of ideas on how to get it done, but probably won't have the 
time to implement them until next week...

> Aside from a few minor nits below though, I could ACK this, it at
> least avoids the nasty corners that can arise when there are a lot
> of branches and tries to minimize the cost when there are many notes.
>
> > diff --git a/fast-import.c b/fast-import.c
> > +
> > +static void add_to_replace_list(
> > +		struct tree_entry_replace **replace_list,
> > +		const char *old_path, const char *new_path)
> > +{
> > +	struct tree_entry_replace *r = (struct tree_entry_replace *)
> > +		xmalloc(sizeof(struct tree_entry_replace));
> > +	r->next = (*replace_list)->next;
> > +	r->old_path = xstrdup(old_path);
> > +	r->new_path = xstrdup(new_path);
> > +	(*replace_list)->next = r;
> > +	*replace_list = r;
>
> Really?  I don't get why you are replacing the head's next with r
> only to then replace head itself with r.
>
> > @@ -2265,6 +2540,18 @@ static void parse_new_commit(void)
> >  			break;
> >  	}
> >
> > +	if (notes) {
> > +		/* reconcile diffs between b->branch_tree and the notes tree */
> > +		struct reconcile_notes_tree_helper_data d;
> > +		struct tree_entry_replace *replace_list =
> > +			xcalloc(1, sizeof(struct tree_entry_replace));
>
> Oh, I see.  The issue I had with understanding add_to_replace_list()
> is due to this spot allocating a blank header node.  Normally we do
> this with a pointer to a pointer and initialize NULL:
>
> 	struct tree_entry_replace *list = NULL;
> 	struct tree_entry_replace **replace_list = &list;
>
> Can we avoid this blank header node?  I think it comlicates the code,
> e.g. in process_replace_list() you have to skip over the blank node
> by testing for both paths being NULL.

The main problem is that I need to grow a linked list at the far end, 
while keeping a reference to the first element, so that 
process_replace_list() traverse the list in the correct order (FIFO). 
However, I agree that my approach to doing so may have been somewhat 
ham-fisted... Will redo (unless the alternative approach above renders 
this code obsolete).

BTW, while we're on the topic, this whole code is only present because I 
assume it's not possible to edit the fast-import tree structure _while_ 
traversing it. Is this assumption correct, or are there ways to get 
around maintaining a separate edit list that is applied to the tree 
structure afterwards?


Thanks for the review! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
