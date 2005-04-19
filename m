From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:38:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:33:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1HJ-0006OH-II
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDSWgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVDSWgs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:36:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:52671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261707AbVDSWgh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:36:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JMaQs4024256
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 15:36:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JMaJc7003912;
	Tue, 19 Apr 2005 15:36:22 -0700
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <426583D5.2020308@mesatop.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Steven Cole wrote:
>
> But perhaps a progress bar right about here might be
> a good thing for the terminally impatient.
> 
> real    3m54.909s
> user    0m14.835s
> sys     0m10.587s
> 
> 4 minutes might be long enough to cause some folks to lose hope.

Well, the real operations took only 15 seconds. What kind of horribe 
person are you, that you don't have all of the kernel in your disk cache 
already? Shame on you.

Or was the 4 minutes for downloading all the objest too?

Anyway, it looks like you are using pasky's scripts, and the old 
"patch-based" upgrade at that. You certainly will _not_ see the

	[many files patched]
	patching file mm/mmap.c
	..

if you use a real git merge. That's probable be the real problem here.

Real merges have no patches taking place _anywhere_. And they take about 
half a second. Doing an "update" of your tree should _literally_ boil down 
to

	#
	# "repo" needs to point to the repo we update from
	#
	rsync -avz --ignore-existing $repo/objects/. .git/objects/.
	rsync -L $repo/HEAD .git/NEW_HEAD || exit 1
	read-tree -m $(cat .git/NEW_HEAD) || exit 1
	checkout-cache -f -a
	update-cache --refresh
	mv .git/NEW_HEAD .git/HEAD

and if it does anything else, it's literally broken. Btw, the above does
need my "read-tree -m" thing which I committed today.

(CAREFUL: the above is not a good script, because it _will_ just overwrite 
all your old contents with the stuff you updated to. You should thus not 
actually use something like this, but a "git update" should literally end 
up doing the above operations in the end, and just add proper checking).

And if that takes 4 minutes, you've got problems.

Just say no to patches. 

		Linus

PS: If you want a clean tree without any old files or anything else, for
that matter, you can then do a "show-files -z --others | xargs -0 rm", but
be careful: that will blow away _anything_ that wasn't revision controlled
with git. So don't blame me if your pr0n collection is gone afterwards.
