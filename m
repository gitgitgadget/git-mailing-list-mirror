From: Chris Wright <chrisw@osdl.org>
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 14:03:09 -0700
Message-ID: <20050711210309.GT5324@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 00:01:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6Ks-00034J-Ka
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVGKWAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVGKV6o
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 17:58:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62376 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262729AbVGKVDR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 17:03:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BL3AjA022271
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 14:03:10 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BL39h7031895;
	Mon, 11 Jul 2005 14:03:09 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j6BL39k7031894;
	Mon, 11 Jul 2005 14:03:09 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> > 
> > A couple of pieces.  The dist target has assumes git-tar-tree is in the
> > path.  Making it so you have to have git installed to build the rpm.
> 
> Yes. Maybe we could relax that requirement by using "./git-tar-tree" or 
> something? That still requires that you have _built_ git to do the rpm, 
> but at least you won't have had to install it.
> 
> Does that fit the rpm build process? Or does an rpm build make something 
> like that really inconvenient? I don't know, patches welcome.

No, that could be done.  It's not the rpmbuild at that point, it's just
prepping to do the rpmbuild.  It's only an issue for those that are trying
to build an rpm directly from the git source and who've never installed
git before.  Doesn't seem necessary to me, I'm not that fond of it (will
even slightly slow down make dist process if it's done from a clean,
i.e. make clean, dir), but hey...the trivial patch below does this.

> > And it does not pass my torture test of building rpm's on debian,
> > but that is not a huge problem.
> 
> Ok, why is debian problematic? Is there some missing dependency or 
> something? I really haven't ever done an rpm, and the git rpm target was 
> all done by Chris Wright, so I don't have any clue at all. Again, patches 
> welcome.

Heh debian rpm build...I missed that bit in Eric's message.  Eric, care
to give details?

thanks,
-chris
--



Use git-tar-tree directly from git source during make dist.  This
handles bootstrap issue with git not being installed.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -175,8 +175,8 @@ git.spec: git.spec.in
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
-dist: git.spec
-	git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
+dist: git.spec git-tar-tree
+	./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec $(GIT_TARNAME)
 	tar rf $(GIT_TARNAME).tar $(GIT_TARNAME)/git.spec
