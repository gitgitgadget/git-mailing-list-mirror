From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Cogito chicken-and-egg problem
Date: Tue, 26 Apr 2005 13:02:22 -0400
Message-ID: <1114534942.26856.10.camel@dv>
References: <Pine.LNX.4.21.0504261229220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:58:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTNH-0000J3-D9
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDZRCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDZRCi
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:02:38 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:23938
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261608AbVDZRCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 13:02:33 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 95A81EFF49; Tue, 26 Apr 2005 13:02:22 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504261229220.30848-100000@iabervon.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Daniel!

On Tue, 2005-04-26 at 12:38 -0400, Daniel Barkalow wrote:

> > Also, the dependency on commit-id was dropped from my patch for some
> > reason.  I believe it's still needed.  Also, we need a dependency on
> > cat-file, which is used by commit-id internally.
> 
> commit-id doesn't really use cat-file; the way it calls gitXnormid.sh

There is gitXnormid.sh in the current cogito.  Please update your tree.

> definitely suppresses that section.

That's not what I see if I remove cat-file but leave commit-id in my
$HOME/bin:

proski@dv:~/src/cogito$ make cg-version
/home/proski/bin/commit-id: line 35: cat-file: command not found
Invalid id: f9f0459b5b39cf83143c91ae39b4eaf187cf678a
Generating cg-version...
proski@dv:~/src/cogito$

> In fact, commit-id with no arguments
> is simply an easy-to-remember way of doing "cat .git/HEAD" using a much
> more complicated script. Earlier, I sent a patch to just do this, since it
> avoids the whole issue.

That would be fine with me.

> (Also, .git/HEAD is a dependancy, since you want to redo the version
> script if you commit; but if you don't have it, that's okay and just means
> you're building from a tarball, which is described completely by VERSION)

It should be a conditional dependency, i.e. it should be a dependency
if .git exists.

It seems to me that the whole idea of including SHA1 in cg-version is
broken.  SHA1 is not human readable.  But if the maintainers insist on
having SHA1 in cg-version, I want it to be done without causing build
warnings for new users.

Here's an alternative patch.

Signed-off-by: Pavel Roskin <proski@gnu.org>

Index: Makefile
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/Makefile  (mode:100644 sha1:4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92)
+++ uncommitted/Makefile  (mode:100644)
@@ -87,12 +87,21 @@
 http-pull: LIBS += -lcurl
 
 
+ifneq (,$(wildcard .git))
+cg-version: $(VERSION) .git/HEAD
+	@echo Generating cg-version...
+	@rm -f $@
+	@echo "#!/bin/sh" > $@
+	@echo "echo \"$(shell cat $(VERSION)) ($(shell cat .git/HEAD))\"" >> $@
+	@chmod +x $@
+else
 cg-version: $(VERSION)
 	@echo Generating cg-version...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@PATH=.:$(PATH) echo "echo \"$(shell cat $(VERSION)) ($(shell commit-id))\"" >> $@
+	@echo "echo \"$(shell cat $(VERSION))\"" >> $@
 	@chmod +x $@
+endif
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)
 	install -m755 -d $(DESTDIR)$(bindir)


-- 
Regards,
Pavel Roskin

