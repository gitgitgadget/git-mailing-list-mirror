From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Use perl instead of sed for t8006-blame-textconv test
Date: Mon,  9 Jan 2012 21:47:33 -0500
Message-ID: <1326163653-26565-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
 <1326163653-26565-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 10 03:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkRkY-0008NB-1b
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 03:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab2AJCrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 21:47:39 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:54301 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab2AJCri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 21:47:38 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:59773 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RkRkP-0000St-0b; Mon, 09 Jan 2012 21:47:37 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RkRkO-0006v5-Vj; Mon, 09 Jan 2012 21:47:36 -0500
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1326163653-26565-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188210>

In test 'blame --textconv with local changes' of t8006-blame-textconv,
using /usr/xpg4/bin/sed (as set by SANE_TOOL_PATH), an additional
newline was added to the output from the 'helper' script.

This was noted by sed with a message such as:
sed: Missing newline at end of file zero.bin.

Sed then exits with status 2 causing the helper script to also exit
with status 2.

In turn, this was triggering a fatal error from git blame:
fatal: unable to read files to diff

To work around this difference in sed behaviour, use perl -p instead
of sed -e as it exits cleanly and does not insert the additional
newline.

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
1.7.8.2
