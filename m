From: Junio C Hamano <gitster@pobox.com>
Subject: No whitespace check during merge conflict resolution
Date: Wed, 19 Mar 2008 14:07:18 -0700
Message-ID: <7vk5jy2zjt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 22:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5aw-0007aG-SE
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbYCSVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965586AbYCSVHf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:07:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760183AbYCSVHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:07:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB71238D1;
	Wed, 19 Mar 2008 17:07:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 86B4B38CD; Wed, 19 Mar 2008 17:07:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77547>

If you are merging from somebody else, and the merge needs manual conflict
resolution, eventually you will complete it by calling "git commit".

Now, if the tree you are merging in introduces whitespace breakages, what
should we do?

Currently the situation is:

 - If the merge does not conflict, you do not have to complete it by
   running "git commit", and whitespace breakages will be accepted as part
   of the merge.

 - If you need to run "git commit", however, pre-commit hook can kick in.
   The sample pre-commit hook will complain.

I think the semantics of "merge" is "I trust him and take his changes";
accepting whitespace broken tree, just like we do in non-conflicting case,
is fine.  Even though the sample hook is, eh, just "sample", we should
make it consistent.

So perhaps something like this patch would take us in the right
direction.

Note that this I think still has issues when amending a merge.  From
inside hooks, I do not think you can detect that you are called to handle
amending.  Worse yet, I suspect that "HEAD" may not be the right thing to
compare with when amending, in which case further fixups (even if we do
not want to deal with this whitespace check issues) is required.

---
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index b25dce6..10b3743 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -11,6 +11,12 @@
 # Lines you introduce should not have trailing whitespace.
 # Also check for an indentation that has SP before a TAB.
 
+in_merge=0
+if test -f $GIT_DIR/MERGE_HEAD
+then
+	in_merge=1
+fi
+
 if git-rev-parse --verify HEAD 2>/dev/null
 then
 	git-diff-index -p -M --cached HEAD --
@@ -24,6 +30,7 @@ perl -e '
     my $filename;
     my $reported_filename = "";
     my $lineno;
+    my $in_merge = $ARGV[0];
     sub bad_line {
 	my ($why, $line) = @_;
 	if (!$found_bad) {
@@ -39,7 +46,7 @@ perl -e '
 	print STDERR "* $why (line $lineno)\n";
 	print STDERR "$filename:$lineno:$line\n";
     }
-    while (<>) {
+    while (<STDIN>) {
 	if (m|^diff --git a/(.*) b/\1$|) {
 	    $filename = $1;
 	    next;
@@ -55,16 +62,18 @@ perl -e '
 	if (s/^\+//) {
 	    $lineno++;
 	    chomp;
-	    if (/\s$/) {
-		bad_line("trailing whitespace", $_);
-	    }
-	    if (/^\s* \t/) {
-		bad_line("indent SP followed by a TAB", $_);
+	    if (!$in_merge) {
+		if (/\s$/) {
+		    bad_line("trailing whitespace", $_);
+		}
+		if (/^\s* \t/) {
+		    bad_line("indent SP followed by a TAB", $_);
+		}
 	    }
-	    if (/^([<>])\1{6} |^={7}$/) {
+	    if ($in_merge && /^([<>])\1{6} |^={7}$/) {
 		bad_line("unresolved merge conflict", $_);
 	    }
 	}
     }
     exit($found_bad);
-'
+' "$in_merge"
