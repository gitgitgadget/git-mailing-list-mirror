From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Start deprecating "git-command" in favor of "git command"
Date: Sat, 30 Jun 2007 11:49:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 30 20:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4i0g-0002CK-DD
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 20:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXF3St2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXF3St2
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 14:49:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47531 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753784AbXF3St2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2007 14:49:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5UInMsd017524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 30 Jun 2007 11:49:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5UInHRR016317;
	Sat, 30 Jun 2007 11:49:17 -0700
X-Spam-Status: No, hits=-5.639 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51245>


I realize that a lot of people use the "git-xyzzy" format, and we have 
various historical reasons for it, but I also think that most people have 
long since started thinking of the git command as a single command with 
various subcommands, and we've long had the documentation talk about it 
that way.

Slowly migrating away from the git-xyzzy format would allow us to 
eventually no longer install hundreds of binaries (even if most of them 
are symlinks or hardlinks) in users $PATH, and the _original_ reasons for 
it (implementation issues and bash completion) are really long long gone.

Using "git xyzzy" also has some fundamental advantages, like the ability 
to specify things like paging ("git -p xyzzy") and making the whole notion 
of aliases act like other git commands (which they already do, but they do 
*not* have a "git-xyzzy" form!)

Anyway, while actually removing the "git-xyzzy" things is not practical 
right now, we can certainly start slowly to deprecate it internally inside 
git itself - in the shell scripts we use, and the test vectors.

This patch adds a "remove-dashes" makefile target, which does that. It 
isn't particularly efficient or smart, but it *does* successfully rewrite 
a lot of our shell scripts to use the "git xyzzy" form for all built-in 
commands.

(For non-builtins, the "git xyzzy" format implies an extra execve(), so 
this script leaves those alone).

So apply this patch, and then run

	make remove-dashes
	make test
	git commit -a

to generate a much larger patch that actually starts this transformation.

(The only half-way subtle thing about this is that it also fixes up 
git-filter-branch.sh for the new world order by adding quoting around 
the use of "git-commit-tree" as an argument. It doesn't need it in that 
format, but when changed into "git commit-tree" it is no longer a single 
word, and the quoting maintains the old behaviour).

NOTE! This does not yet mean that you can actually stop installing the 
"git-xyzzy" binaries for the builtins. There are some remaining places 
that want to use the old form, this just removes the most obvious ones 
that can easily be done automatically.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Comments? I think this is worth doing, but the patch that this scripting 
generates is actually fairly large, even if this patch itself is smallish.

Junio, up to you.

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
index 0000000..d7fae43
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
+		sed "s/$old/$new/g" < $file > $file.new
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
 
