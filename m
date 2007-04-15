From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 16:58:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151652420.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
 <7vfy712uva.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
 <7vhcrh1a2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEc4-00044F-Dz
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbXDOX63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbXDOX63
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:58:29 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39495 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbXDOX63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:58:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FNwPIs030263
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 16:58:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FNwO1I022928;
	Sun, 15 Apr 2007 16:58:25 -0700
In-Reply-To: <7vhcrh1a2w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.452 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44553>



On Sun, 15 Apr 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > Ahh, ok. I was kind of expecting that you'd actually do something at 
> > "receive-pack" time instead, not at the next commit. That would also solve 
> > it - just have an option saying "update the working tree when receiving". 
> 
> I specifically did not want to do that, as it would break
> existing workflow of pushing into a live repository, knowing the
> branch might be checked out at the remote.

Yeah. That said, maybe we could make it an option. There's really a few 
different things we could do:

 (a) what we do now - the working tree and index is totally unaffected
 (b) do a "git-read-tree -m old new" and if that fails, fail the push.
     This would at least ensure the *index* matches
 (b') same as (b), but with "-u" to actually check it out
 (c) do a "git-read-tree --reset new"
 (c') same as (c), but with "-u"

and we could just keep the *default* the same, but allow the receiving 
side to say what it wants to happen.

> Also, the case of multiple working trees sharing the same refs/
> namespace cannot be solved by trapping receive-pack alone.

Right. I think any working-tree thing would have to be conditional on the 
receive being done on a non-bare git repository (obviously) and we'd only 
update the directory that the push was aimed at.

So if somebody does

	git push remote:my-git-tree/.git/

then we'd *always* do (a), since we pushed into the "bare" part, but if 
somebody did

	git push remote:my-git-tree

and the receiver ended up doing a "cd .git", it would remember what the 
checked-out tree was and update that one (and no other).

			Linus
