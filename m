From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff -B -M: fix output for "copy and then rewrite" case
Date: Thu, 23 Oct 2014 16:34:40 -0700
Message-ID: <xmqqoat2gy27.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 01:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhRu5-0008J1-A7
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 01:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbaJWXep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 19:34:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbaJWXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 19:34:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B89819D22;
	Thu, 23 Oct 2014 19:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	SpsvXHtodBBMyyzpKF0Ast+alU=; b=VvEScgIBmuBFCJ/0hhyKz72uu8r0+gUMY
	qaSVnnzE82miVoe88gc27ASRgUgHil+qN5ykAmp4Wqu0jeayP+Rzyaf2xblZ0eAr
	kRGZmVv2Hqmo1t6xOmfB1HG3QZj5U78tir1TyDzwS6haxqZ0RzF1vYieozLANlZL
	OdIU/RXs8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OrK
	gUbX4r7Aj4ukGtYwH7FFsjgUWQpUidgf4qMj++MI5oeaEMKqgBVRS2aQKha765DX
	eWzKjN4edieSH9UD46+pZBM3Ck4M7u1zRA+R5e2yJZxVat8grUZzoDBGimKiSlba
	6lqPSUNQC3KSwks15IdNlBs6UX5BJwpXDQ9C5MKY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 907DA19D21;
	Thu, 23 Oct 2014 19:34:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01E9A19D20;
	Thu, 23 Oct 2014 19:34:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29B21200-5B0D-11E4-BA09-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting from a single file, A, if you create B as a copy of A (and
possibly make some edit) and then make extensive change to A, you
will see:

    $ git diff -C --name-status
    C89    A    B
    M      A

which is expected.  However, if you ask the same question in a
different way, you see this:

    $ git diff -B -M --name-status
    R89    A    B
    M100   A

telling us that A was rename-edited into B (as if "A will no longer
exist as the result") and at the same time A itself was extensively
edited.

In this case, because the resulting tree still does have file A
(even if it has contents vastly different from the original), we
should use "C"opy, not "R"ename, to avoid hinting that A somehow
goes away.

Two existing tests were depending on the wrong behaviour, and fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-break.c                  | 7 +++++++
 t/t4008-diff-break-rewrite.sh     | 4 ++--
 t/t4023-diff-rename-typechange.sh | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 1d9e530..5473493 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -246,6 +246,13 @@ static void merge_broken(struct diff_filepair *p,
 
 	dp = diff_queue(outq, d->one, c->two);
 	dp->score = p->score;
+	/*
+	 * We will be one extra user of the same src side of the
+	 * broken pair, if it was used as the rename source for other
+	 * paths elsewhere.  Increment to mark that the path stays
+	 * in the resulting tree.
+	 */
+	d->one->rename_used++;
 	diff_free_filespec_data(d->two);
 	diff_free_filespec_data(c->one);
 	free(d);
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 27e98a8..8920464 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -123,10 +123,10 @@ test_expect_success \
     'git diff-index -B -M "$tree" >current'
 
 # file0 changed from regular to symlink.  file1 is very close to the preimage of file0.
-# because we break file0, file1 can become a rename of it.
+# the change does not make file0 disappear, so file1 is denoted as a copy of file0
 cat >expected <<\EOF
 :100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R	file0	file1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 C	file0	file1
 EOF
 
 test_expect_success \
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 55d549f..8c98237 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -76,7 +76,8 @@ test_expect_success 'moves and renames' '
 
 	git diff-tree three four -r --name-status -B -M | sort >actual &&
 	{
-		echo "R100	foo	bar"
+		# see -B -M (#6) in t4008
+		echo "C100	foo	bar"
 		echo "T100	foo"
 	} | sort >expect &&
 	test_cmp expect actual
-- 
2.1.2-595-g1568c45
