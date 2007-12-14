From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit: allow --amend to reuse message from another commit
Date: Fri, 14 Dec 2007 11:57:22 -0800
Message-ID: <7vr6hpqcbh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 20:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GfU-0005Dm-GN
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXLNT5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbXLNT5c
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:57:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbXLNT5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:57:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CC8708B;
	Fri, 14 Dec 2007 14:57:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B0540708A;
	Fri, 14 Dec 2007 14:57:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68334>

After tentatively applying a patch from a contributor, you can get a
replacement patch with corrected code and unusable commit log message.
In such a case, this sequence ought to give you an editor based on the
message in the earlier commit, to let you describe an incremental
improvement:

	git reset --hard HEAD^ ;# discard the earlier one
        git am <corrected-patch
        git commit --amend -c HEAD@{1}

Unfortunately, --amend insisted reusing the message from the commit
being amended, ignoring the -c option.  This corrects it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This was supported in the scripted version if --amend came before -c,
   but it was broken if the flags were given in the other order.

 builtin-commit.c  |    2 +-
 t/t7501-commit.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index ad9f921..518ebe0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -537,7 +537,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("Option -m cannot be combined with -c/-C/-F.");
 	if (edit_message)
 		use_message = edit_message;
-	if (amend)
+	if (amend && !use_message)
 		use_message = "HEAD";
 	if (use_message) {
 		unsigned char sha1[20];
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 05aa97d..d1a415a 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -310,4 +310,21 @@ test_expect_success 'same tree (merge and amend merge)' '
 
 '
 
+test_expect_success 'amend using the message from another commit' '
+
+	git reset --hard &&
+	test_tick &&
+	git commit --allow-empty -m "old commit" &&
+	old=$(git rev-parse --verify HEAD) &&
+	test_tick &&
+	git commit --allow-empty -m "new commit" &&
+	new=$(git rev-parse --verify HEAD) &&
+	test_tick &&
+	git commit --allow-empty --amend -C "$old" &&
+	git show --pretty="format:%ad %s" "$old" >expected &&
+	git show --pretty="format:%ad %s" HEAD >actual &&
+	diff -u expected actual
+
+'
+
 test_done
