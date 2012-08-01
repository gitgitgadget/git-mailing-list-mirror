From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] git-am: make a config setting for --keep-non-patch switch
Date: Wed, 1 Aug 2012 13:18:55 -0400
Message-ID: <1343841535-25652-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:19:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwcZi-0001En-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 19:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab2HARTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 13:19:04 -0400
Received: from mail.windriver.com ([147.11.1.11]:57606 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab2HARTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 13:19:03 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q71HJ23B007384
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 1 Aug 2012 10:19:02 -0700 (PDT)
Received: from yow-pgortmak-d2.corp.ad.wrs.com (128.224.146.165) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.2.309.2; Wed, 1 Aug 2012 10:19:02 -0700
X-Mailer: git-send-email 1.7.12.rc1.1.gbce1580
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202713>

In order to make a commit be invariant (excluding ID) over
a format-patch and subsequent am cycle, one needs to use
the '--keep-non-patch' so that commits like:

	[PATCH] [i386] fix foo bar arch/x86/mm

only lose the [PATCH] and not the [i386] part.  Since it
is a common desire (e.g. linux kernel stable trees) to have
the subjects remain invariant during a backport, there is
a genuine need for making this the default behaviour from
a config file, versus specifying it in scripts and on the
command line each time.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

See http://lkml.indiana.edu/hypermail/linux/kernel/1203.1/01817.html
for additional background; stable maintainers using it etc.

 Documentation/config.txt               | 9 +++++++++
 Documentation/git-am.txt               | 4 ++++
 contrib/completion/git-completion.bash | 1 +
 git-am.sh                              | 8 ++++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..47aded5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -655,6 +655,15 @@ am.keepcr::
 	by giving '--no-keep-cr' from the command line.
 	See linkgit:git-am[1], linkgit:git-mailsplit[1].
 
+am.keepnonpatch::
+	Normally git-mailinfo strips from the Subject line, all leading
+	strings bracketed with [ and ] pairs.  If this setting is true,
+	git-am will call git-mailinfo with the parameter '-b' so that only
+	the pairs whose bracketed string contains the word "PATCH" are
+	stripped.  Can be overridden by giving ' '--no-keep-non-patch'
+	from the command line.
+	See linkgit:git-am[1], linkgit:git-mailinfo[1].
+
 apply.ignorewhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 19d57a8..790efdb 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -41,7 +41,11 @@ OPTIONS
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
 --keep-non-patch::
+--no-keep-non-patch::
 	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	The `am.keepnonpatch` configuration variable can be used to specify
+	the default behaviour.  The `--no-keep-non-patch` is useful to
+	override any `am.keepnonpatch` setting.
 
 --keep-cr::
 --no-keep-cr::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffedce7..04339df 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1758,6 +1758,7 @@ _git_config ()
 		advice.statusHints
 		alias.
 		am.keepcr
+		am.keepnonpatch
 		apply.ignorewhitespace
 		apply.whitespace
 		branch.autosetupmerge
diff --git a/git-am.sh b/git-am.sh
index c02e62d..9f6adbf 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-non-patch  pass -b flag to git-mailinfo
+no-keep-non-patch do not pass -b flag to git-mailsplit, independent of am.keepnonpatch
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
@@ -381,6 +382,11 @@ then
     keepcr=t
 fi
 
+if test "$(git config --bool --get am.keepnonpatch)" = true
+then
+    keep=b
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -402,6 +408,8 @@ do
 		keep=t ;;
 	--keep-non-patch)
 		keep=b ;;
+	--no-keep-non-patch)
+		keep= ;;
 	-c|--scissors)
 		scissors=t ;;
 	--no-scissors)
-- 
1.7.12.rc1.1.gbce1580
