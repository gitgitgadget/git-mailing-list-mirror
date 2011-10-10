From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Mon, 10 Oct 2011 21:53:26 +0200
Message-ID: <20111010195325.GA5981@sandbox-rc>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
 <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
 <4E918194.5060102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 10 21:53:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDLum-0001hT-Pj
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 21:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab1JJTx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 15:53:28 -0400
Received: from darksea.de ([83.133.111.250]:48522 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752810Ab1JJTx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 15:53:27 -0400
Received: (qmail 29269 invoked from network); 10 Oct 2011 21:53:25 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 10 Oct 2011 21:53:25 +0200
Content-Disposition: inline
In-Reply-To: <4E918194.5060102@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183252>

Hi Michael,

On Sun, Oct 09, 2011 at 01:12:20PM +0200, Michael Haggerty wrote:
> On 08/17/2011 12:45 AM, Junio C Hamano wrote:
> > All the changes except for this one made sense to me, but I am not sure
> > about this one. How often do we look into different submodule refs in the
> > same process over and over again?
> 
> I am having pangs of uncertainty about this patch.

Currently when doing a 3 way merge of submodule hashes and we find a
conflict. We then use this api to look into the submodule to search for
commit suggestions which contain both sides.

If there are multiple submodules that conflict in this way we look into
those as well.

Since the setup_revision() api can currently not be used to safely
iterate twice over the same submodule my patch

	allow multiple calls to submodule merge search for the same path

rewrites the search into using a child process. AFAIK the submodule ref
iteration api would then even be unused.

> Previous to this patch, the submodule reference cache was only used for
> the duration of one call to do_for_each_ref().  (It was not *discarded*
> until later, but the old cache was never reused.)  Therefore, the
> submodule reference cache was implicitly invalidated between successive
> uses.

The implicit discarding was just done because it was the quickest way to
get a handle on submodule refs from the main process. There was no need
that they get reloaded every time.

> After this change, submodule ref caches are invalidated whenever
> invalidate_cached_refs() is called.  But this function is static, and it
> is only called when main-module refs are changed.
> 
> AFAIK there is no way within refs.c to add, modify, or delete a
> submodule reference.  But if other code modifies submodule references
> directly, then the submodule ref cache in refs.c would become stale.
> Moreover, there is currently no API for invalidating the cache.
> 
> So I think I need help from a submodule guru (Heiko?) who can tell me
> what is done with submodule references and whether they might be
> modified while a git process is executing in the main module.  If so,
> then either this patch has to be withdrawn, or more work has to be put
> in to make such code invalidate the submodule reference cache.

At least in my code there is no place where a submodule ref is changed.
I only used it for merging submodule which only modifies the main
module. So I would say its currently safe to assume that submodule refs
do not get modified. If we do need that later on we can still add
invalidation for submodule refs.

Cheers Heiko
