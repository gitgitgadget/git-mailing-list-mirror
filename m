From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/24] fmt-merge-msg -m to override subject line
Date: Tue, 17 Aug 2010 02:02:45 -0500
Message-ID: <20100817070245.GK22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:04:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGDk-0000Au-KA
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab0HQHEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:04:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63994 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab0HQHEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:04:21 -0400
Received: by gxk23 with SMTP id 23so2287947gxk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fZNoCoPBbuGoDIE1f1ykpiQcJkhfr2zT4zPQtPVEXAI=;
        b=ZW87qqYzTtN8tIgmX0S4+Gkiyhu5hmWOY6KyM0UZQg7tkxp8kt9kl5wfrroBMsVKsu
         wumntsuRaTxfwalNODttry13OBjjVf4M/izn94hDUqRMIbych4rEFYeEz+p02dOZuKbe
         XDFqoKgwH1EZ2FzE+hyPNxVscPuRt4DuNamOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lK0830xnf/qgu/UyuQxURV2C+23DZ1sxfCGxwgKDdgdasGGuOQL1XShmEpQww385yj
         Lf+56/VUjmT5hvmIX0gZRwkyoH2KzM1p91HgoM4CJHAm5eDdXX5+2H8OpWK/cf5EIxym
         b7GpG01mE6jCIcNVXQETVO5y/yjzMuLXut45Y=
Received: by 10.101.155.15 with SMTP id h15mr7003937ano.162.1282028660235;
        Tue, 17 Aug 2010 00:04:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f22sm11758704anh.24.2010.08.17.00.04.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:04:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153714>

The fmt-merge-msg backend has supported a custom subject line and
message beginning since v1.7.1.1~23^2 (merge: --log appends shortlog
to message if specified, 2010-05-11).  Expose the functionality for
scripted callers.

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |    9 +++++++--
 builtin/fmt-merge-msg.c             |   18 ++++++++++++++++--
 t/t6200-fmt-merge-msg.sh            |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index a585dbe..96a06ee 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <subject>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <subject>] [--log ]| --no-log] -F <file>
 
 DESCRIPTION
 -----------
@@ -38,6 +38,11 @@ OPTIONS
 	Synonyms to --log and --no-log; these are deprecated and will be
 	removed in the future.
 
+-m <subject>::
+--message <subject>::
+	Use <subject> instead of the branch names for the first line
+	of the log message.  For use with `--log`.
+
 -F <file>::
 --file <file>::
 	Take the list of merged objects from <file> instead of
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4420425..2782086 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,7 +7,7 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [-m <online>] [--log|--no-log] [--file <file>]",
 	NULL
 };
 
@@ -319,11 +319,14 @@ int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
+	const char *oneline_msg = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
 		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
 		  "alias for --log (deprecated)",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		OPT_STRING('m', "message", &oneline_msg, "oneline",
+			"use <oneline> as subject line"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
 		OPT_END()
 	};
@@ -337,6 +340,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
+	if (oneline_msg && !merge_summary) {
+		char nl = '\n';
+		write_in_full(STDOUT_FILENO, oneline_msg, strlen(oneline_msg));
+		write_in_full(STDOUT_FILENO, &nl, 1);
+		return 0;
+	}
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
@@ -346,7 +355,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die_errno("could not read input file");
-	ret = fmt_merge_msg(merge_summary, &input, &output);
+	if (oneline_msg) {
+		strbuf_addstr(&output, oneline_msg);
+		ret = fmt_merge_msg_shortlog(&input, &output);
+	} else {
+		ret = fmt_merge_msg(merge_summary, &input, &output);
+	}
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 5553dff..71f6cad 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -129,6 +129,38 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
+test_expect_success 'fmt-merge-msg -m' '
+	echo "Sync with left" >expected &&
+	cat >expected.log <<-EOF &&
+	Sync with left
+
+	* ${apos}left${apos} of $(pwd):
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset merge.log &&
+	test_might_fail git config --unset merge.summary &&
+	git checkout master &&
+	git fetch "$(pwd)" left &&
+	git fmt-merge-msg -m "Sync with left" <.git/FETCH_HEAD >actual &&
+	git fmt-merge-msg --log -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.log &&
+	git config merge.log true &&
+	git fmt-merge-msg -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.log-config &&
+	git fmt-merge-msg --no-log -m "Sync with left" \
+					<.git/FETCH_HEAD >actual.nolog &&
+
+	test_cmp expected actual &&
+	test_cmp expected.log actual.log &&
+	test_cmp expected.log actual.log-config &&
+	test_cmp expected actual.nolog
+'
+
 test_expect_success 'setup: expected shortlog for two branches' '
 	cat >expected <<-EOF
 	Merge branches ${apos}left${apos} and ${apos}right${apos}
-- 
1.7.2.1.544.ga752d.dirty
