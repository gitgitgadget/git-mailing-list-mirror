From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Add test cases for git-am
Date: Fri, 30 May 2008 16:04:47 +0200
Message-ID: <20080530140447.GB10514@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 16:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K25Es-0005ZC-6W
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYE3OEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 10:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbYE3OEx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 10:04:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:45717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbYE3OEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 10:04:51 -0400
Received: (qmail invoked by alias); 30 May 2008 14:04:49 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp052) with SMTP; 30 May 2008 16:04:49 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19C5/UOFJxC54OniSz2Pwv2qtaYUKwcSFd2LR+SeW
	CLyL/AsAnakbz/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K25Dr-0005Eh-B2; Fri, 30 May 2008 16:04:47 +0200
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83303>

Add t/t4151-am.sh that does basic testing of git-am functionality,
including:
 * am applies patch correctly
 * am changes committer and keeps author
 * am --signoff adds Signed-off-by: line
 * am stays in branch
 * am --signoff does not add Signed-off-by: line if already there
 * am without --keep removes Re: and [PATCH] stuff
 * am --keep really keeps the subject
 * am -3 falls back to 3-way merge
 * am pauses on conflict
 * am --skip works
 * am --resolved works
 * am takes patches from a Pine mailbox
 * am fails on mail without patch
 * am fails on empty patch

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

the reason I added this test is because I'm working on git-sequencer (for
GSoC'08), which functions as a common backend for git-am, git-rebase, ...
And I think this test will make my life easier ;-)

As this is my first test, I hope to get some constructive feedback.

Perhaps it is also useful to swap t4150 and t4151 or to merge them.

Ah, and I omitted tests for --whitespace and some other git-apply-specific
stuff.

Regards,
  Stephan

 t/t4151-am.sh |  223 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100755 t/t4151-am.sh

