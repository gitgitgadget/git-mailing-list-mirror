From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] commit: print "Date" line when the user has set date
Date: Thu, 1 May 2014 21:10:01 -0400
Message-ID: <20140502011001.GC25413@sigill.intra.peff.net>
References: <20140502010328.GA30556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1zO-0001wP-LN
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaEBBKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:10:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:43267 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbaEBBKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 21:10:03 -0400
Received: (qmail 28089 invoked by uid 102); 2 May 2014 01:10:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 20:10:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 21:10:01 -0400
Content-Disposition: inline
In-Reply-To: <20140502010328.GA30556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247916>

When we make a commit and the author is not the same as the
committer (e.g., because you used "-c $commit" or
"--author=$somebody"), we print the author's name and email
in both the commit-message template and as part of the
commit summary. This is a safety check to give the user a
chance to confirm that we are doing what they expect.

This patch brings the same safety for the "date" field,
which may be set by "-c" or by using "--date".  Note that we
explicitly do not set it for $GIT_AUTHOR_DATE, as it is
probably not of interest when "git commit" is being fed its
parameters by a script.

Signed-off-by: Jeff King <peff@peff.net>
---
Note the test updates in t3508, as cherry-picks will now print the date.
I think that's probably a good thing, but if we don't like it, we can
tweak author_date_is_interesting() to only check force_date.

I'd also be open to using a different date format than DATE_NORMAL if
people care. I guess we could respect log.date.

 builtin/commit.c                    | 19 +++++++++++++++++++
 t/t3508-cherry-pick-many-commits.sh |  6 ++++++
 t/t7501-commit.sh                   |  5 +++++
 t/t7502-commit.sh                   |  7 +++++++
 4 files changed, 37 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 728cc9b..a25661f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -592,6 +592,11 @@ static void split_ident_or_die(struct ident_split *id, const struct strbuf *buf)
 		die(_("Malformed ident string: '%s'"), buf->buf);
 }
 
+static int author_date_is_interesting(void)
+{
+	return author_message || force_date;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -805,6 +810,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				(int)(ai.name_end - ai.name_begin), ai.name_begin,
 				(int)(ai.mail_end - ai.mail_begin), ai.mail_begin);
 
+		if (author_date_is_interesting())
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				_("%s"
+				"Date:      %s"),
+				ident_shown++ ? "" : "\n",
+				show_ident_date(&ai, DATE_NORMAL));
+
 		if (!committer_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
@@ -1355,6 +1367,13 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
+	if (author_date_is_interesting()) {
+		struct strbuf date = STRBUF_INIT;
+		format_commit_message(commit, "%ad", &date, &pctx);
+		strbuf_addstr(&format, "\n Date: ");
+		strbuf_addbuf_percentquote(&format, &date);
+		strbuf_release(&date);
+	}
 	if (!committer_ident_sufficiently_given()) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 19c99d7..b457333 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -65,12 +65,15 @@ test_expect_success 'output to keep user entertained during multi-pick' '
 	cat <<-\EOF >expected &&
 	[master OBJID] second
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:14:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	[master OBJID] third
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:15:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	[master OBJID] fourth
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:16:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	EOF
 
@@ -98,14 +101,17 @@ test_expect_success 'output during multi-pick indicates merge strategy' '
 	Trying simple merge.
 	[master OBJID] second
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:14:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	Trying simple merge.
 	[master OBJID] third
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:15:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	Trying simple merge.
 	[master OBJID] fourth
 	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:16:13 2005 -0700
 	 1 file changed, 1 insertion(+)
 	EOF
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d58b097..5a76823 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -346,6 +346,11 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'commit mentions forced date in output' '
+	git commit --amend --date=2010-01-02T03:04:05 >output &&
+	grep "Date: *Sat Jan 2 03:04:05 2010" output
+'
+
 test_expect_success 'commit complains about bogus date' '
 	test_must_fail git commit --amend --date=10.11.2010
 '
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 9a3f3a1..6465cd5 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -344,6 +344,13 @@ test_expect_success 'message shows author when it is not equal to committer' '
 	  .git/COMMIT_EDITMSG
 '
 
+test_expect_success 'message shows date when it is explicitly set' '
+	git commit --allow-empty -e -m foo --date="2010-01-02T03:04:05" &&
+	test_i18ngrep \
+	  "^# Date: *Sat Jan 2 03:04:05 2010 +0000" \
+	  .git/COMMIT_EDITMSG
+'
+
 test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 
 	echo >>negative &&
-- 
1.9.1.656.ge8a0637
