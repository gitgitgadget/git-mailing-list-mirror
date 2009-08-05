From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4] Allow mailsplit (and hence git-am) to handle mails with CRLF line-endings
Date: Tue,  4 Aug 2009 22:31:59 -0500
Message-ID: <r3l_p2g-BpVHWKE-kMWIRydBBfOVeq5L9RbpHa_iUxak9BjwONJobsuScOrzURDhi2RTa-0nDQY@cipher.nrlssc.navy.mil>
References: <7vmy6fdxst.fsf@alter.siamese.dyndns.org> <r3l_p2g-BpVHWKE-kMWIRzBGUCnzo9_l7hOHzYLG_4X6oEjXrJ4rJdB10yXPT2jmJJ7ppBmr-x8@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIRydJaW0FHLKBpE497REXzOgqPjLUFjPkJ-YKp1tkrIs3CwcppURiH8o@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIR9UKBn9dqjBL2asOE11gruEtEyCyQOOh37zkh5F2bJkihtkN8WUp4d0@cipher.nrlssc.navy.mil> <r3l_p2g-BpVHWKE-kMWIR-hbNfTwGmUrXhM-lhoS9dZKPidslwcauSWyJW7X27JpF_HWaZz1tHI@cipher.nrlssc.navy.mil>
Cc: nanako3@lavabit.com, raa.lkml@gmail.com, hpa@zytor.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 05:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFc-0001ap-Nq
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933846AbZHEDcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 23:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933598AbZHEDcx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:32:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59681 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933421AbZHEDcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 23:32:52 -0400
Received: by mail.nrlssc.navy.mil id n753WmmF015232; Tue, 4 Aug 2009 22:32:50 -0500
In-Reply-To: <r3l_p2g-BpVHWKE-kMWIR-hbNfTwGmUrXhM-lhoS9dZKPidslwcauSWyJW7X27JpF_HWaZz1tHI@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Aug 2009 03:32:49.0804 (UTC) FILETIME=[6846B4C0:01CA157D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124842>

From: Junio C Hamano <gitster@pobox.com>

It is not that uncommon to have mails with DOS line-ending, notably
Thunderbird and web mailers like Gmail (when saving what they call
"original" message).  So modify mailsplit to convert CRLF line-endings to
just LF.

Since git-rebase is built on top of git-am, add an option to mailsplit to
be used by git-am when it is acting on behalf of git-rebase, to refrain
from doing this conversion.

And add a test to make sure that rebase still works.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-mailsplit.c |    6 ++++++
 git-am.sh           |    8 +++++++-
 t/t3400-rebase.sh   |   26 ++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index d288fde..c9c85c3 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -44,6 +44,7 @@ static int is_from_line(const char *line, int len)
 }
 
 static struct strbuf buf = STRBUF_INIT;
+static int keep_cr;
 
 /* Called with the first line (potentially partial)
  * already in buf[] -- normally that should begin with
@@ -69,6 +70,12 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	 * "From " and having something that looks like a date format.
 	 */
 	for (;;) {
+		if (!keep_cr && buf.len > 1 && buf.buf[buf.len-1] == '\n' &&
+			buf.buf[buf.len-2] == '\r') {
+			strbuf_setlen(&buf, buf.len-2);
+			strbuf_addch(&buf, '\n');
+		}
+
 		if (fwrite(buf.buf, 1, buf.len, output) != buf.len)
 			die_errno("cannot write output");
 
@@ -226,6 +233,8 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			nr = strtol(arg+2, NULL, 10);
 		} else if ( arg[1] == 'b' && !arg[2] ) {
 			allow_bare = 1;
+		} else if (!strcmp(arg, "--keep-cr")) {
+			keep_cr = 1;
 		} else if ( arg[1] == 'o' && arg[2] ) {
 			dir = arg+2;
 		} else if ( arg[1] == '-' && !arg[2] ) {
diff --git a/git-am.sh b/git-am.sh
index d64d997..985226b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -197,7 +197,13 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||
+		case "$rebasing" in
+		'')
+			keep_cr= ;;
+		?*)
+			keep_cr=--keep-cr ;;
+		esac
+		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
 		clean_abort
 		;;
 	stgit-series)
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c5c29cc..4e6a44b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -3,9 +3,10 @@
 # Copyright (c) 2005 Amos Waterland
 #
 
-test_description='git rebase should not destroy author information
+test_description='git rebase assorted tests
 
-This test runs git rebase and checks that the author information is not lost.
+This test runs git rebase and checks that the author information is not lost
+among other things.
 '
 . ./test-lib.sh
 
@@ -133,4 +134,25 @@ test_expect_success 'rebase -q is quiet' '
      test ! -s output.out
 '
 
+q_to_cr () {
+	tr Q '\015'
+}
+
+test_expect_success 'Rebase a commit that sprinkles CRs in' '
+	(
+		echo "One"
+		echo "TwoQ"
+		echo "Three"
+		echo "FQur"
+		echo "Five"
+	) | q_to_cr >CR &&
+	git add CR &&
+	test_tick &&
+	git commit -a -m "A file with a line with CR" &&
+	git tag file-with-cr &&
+	git checkout HEAD^0 &&
+	git rebase --onto HEAD^^ HEAD^ &&
+	git diff --exit-code file-with-cr:CR HEAD:CR
+'
+
 test_done
-- 
1.6.4
