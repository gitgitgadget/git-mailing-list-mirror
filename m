From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 4/5] pack-objects: avoid reading uninitalized data
Date: Thu, 23 Oct 2008 11:33:30 -0400
Message-ID: <20081023153329.GC10804@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net> <20081022203103.GD4547@coredump.intra.peff.net> <alpine.LFD.2.00.0810222107540.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 17:35:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt2D2-0006dz-Pl
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 17:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYJWPdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYJWPdd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 11:33:33 -0400
Received: from peff.net ([208.65.91.99]:3963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYJWPdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 11:33:32 -0400
Received: (qmail 10311 invoked by uid 111); 23 Oct 2008 15:33:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 11:33:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 11:33:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810222107540.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98973>

On Wed, Oct 22, 2008 at 09:11:16PM -0400, Nicolas Pitre wrote:

> >  	for (;;) {
> > -		struct object_entry *entry = *list++;
> > +		struct object_entry *entry;
> >  		struct unpacked *n = array + idx;
> >  		int j, max_depth, best_base = -1;
> >  
> > @@ -1384,6 +1384,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
> >  			progress_unlock();
> >  			break;
> >  		}
> 
> ---> Please preserve the empty line here so the previous code
>      chunk still appears logically separate.
> 
> > +		entry = *list++;
> >  		(*list_size)--;
> >  		if (!entry->preferred_base) {
> >  			(*processed)++;

Er, there was no empty line there (or else there would have been a '-'
line in the diff). I am happy to add it, like:

  if (!*list_size) {
    progress_unlock();
    break;
  }

  entry = *list++;
  (*list_size)--;
  if (!entry->preferred_base)
    ...

if you like, but the current version seems to format it as one stanza
inside of the progress_lock/progress_unlock. Look at the version in
'master' to see what I mean.

-Peff
