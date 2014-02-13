From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 02/11] tree-diff: consolidate code for emitting diffs
 and recursion in one place
Date: Thu, 13 Feb 2014 21:52:14 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140213175214.GB6409@tugrik.mns.mnsspb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
 <f0616720dfff7fedbd148e67909fe669834d8e6a.1391794688.git.kirr@mns.spb.ru>
 <xmqqob2alxhc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 18:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE0Qj-0001x1-AW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbaBMRu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 12:50:28 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:45935 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbaBMRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 12:50:28 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WE0Qb-0007ou-RV; Thu, 13 Feb 2014 21:50:25 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WE0SM-0001fw-GZ; Thu, 13 Feb 2014 21:52:14 +0400
Content-Disposition: inline
In-Reply-To: <xmqqob2alxhc.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242067>

On Thu, Feb 13, 2014 at 09:43:27AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > +static void show_path(struct strbuf *base, struct diff_options *opt,
> > +		      struct tree_desc *t1, struct tree_desc *t2)
> >  {
> >  	unsigned mode;
> >  	const char *path;
> > -	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
> > -	int pathlen = tree_entry_len(&desc->entry);
> > +	const unsigned char *sha1;
> > +	int pathlen;
> >  	int old_baselen = base->len;
> > +	int isdir, recurse = 0, emitthis = 1;
> > +
> > +	/* at least something has to be valid */
> > +	assert(t1 || t2);
> > +
> > +	if (t2) {
> > +		/* path present in resulting tree */
> > +		sha1 = tree_entry_extract(t2, &path, &mode);
> > +		pathlen = tree_entry_len(&t2->entry);
> > +		isdir = S_ISDIR(mode);
> > +	}
> > +	else {
> > +		/* a path was removed - take path from parent. Also take
> > +		 * mode from parent, to decide on recursion.
> > +		 */
> > +		tree_entry_extract(t1, &path, &mode);
> > +		pathlen = tree_entry_len(&t1->entry);
> > +
> > +		isdir = S_ISDIR(mode);
> > +		sha1 = NULL;
> > +		mode = 0;
> > +	}
> > +
> > +	if (DIFF_OPT_TST(opt, RECURSIVE) && isdir) {
> > +		recurse = 1;
> > +		emitthis = DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
> > +	}
> >  
> >  	strbuf_add(base, path, pathlen);
> > -	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
> > -		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
> > -			opt->add_remove(opt, *prefix, mode, sha1, 1, base->buf, 0);
> >  
> > +	if (emitthis)
> > +		emit_diff(opt, base, t1, t2);
> > +
> > +	if (recurse) {
> >  		strbuf_addch(base, '/');
> > -		diff_tree_sha1(*prefix == '-' ? sha1 : NULL,
> > -			       *prefix == '+' ? sha1 : NULL, base->buf, opt);
> > -	} else
> > -		opt->add_remove(opt, prefix[0], mode, sha1, 1, base->buf, 0);
> > +		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> > +			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
> > +	}
> 
> 
> After this step, "sha1" is assigned but never gets used.  Please
> double-check the fix-up I queued in the series before merging it to
> 'pu'.

Your fixup is correct - it was my overlook when preparing the patch -
sha1 is needed for later patch (multiparent diff tree-walker), but I've
mistakenly left it here.

The two interesting patches I've sent you today, are already adjusted to
this correction - it is safe to squash the fixup in.

Thanks for noticing,
Kirill
