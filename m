From: Johan Herland <johan@herland.net>
Subject: Re: Relative submodule URLs vs. clone URL DWIMming
Date: Fri, 29 Aug 2008 01:01:19 +0200
Message-ID: <200808290101.20048.johan@herland.net>
References: <200808271400.54302.johan@herland.net> <48B6BB49.3000703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqVd-0004MO-Lf
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbYH1XB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbYH1XB2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:01:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:62759 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbYH1XB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:01:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6C0010B2MDK600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 29 Aug 2008 01:01:25 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6C001DW2M83M40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 29 Aug 2008 01:01:20 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6C00IG62M84620@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 29 Aug 2008 01:01:20 +0200 (CEST)
In-reply-to: <48B6BB49.3000703@gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94197>

On Thursday 28 August 2008, Mark Levedahl wrote:
> Johan Herland wrote:
> > I'd like to fix this, but I'm not sure whether the fix belongs in
> > builtin-clone.c (i.e. making sure the origin URL is always "correct"
> > wrt. resolving relative submodule URLs), or in git-submodule.sh (i.e.
> > adding smarts when resolving relative submodule URLs against the
> > super-repo's origin URL).
>
> I think the right approach is to start with clone and make it record the
> real url it is using, regardless of what was input. The problem with
> doing this in submodule is that in effect this replicates the search
> logic clone would use, and furthermore could lead to nasty surprises by
> grabbing the wrong submodule in an extreme case of having two
> identically named repositories in different locations on a server.

Thanks for your input. I looked into builtin-clone, and how to make it write
the real origin URL for remote repos (it already does this today for local
repos). But AFAICS, there's no way to get this information from the
transport layer. I assume that the actual repo location is resolved on the
remote side, and simply not communicated back to the local side.

Also, after thinking some more about this, I'm unsure of the practical
implications of this. Let's assume we can actually make "git clone" write
the real URL in all cases (i.e. typically "repo.git" for bare repos
and "repo/.git" for non-bare repos):

If we simply resolve submodule URLs against the _repo_ (i.e. the real origin
URL) and not the work tree (if any), we get results that are coupled to
whether we use bare or non-bare repos: Take, for example, your use
of "../<path>" to make submodules live outside the (bare) superproject. If I
now create a non-bare clone of this, I must move the submodule repos _into_
my work tree, so that the submodule repos are available, if someone tries to
clone from me.

Additionally, when making super/sub repos available for others, I must make
a mental effort to interpret the relative submodule URLs in .gitmodules
against - NOT the work tree in which .gitmodules is located - but rather
against the .git directory which is (most often) one directory level further
down from the .gitmodules file.

Maybe the easiest solution is to add a new config directive called something
like "core.submodules.baseUrl". When set, relative submodule URLs would be
resolved against this instead of the origin URL. When unset, the origin URL
is used as a fallback. Hmm?

Still, it would be nice to have intuitive and consistent behaviour by
default, though...

> I was about to create a patch for submodule to always remove trailing
> "/.git" before resolving, but in fact a user could put the submodule
> .git into the superproject's .git, in a non-bare repository, and then
> gitlink that in the checked out submodule. So, it may also be good to
> define and enforce rules on how relative url naming can be used for this
> purpose. So far, I have only used it for bare repositories using the
> "../<path> form keeping the submodules out of the superproject.

Yes, duplication of such logic is probably a bad idea. Would it be better to
consolidate all this URL DWIMming in one place which is #included from
builtin-clone, git-submodule, git-fetch, and other commands that need this
functionality?

In any case, defining the rules for how relative submodule URLs are supposed
to work would certainly make a good step in the right direction.


Have fun! :)

...Johan


PS: Here are the beginning of a test case for codifying the rules of
relative submodule URL behaviour. Needless to say, the last testcase
currently fails:

diff --git a/t/t7403-submodule-relative.sh b/t/t7403-submodule-relative.sh
new file mode 100755
index 0000000..9c12248
--- /dev/null
+++ b/t/t7403-submodule-relative.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Johan Herland
+#
+
+test_description='Testing repos with relative submodule URLs
+
+This test tries to verify the sanity of working with relative submodule URLs.
+'
+
+. ./test-lib.sh
+
+TRASH_DIR=$(pwd)
+
+#
+# Test setup:
+#  - create the following super-/sub-repository hierarchy:
+#     /
+#     /file
+#     /a submodule/
+#     /a submodule/file
+#
+test_expect_success 'setup' '
+
+	echo file > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	test_tick &&
+	git clone . "a submodule" &&
+	cat >.gitmodules <<EOF &&
+[submodule "a submodule"]
+        path = "a submodule"
+        url = "./a submodule"
+EOF
+	git add "a submodule" .gitmodules &&
+	git commit -m "a submodule"
+
+'
+
+test_expect_success 'Cloning repo and updating submodules using file:// URL' '
+
+	git clone "file://$TRASH_DIR" clone &&
+	cd clone &&
+	git submodule update --init &&
+	test -d "a submodule/.git"
+
+'
+
+test_expect_success 'Cloning repo and updating submodules using local path' '
+
+	rm -rf clone &&
+	git clone "$TRASH_DIR" clone &&
+	cd clone &&
+	git submodule update --init &&
+	test -d "a submodule/.git"
+
+'
+
+test_done


-- 
Johan Herland, <johan@herland.net>
www.herland.net
