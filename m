From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 next 4/4] format-patch: support deep threading
Date: Fri, 20 Feb 2009 20:55:40 +0100
Message-ID: <e8e7b8a8a9f8bf5d6f96875745f5c54b216f84b3.1235158956.git.trast@student.ethz.ch>
References: <alpine.LNX.1.00.0902191734110.19665@iabervon.org> <cover.1235158956.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabV5-0006tb-JQ
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 20:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZBTT4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 14:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZBTT4C
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 14:56:02 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28518 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbZBTTz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 14:55:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:54 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:53 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.ga3b4a
In-Reply-To: <cover.1235158956.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 20 Feb 2009 19:55:53.0647 (UTC) FILETIME=[3CD063F0:01C99395]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110882>

For deep threading mode, i.e., the mode that gives a thread structured
like

  + [PATCH 0/n] Cover letter
   `-+ [PATCH 1/n] First patch
      `-+ [PATCH 2/n] Second patch
         `-+ ...

we currently have to use 'git send-email --thread' (the default).  On
the other hand, format-patch also has a --thread option which gives
shallow mode, i.e.,

  + [PATCH 0/n] Cover letter
  |-+ [PATCH 1/n] First patch
  |-+ [PATCH 2/n] Second patch
  ...

To reduce the confusion resulting from having two indentically named
features in different tools giving different results, let format-patch
take an optional argument '--thread=deep' that gives the same output
as 'send-mail --thread'.  With no argument, or 'shallow', behave as
before.  Also add a configuration variable format.thread with the same
semantics.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 Documentation/config.txt           |   10 +++
 Documentation/git-format-patch.txt |   10 +++-
 builtin-log.c                      |   36 +++++++++--
 t/t4014-format-patch.sh            |  120 ++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3117d65..cf835c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -690,6 +690,16 @@ format.pretty::
 	See linkgit:git-log[1], linkgit:git-show[1],
 	linkgit:git-whatchanged[1].
 
+format.thread::
+	The default threading style for 'git-format-patch'.  Can be
+	either a boolean value, `shallow` or `deep`.  'Shallow'
+	threading makes every mail a reply to the head of the series,
+	where the head is chosen from the cover letter, the
+	`\--in-reply-to`, and the first patch mail, in this order.
+	'Deep' threading makes every mail a reply to the previous one.
+	A true boolean value is the same as `shallow`, and a false
+	value disables threading.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git-gc --aggressive'.  This defaults
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e7ae8cf..c14e3ee 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -127,10 +127,18 @@ include::diff-options.txt[]
 	which is the commit message and the patch itself in the
 	second part, with "Content-Disposition: inline".
 
---thread::
+--thread[=<style>]::
 	Add In-Reply-To and References headers to make the second and
 	subsequent mails appear as replies to the first.  Also generates
 	the Message-Id header to reference.
++
+The optional <style> argument can be either `shallow` or `deep`.
+'Shallow' threading makes every mail a reply to the head of the
+series, where the head is chosen from the cover letter, the
+`\--in-reply-to`, and the first patch mail, in this order.  'Deep'
+threading makes every mail a reply to the previous one.  If not
+specified, defaults to the 'format.thread' configuration, or `shallow`
+if that is not set.
 
 --in-reply-to=Message-Id::
 	Make the first mail (or all the mails with --no-thread) appear as a
diff --git a/builtin-log.c b/builtin-log.c
index 2dc6c48..8684fcd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -462,6 +462,10 @@ static void add_header(const char *value)
 	extra_hdr[extra_hdr_nr++] = xstrndup(value, len);
 }
 
+#define THREAD_SHALLOW 1
+#define THREAD_DEEP 2
+static int thread = 0;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -498,7 +502,18 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			default_attach = xstrdup(git_version_string);
 		return 0;
 	}
-
+	if (!strcmp(var, "format.thread")) {
+		if (value && !strcasecmp(value, "deep")) {
+			thread = THREAD_DEEP;
+			return 0;
+		}
+		if (value && !strcasecmp(value, "shallow")) {
+			thread = THREAD_SHALLOW;
+			return 0;
+		}
+		thread = git_config_bool(var, value) && THREAD_SHALLOW;
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -777,7 +792,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int numbered_files = 0;		/* _just_ numbers */
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
-	int thread = 0;
 	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
@@ -879,8 +893,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp(argv[i], "--ignore-if-in-upstream"))
 			ignore_if_in_upstream = 1;
-		else if (!strcmp(argv[i], "--thread"))
-			thread = 1;
+		else if (!strcmp(argv[i], "--thread")
+			|| !strcmp(argv[i], "--thread=shallow"))
+			thread = THREAD_SHALLOW;
+		else if (!strcmp(argv[i], "--thread=deep"))
+			thread = THREAD_DEEP;
+		else if (!strcmp(argv[i], "--no-thread"))
+			thread = 0;
 		else if (!prefixcmp(argv[i], "--in-reply-to="))
 			in_reply_to = argv[i] + 14;
 		else if (!strcmp(argv[i], "--in-reply-to")) {
@@ -1055,6 +1074,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			/* Have we already had a message ID? */
 			if (rev.message_id) {
 				/*
+				 * For deep threading: make every mail
+				 * a reply to the previous one, no
+				 * matter what other options are set.
+				 *
+				 * For shallow threading:
+				 *
 				 * Without --cover-letter and
 				 * --in-reply-to, make every mail a
 				 * reply to the one before.
@@ -1069,7 +1094,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				 * letter is a reply to the
 				 * --in-reply-to, if specified.
 				 */
-				if (rev.ref_message_ids->nr > 0
+				if (thread == THREAD_SHALLOW
+				    && rev.ref_message_ids->nr > 0
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8b970c3..ebfc4a6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -257,6 +257,126 @@ test_expect_success 'thread cover-letter in-reply-to' '
 		--in-reply-to="<test.message>" --thread master
 '
 
+test_expect_success 'thread explicit shallow' '
+	check_threading expect.cl-irt --cover-letter \
+		--in-reply-to="<test.message>" --thread=shallow master
+'
+
+cat > expect.deep <<EOF
+---
+Message-Id: <0>
+---
+Message-Id: <1>
+In-Reply-To: <0>
+References: <0>
+---
+Message-Id: <2>
+In-Reply-To: <1>
+References: <0>
+	<1>
+EOF
+
+test_expect_success 'thread deep' '
+	check_threading expect.deep --thread=deep master
+'
+
+cat > expect.deep-irt <<EOF
+---
+Message-Id: <0>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <2>
+In-Reply-To: <0>
+References: <1>
+	<0>
+---
+Message-Id: <3>
+In-Reply-To: <2>
+References: <1>
+	<0>
+	<2>
+EOF
+
+test_expect_success 'thread deep in-reply-to' '
+	check_threading expect.deep-irt  --thread=deep \
+		--in-reply-to="<test.message>" master
+'
+
+cat > expect.deep-cl <<EOF
+---
+Message-Id: <0>
+---
+Message-Id: <1>
+In-Reply-To: <0>
+References: <0>
+---
+Message-Id: <2>
+In-Reply-To: <1>
+References: <0>
+	<1>
+---
+Message-Id: <3>
+In-Reply-To: <2>
+References: <0>
+	<1>
+	<2>
+EOF
+
+test_expect_success 'thread deep cover-letter' '
+	check_threading expect.deep-cl --cover-letter --thread=deep master
+'
+
+cat > expect.deep-cl-irt <<EOF
+---
+Message-Id: <0>
+In-Reply-To: <1>
+References: <1>
+---
+Message-Id: <2>
+In-Reply-To: <0>
+References: <1>
+	<0>
+---
+Message-Id: <3>
+In-Reply-To: <2>
+References: <1>
+	<0>
+	<2>
+---
+Message-Id: <4>
+In-Reply-To: <3>
+References: <1>
+	<0>
+	<2>
+	<3>
+EOF
+
+test_expect_success 'thread deep cover-letter in-reply-to' '
+	check_threading expect.deep-cl-irt --cover-letter \
+		--in-reply-to="<test.message>" --thread=deep master
+'
+
+test_expect_success 'thread via config' '
+	git config format.thread true &&
+	check_threading expect.thread master
+'
+
+test_expect_success 'thread deep via config' '
+	git config format.thread deep &&
+	check_threading expect.deep master
+'
+
+test_expect_success 'thread config + override' '
+	git config format.thread deep &&
+	check_threading expect.thread --thread master
+'
+
+test_expect_success 'thread config + --no-thread' '
+	git config format.thread deep &&
+	check_threading expect.no-threading --no-thread master
+'
+
 test_expect_success 'excessive subject' '
 
 	rm -rf patches/ &&
-- 
1.6.2.rc1.310.ga3b4a
