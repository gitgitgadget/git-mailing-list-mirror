From: Johan Herland <johan@herland.net>
Subject: [PATCH 14/15] git-note: (Tests) Add tests for git-note and associated
 functionality
Date: Sun, 27 May 2007 16:16:53 +0200
Message-ID: <200705271616.53832.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJYc-0007by-BU
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXE0ORN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXE0ORN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:17:13 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34803 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbXE0ORM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:17:12 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00509ECNNQ00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:17:11 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00G1QEC6R350@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:54 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000IMEC5JB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:16:54 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48554>

This test script add tests for:
- git-note (including -l and -d options)
- State of note/tag objects
- git-show-ref --notes
- git-for-each-ref refs/notes
- git-{log,show,whatchanged} --decorate

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3850-note.sh |  303 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100755 t/t3850-note.sh

diff --git a/t/t3850-note.sh b/t/t3850-note.sh
new file mode 100755
index 0000000..f737f7c
--- /dev/null
+++ b/t/t3850-note.sh
@@ -0,0 +1,303 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johan Herland
+#
+
+test_description='Test of git-note'
+
+. ./test-lib.sh
+
+
+# Prepare repo and create some notes
+
+test_expect_success 'Preparing for test' '
+	echo "foo" > foo &&
+	git-add foo &&
+	test_tick &&
+	git-commit -m "Initial commit" &&
+	echo "bar" >> foo
+	test_tick &&
+	git-commit -m "Second commit" foo
+'
+test_expect_success 'Testing git-note -m' '
+	test_tick &&
+	git-note -m "spam"
+'
+test_expect_success 'Testing git-note -F' '
+	echo "spam spam" > note.msg &&
+	test_tick &&
+	git-note -F note.msg
+'
+test_expect_success 'Testing git-note <commit>' '
+	test_tick &&
+	git-note -m "spam spam spam" 301711b66fe71164f646b798706a2c1f7024da8d
+'
+
+# At this point we should have:
+# - commit @ 301711b66fe71164f646b798706a2c1f7024da8d ("Initial commit")
+#   - note @ 93bbbc95a42852552494327537263d475aac1789 ("spam spam spam")
+# - commit @ 9671cbee7ad26528645b2665c8f74d39a6288864 ("Second commit")
+#   - note @ 1245491fece5910086bc1870a4a746256f8a7ecf ("spam")
+#   - note @ 466f861dde008d3905d320225eebef727665a3f0 ("spam spam")
+
+# Verify note objects
+
+test_expect_success 'Testing git-cat-file tag <note>' '
+	cat > note.expect << EOF &&
+object 9671cbee7ad26528645b2665c8f74d39a6288864
+type commit
+tag note-14669883eb004f12636307269f537d59eb143125
+tagger C O Mitter <committer@example.com> 1112912113 -0700
+
+spam
+EOF
+	git-cat-file tag 1245491fece5910086bc1870a4a746256f8a7ecf > note.output &&
+	cmp note.expect note.output &&
+	cat > note.expect << EOF &&
+object 9671cbee7ad26528645b2665c8f74d39a6288864
+type commit
+tag note-ad2099b641be660c4e616bf0b46dcaca391764af
+tagger C O Mitter <committer@example.com> 1112912173 -0700
+
+spam spam
+EOF
+	git-cat-file tag 466f861dde008d3905d320225eebef727665a3f0 > note.output &&
+	cmp note.expect note.output &&
+	cat > note.expect << EOF &&
+object 301711b66fe71164f646b798706a2c1f7024da8d
+type commit
+tag note-c1afd1d9a4e2df7efbb29ff88e50e866e88eb108
+tagger C O Mitter <committer@example.com> 1112912233 -0700
+
+spam spam spam
+EOF
+	git-cat-file tag 93bbbc95a42852552494327537263d475aac1789 > note.output &&
+	cmp note.expect note.output
+'
+
+# Verify output from git-note -l
+
+test_expect_success 'Testing git-note -l' '
+	cat > note.expect << EOF &&
+=== Notes on commit 9671cbe (Second commit) by A U Thor <author@example.com> on Thu, 7 Apr 2005 15:14:13 -0700
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+spam
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+spam spam
+
+=== Notes on commit 301711b (Initial commit) by A U Thor <author@example.com> on Thu, 7 Apr 2005 15:13:13 -0700
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:17:13 2005 -0700
+spam spam spam
+EOF
+	git-note -l > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-note -l <commit>' '
+	cat > note.expect << EOF &&
+=== Notes on commit 9671cbe (Second commit) by A U Thor <author@example.com> on Thu, 7 Apr 2005 15:14:13 -0700
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+spam
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+spam spam
+EOF
+	git-note -l 9671cbee7ad26528645b2665c8f74d39a6288864 > note.output &&
+	cmp note.expect note.output &&
+	cat > note.expect << EOF &&
+=== Notes on commit 301711b (Initial commit) by A U Thor <author@example.com> on Thu, 7 Apr 2005 15:13:13 -0700
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:17:13 2005 -0700
+spam spam spam
+EOF
+	git-note -l 301711b66fe71164f646b798706a2c1f7024da8d > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-note -l <note> <note> <note>' '
+	cat > note.expect << EOF &&
+
+=== Note 93bbbc95a42852552494327537263d475aac1789
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:17:13 2005 -0700
+spam spam spam
+
+=== Note 466f861dde008d3905d320225eebef727665a3f0
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+spam spam
+
+=== Note 1245491fece5910086bc1870a4a746256f8a7ecf
+
+--- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+spam
+EOF
+	git-note -l 93bbbc95a42852552494327537263d475aac1789 \
+	            466f861dde008d3905d320225eebef727665a3f0 \
+	            1245491fece5910086bc1870a4a746256f8a7ecf > note.output &&
+	cmp note.expect note.output
+'
+
+# Verify that notes show up in git-show-ref and git-for-each-ref
+
+test_expect_success 'Testing git-show-ref with notes' '
+	cat > note.expect << EOF &&
+9671cbee7ad26528645b2665c8f74d39a6288864 refs/heads/master
+93bbbc95a42852552494327537263d475aac1789 refs/notes/301711b66fe71164f646b798706a2c1f7024da8d/93bbbc95a42852552494327537263d475aac1789
+1245491fece5910086bc1870a4a746256f8a7ecf refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/1245491fece5910086bc1870a4a746256f8a7ecf
+466f861dde008d3905d320225eebef727665a3f0 refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/466f861dde008d3905d320225eebef727665a3f0
+EOF
+	git-show-ref > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-show-ref --notes' '
+	cat > note.expect << EOF &&
+93bbbc95a42852552494327537263d475aac1789 refs/notes/301711b66fe71164f646b798706a2c1f7024da8d/93bbbc95a42852552494327537263d475aac1789
+1245491fece5910086bc1870a4a746256f8a7ecf refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/1245491fece5910086bc1870a4a746256f8a7ecf
+466f861dde008d3905d320225eebef727665a3f0 refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/466f861dde008d3905d320225eebef727665a3f0
+EOF
+	git-show-ref --notes > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-for-each-ref refs/notes' '
+	cat > note.expect << EOF &&
+93bbbc95a42852552494327537263d475aac1789 tag	refs/notes/301711b66fe71164f646b798706a2c1f7024da8d/93bbbc95a42852552494327537263d475aac1789
+1245491fece5910086bc1870a4a746256f8a7ecf tag	refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/1245491fece5910086bc1870a4a746256f8a7ecf
+466f861dde008d3905d320225eebef727665a3f0 tag	refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/466f861dde008d3905d320225eebef727665a3f0
+EOF
+	git-for-each-ref refs/notes > note.output &&
+	cmp note.expect note.output
+'
+
+# Verify output from git-log/git-show/git-whatchanged --decorate
+
+test_expect_success 'Testing git-log --decorate' '
+	cat > note.expect << EOF &&
+commit 9671cbee7ad26528645b2665c8f74d39a6288864 (refs/heads/master)
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    Second commit
+
+Notes:
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+    spam
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+    spam spam
+
+commit 301711b66fe71164f646b798706a2c1f7024da8d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    Initial commit
+
+Notes:
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:17:13 2005 -0700
+    spam spam spam
+EOF
+	git-log --decorate > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-show --decorate' '
+	cat > note.expect << EOF &&
+commit 9671cbee7ad26528645b2665c8f74d39a6288864 (refs/heads/master)
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    Second commit
+
+Notes:
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+    spam
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+    spam spam
+
+diff --git a/foo b/foo
+index 257cc56..3bd1f0e 100644
+--- a/foo
++++ b/foo
+@@ -1 +1,2 @@
+ foo
++bar
+EOF
+	git-show --decorate > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-whatchanged --decorate' '
+	cat > note.expect << EOF &&
+commit 9671cbee7ad26528645b2665c8f74d39a6288864 (refs/heads/master)
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    Second commit
+
+Notes:
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:15:13 2005 -0700
+    spam
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:16:13 2005 -0700
+    spam spam
+
+:100644 100644 257cc56... 3bd1f0e... M	foo
+
+commit 301711b66fe71164f646b798706a2c1f7024da8d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    Initial commit
+
+Notes:
+
+    --- by C O Mitter <committer@example.com> Thu Apr 7 15:17:13 2005 -0700
+    spam spam spam
+
+:000000 100644 0000000... 257cc56... A	foo
+EOF
+	git-whatchanged --decorate > note.output &&
+	cmp note.expect note.output
+'
+
+# Verify successful removal of notes
+
+test_expect_success 'Testing git-note -d <note>' '
+	cat > note.expect << EOF &&
+Deleting note 93bbbc95a42852552494327537263d475aac1789
+EOF
+	git-note -d 93bbbc95a42852552494327537263d475aac1789 > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Verify repo state after git-note -d <note>' '
+	cat > note.expect << EOF &&
+1245491fece5910086bc1870a4a746256f8a7ecf refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/1245491fece5910086bc1870a4a746256f8a7ecf
+466f861dde008d3905d320225eebef727665a3f0 refs/notes/9671cbee7ad26528645b2665c8f74d39a6288864/466f861dde008d3905d320225eebef727665a3f0
+EOF
+	git-show-ref --notes > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Testing git-note -d <commit>' '
+	cat > note.expect << EOF &&
+Deleting note 1245491fece5910086bc1870a4a746256f8a7ecf associated with commit 9671cbee7ad26528645b2665c8f74d39a6288864
+Deleting note 466f861dde008d3905d320225eebef727665a3f0 associated with commit 9671cbee7ad26528645b2665c8f74d39a6288864
+EOF
+	git-note -d 9671cbee7ad26528645b2665c8f74d39a6288864 > note.output &&
+	cmp note.expect note.output
+'
+test_expect_success 'Verify repo state after git-note -d <commit>' '
+	cat > note.expect << EOF &&
+EOF
+	git-show-ref --notes > note.output
+	test "$?" == "1" &&
+	cmp note.expect note.output
+'
+
+# Testing of clone/fetch/push?
+
+test_done
-- 
1.5.2.101.gee49f
