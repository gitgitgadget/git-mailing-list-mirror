From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 07/13] Read resolve-undo data
Date: Fri, 10 Aug 2012 01:23:20 +0200
Message-ID: <20120809232320.GD5127@tommy-fedora.scientificnet.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-8-git-send-email-t.gummerer@gmail.com>
 <7vk3x7n0fl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 01:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szc4g-0004tK-TC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759998Ab2HIXX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 19:23:26 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42254 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab2HIXXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 19:23:25 -0400
Received: by wgbdr13 with SMTP id dr13so906320wgb.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IRO/Cea8iaXytZdCriRO7oUQVzrtOY+GP4qxRRe73oE=;
        b=AhdL3O1NRdP0kpj7cd4Wn+cVVirTxDpvjDYeLyHOPuoOQvymtP7XpYyFVYPDTJCblF
         9FWl2yHocP7ez3zGm14qkKNE/jv3NMfLdXVL6hjR9d5+cdBB7WT6gSuhZmYoKtWZQhOh
         bq6ag3g04T3A9jX5/U6sfNUQc7+NPUNUGitpkUz/OY6kSNJOzVcSIxTeGN70ADSRkp9S
         XCfG2fiLG5cYgB6e8IH+VNvJ3ZxvD6SzHMH4ke70f+AG5GFW7oZjSkAfIj5xJeOuHKd2
         +nrORXRbWMP/zIL1V2YZlu70j1h/KnUMOTHeAInQPBrNV8slrGoTXsVCjKbBbZNYU486
         W/Nw==
Received: by 10.180.100.133 with SMTP id ey5mr651969wib.4.1344554603691;
        Thu, 09 Aug 2012 16:23:23 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id fb20sm6498205wid.1.2012.08.09.16.23.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 16:23:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk3x7n0fl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203190>

On 08/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Make git read the resolve-undo data from the index.
> >
> > Since the resolve-undo data is joined with the conflicts in
> > the ondisk format of the index file version 5, conflicts and
> > resolved data is read at the same time, and the resolve-undo
> > data is then converted to the in-memory format.
> 
> This, and the next one, are both about reading extension data from
> the v2 formatted index, no?

Yes, exactly.

> Again, mild NAK.
> 
> I think it is a lot more logical for the v5 code to read data stored
> in the resolve-undo and cache-tree extensions using the public API
> just like other users of these data do, and write out whatever in a
> way that is specific to the v5 index format.
> 
> If the v5 codepath needs some information that is not exposed to
> other users of istate->resolve_undo and istate->cache_tree, then the
> story is different, but I do not think that is the case.

Sorry it's not clear to me what you mean with using the public API here.
Do you mean using resolve_undo_write() and resolve_undo_read()? I
wouldn't think those two methods would be really useful, as they expect
the data mangled in to a char* or return it as struct strbuf*.  And I
don't see the other methods doing something more useful.  Or I could
use the resolve-undo string_list directly, and just move the function
to read-cache-v5.c, or am I missing something here?

> >
> > Helped-by: Thomas Rast <trast@student.ethz.ch>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  read-cache-v5.c |    1 +
> >  resolve-undo.c  |   36 ++++++++++++++++++++++++++++++++++++
> >  resolve-undo.h  |    2 ++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/read-cache-v5.c b/read-cache-v5.c
> > index ec1201d..b47398d 100644
> > --- a/read-cache-v5.c
> > +++ b/read-cache-v5.c
> > @@ -494,6 +494,7 @@ static struct directory_entry *read_entries(struct index_state *istate,
> >  	int i;
> >  
> >  	conflict_queue = read_conflicts(de, mmap, mmap_size, fd);
> > +	resolve_undo_convert_v5(istate, conflict_queue);
> >  	for (i = 0; i < de->de_nfiles; i++) {
> >  		ce = read_entry(de,
> >  				entry_offset,
> > diff --git a/resolve-undo.c b/resolve-undo.c
> > index 72b4612..f96c6ba 100644
> > --- a/resolve-undo.c
> > +++ b/resolve-undo.c
> > @@ -170,3 +170,39 @@ void unmerge_index(struct index_state *istate, const char **pathspec)
> >  		i = unmerge_index_entry_at(istate, i);
> >  	}
> >  }
> > +
> > +void resolve_undo_convert_v5(struct index_state *istate,
> > +					struct conflict_entry *ce)
> > +{
> > +	int i;
> > +
> > +	while (ce) {
> > +		struct string_list_item *lost;
> > +		struct resolve_undo_info *ui;
> > +		struct conflict_part *cp;
> > +
> > +		if (ce->entries && (ce->entries->flags & CONFLICT_CONFLICTED) != 0) {
> > +			ce = ce->next;
> > +			continue;
> > +		}
> > +		if (!istate->resolve_undo) {
> > +			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
> > +			istate->resolve_undo->strdup_strings = 1;
> > +		}
> > +
> > +		lost = string_list_insert(istate->resolve_undo, ce->name);
> > +		if (!lost->util)
> > +			lost->util = xcalloc(1, sizeof(*ui));
> > +		ui = lost->util;
> > +
> > +		cp = ce->entries;
> > +		for (i = 0; i < 3; i++)
> > +			ui->mode[i] = 0;
> > +		while (cp) {
> > +			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
> > +			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
> > +			cp = cp->next;
> > +		}
> > +		ce = ce->next;
> > +	}
> > +}
> > diff --git a/resolve-undo.h b/resolve-undo.h
> > index 8458769..ab660a6 100644
> > --- a/resolve-undo.h
> > +++ b/resolve-undo.h
> > @@ -13,4 +13,6 @@ extern void resolve_undo_clear_index(struct index_state *);
> >  extern int unmerge_index_entry_at(struct index_state *, int);
> >  extern void unmerge_index(struct index_state *, const char **);
> >  
> > +extern void resolve_undo_convert_v5(struct index_state *, struct conflict_entry *);
> > +
> >  #endif
