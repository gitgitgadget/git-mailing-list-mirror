From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/3] New version of pre-commit hook
Date: Wed, 12 Dec 2007 11:03:08 +0100
Message-ID: <1197453788-3097-4-git-send-email-win@wincent.com>
References: <1197453788-3097-1-git-send-email-win@wincent.com>
 <1197453788-3097-2-git-send-email-win@wincent.com>
 <1197453788-3097-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 11:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ORz-0004B9-Ll
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbXLLKD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbXLLKD4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:03:56 -0500
Received: from wincent.com ([72.3.236.74]:43898 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757103AbXLLKD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:03:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCA39ul018416;
	Wed, 12 Dec 2007 04:03:16 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197453788-3097-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68030>

Now that "git diff --check" indicates problems with its exit code the
pre-commit hook becomes a trivial one-liner.

A side effect of this is that when "git diff --check" learns to detect
problems according to core.whitespace in the future, the hook's
behaviour will evolve to match without any changes required.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 templates/hooks--pre-commit |   67 ++++--------------------------------------
 1 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 7092bae..f8c7be7 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -7,64 +7,11 @@
 #
 # To enable this hook, make this file executable.
 
-# This is slightly modified from Andrew Morton's Perfect Patch.
-# Lines you introduce should not have trailing whitespace.
-# Also check for an indentation that has SP before a TAB.
+git-diff-index -M --cached --check HEAD -- && exit 0
 
-if git-rev-parse --verify HEAD 2>/dev/null
-then
-	git-diff-index -p -M --cached HEAD --
-else
-	# NEEDSWORK: we should produce a diff with an empty tree here
-	# if we want to do the same verification for the initial import.
-	:
-fi |
-perl -e '
-    my $found_bad = 0;
-    my $filename;
-    my $reported_filename = "";
-    my $lineno;
-    sub bad_line {
-	my ($why, $line) = @_;
-	if (!$found_bad) {
-	    print STDERR "*\n";
-	    print STDERR "* You have some suspicious patch lines:\n";
-	    print STDERR "*\n";
-	    $found_bad = 1;
-	}
-	if ($reported_filename ne $filename) {
-	    print STDERR "* In $filename\n";
-	    $reported_filename = $filename;
-	}
-	print STDERR "* $why (line $lineno)\n";
-	print STDERR "$filename:$lineno:$line\n";
-    }
-    while (<>) {
-	if (m|^diff --git a/(.*) b/\1$|) {
-	    $filename = $1;
-	    next;
-	}
-	if (/^@@ -\S+ \+(\d+)/) {
-	    $lineno = $1 - 1;
-	    next;
-	}
-	if (/^ /) {
-	    $lineno++;
-	    next;
-	}
-	if (s/^\+//) {
-	    $lineno++;
-	    chomp;
-	    if (/\s$/) {
-		bad_line("trailing whitespace", $_);
-	    }
-	    if (/^\s* \t/) {
-		bad_line("indent SP followed by a TAB", $_);
-	    }
-	    if (/^(?:[<>=]){7}/) {
-		bad_line("unresolved merge conflict", $_);
-	    }
-	}
-    }
-    exit($found_bad);
-'
+cat >&2 <<EOF
+fatal: commit aborted due to whitespace problems
+specify --no-verify to bypass these checks and commit anyway
+EOF
+
+exit 1
-- 
1.5.3.7.1159.g2f071-dirty
