From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3] git cherry-pick: Add NULL check to sequencer parsing
 of HEAD
Date: Thu, 3 May 2012 13:34:44 -0400
Message-ID: <20120503173443.GA2957@neilslaptop.think-freely.org>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
 <1336054159-5123-1-git-send-email-nhorman@tuxdriver.com>
 <7vsjfhfbko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mmueller@vigilantsw.com,
	rene.scharfe@lsrfire.ath.cx, Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 19:35:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzvj-0002Nz-3G
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 19:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab2ECRe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 13:34:58 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:56967 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab2ECRe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 13:34:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.202] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SPzvW-0006jM-MX; Thu, 03 May 2012 13:34:53 -0400
Content-Disposition: inline
In-Reply-To: <7vsjfhfbko.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -0.2 (/)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196925>

On Thu, May 03, 2012 at 09:56:07AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Michael Mueller noted that a feature I recently added failed to check the return
> > of lookup_commit to ensure that it was not NULL.  I don't think a NULL can
> > actually happen in the this particular use case, but regardless it seems a good
> > idea to check.
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> Make a mental note here to remember what we just read above: Earlier code
> was missing a check for NULL and the patch should be about adding a new
> check.
> 
> >  sequencer.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index f83cdfd..f7eac1d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -261,9 +261,9 @@ static int is_index_unchanged(void)
> >  		return error(_("Could not resolve HEAD commit\n"));
> >  
> >  	head_commit = lookup_commit(head_sha1);
> > -	if (!head_commit || parse_commit(head_commit))
> > -		return error(_("could not parse commit %s\n"),
> > -			     sha1_to_hex(head_commit->object.sha1));
> > +
> > +	if (parse_commit(head_commit))
> > +		return -1;
> 
> Whoa?  This patch is not about adding any new check.  It removes
> conditions from if clause and removes an error message.
> 
> What does that mean?  6 months down the road, when you read this commit,
> you will be very confused.  The resulting code may be correct, but the
> explanation is way off.  Perhaps explain it like the attached?
> 
> Having said that, if you had HEAD that is corrupt (perhaps filesystem
> corruption), you *WILL* get NULL in head_commit, and with the updated code
> you won't issue any error message from parse_commit(), so I do not think
> the patched result is entirely correct.
> 
See check_commit, as called from lookup_commit, it issues a user visible error
message as part of its parsing.

> -- >8 --
> Subject: [PATCH] git cherry-pick: remove bogus error message generation
> 
> The code to issue an error message tried to access the pointer head_commit
> that is potentially NULL.  Just calling parse_commit() will give us the
> necessary "is the commit object valid?" check and issue an error message,
> so we do not need an error message here.
> 
This seems reasonable to me
Neil
