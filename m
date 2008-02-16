From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] http-push: avoid invalid memory accesses
Date: Sat, 16 Feb 2008 12:12:03 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802161211320.30505@racer.site>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site> <alpine.LSU.1.00.0802142325120.30505@racer.site> <7vabm1cqkd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 13:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQLuR-0007Dq-C4
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 13:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYBPMMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 07:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbYBPMMM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 07:12:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:59138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754647AbYBPMMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 07:12:10 -0500
Received: (qmail invoked by alias); 16 Feb 2008 12:12:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 16 Feb 2008 13:12:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FFZgb1wcFscdo8lEP4Nk0OMzF50gIi28lnI7/VZ
	xmR8O6DKvF9l8N
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabm1cqkd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74041>

Hi,

On Fri, 15 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Before objects are sent, the respective ref is locked.  However,
> > without this patch, the lock is lifted before the last object for
> > that ref was sent.  As a consequence, the lock data was accessed
> > after the lock structure was free()d.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  http-push.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/http-push.c b/http-push.c
> > index b2b410d..7a6c669 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -2398,7 +2398,10 @@ int main(int argc, char **argv)
> >  		fill_active_slots();
> >  		add_fill_function(NULL, fill_active_slot);
> >  #endif
> > -		finish_all_active_slots();
> > +		do {
> > +			finish_all_active_slots();
> #ifdef CURL_MULTI
> > +			fill_active_slots();
> #endif
> > +		} while (request_queue_head && !aborted);
> >  
> >  		/* Update the remote branch if all went well */
> >  		if (aborted || !update_remote(ref->new_sha1, ref_lock)) {
> > -- 
> > 1.5.4.1.1353.g0d5dd
> 
> I wonder if we should define a no-op function fill_active_slots()
> for non MULTI case...

Darn, darn, darn.  Fixing the MULTI case was on my TODO list.

Ciao,
Dscho
