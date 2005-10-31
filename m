From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git push sends more objects than it needs to
Date: Mon, 31 Oct 2005 10:44:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311035310.27915@g5.osdl.org>
References: <20051031182355.GA7368@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 19:47:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWedj-0006YM-PB
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 19:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVJaSoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 13:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVJaSoN
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 13:44:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932452AbVJaSoM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 13:44:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VIi4sC027446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 10:44:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VIi2bk020201;
	Mon, 31 Oct 2005 10:44:02 -0800
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <20051031182355.GA7368@agluck-lia64.sc.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10872>



On Mon, 31 Oct 2005, Luck, Tony wrote:
> 
> Finally, after making sure that release and test
> branches still built with all the new stuff I did
> a "git push" to update my kernel repo.  I saw this:
...
> Packing 10785 objects
> Unpacking 10785 objects
> 
> Now the "unpack" on kernel.org did the right thing and noticed
> that over 9000 of the objects were already in the packfile.  But
> I wonder if it couldn't have been smarter and not sent them?

It should have been smarter, but I suspect you got caught by the fact that 
kernel.org by default has git-0.99.8f on it, which has the old 
pre-multi_ack code to figure out what the common commit was.

The pack-file contains over ten times as many objects, so you definitely 
didn't get all of them - but because there has been a lot of merges 
lately, and the common commit finder algorithm wasn't all that careful, 
you ended up getting many more objects than you really needed.

Remember: the pack generation is not "exact" - it will often generate a 
few extra objects for any non-trivial case (for example, it fundamentally 
happens if there has been reverts: it won't realize that you had the older 
version of a file already). It just so happens that the old algorithm had 
some cases where it would decide on totally the wrong common commit, and 
re-send a _lot: more objects than it needs.

I'm not sure multi-ack fixes it entirely either, but I think it makes it a 
lot less likely (but even with multi-ack, the "file revert" case still 
happens, so you should always expect that can get a _couple_ of 
unnecessary objects).

Now, even the old stupid algorithm got the _easy_ cases obviously right, 
so people might have incorrectly gotten the idea that it was careful and 
exact, just because quite often it ends up being that in practice.

		Linus
