From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] am: allow some defaults to be specified via git-config
Date: Fri, 16 Oct 2009 12:50:27 +1300
Message-ID: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Nigel McNie <nigel@catalyst.net.nz>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 02:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyaGh-0002Xv-TW
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 02:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763178AbZJOXvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbZJOXvK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 19:51:10 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:57676 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819AbZJOXvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 19:51:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id C29BA3240D;
	Fri, 16 Oct 2009 12:50:31 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdBoVC1ugJ+I; Fri, 16 Oct 2009 12:50:30 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id BDB61323FC;
	Fri, 16 Oct 2009 12:50:30 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130440>

Some users prefer in particular '3way' to be the default, let them
specify it via the config file - and some other boolean settings while
we're at it.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/config.txt |    4 ++++
 Documentation/git-am.txt |   11 +++++++++--
 git-am.sh                |    5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cd17814..82adca5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -476,6 +476,10 @@ it will be treated as a shell command.  For example, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
 
+am.*::
+	Specify defaults for linkgit:git-am[1].  Currently, the three
+	boolean options, 'sign', 'utf8' and 'keep' may be specified.
+
 apply.ignorewhitespace::
 	When set to 'change', tells 'git-apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 67ad5da..c22bca2 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -38,6 +38,7 @@ OPTIONS
 -k::
 --keep::
 	Pass `-k` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
+	May be specified via 'am.keep' (see linkgit:git-config[1]).
 
 -c::
 --scissors::
@@ -60,7 +61,8 @@ OPTIONS
 	preferred encoding if it is not UTF-8).
 +
 This was optional in prior versions of git, but now it is the
-default.   You can use `--no-utf8` to override this.
+default.   You can use `--no-utf8` to override this, or set
+'am.utf8' to no via linkgit:git-config[1].
 
 --no-utf8::
 	Pass `-n` flag to 'git-mailinfo' (see
@@ -71,7 +73,12 @@ default.   You can use `--no-utf8` to override this.
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
-	available locally.
+	available locally.  This can be configured via
+	linkgit:git-config[1] using the 'am.3way' option
+
+--no-3way::
+	If 'am.3way' is specified to be true in the configuration file,
+	this switch allows it to be disabled.
 
 --ignore-date::
 --ignore-space-change::
diff --git a/git-am.sh b/git-am.sh
index c132f50..a22fa3b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -294,6 +294,9 @@ git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 
+# apply defaults from config
+eval "$(git config --bool --get-regexp '^am\.(sign|utf8|keep)' | sed 's/^am\.\([a-z0-9]*\) /\1=/;s/true/t/;s/false//')"
+
 while test $# != 0
 do
 	case "$1" in
@@ -303,6 +306,8 @@ do
 		: ;;
 	-3|--3way)
 		threeway=t ;;
+	--no-3way)
+		threeway= ;;
 	-s|--signoff)
 		sign=t ;;
 	-u|--utf8)
-- 
1.6.3.3
