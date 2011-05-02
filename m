From: Ciaran <ciaranj@gmail.com>
Subject: [PATCH RFC] Test for apparent regression of merging renamed files
Date: Mon, 2 May 2011 20:04:24 +0100
Message-ID: <BANLkTimcRbuYzSp+MM-vsvxoWhAS8Jvo8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, newren@gmail.com,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyVj-0003TT-HH
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab1EBTKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:10:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55444 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBTKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:10:16 -0400
Received: by pzk9 with SMTP id 9so3163800pzk.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Cn6fbkyvHeHerja57XKrEc8Sv1n+NfF5iGcc+hxzgGM=;
        b=ietMyM5ro1BBBst2VP4ZWSObXWwFzbt1eP2KdvIYG9s3cSMaXHEr6lasbDn2z4OfVc
         ktZtJqQCzp5oZPV5Gwdpr9TtL9sFSdjAEJKi+uQ+f2/1BLz+uiYlyZq4FUDyNmVQf2+e
         cmtw3o7RzZZb40rjwBL4VGFNHwSWc1H/F5tHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=w9F1R7u8+ZX2GhgsW16Rt8wDfnx+1nNkh2ZBBf/JhbZqnQb0EUGgQPDkSS44/kGxu2
         0Ti/KgKkW25fsc/84rwSqvhjOUwdJTcmYw2IUA0epp/h3W2pzTTkjtVIxbr3zhFD8Yoz
         cz/YUkL0Ctr2xsU3wKohVsIwrWebYR0w/nLuc=
Received: by 10.68.10.9 with SMTP id e9mr8050399pbb.255.1304363064642; Mon, 02
 May 2011 12:04:24 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Mon, 2 May 2011 12:04:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172617>

Provides a test to cover a case that appears to have been regressed out by:

 b2c8c0a762745768e8fb249949801c1aed8f7c1d

At this point no tags contain the above commit, but 'master' does.  I'm unsure
what is causing the issue, but can see discussion about this fix here:

http://git.661346.n2.nabble.com/BUG-merge-recursive-triggered-quot-BUG-quot-td6179353.html

Providing a patch to demonstrate the issue and spark discussion.
---
Whilst working up a patch for my 'whitespace ignorant rename
detection' ( http://git.661346.n2.nabble.com/PATCH-RFC-Rename-detection-and-whitespace-td6288524.html
) I was unable to get my tests working, turns out that something that
used to work for me, no longer does in master's HEAD.

I don't really understand the fault so I'm throwing it to the list in
the hope that someone brighter than me can take it on (I've
CC'd the signoff-s to that end! :) Sorry!

 t/t9801-merge-rename.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100755 t/t9801-merge-rename.sh

diff --git a/t/t9801-merge-rename.sh b/t/t9801-merge-rename.sh
new file mode 100755
index 0000000..363911f
--- /dev/null
+++ b/t/t9801-merge-rename.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Test for rename merge regression'
+
+. ./test-lib.sh
+
+write_out_files() {
+cat > noformatting.txt << EOF
+if(true){
+// Meaningless
+}
+EOF
+
+cat > formatting.txt << EOF
+	if ( true ) {
+	  // Meaningless
+	}
+EOF
+}
+
+# Test the case where a rename happens in one branch and
+# a whitespace change occurs in a different branch.  The rename
+# change should apply to the whitespace modified file
+test_expect_success setup '
+	write_out_files &&
+	git add formatting.txt &&
+
+	test_tick &&
+	git commit -m Initial &&
+	git checkout -b rename_branch &&
+	git mv formatting.txt formatting_renamed.txt &&
+	git commit -m Rename &&
+	git checkout master &&
+	rm formatting.txt &&
+	mv noformatting.txt formatting.txt &&
+	git commit -a -m Reformat
+'
+test_expect_success 'merge' '
+	git merge rename_branch
+'
+test_done
-- 
1.7.4.1
