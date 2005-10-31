From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git push sends more objects than it needs to
Date: Mon, 31 Oct 2005 11:36:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311119170.27915@g5.osdl.org>
References: <20051031182355.GA7368@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0510311035310.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:38:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWfS7-0005GM-Lf
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 20:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVJaTgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVJaTgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 14:36:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbVJaTgP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 14:36:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VJaCsC005724
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 11:36:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VJa9uW022673;
	Mon, 31 Oct 2005 11:36:11 -0800
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <Pine.LNX.4.64.0510311035310.27915@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10876>



On Mon, 31 Oct 2005, Linus Torvalds wrote:
> > 
> > Now the "unpack" on kernel.org did the right thing and noticed
> > that over 9000 of the objects were already in the packfile.  But
> > I wonder if it couldn't have been smarter and not sent them?
> 
> It should have been smarter, but I suspect you got caught by the fact that 
> kernel.org by default has git-0.99.8f on it, which has the old 
> pre-multi_ack code to figure out what the common commit was.

Oh, actually, I take that back.

This is not the multi-ack code at all, I suspect.

The problem is totally different: you copied the new pack to your 
master.kernel.org repository, but you never updated any branches there.

So you had the objects, but git had no way of knowing. The pack generation 
doesn't look at what _objects_ you have, it looks at what _refs_ you have. 
And your refs were all to the old state.

So git actually did everything right (you can never rely on objects: you 
may have a partial object list due to some earlier incomplete pull/push). 

This is actually easy enough to fix up in one of several ways:

 a) The "don't do that then" approach:

    Don't go behind git's back and add objects on your own, and expect git 
    to realize what you did. ;^p

 b) The "live with it" approach:

    You copied the pack by hand, and that will keep git-unpack-objects 
    from duplicating the objects, but you'll still waste time and network 
    when trying pushing the objects (just once, though).

    Ie this is what happened this time: nothing really lost, and the end 
    result is fine. Now you know why it happened, and you're fine.

 c) The "I'm smarter than git" approach:

    When you copy my objects, copy my reference to the top-of-tree too 
    (and rename it). NOTE! Now you need to be really careful, and you need 
    to make sure you copy _all_ the objects, because if you screw this up, 
    your repo will be missing objects that you claim are there, and it 
    will be all your fault.

    I really don't advocate this approach at all. It's certainly doable, 
    but it's also the only approach where you can really screw up.

 d) Just let git do it for you.

    Copy the pack-files, or add my object directory as an "alternates" for 
    your object directory, do the "git prune-objects", and then _locally_ 
    on master.kernel.org just do something like

	git fetch ..linus-directory.. master:linus

    which will still create the unnecessary pack-file and unpack it into 
    nothingness (since you have the objects in the pack-file you copied by 
    hand), but at least it won't eat any network bandwidth, and it will do 
    the right thing if it turns out that I've pushed something after doing 
    the pack-file, and fetch those individual objects in _addition_ to the 
    pack-file you snarfed by hand. It will also obviously update a ref in
    your tree (the "linus" branch), so now when you send stuff later, it 
    will know all about the objects you already have.

 e) Re-create the tree entirely

    Blow away your tree on master entirely, just re-create it locally with 
    "git clone -l -s" from my tree (which will do all the "alternates" 
    object files for you), and then populate the result with a simple push
    from your home tree.

 f) any number of variations on a theme. IOW, there are endless ways to do 
    this. 

Hmm?

		Linus
