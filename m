From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Sat, 04 Aug 2007 12:03:28 -0400
Message-ID: <46B4A350.9060806@tromer.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>	<7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>	<20070801140532.GC31114MdfPADPa@greensroom.kotnet.org> <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, Sven Verdoolaege <skimo@kotnet.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHM6Z-0002vf-4X
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbXHDQDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbXHDQDt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:03:49 -0400
Received: from rozz.csail.mit.edu ([128.30.2.16]:46824 "EHLO
	rozz.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbXHDQDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:03:48 -0400
Received: from c-66-30-26-80.hsd1.ma.comcast.net ([66.30.26.80] helo=moby.tromer.org)
	by rozz.csail.mit.edu with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <git2eran@tromer.org>)
	id 1IHM6H-0008PK-Cq; Sat, 04 Aug 2007 12:03:33 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54872>

On 2007-08-04 01:13, Junio C Hamano wrote:
> Let me understand the problem first.  If your first checkout
> does not check out the submodule, switching between revisions
> that has different commit of the submodule there would not fail,
> but once you checkout the submodule, switching without updating
> the submodule would be Ok (because by design updating the
> submodule is optional) but then further switching out of that
> state will fail because submodule in the supermodule tree and
> checked-out submodule repository are now out of sync.  Is that
> the problem?
> 
[snip]

> Where does the "No you are not up-to-date, I wouldn't let you
> switch" come from?  Is that verify_uptodate() called from
> merged_entry() called from twoway_merge()?  I think the right
> approach to deal with this is to teach verify_uptodate() about
> the policy.  The function is about "make sure the filesystem
> entity that corresponds to this cache entry is up to date, lest
> we lose the local modifications".  As we explicitly allow
> submodule checkout to drift from the supermodule index entry,
> the check should say "Ok, for submodules, not matching is the
> norm" for now.  Later when we have the ability to mark "I care
> about this submodule to be always in sync with the superproject"
> (thereby implementing automatic recursive checkout and perhaps
> diff, among other things), we should check if the submodule in
> question is marked as such and perform the current test.
> 
> How about doing something like this instead?
> 
>  unpack-trees.c |    9 +++++++++

Works here: it silences the check and allows switching branches. Still,
leaving the working tree dirty can inadvertently affect subsequent
commits. Consider the most ordinary of sequences:

$ git checkout experimental-death-ray
$ git submodules update
(return a week later, woozy from the vacation.)
$ git checkout master
(hack hack hack)
$ git commit -a -m "fixed typos"
$ git push
(Oops. You've just accidentally committed the wrong submodule heads.)

So to safely make new commits you must remember to always run "git
submodule update", or forgo use of "git commit -a", whenever submodules
might be involved.

I guess you can hack around this by excluding submodules from "commit
-a" and (for scripts) "ls-files -m" too...

Another approach is for pull, checkout etc. to automatically update the
submodule' head ref, but no more. In this case the supermodule always
sees a consistent state with traditional semantics, but the *submodule*
ends up with a dirty working tree and a head referring to a
possibly-missing commit; "git submodule update" would need to clean that up.

  Eran
