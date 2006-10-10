From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 08:03:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 17:05:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXJ9F-0001Ff-7p
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 17:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWJJPD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 11:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWJJPD6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 11:03:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbWJJPD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 11:03:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9AF3taX026500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 08:03:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9AF3sVM011331;
	Tue, 10 Oct 2006 08:03:55 -0700
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <20061010102210.568341380D6@magnus.utsl.gen.nz>
X-Spam-Status: No, hits=-2.466 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28634>



On Tue, 10 Oct 2006, Sam Vilain wrote:
>
> If using git-repack -a, unreferenced objects are kept behind in the
> pack.  This might be the best default, but there are no good ways
> to clean up the packfiles if a lot of rebasing is happening, or
> branches have been deleted.

Don't do this.

I understand why you want to do it, but the fact is, it's dangerous.

Right now, "git repack" is actually safe to run even on a repository which 
is being modified! And that's actually important, if you have something 
like a shared repo that gets re-packed every once in a while from a 
cron-job!

So the refs might be up-dated as it runs, and if that happens, your 
pruning doesn't really do the right thing - it might consider a new loose 
object to be unreachable, because it didn't check whether the refs have 
changed since it read them so that it might actually _be_ reachable after 
all.

So please don't do this. 

It's important for operations to always think about "what happens if 
somebody does a 'commit' or pushes into the tree at the same time?".

For example, the "git prune-packed" that gets run afterwards is _not_ 
racy, because it will only prune objects that already exist in the pack.

		Linus
