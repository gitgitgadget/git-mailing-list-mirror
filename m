From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 2/2] bugfix: git diff --quiet -w never returns with
 exit status 1
Date: Tue, 16 Feb 2010 01:45:39 -0500
Message-ID: <20100216064539.GA18741@cthulhu>
References: <1266293446-8092-1-git-send-email-larry@elder-gods.org>
 <1266293446-8092-2-git-send-email-larry@elder-gods.org>
 <7v3a11ivmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:45:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHBr-0002BT-9S
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab0BPGpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:45:41 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59613 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab0BPGpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:45:40 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id CFBC6822010; Tue, 16 Feb 2010 01:45:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v3a11ivmz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140073>

* Junio C Hamano (gitster@pobox.com) [100216 00:42]:
> Larry D'Anna <larry@elder-gods.org> writes:
> 
> > Rationale: diff_flush_patch expects to write its output to options->file.
> > Adding a "silence" flag to diff_flush_patch and everything it calls would be
> > more invasive.
> 
> I would agree that the logic to redirect the output to nowhere may be the
> easiest way out, but because the reason anybody sane would want to give -q
> is to say "I don't care what the actual changes are, but I want to know if
> there is any real quick" (otherwise the call would be "diff -w >/dev/null"),
> shouldn't we at least be exiting the loop early when we see any difference?
> 
> > Signed-off-by: Larry D'Anna <larry@elder-gods.org>
> > ---
> >  diff.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/diff.c b/diff.c
> > index 68def6c..ff00816 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3522,6 +3522,26 @@ void diff_flush(struct diff_options *options)
> >  		separator++;
> >  	}
> >  
> > +	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> > +	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
> > +	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
> > +		/* run diff_flush_patch for the exit status */
> > +		/* setting options->file to /dev/null should be safe, becaue we
> > +		   aren't supposed to produce any output anyways */
> 
> Style?
> 
> > +		static FILE *devnull = NULL;
> 
> Would this cause one file descriptor to leak?  Do we care?

Originally I thought it would be best to just let one leak, because I didn't
know how much longer it would need to stick around.  I didn't notice it's being
closed anyway a few lines down.


> > +		if(!devnull) {
> 
> Style?	if (!devnull)
> 
> > +			devnull = fopen("/dev/null", "w");
> > +			if (!devnull)
> > +				die_errno("Could not open /dev/null");
> > +		}
> > +		options->file = devnull;
> 
> Would this cause the original "options->file" leak?  Do we care?

oops.

> > +		for (i = 0; i < q->nr; i++) {
> > +			struct diff_filepair *p = q->queue[i];
> > +			if (check_pair_status(p))
> > +				diff_flush_patch(p, options);
> > +		}
> > +	}
> > +
> >  	if (output_format & DIFF_FORMAT_PATCH) {
> >  		if (separator) {
> >  			putc(options->line_termination, options->file);
> > -- 
> > 1.7.0.rc2.40.g7d8aa
> 
