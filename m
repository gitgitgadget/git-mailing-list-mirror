From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/3] http-push: avoid invalid memory accesses
Date: Sat, 16 Feb 2008 09:13:17 +0100
Organization: glandium.org
Message-ID: <20080216081317.GA5350@glandium.org>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site> <alpine.LSU.1.00.0802142325120.30505@racer.site> <7vabm1cqkd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQIAF-0002ui-BT
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbYBPIMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 03:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbYBPIMR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:12:17 -0500
Received: from vuizook.err.no ([85.19.215.103]:41396 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbYBPIMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 03:12:16 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JQI9X-0006iU-TT; Sat, 16 Feb 2008 09:12:14 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JQIAf-0001bD-9Q; Sat, 16 Feb 2008 09:13:17 +0100
Content-Disposition: inline
In-Reply-To: <7vabm1cqkd.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74028>

On Fri, Feb 15, 2008 at 11:23:46PM -0800, Junio C Hamano wrote:
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

Or a #define... but all this slot thing is probably going to change
anyway, when I'll be done with it (but this is not planned for tomorrow).

Mike
