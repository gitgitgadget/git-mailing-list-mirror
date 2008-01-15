From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 13:26:26 +0300
Message-ID: <20080115102626.GE2963@dpotapov.dyndns.org>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de> <12003528401309-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 11:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEj1V-0005yT-LY
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 11:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbYAOK1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 05:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbYAOK1d
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 05:27:33 -0500
Received: from smtp04.mtu.ru ([62.5.255.51]:54055 "EHLO smtp04.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbYAOK1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 05:27:32 -0500
Received: from smtp04.mtu.ru (localhost [127.0.0.1])
	by smtp04.mtu.ru (Postfix) with ESMTP id 97A26823D0E;
	Tue, 15 Jan 2008 13:27:30 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-67.pppoe.mtu-net.ru [85.141.191.67])
	by smtp04.mtu.ru (Postfix) with ESMTP id 31B38825EE3;
	Tue, 15 Jan 2008 13:26:27 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEizy-00024M-NX; Tue, 15 Jan 2008 13:26:26 +0300
Content-Disposition: inline
In-Reply-To: <12003528401309-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp04.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70511>

On Tue, Jan 15, 2008 at 12:20:40AM +0100, Steffen Prohaska wrote:
> 
> I looked briefly at the various places where convert_to_git() is
> called.  I think that only the one code path through index_fd()
> actually writes data to the repsitory.  Maybe someone else with
> a better understanding of git's internals should confirm this.

Your patch is certainly better than my quick hack for git-add,
and perhaps you are right that the check should be done only
when data are written, but it also means that there is no longer
any warning when you are running git diff with the work tree,
which would be useful, because it is what most users do before
adding anything.

However, my real concern is that it seems we have two different
heuristics for binary -- one that is used inside of convert.c
and the other one is buffer_is_binary() in xdiff-interface.c.

So, I am running 'git diff' for some test file, and it says:

diff --git a/foo b/foo
index e965047..c102bdc 100644
Binary files a/foo and b/foo differ

okay, now I want to add this *binary* file, so I run 'git add':

warning: Stripped CRLF from foo.

I imagine a user saying: "What the hell! Why did this stupid Git
strip CRLF from my _binary_ file?"

And the current version of Git, which does not print CRLF warning,
seems to be dangerous, because when 'git diff' told me that it is
a _binary_ file, I expect that Git will put it as *binary*. So,
from the user's point of view, it looks like a bug.

So, I suppose that at least we should make is_binary heuristic in
convert.c more strict than those that is used by diff. Namely, if
there is at least one NUL byte in the buffer, it should be treated
as binary.


Dmitry
