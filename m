From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] make pack-objects a bit more resilient to repo
	corruption
Date: Fri, 22 Oct 2010 11:24:24 -0400
Message-ID: <1287761064.31218.37.camel@drew-northup.unet.maine.edu>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
	 <20101022144600.GA5554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JX1-0008Nx-Pu
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab0JVP1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:27:42 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:57940 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0JVP1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:27:42 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9MFOSkR011453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 11:24:33 -0400
In-Reply-To: <20101022144600.GA5554@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9MFOSkR011453
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288365935.94097@bw9P/dVZniqFGAAXorfnTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159701>


On Fri, 2010-10-22 at 10:46 -0400, Jeff King wrote:
> On Fri, Oct 22, 2010 at 12:53:32AM -0400, Nicolas Pitre wrote:
> 
> > -		if (!src->data)
> > +		if (!src->data) {
> > +			if (src_entry->preferred_base) {
> > +				/* 
> > +				 * Those objects are not included in the
> > +				 * resulting pack.  Be resilient and ignore
> > +				 * them if they can't be read, in case the
> > +				 * pack could be created nevertheless.
> > +				 */
> > +				return 0;
> > +			}
> >  			die("object %s cannot be read",
> >  			    sha1_to_hex(src_entry->idx.sha1));
> > +		}
> 
> By converting this die() into a silent return, are we losing a place
> where git might previously have alerted a user to corruption? In this
> case, we can continue the operation without the object, but if we have
> detected corruption, letting the user know as soon as possible is
> probably a good idea.
> 
> In other words, should this instead be:
> 
>   warning("unable to read preferred base object: %s", ...);
>   return 0;
> 
> Or will some other part of the code already complained to stderr?
> 
> -Peff

Agreed. If it broke we should probably tell the user--even if we can't
do much useful about it other than attempt to recover by continuing.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
