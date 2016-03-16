From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Can't git stash after using git add -N
Date: Wed, 16 Mar 2016 05:02:45 -0700
Message-ID: <20160316120245.GA15091@cloud>
References: <20160315230754.GA12058@cloud>
 <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
 <20160316020000.GB12130@cloud>
 <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:03:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAAG-00018G-3I
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966637AbcCPMCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:02:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54657 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965816AbcCPMCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:02:49 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5828EA80D2;
	Wed, 16 Mar 2016 13:02:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288962>

On Tue, Mar 15, 2016 at 09:51:35PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > As far as I can tell, if I run "git add -N" on a file, and then commit
> > without adding the file contents, it gets committed as an empty file.
> 
> Is that true?  Git once worked like that in earlier days, but I
> think write-tree (hence commit) would simply ignore intent-to-add
> entries from its resulting tree.

Git 2.7.0 does appear to commit an empty file if I commit after git add
-N.

> > Could stash save it exactly as if I'd done "git add" of an empty file at
> > that path and then filled in the contents without adding them?
> 
> As I said, there is no space for a tree object to say "this one
> records an empty blob but it actually was an intent-to-add entry"
> and "this other one records an empty blob and it indeed is an empty
> blob".  So "stash pop" (or "stash apply") would fundamentally be
> unable to resurrect the exact state after "add -N".

How completely crazy would it be to use a non-standard mode bit for
that?

> >> "git rm --cached" the path and then running "stash save" would be a
> >> workaround, but then you'd probably need to use "--untracked" hack
> >> when you run "stash save" if you are stashing because you are going
> >> to do something to the same path in the cleaned-up working tree.
> >
> > Right; I do specifically want to save the working-tree files.
> 
> Then "git add" that path before "stash save" would probably be a
> better workaround.

I ended up using rm --cached and stash -u, which worked OK, though I
then had to manually restore the add -N state.
