From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 14:41:23 -0700
Message-ID: <7vir5vss58.fsf@gitster.siamese.dyndns.org>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	<20070927185707.GC12427@artemis.corp>
	<94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	<7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	<7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	<7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	<7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
	<94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com>
	<7vmyv7sshv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kelvie Wong" <kelvie@ieee.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib178-00089W-CI
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbXI0Vlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756870AbXI0Vlb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 17:41:31 -0400
Received: from rune.pobox.com ([208.210.124.79]:33728 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433AbXI0Vl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 17:41:29 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D3C2D13D3EB;
	Thu, 27 Sep 2007 17:41:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DCFC13AE24;
	Thu, 27 Sep 2007 17:41:46 -0400 (EDT)
In-Reply-To: <7vmyv7sshv.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 27 Sep 2007 14:33:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59338>

When mergetool is run from a subdirectory, "ls-files -u" nicely
limits the output to conflicted files in that directory, but
we need to give the full path to cat-file plumbing to grab the
contents of stages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I earlier sent one with cd_to_toplevel but I think the
   approach in this patch is nicer.

 git-mergetool.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index a0e44f7..3b1ec13 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -12,6 +12,7 @@ USAGE='[--tool=tool] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
+prefix=$(git rev-parse --show-prefix)
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -162,9 +163,9 @@ merge_file () {
     local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
+    base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
+    local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
+    remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$path':"