diff --git a/t/t4151-am.sh b/t/t4151-am.sh
new file mode 100755
index 0000000..df4fb5a
--- /dev/null
+++ b/t/t4151-am.sh
@@ -0,0 +1,223 @@
+#!/bin/sh
+
+test_description='git am running'
+
+. ./test-lib.sh
+
+cat >msg <<EOF
+second
+
+Lorem ipsum dolor sit amet, consectetuer sadipscing elitr, sed diam nonumy
+eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
+voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita
+kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem
+ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
+tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
+vero eos et accusam et justo duo dolores et ea rebum.
+
+	Duis autem vel eum iriure dolor in hendrerit in vulputate velit
+	esse molestie consequat, vel illum dolore eu feugiat nulla facilisis
+	at vero eros et accumsan et iusto odio dignissim qui blandit
+	praesent luptatum zzril delenit augue duis dolore te feugait nulla
+	facilisi.
+
+
+Lorem ipsum dolor sit amet,
+consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
+laoreet dolore magna aliquam erat volutpat.
+
+  git
+  ---
+  +++
+
+Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit
+lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure
+dolor in hendrerit in vulputate velit esse molestie consequat, vel illum
+dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio
+dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te
+feugait nulla facilisi.
+EOF
+
+cat >failmail <<EOF
+From foo@example.com Fri May 23 10:43:49 2008
+From:	foo@example.com
+To:	bar@example.com
+Subject: Re: [RFC/PATCH] git-foo.sh
+Date:	Fri, 23 May 2008 05:23:42 +0200
+
+Sometimes we have to find out that there's nothing left.
+
+EOF
+
+cat >pine <<EOF
+From MAILER-DAEMON Fri May 23 10:43:49 2008
+Date: 23 May 2008 05:23:42 +0200
+From: Mail System Internal Data <MAILER-DAEMON@example.com>
+Subject: DON'T DELETE THIS MESSAGE -- FOLDER INTERNAL DATA
+Message-ID: <foo-0001@example.com>
+
+This text is part of the internal format of your mail folder, and is not
+a real message.  It is created automatically by the mail system software.
+If deleted, important folder data will be lost, and it will be re-created
+with the data reset to initial values.
+
+EOF
+
+test_expect_success setup '
+	echo hello >file &&
+	git add file &&
+	test_tick &&
+	git commit -m first &&
+	git tag first &&
+	echo world >>file &&
+	git add file &&
+	test_tick &&
+	git commit -s -F msg &&
+	git tag second &&
+	git format-patch --stdout first >patch1 &&
+	tail -n +3 msg >file &&
+	git add file &&
+	test_tick &&
+	git commit -m third &&
+	git tag third &&
+	git format-patch --stdout first >patch2	&&
+	git checkout -b lorem &&
+	tail -n +11 msg >file &&
+	head -n +9 msg >>file &&
+	test_tick &&
+	git commit -a -m "moved stuff" &&
+	echo goodbye >another &&
+	git add another &&
+	test_tick &&
+	git commit -m "added another file" &&
+	git format-patch --stdout master >lorem-move.patch
+'
+
+# reset time
+unset test_tick
+test_tick
+
+test_expect_success 'am applies patch correctly' '
+	git checkout first &&
+	test_tick &&
+	git am <patch1 &&
+	! test -d .dotest &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
+GIT_AUTHOR_NAME="Another Thor"
+GIT_AUTHOR_EMAIL="a.thor@example.com"
+GIT_COMMITTER_NAME="Co M Miter" 
+GIT_COMMITTER_EMAIL="c.miter@example.com"
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+
+compare () {
+	test "$(git cat-file commit "$2" | grep "^$1 ")" = \
+	     "$(git cat-file commit "$3" | grep "^$1 ")"
+}
+
+test_expect_success 'am changes committer and keeps author' '
+	test_tick &&
+	git checkout first &&
+	git am patch2 &&
+	! test -d .dotest &&
+	test "$(git rev-parse master)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse master^)" != "$(git rev-parse HEAD^)" &&
+	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
+	test -z "$(git diff master..HEAD)" &&
+	test -z "$(git diff master^..HEAD^)" &&
+	compare author master HEAD &&
+	compare author master^ HEAD^ &&
+	! compare committer master HEAD &&
+	! compare committer master^ HEAD^
+'
+
+test_expect_success 'am --signoff adds Signed-off-by: line' '
+	git checkout -b master2 first &&
+	git am --signoff <patch2 &&
+	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1 &&
+	test "$(git cat-file commit HEAD^ | grep -c "^Signed-off-by:")" -eq 2
+'
+
+test_expect_success 'am stays in branch' '
+	test "refs/heads/master2" = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
+	git format-patch --stdout HEAD^ >patch3 &&
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4
+	git checkout HEAD^ &&
+	git am --signoff patch4 &&
+	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1
+'
+
+test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
+	test "$(git rev-parse HEAD)" = "$(git rev-parse master2)"
+'
+
+test_expect_success 'am --keep really keeps the subject' '
+	git checkout HEAD^ &&
+	git am --keep patch4 &&
+	! test -d .dotest &&
+	git-cat-file commit HEAD |
+		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
+'
+
+test_expect_success 'am -3 falls back to 3-way merge' '
+	git checkout -b lorem2 master2 &&
+	tail -n +3 msg >file &&
+	head -n +9 msg >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "copied stuff" &&
+	git am -3 lorem-move.patch &&
+	! test -d .dotest &&
+	test -z "$(git diff lorem)"
+'
+
+test_expect_success 'am pauses on conflict' '
+	git checkout lorem2^^ &&
+	! git am lorem-move.patch &&
+	test -d .dotest
+'
+
+test_expect_success 'am --skip works' '
+	git am --skip &&
+	! test -d .dotest &&
+	test -z "$(git diff lorem2^^ -- file)" &&
+	test goodbye = "$(cat another)"
+'
+
+test_expect_success 'am --resolved works' '
+	git checkout lorem2^^ &&
+	! git am lorem-move.patch &&
+	test -d .dotest &&
+	echo resolved >>file &&
+	git add file &&
+	git am --resolved &&
+	! test -d .dotest &&
+	test goodbye = "$(cat another)"
+'
+
+test_expect_success 'am takes patches from a Pine mailbox' '
+	git checkout first &&
+	cat pine patch1 | git am &&
+	! test -d .dotest &&
+	test -z "$(git diff master^..HEAD)"
+'
+
+test_expect_success 'am fails on mail without patch' '
+	! git am <failmail &&
+	rm -r .dotest/
+'
+
+test_expect_success 'am fails on empty patch' '
+	echo "---" >>failmail &&
+	! git am <failmail &&
+	git am --skip &&
+	! test -d .dotest
+'
+
+test_done
-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
