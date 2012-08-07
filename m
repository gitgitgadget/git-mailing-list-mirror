From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 10/16] Read resolve-undo data
Date: Tue, 7 Aug 2012 21:17:59 +0200
Message-ID: <20120807191759.GB867@tgummerer.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-11-git-send-email-t.gummerer@gmail.com>
 <7vk3xc23f8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 21:18:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SypIG-0003Vr-Fn
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 21:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab2HGTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 15:18:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60589 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab2HGTSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 15:18:09 -0400
Received: by pbbrr13 with SMTP id rr13so114392pbb.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6UIb6KGyzxvqJmpW31Wc3NdAL5iH+W/lFsfc/jEQuLE=;
        b=elhVKL6SLGm5S9x5MPGlNc4A1oN1sRXuvE3lEbDxHuQ1uZEmhV4O4mIlCjFNj3CQau
         LO4USoDAmxa/nx+3a5rVeget/1QvZhou7GFre/1gqr3CkoJWvgCJRuDEfC66kDY6/11F
         HQ+YVc4EVEsNiXRDNKkoyEIHaYOSd8RP2+aBCvL67LWecF3SnIX7NfcmsBnGfsqvlypi
         fcGTlqBgTX1qgQmWDwEw0THcqwqkS/8vTgV8U7Eb1CR6PPy9J0tIGnbTYyp3zo5mUv8J
         /PvwPP40DRUmSES6T1INEv5IK1OwcKLzSMq1X2v9TzH1QudAsIMNjVP6sqKvzI5SnFKt
         oNgA==
Received: by 10.68.223.35 with SMTP id qr3mr30653997pbc.83.1344367089142;
        Tue, 07 Aug 2012 12:18:09 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id pn4sm376022pbb.50.2012.08.07.12.18.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 12:18:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk3xc23f8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203038>



On 08/05, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Make git read the resolve-undo data from the index.
> >
> > Since the resolve-undo data is joined with the conflicts in
> > the ondisk format of the index file version 5, conflicts and
> > resolved data is read at the same time, and the resolve-undo
> > data is then converted to the in-memory format.
> >
> > Helped-by: Thomas Rast <trast@student.ethz.ch>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  read-cache.c   |    1 +
> >  resolve-undo.c |   36 ++++++++++++++++++++++++++++++++++++
> >  resolve-undo.h |    2 ++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index 70334f9..03370f9 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1942,6 +1942,7 @@ static struct directory_entry *read_entries_v5(struct index_state *istate,
> >  	int i;
> >  
> >  	conflict_queue = read_conflicts_v5(de, mmap, mmap_size, fd);
> > +	resolve_undo_convert_v5(istate, conflict_queue);
> >  	for (i = 0; i < de->de_nfiles; i++) {
> >  		ce = read_entry_v5(de,
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
> 
> It is unclear why this needs to be part of resolve-undo.c and
> exported from it.  Shouldn't it (and bulk of the previous few
> patches) be part of a read-cache-v5.c file (with v2/3/4 specific
> part separated out from read-cache.c to form read-cache-v2.c)?

I thought this should be part of resolve-undo.c, to keep everything
that has to do with resolve-undo in the same file, taking model
from resolve_undo_read and resolve_undo_write.  But I don't care
to deeply about it, it can easily be moved to read-cache-v5.c.

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
