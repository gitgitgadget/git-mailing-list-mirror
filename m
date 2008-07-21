From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 21 Jul 2008 15:57:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807211546590.3007@woody.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <8C23FB54-A28E-4294-ABEA-A5766200768B@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 00:59:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL4LP-000765-JU
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 00:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYGUW6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 18:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYGUW6B
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 18:58:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751405AbYGUW6A (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2008 18:58:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6LMvwhH002620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2008 15:57:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6LMvwG6029497;
	Mon, 21 Jul 2008 15:57:58 -0700
In-Reply-To: <8C23FB54-A28E-4294-ABEA-A5766200768B@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.403 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89415>


[ git channel added back to cc, because this is an interesting question in 
  itself ]

On Mon, 21 Jul 2008, Tim Harper wrote:
> 
> Another false impression I had is a merge conflict resolution would always be
> displayed in a merge commit.  However, after running over the merges again, if
> you pick the right or left, discarding the one or the other, nothing is shown
> in "git log -p" for the merge commit.  Is there a way to see what was chosen
> for a conflict resolution?  Seeing that in the merge commit would have made
> things a little more clear.

The default behavior for showing merges is "--cc", which is the condensed 
version that only shows _actual_ conflicts that got resolved differently 
from either of the sources.

But note how this is an "after-the-fact" determination: it doesn't look 
whether the merge _did_ conflict (because doing that would require 
re-running the whole merge!), but it looks whether the end _result_ is 
different from either side.

So you can easily have a merge that conflicts - but then you resolve that 
merge by picking just one side of the merge as the result. And in that 
case the "--cc" diff will not show anything at all - because the end 
result did not conflict with the sources of the merge!

So "--cc" only shows output if: the merge itself actually changed 
something from _all_ parents. This can happen if:

 - there was a non-trivial conflict, and the end result really was a 
   "mixture" of the two. The result wasn't just a select of either side, 
   it was a combination of the two.

   This is obviously one "common" case for a merge resolution.

   But it's equally common that when you merge something you just say "Ok, 
   that other side did it better, I'll just pick that version". And in 
   that case, "--cc" won't show anything at all, because it's not really a 
   conflict any more once you've done that choice.

 - There can also be an "evil merge" that actually adds/changes/deletes 
   code that didn't exist AT ALL in either side. And --cc is very much 
   designed to show that.

   This is actually not always a bad thing (despite the name "evil 
   merge"), because it happens regularly that one branch had changed some 
   infrastructure setup or other, and the other branch had added a totally 
   new use of that infrastructure - and as a result the _merge_ needs to 
   add that setup code that didn't exist in either of the branches (in one 
   because the use wasn't there, in the other because the setup wasn't 
   needed).

Anyway, this all means that yes, "--cc" _often_ shows conflicts, but not 
always - exactly because it doesn't show the ones that the merge had 
committed as a non-conflict.

If you actually want to see the _real_ conflicts that happened as the 
merge was done, you do have to re-do it. 

		Linus
