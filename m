From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation/rev-parse: --verify does not check existence
Date: Tue, 11 Jan 2011 19:51:02 +0100
Message-ID: <2441701cf9c9cc09d86f52b093bfa896479daad8.1294771717.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Zachery Hostens <zacheryph@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcjJI-0008Tc-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314Ab1AKSvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:51:07 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:39430 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184Ab1AKSvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:51:05 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 19:51:00 +0100
Received: from localhost.localdomain (84.74.105.24) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 19:51:03 +0100
X-Mailer: git-send-email 1.7.4.rc1.309.g58aa0
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164972>

Rather counterintuitively,

  $ git rev-parse --verify aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

does *not* fail.  The check is based solely on whether we can come up
with something that "looks like" a SHA1, not whether the object
actually exists.  To wit:

  # this cannot be done with update-ref as that *does* check
  $ echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa > .git/refs/heads/nonexistent
  $ git rev-parse --verify nonexistent
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

Note that the commit message of 79162bb makes clear that this is
exactly the intended behaviour:

  git-rev-parse: Allow a "zeroth" parent of a commit - the commit itself.

  This sounds nonsensical, but it's useful to make sure that the result is
  a commit.
[...]
  Also, since the "parent" code will actually parse the commit, this,
  together with the "--verify" flag, will verify not only that the result
  is a single SHA1, but will also have verified that it's a proper commit
  that we can see.

Document this clearly in the description for --verify.

Furthermore the second item in EXAMPLES

  * Print the commit object name from the revision in the $REV shell variable:

seems to imply that rev-parse should actually check that the object
exists *and* is a commit, when in reality it does neither.  We could
suggest the ^0 trick alluded to above, but instead document the more
verbose (and clear)

  $ git rev-parse --verify "$REV^{commit}"

Observe that if you ran

  $ git rev-parse --verify "nonexistent^{commit}"

after the above setup, the failure would come from the ^{} peeling
operator and not from --verify.

Noticed-by: Zachery Hostens <zacheryph@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-parse.txt |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index ff23cb0..779fa87 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -59,8 +59,9 @@ OPTIONS
 	instead.
 
 --verify::
-	The parameter given must be usable as a single, valid
-	object name.  Otherwise barf and abort.
+	The parameter must either be formed like an object name, or
+	dereference to an object name.  This does 'not' verify that
+	the object actually exists!  See EXAMPLES below.
 
 -q::
 --quiet::
@@ -292,21 +293,31 @@ EXAMPLES
 $ git rev-parse --verify HEAD
 ------------
 
-* Print the commit object name from the revision in the $REV shell variable:
+* Print the object name from the revision in the $REV shell variable:
 +
 ------------
 $ git rev-parse --verify $REV
 ------------
 +
-This will error out if $REV is empty or not a valid revision.
+This will error out if $REV does not dereference to a well-formed
+object name (i.e., SHA1).
 
-* Same as above:
+* Same as above, but also verify that the object exists and is a commit:
++
+------------
+$ git rev-parse --verify "$REV^{commit}"
+------------
++
+This works because the `{caret}\{commit\}` peeling operator will fail
+unless the object exists and can be peeled into a commit.
+
+* Print the object name from $REV, but default to master:
 +
 ------------
 $ git rev-parse --default master --verify $REV
 ------------
 +
-but if $REV is empty, the commit object name from master will be printed.
+If $REV is empty, the commit object name from master will be printed.
 
 
 Author
-- 
1.7.4.rc1.309.g58aa0
