From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Mon, 21 Feb 2011 11:13:21 -0500
Message-ID: <4D628F21.3050808@xiplink.com>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF6E7.8090104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 21 17:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrYO8-0004JT-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 17:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1BUQNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 11:13:23 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:43325 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab1BUQNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 11:13:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id C815F202DC;
	Mon, 21 Feb 2011 11:13:21 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp51.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E78E6206C5;
	Mon, 21 Feb 2011 11:13:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D5FF6E7.8090104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167492>

On 11-02-19 11:59 AM, Jens Lehmann wrote:
> Proposal:
> When switching branches, merging or resetting the work tree of
> populated submodules should be checked out too according to the
> commit recorded in the superproject. Make this the default for
> porcelain and optional for plumbing.
> 
> The same safety precautions that are used for files in the
> superproject apply to the changes present in the submodules,
> no local modifications may be overwritten unless -f is used.
> When the "update" config option is set to "merge" or "rebase"
> the submodule will be left unchanged.
> 
> The "update" config option will learn a new value "none" to let
> the user turn off this behavior for single submodules. A global
> config option and the command line parameter "--recurse-submodules"
> will also be added. This change will remove the need to call "git
> submodule update" for all populated submodules (except those who
> use the "update=merge" or "update=rebase" configuration settings).

A big +1 from me for all the submodule work -- thanks Jens!

Could you clarify the proposal a bit?  A few questions occurred to me as I
read it:

* How is the initial set of populated submodules set up during a clone
operation?  Specifically, how would the origin repo specify which submodules
to recursively clone?  (My understanding is that the origin's .gitmodules
file, as it exists in whatever branch is being cloned, would specify
submodule.<name>.update values, and those would drive the recursion.)

* Which values of submodule.<name>.update would enable/disable recursion
during a clone?  Would just "checkout" enable it, or should "merge" and
"rebase" also trigger recursion when cloning?

* What happens when a clone's user manually populates one of the other
submodules that wasn't part of the initial set?  Automatic recursion into
this newly-populated submodule is controlled by the setting of the global
recurse-submodules option, right?

* What are the possible values of the global recurse-submodules option?
Here's what I came up with:

  all       -- Always recurse
  populated -- Only recurse into *all* currently-populated submodules
  respect   -- Respect each submodule's "update" option (better name?)
  none      -- Never recurse

* What will happen when I start checked out at commit A, with a populated
submodule, then check out commit B where that submodule doesn't exist, then
return to commit A?  How will whatever recursion settings I had at the start
be preserved?

		M.
