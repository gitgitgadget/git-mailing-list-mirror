From: Luke Diamand <luke@diamand.org>
Subject: [RFC v1] git-p4: test case for RCS keyword problem
Date: Mon,  9 May 2011 08:49:57 +0100
Message-ID: <1304927397-24614-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>,
	Michael Horowitz <michael.horowitz@ieee.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 09:50:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLEM-0007xi-Lt
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 09:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1EIHuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 03:50:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57574 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1EIHuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 03:50:07 -0400
Received: by wwa36 with SMTP id 36so5457873wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 00:50:06 -0700 (PDT)
Received: by 10.227.19.130 with SMTP id a2mr2464196wbb.8.1304927406133;
        Mon, 09 May 2011 00:50:06 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id w25sm3572931wbd.56.2011.05.09.00.50.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 00:50:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173202>

This is following on from some earlier threads about RCS keywords
and git-p4:

http://marc.info/?l=git&m=122145837226632&w=2
http://marc.info/?l=git&m=130470278328964&w=2

The problem is that git-p4 imports into git with RCS keywords
unexpanded (e.g. as $Id$), which is certainly the right thing
to do given how nasty RCS keywords are.

However, when it comes to try to apply your changes, it
applies them against a checked-out p4 tree, where the RCS keywords
*are* expanded. This then fails if in git you modify any lines
that contain RCS keywords (i.e. deleting them, or deleting the
entire file).

You would think you could just tell p4 to not expand RCS keywords
in your client view, but sadly that option doesn't exist :-(

This isn't a fix, it's just a test case that shows the problem,
and doesn't even try to test the whole-file deletion case.

I'm hoping someone will suggest a good way to handle this.

Otherwise, I've got a possible scheme that involves spotting the
failure to apply the patch, patching up RCS keywords in the
p4 client shadow and then trying again. It's not pretty but it seems
like it ought to work. My current version doesn't handle deletion,
and zaps *all* RCS keywords rather than just the ones zapped in git;
more work is needed before I can submit it.

Regards!
Luke


Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 0dcaa9c..8e79331 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -258,6 +258,50 @@ test_expect_success 'not preserving user with mixed authorship' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+create_kw_file() {
+	cat <<'EOF' > $1
+/* A file
+   Id: $Id:$
+   Revision: $Revision:$
+   File: $File:$
+ */
+int main(int argc, const char **argv) {
+	return 0;
+}
+EOF
+	git add $1
+}
+
+p4_append_to_file() {
+	f=$1
+	p4 edit -t ktext $f &&
+	echo "/* $(date) */" >> $f &&
+	p4 submit -d "appending a line in p4" &&
+	cat $f
+}
+
+# Create some files with RCS keywords. If they get modified
+# elsewhere then the version number gets bumped which then
+# results in a merge conflict if we touch the RCS kw lines,
+# even though the change itself would otherwise apply cleanly.
+test_expect_failure 'cope with rcs keyword expansion damage' '
+	"$GITP4" clone --dest="$git" //depot &&
+	cd "$git" &&
+	git config git-p4.skipSubmitEditCheck true &&
+	create_kw_file kwfile1.c &&
+	git commit -m "Files with RCS keywords" &&
+	P4EDITOR=touch "$GITP4" commit && "$GITP4" rebase &&
+	(cd ../cli && p4_append_to_file kwfile1.c) &&
+	perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
+	git add kwfile1.c &&
+	git commit -m "Zap an RCS kw line" &&
+	(echo 'w' | P4EDITOR=touch "$GITP4" submit) && "$GITP4" rebase &&
+	git diff p4/master &&
+	"$GITP4" commit &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
-- 
1.7.1
