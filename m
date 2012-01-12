From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] word-diff: ignore '\ No newline at eof' marker
Date: Thu, 12 Jan 2012 12:15:33 +0100
Message-ID: <902665ee053876c2684f5b935ee4f81e77122802.1326366909.git.trast@student.ethz.ch>
References: <4F0EA23D.3010603@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ivan Shirokoff <shirokoff@yandex-team.ru>
X-From: git-owner@vger.kernel.org Thu Jan 12 12:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlIdC-0007DL-3C
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 12:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab2ALLPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 06:15:37 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:24908 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab2ALLPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 06:15:36 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 12:15:33 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 12:15:33 +0100
X-Mailer: git-send-email 1.7.9.rc0.168.g3847c
In-Reply-To: <4F0EA23D.3010603@yandex-team.ru>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188442>

The word-diff logic accumulates + and - lines until another line type
appears (normally [ @\]), at which point it generates the word diff.
This is usually correct, but it breaks when the preimage does not have
a newline at EOF:

  $ printf "%s" "a a a" >a
  $ printf "%s\n" "a ab a" >b
  $ git diff --no-index --word-diff a b
  diff --git 1/a 2/b
  index 9f68e94..6a7c02f 100644
  --- 1/a
  +++ 2/b
  @@ -1 +1 @@
  [-a a a-]
   No newline at end of file
  {+a ab a+}

Because of the order of the lines in a unified diff

  @@ -1 +1 @@
  -a a a
  \ No newline at end of file
  +a ab a

the '\' line flushed the buffers, and the - and + lines were never
matched with each other.

A proper fix would defer such markers until the end of the hunk.
However, word-diff is inherently whitespace-ignoring, so as a cheap
fix simply ignore the marker (and hide it from the output).

We use a prefix match for '\ ' to parallel the logic in
apply.c:parse_fragment().  We currently do not localize this string
(just accept other variants of it in git-apply), but this should be
future-proof.

Noticed-by: Ivan Shirokoff <shirokoff@yandex-team.ru>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c                |    8 ++++++++
 t/t4034-diff-words.sh |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index a65223a..996cc60 100644
--- a/diff.c
+++ b/diff.c
@@ -1113,6 +1113,14 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_append(line, len,
 					  &ecbdata->diff_words->plus);
 			return;
+		} else if (!prefixcmp(line, "\\ ")) {
+			/*
+			 * Silently eat the "no newline at eof" marker
+			 * (we are diffing without regard to
+			 * whitespace anyway), and defer processing:
+			 * more '+' lines could be after it.
+			 */
+			return;
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6f1e5a2..5c20121 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -334,4 +334,18 @@ test_expect_success 'word-diff with diff.sbe' '
 	word_diff --word-diff=plain
 '
 
+test_expect_success 'word-diff with no newline at EOF' '
+	cat >expect <<-\EOF &&
+	diff --git a/pre b/post
+	index 7bf316e..3dd0303 100644
+	--- a/pre
+	+++ b/post
+	@@ -1 +1 @@
+	a a [-a-]{+ab+} a a
+	EOF
+	printf "%s" "a a a a a" >pre &&
+	printf "%s" "a a ab a a" >post &&
+	word_diff --word-diff=plain
+'
+
 test_done
-- 
1.7.9.rc0.168.g3847c
