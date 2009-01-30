From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] fsck: check loose objects from alternate object stores
 by default
Date: Fri, 30 Jan 2009 01:13:04 -0800
Message-ID: <7vd4e5b1i7.fsf_-_@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
 <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
 <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu>
 <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 10:14:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSpSU-0006z1-E5
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 10:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZA3JNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 04:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbZA3JNP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 04:13:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZA3JNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 04:13:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CCDE32A102;
	Fri, 30 Jan 2009 04:13:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 872DE2A101; Fri,
 30 Jan 2009 04:13:05 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
 (Linus Torvalds's message of "Thu, 29 Jan 2009 15:21:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37C331F2-EEAE-11DD-9926-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107782>

"git fsck" used to validate only loose objects that are local and nothing
else by default.  This is not just too little when a repository is
borrowing objects from other object stores, but also caused the
connectivity check to mistakenly declare loose objects borrowed from them
to be missing.

The rationale behind the default mode that validates only loose objects is
because these objects are still young and more unlikely to have been
pushed to other repositories yet.  That holds for loose objects borrowed
from alternate object stores as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This implements your earlier suggestion.  We might want to say where
   the corrupt object was found when fsck_sha1() reports problems, but
   that is an issue that already exists when the command is run with
   --full.

 builtin-fsck.c  |   21 ++++++++++++---------
 t/t1450-fsck.sh |   16 ++++++++++++++--
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 2cfff43..64dffa5 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -586,6 +586,7 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
+	struct alternate_object_database *alt;
 
 	errors_found = 0;
 
@@ -597,17 +598,19 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_head_link();
 	fsck_object_dir(get_object_directory());
+
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next) {
+		char namebuf[PATH_MAX];
+		int namelen = alt->name - alt->base;
+		memcpy(namebuf, alt->base, namelen);
+		namebuf[namelen - 1] = 0;
+		fsck_object_dir(namebuf);
+	}
+
 	if (check_full) {
-		struct alternate_object_database *alt;
 		struct packed_git *p;
-		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next) {
-			char namebuf[PATH_MAX];
-			int namelen = alt->name - alt->base;
-			memcpy(namebuf, alt->base, namelen);
-			namebuf[namelen - 1] = 0;
-			fsck_object_dir(namebuf);
-		}
+
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
 			/* verify gives error messages itself */
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5166566..6e64e44 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -5,9 +5,9 @@ test_description='git fsck random collection of tests'
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit A &&
+	test_commit A fileA one &&
 	git checkout HEAD^0 &&
-	test_commit B &&
+	test_commit B fileB two &&
 	git reflog expire --expire=now --all
 '
 
@@ -15,4 +15,16 @@ test_expect_success 'HEAD is part of refs' '
 	test 0 = $(git fsck | wc -l)
 '
 
+test_expect_success 'loose objects borrowed from alternate are not missing' '
+	mkdir another &&
+	(
+		cd another &&
+		git init &&
+		echo ../../../.git/objects >.git/objects/info/alternates &&
+		test_commit C fileC one &&
+		git fsck >out &&
+		! grep "missing blob" out
+	)
+'
+
 test_done
-- 
1.6.1.2.312.g5be3c
