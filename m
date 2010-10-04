From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 11/18] git notes merge: Add automatic conflict resolvers (ours, theirs, union)
Date: Mon, 4 Oct 2010 17:10:01 +0200
Message-ID: <201010041710.02046.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-12-git-send-email-johan@herland.net> <4CA6F806.9030209@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 17:10:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2mfy-0006I7-1C
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 17:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab0JDPJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 11:09:56 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:61507 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0JDPJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 11:09:56 -0400
Received: from dslb-088-073-123-190.pools.arcor-ip.net ([88.73.123.190] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P2mfp-0005lw-OI; Mon, 04 Oct 2010 17:09:53 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <4CA6F806.9030209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158059>

On Saturday 2. October 2010 11.14.46 Stephen Boyd wrote:
> On 09/28/2010 05:23 PM, Johan Herland wrote:
> > @@ -788,6 +792,21 @@ static int merge(int argc, const char **argv, const
> > char *prefix)
> > 
> >  	expand_notes_ref(&remote_ref);
> >  	o.remote_ref = remote_ref.buf;
> > 
> > +	if (strategy) {
> > +		if (!strcmp(strategy, "manual"))
> > +			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> > +		else if (!strcmp(strategy, "ours"))
> > +			o.strategy = NOTES_MERGE_RESOLVE_OURS;
> > +		else if (!strcmp(strategy, "theirs"))
> > +			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> > +		else if (!strcmp(strategy, "union"))
> > +			o.strategy = NOTES_MERGE_RESOLVE_UNION;
> > +		else {
> > +			error("Unknown -X/--resolve strategy: %s", strategy);
> 
> Is it -X/--resolve or -s/--strategy? This error confuses me.

No, the message should say "Unknown -s/--strategy: %s". Will be fixed in the 
next iteration. Thanks for noticing.

> > diff --git a/notes-merge.c b/notes-merge.c
> > index f625ebd..6fa59d8 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -262,6 +262,35 @@ static void diff_tree_local(struct
> > notes_merge_options *o,
> > 
> >  	diff_tree_release_paths(&opt);
> >  
> >  }
> > 
> > +static int merge_one_change(struct notes_merge_options *o,
> > +			    struct notes_merge_pair *p, struct notes_tree *t)
> > +{
> > +	/*
> > +	 * Return 0 if change was resolved (and added to notes_tree),
> > +	 * 1 if conflict
> > +	 */
> > +	switch (o->strategy) {
> > +	case NOTES_MERGE_RESOLVE_MANUAL:
> > +		return 1;
> > +	case NOTES_MERGE_RESOLVE_OURS:
> > +		OUTPUT(o, 2, "Using local notes for %s", sha1_to_hex(p->obj));
> > +		/* nothing to do */
> > +		return 0;
> > +	case NOTES_MERGE_RESOLVE_THEIRS:
> > +		OUTPUT(o, 2, "Using remote notes for %s", sha1_to_hex(p-
>obj));
> > +		if (add_note(t, p->obj, p->remote, combine_notes_overwrite))
> > +			die("confused: combine_notes_overwrite failed");
> 
> This will say:
> 
> fatal: confused: combine_notes_overwrite failed
> 
> Do we actually need the "confused" part? Heh, maybe we need a confused()
> function?

Well, combine_notes_overwrite() can only return 0, so if we get a non-zero 
return here I will certainly be confused, since this should be impossible. 
Maybe better to drop the check altogether and simply leave add_note(...)?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
