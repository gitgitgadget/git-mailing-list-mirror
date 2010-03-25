From: Eli Barzilay <eli@barzilay.org>
Subject: [PATCH] Add `%B' in format strings for raw commit body in `git log' and friends
Date: Wed, 24 Mar 2010 22:51:52 -0400
Message-ID: <19370.53192.313137.191218@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 05:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NueMp-0005Fu-G7
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 05:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904Ab0CYEIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 00:08:18 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:51283 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab0CYEIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 00:08:17 -0400
X-Greylist: delayed 4583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2010 00:08:17 EDT
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NudAm-0000JC-AQ; Wed, 24 Mar 2010 22:51:52 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143147>

Also update the documentation text and add a test.

Signed-off-by: Eli Barzilay <eli@barzilay.org>
---

This is re a feature request I made a few days ago.  The test is
trivial, since there are only two commits with a single line.

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    4 ++++
 t/t6006-rev-list-format.sh       |    9 +++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..bd760d3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,7 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
 - '%gD': reflog selector, e.g., `refs/stash@\{1\}`
 - '%gd': shortened reflog selector, e.g., `stash@\{1\}`
diff --git a/pretty.c b/pretty.c
index 6ba3da8..14c9568 100644
--- a/pretty.c
+++ b/pretty.c
@@ -797,6 +797,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'e':	/* encoding */
 		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
 		return 1;
+	case 'B':	/* raw body */
+		/* message_off is always left at the initial newline */
+		strbuf_addstr(sb, msg + c->message_off + 1);
+		return 1;
 	}
 
 	/* Now we need to parse the commit message. */
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b0047d3..5d15f18 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -101,6 +101,15 @@ commit 131a310eb913d107dd3c09a65d1651175898735d
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 EOF
 
+test_format raw-body %B <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+changed foo
+
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+added foo
+
+EOF
+
 test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
 [31mfoo[32mbar[34mbaz[mxyzzy
-- 
1.7.0.3
