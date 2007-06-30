From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 12:43:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706301231200.1172@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 21:44:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4ira-0001X0-RP
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 21:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXF3ToI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 15:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXF3ToH
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 15:44:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59660 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820AbXF3ToG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2007 15:44:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5UJi0ht019373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Jun 2007 12:44:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5UJhtPi018732;
	Sat, 30 Jun 2007 12:43:55 -0700
In-Reply-To: <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-5.648 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51248>



On Sat, 30 Jun 2007, Junio C Hamano wrote:
> 
> In the longer run, we may want to allow "git foo" to alias to
> "git foo --preferred-options", although we currently do not
> allow such an alias.  Scripts, especially the ones we ship,
> would not want to be confused by the user aliases when that
> happens.

I agree. And I think our current behaviour is the correct one.

> So I am somewhat negative on this, unless there is a way for
> scripts to say "Even though I say 'git foo', I do mean 'git foo'
> not whatever the user has aliased".

Well, we have a more serious issue, that is related, but has nothing to do 
with aliases.

If you set an environment variable "diff.color=always", any script will 
get that behaviour, and not work the way it might expect.

My point being that this has nothing to do with "git-diff" vs "git diff", 
and everything to do with default configurations. If you don't want people 
to be able to change fixed behaviour, you'd need to have a way to disable 
it.

Quite frankly, I think it's _easier_ to disable with "git xyzzy" than with 
"git-xyzzy", but hey, not a big deal. With "git xyzzy", we could add a 
generic flag like

	git - xyzzy

to make the rule be that no configurations (_including_ aliases) are 
allowed to override default behaviour, which is much harder with the 
"git-xyzzy" format (since then it's invariably a per-command thing).

That said, I'm not going to push that patch very hard.

Especially as I just realized that it had a bug: it caused things like

	-our \$logo = "file:///$(pwd)/../../gitweb/git-logo.png";
	+our \$logo = "file:///$(pwd)/../../gitweb/git logo.png";

because "git-log" got rewritten as "git log", without checking that it was 
a proper word.

I have a fixed version already (just make the sed script use \<..\> around 
the pattern - appended here), but as mentioned, I don't think this is a 
hugely important issue. I prefer the "git cmd" form, but if we want to 
maintain "git-cmd" forever, then hey...

		Linus
---

Fixed the sed pattern a bit..

 Makefile             |    3 ++-
 fixup-builtins       |   16 ++++++++++++++++
 git-filter-branch.sh |    2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a98e27a..1620ef8 100644
--- a/Makefile
+++ b/Makefile
@@ -987,7 +987,8 @@ check-sha1:: test-sha1$X
 check: common-cmds.h
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
-
+remove-dashes:
+	./fixup-builtins $(BUILT_INS)
 
 ### Installation rules
 
diff --git a/fixup-builtins b/fixup-builtins
new file mode 100755
index 0000000..49e861d
--- /dev/null
+++ b/fixup-builtins
@@ -0,0 +1,16 @@
+#!/bin/sh
+while [ "$1" ]
+do
+	old="$1"
+	new=$(echo "$1" | sed 's/git-/git /')
+	echo "Converting '$old' to '$new'"
+	git ls-files '*.sh' | while read file
+	do
+		sed "s/\\<$old\\>/$new/g" < $file > $file.new
+		chmod --reference=$file $file.new
+		mv $file.new $file
+	done
+	shift
+done
+git update-index --refresh >& /dev/null
+exit 0
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 8fa5ce6..0f54271 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -383,7 +383,7 @@ while read commit parents; do
 
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" | \
-		sh -c "$filter_commit" git-commit-tree $(git-write-tree) $parentstr | \
+		sh -c "$filter_commit" "git-commit-tree" $(git-write-tree) $parentstr | \
 		tee ../map/$commit
 done <../revs
 
