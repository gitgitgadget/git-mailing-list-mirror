From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Thu, 26 Jun 2008 16:06:56 -0700
Message-ID: <7vlk0rokxb.fsf@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
 <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
 <7vprq3ol63.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC0Zc-0003Ig-6o
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbYFZXHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYFZXHL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:07:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbYFZXHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 19:07:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B8E4822187;
	Thu, 26 Jun 2008 19:07:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AA3F122186; Thu, 26 Jun 2008 19:07:03 -0400 (EDT)
In-Reply-To: <7vprq3ol63.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 16:01:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9971396A-43D4-11DD-9B39-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86501>

Junio C Hamano <gitster@pobox.com> writes:

> With these enhancements in place, I think the pre-commit hook to find
> problematic change would become essentially a one-liner, something like:
>
> 	git diff-index --check -M --cached

More specifically, it would be like this.

 templates/hooks--pre-commit.sample |   89 ++++++++----------------------------
 1 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
dissimilarity index 79%
index 71c10f2..c302ed1 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -1,70 +1,19 @@
-#!/bin/sh
-#
-# An example hook script to verify what is about to be committed.
-# Called by git-commit with no arguments.  The hook should
-# exit with non-zero status after issuing an appropriate message if
-# it wants to stop the commit.
-#
-# To enable this hook, rename this file to "pre-commit".
-
-# This is slightly modified from Andrew Morton's Perfect Patch.
-# Lines you introduce should not have trailing whitespace.
-# Also check for an indentation that has SP before a TAB.
-
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
-	    if (/^([<>])\1{6} |^={7}$/) {
-		bad_line("unresolved merge conflict", $_);
-	    }
-	}
-    }
-    exit($found_bad);
-'
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by git-commit with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message if
+# it wants to stop the commit.
+#
+# To enable this hook, rename this file to "pre-commit".
+
+if git-rev-parse --verify HEAD 2>/dev/null
+then
+	against=
+else
+	# Initial commit: diff against an empty tree object
+	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+fi
+
+exec git diff-index --check --cached $against
+
