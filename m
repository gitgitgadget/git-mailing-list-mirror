From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 20:23:41 +0100
Message-ID: <20090114192341.GA26703@localhost>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <1231944876-29930-4-git-send-email-drizzd@aon.at> <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes@familieschneider.info
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBMQ-0006ry-Nt
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbZANTXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbZANTXn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:23:43 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:31167 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbZANTXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:23:41 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 20:23:38 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LNBL3-00079r-Sn; Wed, 14 Jan 2009 20:23:41 +0100
Content-Disposition: inline
In-Reply-To: <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 14 Jan 2009 19:23:39.0808 (UTC) FILETIME=[9ADF3A00:01C9767D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105683>

On Wed, Jan 14, 2009 at 10:39:29AM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > With this patch ce_path_match uses match_pathspec in order to perform
> > pattern matching.
> 
> We have two conflicting definitions of pattern matching in our system.
> I'd make it more explicit which kind of pattern matching you are talking
> about here.

Right, will fix.

> In the longer term we really should unify them by teaching the former to
> fall back to globbing without getting undue performance hit, and this
> patch may be a step in the right direction.  There are optimizations that
> assume the "leading path" semantics to trim the input early and avoid
> opening and descending into a tree object if pathspec patterns cannot
> possibly match (see tree-diff.c::tree_entry_interesting() for an example),
> and we need to teach them to notice a glob wildcard in an earlier part of
> a pathspec and to descend into some trees that they would have skipped
> with the old definition of pathspec.

I see. I can probably fix that this weekend.

> > @@ -49,7 +60,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
> >  		rev->always_show_header = 0;
> >  	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
> >  		rev->always_show_header = 0;
> > -		if (rev->diffopt.nr_paths != 1)
> > +		if (rev->diffopt.nr_paths != 1 || has_special(rev->diffopt.paths[0]))
> >  			usage("git logs can only follow renames on one pathname at a time");
> >  	}
> 
> The reason match_pathspec() first tries exact match and then falls back to
> globbing is so that the user can say "I have a file whose name ends with a
> question mark, please match it literally."  This patch defeats it, but it
> probably is a minor point.

I was wondering actually if we should disallow such paths altogether,
since there would be no way to match only 'a?', if something like 'ab' also
exists. So if you added 'a?' by accident, you cannot even remove it without
also removing 'ab'.

I think we could at least add an option to disable globbing. Then we can
also disable the above check conditioned on that. If we allowed globbing
pattern for following renames wouldn't that result in following the first
file (or last in history) to match the pattern, which is potentially
confusing?
