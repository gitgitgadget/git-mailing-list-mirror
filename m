From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5/8] checkout(-index): do not checkout i-t-a entries
Date: Sun, 29 Nov 2015 16:31:22 +0100
Message-ID: <20151129153122.GA3719@duynguyen-vnpc.dek-tpc.internal>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
 <1440205700-19749-6-git-send-email-pclouds@gmail.com>
 <xmqq8u8z1d8r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 16:31:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a33xD-00036k-88
	for gcvg-git-2@plane.gmane.org; Sun, 29 Nov 2015 16:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbK2Pbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2015 10:31:48 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34944 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbK2Pb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2015 10:31:28 -0500
Received: by wmuu63 with SMTP id u63so101541648wmu.0
        for <git@vger.kernel.org>; Sun, 29 Nov 2015 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7qXLI7BS+DrkiuX/6C4YHQw7nEwZ7cKd2OdVZ/eEeYM=;
        b=yLnONAgtEgTDzQ6l6tgh9VuhN13RYVXB8aK6yoXhH3eRH+gIyfzYg8x59RVn3Yus/K
         Os67HDHQ/LbBTP8CLE1Y6tH98/l70v6KfR4lRd+E+aFoJ7s4lOTYPxVlKKJZHQEFNtqT
         ViRImhNLprd6wYpF+Pjt8oBa0LY3lUH7ouc8lNswj0RD3xZrom0VJ3ss7gWgL9MPOJTI
         /VdSFEfDRPeMBpd1s25AwEimihMJdKXu4Mc0MYtVamzQGXNpa5IU4s0AAzI4RXKr5pKA
         bxQ0y+QIid6W+k+GqkZxp2hx0qUNNdVxUzFuTRlBkjDCZSPQ+vFnFq4e7K0SUt/2+k3O
         EmcA==
X-Received: by 10.194.222.104 with SMTP id ql8mr36870359wjc.157.1448811087303;
        Sun, 29 Nov 2015 07:31:27 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id z1sm42357985wje.35.2015.11.29.07.31.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Nov 2015 07:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq8u8z1d8r.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281798>

Sorry for this waaay too late response, everything (of the series
nd/ita-cleanup) is addressed so far except this..

On Tue, Aug 25, 2015 at 10:36:52AM -0700, Junio C Hamano wrote:
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index e1403be..02889d4 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -300,6 +300,8 @@ static int checkout_paths(const struct checkout_opts *opts,
> >  			 * anything to this entry at all.
> >  			 */
> >  			continue;
> > +		if (ce_intent_to_add(ce))
> > +			continue;
> >  		/*
> >  		 * Either this entry came from the tree-ish we are
> >  		 * checking the paths out of, or we are checking out
> 
> Hmm, while this does prevent the later code from checking it out, I
> am not sure how well this interacts with ps_matched[] logic here.
> If the user told Git that 'foo' is a path that she cares about with
> "add -N foo", and said "git checkout -- foo", should we be somehow
> saying that 'foo' did match but there is nothing to check out, or
> something?

How about this? It does not mess with ps_matched logic. But it does
not say "nothing to checkout" at the end either. While we could do
that (in general case, not just because all we are checking out is ita
entries), I'm not sure if such verbosity helps anyone. I'm thinking of
dropping the new warning I added here too..

-- 8< --
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e141fc..c11fe71 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -328,12 +328,17 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->merge)
 		unmerge_marked_index(&the_index);
 
-	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce))
+			if (!ce_stage(ce)) {
+				if (ce_intent_to_add(ce)) {
+					warning(_("path '%s' is only intended to add"), ce->name);
+					ce->ce_flags &= ~CE_MATCHED;
+				}
 				continue;
+			}
+			/* Any unmerged paths? */
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
-- 8< --
--
Duy
