From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] git commit: pathspec without -i/-o implies -i semantics
 during a merge
Date: Thu, 22 Jan 2009 22:21:49 -0800
Message-ID: <7vy6x235ky.fsf_-_@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFSn-00033g-QN
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762303AbZAWGWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762301AbZAWGWB
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:22:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760987AbZAWGWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:22:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DC94F1D1ED;
	Fri, 23 Jan 2009 01:21:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7D4371D1E9; Fri,
 23 Jan 2009 01:21:51 -0500 (EST)
In-Reply-To: <7viqo64kfo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 22 Jan 2009 22:15:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23B81094-E916-11DD-878E-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106842>

"git commit paths..." has been a short-hand for "git commit -o paths..."
since v1.3.0 and let you create a commit skipping any other updated state
staged in the index.  The "--only" semantics (aka "partial commit") is
always wrong during a conflicted merge resolution, and we rejected both
"git commit paths..."  and "git commit -o paths..."  forms during a merge.

On the other hand, "git commit -i paths..." (aka "an also commit", which
asks to commit what you staged in the index, and also the paths you may or
may not have git-add'ed) is accepted, as it is a way to register the
contents you fixed up to the index and commit the result.

This makes "git commit paths..." form default to "git commit -i paths"
semantics only during a merge, restoring the pre-v1.3.0 behaviour.  The
codepath to create a non-merge commit is not affected and still defaults
to the "--only" semantics.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c  |   14 ++++++++++++--
 t/t7501-commit.sh |    2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index d861263..4cb1985 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -74,6 +74,7 @@ static struct strbuf message;
 enum {
 	MSG_AMEND_CLEVER,
 	MSG_ASSUME_PARTIAL,
+	MSG_ASSUME_ALSO_DURING_MERGE
 };
 
 static void set_partial_commit_message(int msgnum)
@@ -87,6 +88,9 @@ static void set_partial_commit_message(int msgnum)
 	case MSG_ASSUME_PARTIAL:
 		msg = "Explicit paths specified without -i nor -o; assuming --only paths...";
 		break;
+	case MSG_ASSUME_ALSO_DURING_MERGE:
+		msg = "Paths specified without -i nor -o during a merge; assuming -i";
+		break;
 	default:
 		die("Oops (%d) is not a valid message number", msgnum);
 		break;
@@ -812,8 +816,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
 		set_partial_commit_message(MSG_AMEND_CLEVER);
-	if (argc > 0 && !also && !only)
-		set_partial_commit_message(MSG_ASSUME_PARTIAL);
+	if (argc > 0 && !also && !only) {
+		if (!in_merge)
+			set_partial_commit_message(MSG_ASSUME_PARTIAL);
+		else {
+			set_partial_commit_message(MSG_ASSUME_ALSO_DURING_MERGE);
+			also = 1;
+		}
+	}
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0c10105..68892de 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -399,7 +399,7 @@ test_expect_success 'allow --include during a merge' '
 	git reset --hard
 '
 
-test_expect_failure 'assume --include during a merge' '
+test_expect_success 'assume --include during a merge' '
 	git checkout HEAD^0 &&
 	git reset --hard the-other-side-says-nitfol &&
 	test_must_fail git merge one-side-says-frotz &&
-- 
1.6.1.265.g9a013
