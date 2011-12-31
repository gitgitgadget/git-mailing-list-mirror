From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Work around sed portability issue in t8006-blame-textconv
Date: Sat, 31 Dec 2011 08:44:28 -0500
Message-ID: <1325339068-6063-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 31 14:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgzEt-0001Vm-Ri
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 14:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab1LaNon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 08:44:43 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:40003 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab1LaNom (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 08:44:42 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:52771 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RgzEn-0001dz-8u; Sat, 31 Dec 2011 08:44:41 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RgzEn-0001aI-30; Sat, 31 Dec 2011 08:44:41 -0500
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187813>

In test 'blame --textconv with local changes' of t8006-blame-textconv,
using /usr/xpg4/bin/sed on Solaris as set by SANE_TOOL_PATH, an
additional newline was added to the output from the 'helper' script
driven by git attributes.

This was noted by sed with a message such as:
sed: Missing newline at end of file zero.bin.

In turn, this was triggering a fatal error from git blame:
fatal: unable to read files to diff

The git blame --textconv stdout was empty as a result of the error
condition above.  This caused the test to fail because the output
value differed from the expected result.

Use perl -p -e instead of sed -e to work around this portability issue
as it will not insert the newline.  This allows the git blame call to
complete at which point the output comparison is successful.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 t/t8006-blame-textconv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 4ee42f1..c3c22f7 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -10,7 +10,7 @@ find_blame() {
 cat >helper <<'EOF'
 #!/bin/sh
 grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
-sed 's/^bin: /converted: /' "$1"
+perl -p -e 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
 
-- 
1.7.4.1
