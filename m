From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: BUG: rebase -p after cherry-pick does not work
Date: Mon, 18 Feb 2008 15:06:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181458300.30505@racer.site>
References: <47B990FC.9090600@b-i-t.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: sf <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 16:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR7ab-0006LY-UF
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 16:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYBRPGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757578AbYBRPGb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 10:06:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:43410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757503AbYBRPGa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 10:06:30 -0500
Received: (qmail invoked by alias); 18 Feb 2008 15:06:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 18 Feb 2008 16:06:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gF/xSY7ogSyO9lLHvw+tnJMm+yz0gmqK4xA1SVv
	dYS0pjqzQwE50K
X-X-Sender: gene099@racer.site
In-Reply-To: <47B990FC.9090600@b-i-t.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74301>

Hi,

On Mon, 18 Feb 2008, sf wrote:

> git-rebase -p does not work when one of the changes is cherry-picked
> before rebase.
>
> [...]
> 
> The problem area is function pick_one_preserving_merges in
> git-rebase--interactive.sh:
> 
> [...]
>
> If a commit's parent is not applied during rebase (e.g. because it was 
> cherry-picked already) then it is not rewritten either.

That is right.  How about giving it a try yourself?

Hints: you need to write a sha-1 to "$REWRITTEN"/<commit> for every commit 
that was _not_ cherry-picked.  To do this, you could run the same rev-list 
as for $TODO, but without the --cherry-pick, and then filter with

	(cat "$TODO" "$TODO" "$ALLCOMMITS") | sort | uniq -u

For these commits, you need to find the ones with the same patch-id, but 
which are upstream.  You can achieve that by calling "git patch-id" for 
each upstream commit that was not in the to-be-rebased branch, and storing 
those mappings in a file.  Then, for each leftout commit, you grep in that 
file, and write to "$REWRITTEN"/<orig-commit>.

Oh, and you have to warn or error if there are two or more commits with 
the desired patch-id.

Alternatively, you can wait until Daniel has rewritten 
git-rebase--interactive in C, which shouldn't be too long, and work on 
that.  Should be easier and more efficient, too.

Ciao,
Dscho
