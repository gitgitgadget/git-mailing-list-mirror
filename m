From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 08:06:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 17:07:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrFui-00085N-2t
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 17:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWFPPHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWFPPHE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 11:07:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751434AbWFPPHC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 11:07:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5GF6xgt007452
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jun 2006 08:06:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5GF6wlF020153;
	Fri, 16 Jun 2006 08:06:58 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21944>



On Fri, 16 Jun 2006, Jon Smirl wrote:
> 
> I am spending over 40% of the time in the kernel. This looks to be
> caused from forks and starting small tasks, is that the correct
> interpretation?

Yes. Your kernel profile is all for stuff related to setting up and 
tearing down process space (well, __mutex_lock_slowpath at 1.88% and 
__d_lookup at 1.3% is not, but every single one before that does seem to 
be about fork/exec/exit).

I think it's both the CVS server that continually forks/exits (it doesn't 
actually do a exec at all - it seem sto be using fork/exit as a way to 
control its memory usage - knowing that the OS will free all the temporary 
memory on exit - I think the newer CVS development trees don't do this, 
but that also seems to be why they leak memory like mad and eventually run 
out ;).

AND it's git-cvsimport forking and exec'ing git helper processes. 

So that process overhead is expected.

What I would _not_ have expected is:

>   933646  2.0983 /usr/local/bin/git-read-tree

I don't see why git-read-tree is so hot for you. We should never need to 
read a tree when we're importing something, unless there are tons of 
branches and we switch back and forth between them.

I guess mozilla really does use a fair number of branches? 

Martin sent out a patch (that I don't think has been merged yet) to avoid 
the git-read-tree overhead when switching branches. Look for an email with 
a subject like "cvsimport: keep one index per branch during import", I 
suspect that would speed up the git part a lot.

(It will also avoid a few fork/exec's, but you'll still have most of them, 
so I don't think you'll see any really _fundamental_ changes to this, but 
the git-read-tree overhead should be basically gone, and some of the 
libz.so pressure would also be gone with it. It should also avoid 
rewriting the index file, so you'd get lower disk pressure, but it looks 
like none of your problems are really due to IO, so again, that probably 
won't make much of a difference for you).

			Linus
