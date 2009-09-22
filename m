From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: Wed, 23 Sep 2009 09:30:00 +1000
Message-ID: <19129.24056.422939.880134@cargo.ozlabs.ibm.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
	<19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	<6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	<4AB78910.7010402@viscovery.net>
	<6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	<4AB7A2E7.5000601@viscovery.net>
	<874oqvc0n3.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy, John" <john.murphy@bankofamerica.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Sep 23 01:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqEoJ-0000SG-IQ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 01:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbZIVXaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbZIVXaE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 19:30:04 -0400
Received: from ozlabs.org ([203.10.76.45]:55336 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbZIVXaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 19:30:03 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id CBABAB7B81; Wed, 23 Sep 2009 09:30:05 +1000 (EST)
In-Reply-To: <874oqvc0n3.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128961>

Pat Thoyts writes:

> That script gives me a repository I can test against. thanks.
> The start_rev_list function calls parseviewrevs and expands the
> arguments into a list of appropriate revision ids. In this case --all
> gets expanded to a list of 1000 sha1 ids. This is appended to any
> other view arguments and passed to git log on the command line
> yielding our error.
> git log can accept a --all argument it seems so it looks like we can
> just short-circuit the parseviewrevs function when --all is passed in
> and return --all instead of expanding the list. The following seems to
> work for me with this test repository.

What the code is trying to do here is to get git log to give us all
the commits that the user asked for *except* any commits we have
already received.  So, when gitk is first invoked, this means all the
commits that the user asked for.  If the user presses F5 or does
File->Update, then we do git log with some starting points removed
(those that haven't changed since the last update) and some negative
arguments added (to exclude the previous starting points).

To do that accurately, we need to know exactly what set of revisions
we are asking git log to start from, and exactly what set of revisions
we are asking git log to stop at.  The problem with just passing --all
to git log, as your patch does, is that the list of revs might change
between when gitk expands --all and when git log expands --all (due to
commits getting added, heads getting reset etc.).  Then, if the user
presses F5, some commits might get missed.

If git log had an argument to tell it to mark those commits that were
a starting point or a finishing point, then I could simplify this
logic enormously, plus we wouldn't have to pass a long parameter list
to git log.  It may still turn out to be necessary to add a negative
argument for each previous starting point, though, when refreshing the
list.

I think the simplest fix for now is to arrange to take the
non-optimized path on windows when the list of revs gets too long,
i.e., set $vcanopt($view) to 0 and take that path.  That means that
refreshing the view will be slow, but I think it's the best we can do
at this point.

Paul.
