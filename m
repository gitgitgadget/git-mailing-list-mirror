From: Mike Hommey <mh@glandium.org>
Subject: Re: git-http-fetch segfault, curl 7.18.0
Date: Sun, 2 Mar 2008 21:33:44 +0100
Organization: glandium.org
Message-ID: <20080302203344.GA8760@glandium.org>
References: <20080302190857.11027.qmail@28c5bbafb32cb2.315fe32.mid.smarden.org> <20080302192355.GA625@glandium.org> <20080302200309.GA2070@glandium.org> <alpine.LNX.1.00.0803021508340.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 21:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVupN-0008CC-UP
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 21:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbYCBU34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbYCBU34
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 15:29:56 -0500
Received: from vuizook.err.no ([194.24.252.247]:40225 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755139AbYCBU34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 15:29:56 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVuod-0007DT-Mb; Sun, 02 Mar 2008 21:29:54 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVusS-0002LA-FT; Sun, 02 Mar 2008 21:33:44 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0803021508340.19665@iabervon.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75836>

On Sun, Mar 02, 2008 at 03:20:17PM -0500, Daniel Barkalow wrote:
> > And the problem lies in the fact we run_active_slot() during cleanup,
> > which can end up going through all the slots starting at
> > active_queue_head, while we have freed the first slots...
> > 
> > Now, why do we need to run slots when cleaning up ?
> 
> AFAICT, it's always been that way. I assume there was code that set up all 
> of the remaining transfers and then just called http_cleanup, relying on 
> the callbacks to handle the receipt of the remaining data, but I'm not 
> sure if that's still the case.

It doesn't look like it is stil the case.

> On the other hand, I think that code is 
> supposed to remove slots from the active queue as they get processed, so 
> that run_active_slot() is always safe to call and just won't do anything 
> if it's not needed in cleanup.
> 
> So I'm guessing that we have list corruption due to code getting careless 
> in error cases, in addition to cleanup code that possibly cares too much 
> about finishing everything it can.

That's in fill_active_slots that it's trying to go through all slots
starting at active_queue_head, which is likely to be freed at this
point. The fix I sent earlier just throws all active slots, which should
just be fine now.

Mike
