From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] merge-recursive: don't detect renames of empty files
Date: Thu, 22 Mar 2012 18:52:24 -0400
Message-ID: <20120322225223.GB14902@sigill.intra.peff.net>
References: <20120322224651.GA14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAqs3-0003wO-7a
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031359Ab2CVWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:52:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57014
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031315Ab2CVWw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 18:52:26 -0400
Received: (qmail 6779 invoked by uid 107); 22 Mar 2012 22:52:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 18:52:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 18:52:24 -0400
Content-Disposition: inline
In-Reply-To: <20120322224651.GA14874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193726>

Merge-recursive detects renames so that if one side modifies
"foo" and the other side moves it to "bar", the modification
is applied to "bar". However, our rename detection is based
on content analysis, it can be wrong (i.e., two files were
not intended as a rename, but just happen to have the same
or similar content).

This is quite rare if the files actually contain content,
since two unrelated files are unlikely to have exactly the
same content.  However, empty files present a problem, in
that there is nothing to analyze. An uninteresting
placeholder file with zero bytes may or may not be related
to a placeholder file with another name.

The result is that adding content to an empty file may cause
confusion if the other side of a merge removed it; your
content may end up in another random placeholder file that
was added.

Let's err on the side of caution and not consider empty
files as renames. This will cause a modify/delete conflict
on the merge, which will let the user sort it out
themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c       |    1 +
 t/t6022-merge-rename.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 318d32e..0fb1743 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -485,6 +485,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	renames = xcalloc(1, sizeof(struct string_list));
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
+	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 9d8584e..1104249 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -884,4 +884,20 @@ test_expect_success 'no spurious "refusing to lose untracked" message' '
 	! grep "refusing to lose untracked file" errors.txt
 '
 
+test_expect_success 'do not follow renames for empty files' '
+	git checkout -f -b empty-base &&
+	>empty1 &&
+	git add empty1 &&
+	git commit -m base &&
+	echo content >empty1 &&
+	git add empty1 &&
+	git commit -m fill &&
+	git checkout -b empty-topic HEAD^ &&
+	git mv empty1 empty2 &&
+	git commit -m rename &&
+	test_must_fail git merge empty-base &&
+	>expect &&
+	test_cmp expect empty2
+'
+
 test_done
-- 
1.7.10.rc0.9.gdcbe9
