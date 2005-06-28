From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 09:45:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506280921480.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
 <20050628103852.GB21533@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 18:37:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnJ5V-00080a-W7
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 18:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVF1QoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVF1QoS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 12:44:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261506AbVF1Qnd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 12:43:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SGhQjA031024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 09:43:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SGhNxU012615;
	Tue, 28 Jun 2005 09:43:25 -0700
To: Christopher Li <git@chrisli.org>
In-Reply-To: <20050628103852.GB21533@64m.dyndns.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Christopher Li wrote:
>
> That is all nice improvement to address the space usage issue.
> 
> Should people just run repacking once a while or is it automaticly
> add new object to the pack file?

While adding a new object to a pack file is _possible_ (you add it to the
end of the pack-file, and re-generate the index file), I would strongly
suggest against it for several reasons:

 - It's a lot more complex and expensive than just writing a new file.  
   Much better to make the pack generation be an off-line thing, and make 
   new object creation really cheap.

 - it has serious locking issues, and if something goes wrong you are just 
   horribly screwed. This implies, for example, that to be safe you really 
   have to use fsync() etc at every point (and be careful about writing 
   the index), making the update even _more_ expensive. Over NFS you need 
   to be extremely careful to make sure that everybody got the right lock, 
   yadda yadda.

   Packing things off-line just means that _all_ of these problems go 
   away.

 - There are operations that want to remove objects (I do that all the 
   time: I do something stupid, and decide to undo it, or I just do a 
   "git-update-cache" and notice that I need to do more work so I edit it 
   some more and actually never commit the first version)

   If _adding_ to the file had some serious correctness issues, _removing_ 
   an object from a file is even worse. MUCH worse. Now you don't just 
   have to lock against other people creating new objects, now you have to 
   lock against updates (or totally re-write the whole big file and do an 
   atomic "rename").

 - it can actually generate worse packing. The current "offline" method 
   means that we can pack any version of a file against any other version 
   of a file, and we do. We pick the closest version we can find, and we 
   try to always pack against the bigger one (deletes are smaller deltas, 
   and the biggest one tends to be the latest version, so this not only
   means that the delta is denser, it also means that the latest version -
   which is likely to be the biggest and most often used - tends to be
   non-delta).

   In contrast, updating the pack file means that you always write the 
   latest version as a delta, which means that you're doing things 
   _exactly_ the wrong way around both for performance and size.

 - Finally: packing allows us to do optimize for locality. In particular, 
   I write out the pack file in "recency" order, ie the top-most objects 
   go first, and in particular, the "commit" objects go at the very top of 
   the file. Why? Because it means that the commit objects (which are 
   heavily used for the history generation by pretty much anything, since 
   "git-rev-list" will access them) are packed together, and in the right 
   order.

   Again, you can't do that if you do on-line updates as opposed to 
   offline packing.

So the usage pattern I envision is to pack stuff maybe once a month
(depending on how much changes, of course), because then you really do get
the best of both worlds: the simplicity of individual objects for recent
work and the optimal packing and ordering that you can really work on for
the longer range case. And your project never grows very big.

Btw, I'm not claiming that my current pack format is "optimal" of course.  
For example, while I write all objects in recency order, right now that
means that if a recent object has been written as a delta that depends on
an older one, I actually write the delta first (correct) but I won't write
the older object until its recency ordering (wrong).

That kind of thing is trivial to fix (eventually), but it's an example of
where ordering matters (ie if it's the other way around: the delta is the
older object, it's probably better to leave it at the end of the file,
since it's probably not going to be accessed much, making the effective
packing at the head more efficicient). It's also an example of the kinds
of things we can do exactly because we're doing the packing off-line.

			Linus
