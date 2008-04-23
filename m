From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] clone: detect and fail on excess parameters
Date: Wed, 23 Apr 2008 10:53:47 -0700
Message-ID: <7vfxtcsbis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 19:54:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JojB7-0002DH-Mr
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 19:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbYDWRx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 13:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbYDWRx7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 13:53:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbYDWRx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 13:53:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 59FEB3246;
	Wed, 23 Apr 2008 13:53:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9324F3244; Wed, 23 Apr 2008 13:53:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80235>

"git clone [options] $src $dst excess-garbage" simply ignored
excess-garbage without giving any diagnostic message.  Fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I noticed it while trying "git clone --reference $there $src $dst" with
   various combinations of options, and in one case I errorneously removed
   "--reference" without removing $there.  It happily created a clone of
   the reference repository under a funnily named directory whose name
   looked like a URL.

 git-clone.sh     |    1 +
 t/t5601-clone.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 2636159..9e433c0 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -219,6 +219,7 @@ fi
 if test -n "$2"
 then
 	dir="$2"
+	test $# == 2 || die "excess parameter to git-clone"
 else
 	# Derive one from the repository name
 	# Try using "humanish" part of source repo if user didn't specify one
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
new file mode 100755
index 0000000..dc9d63d
--- /dev/null
+++ b/t/t5601-clone.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description=clone
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	rm -fr .git &&
+	test_create_repo src &&
+	(
+		cd src
+		>file
+		git add file
+		git commit -m initial
+	)
+
+'
+
+test_expect_success 'clone with excess parameters' '
+
+	test_must_fail git clone -n "file://$(pwd)/src" dst junk
+
+'
+
+test_done
