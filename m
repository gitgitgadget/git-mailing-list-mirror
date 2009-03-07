From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 3/3] builtin-merge: add support for default merge options
Date: Fri,  6 Mar 2009 19:44:35 -0500
Message-ID: <1236386675-23308-1-git-send-email-jaysoffian@gmail.com>
References: <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	jean-luc malet <jeanluc.malet@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 01:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfkgB-0008CO-MG
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 01:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbZCGAos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZCGAor
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 19:44:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:48928 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZCGAoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 19:44:46 -0500
Received: by gxk22 with SMTP id 22so1359558gxk.13
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YnYvjXBUD1ocxxZvFnIWUomb+LdDEgGC+fviqj1kHfc=;
        b=cSZ6YSFggprPpYP2tmfFxvOzpdJQolP1L01Tttvwfumk8n54jdN5yI3CCZATNTPwmp
         DjpoL6F+OSpwsailcElvc5AjOKT0JaLxDNv+1LWcimZ/+43a7M92o1U6G9Dhl8diYPOJ
         5MO7aD+om+6zGaG/1cwfZhrc3PC/OhsMvqgeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OeW95V1nZCtMVF132Y8y7HNOFCXN4hM6+v2o142Oq74oGGCAfn3bq5PEe/CRQlT+W2
         4U0mcubz3JIaqCPNnuD8f1BnfuXA+OSQK99vwiAd4UIIKk5UbelFUx9IcTY+DHsb0jsv
         HE6le7cPGivU3an4QKlycphcPohsL2gw8ajyk=
Received: by 10.150.156.5 with SMTP id d5mr5425790ybe.8.1236386684088;
        Fri, 06 Mar 2009 16:44:44 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id z26sm4088045ele.0.2009.03.06.16.44.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 16:44:43 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112498>

This patch teaches merge a new setting, merge.options, which is
processed before any of the other merge configuration settings. It may
be used to establish a default which can then be overridden by more
specific branch.<name>.mergeoptions (or, obviously, command-line
switches).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Fri, Mar 6, 2009 at 5:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If for some reason you would want to have cumulative options across
> branch.*.merge, merge.options and the command line, then you would instead
> keep two separate strings, and call git_config_option_string() for both of
> them, before processing the real command line options.

Which is what this version does. I also made the explanation of this behavior
in the man page more explicit.

 Documentation/git-merge.txt |   12 +++++--
 builtin-merge.c             |   22 +++++++++++--
 t/t7600-merge.sh            |   69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f7be584..5d80a78 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -47,10 +47,16 @@ CONFIGURATION
 -------------
 include::merge-config.txt[]
 
+merge.options::
+	Sets default options for merging. The syntax and supported options are
+	equal to that of 'git-merge'. Arguments are split by spaces, and may be
+	quoted in the same way as alias.* config options.
+
 branch.<name>.mergeoptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are equal to that of 'git-merge', but option values
-	containing whitespace characters are currently not supported.
+	Sets default options for merging into branch <name>. This setting is
+	handled after and is cumulative to `merge.options`. So it may override,
+	but does replace, any settings appearing there. The syntax is identical
+	to `merge.options`.
 
 HOW MERGE WORKS
 ---------------
diff --git a/builtin-merge.c b/builtin-merge.c
index 504f2be..d4dc4fe 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,6 +50,8 @@ static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
+static const char *branch_option_string = NULL;
+static const char *default_option_string = NULL;
 static int verbosity;
 
 static struct strategy all_strategy[] = {
@@ -451,10 +453,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
-		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
-		if (git_config_option_string(builtin_merge_options, 0, k, v))
-			die("Bad branch.%s.mergeoptions string", branch);
-	}
+		!strcmp(k + 7 + strlen(branch), ".mergeoptions"))
+			return git_config_string(&branch_option_string, k, v);
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
@@ -462,6 +462,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
+	else if (!strcmp(k, "merge.options"))
+		return git_config_string(&default_option_string, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
 		option_log = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
@@ -839,6 +841,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		head_invalid = 1;
 
 	git_config(git_merge_config, NULL);
+	if (default_option_string) {
+		if (git_config_option_string(builtin_merge_options, 0,
+		    "merge.options", default_option_string))
+			die("Bad merge.options string");
+	}
+	if (branch_option_string) {
+		strbuf_addf(&buf, "branch.%s.mergeoptions", branch);
+		if (git_config_option_string(builtin_merge_options, 0,
+		     buf.buf, branch_option_string))
+			die("Bad %s string", buf.buf);
+		strbuf_reset(&buf);
+	}
 
 	/* for color.ui */
 	if (diff_use_color_default == -1)
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9db8bb4..aaecdab 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -367,6 +367,16 @@ test_expect_success 'merge c1 with c2 (no-commit in config)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (no-commit in merge.options)' '
+	git reset --hard c1 &&
+	with_config merge.options --no-commit -- merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_mergeheads $c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
 	with_config branch.master.mergeoptions --squash -- \
@@ -379,6 +389,17 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 (squash in merge.options)' '
+	git reset --hard c1 &&
+	with_config merge.options --squash -- merge c2 &&
+	verify_merge file result.1-5 &&
+	verify_head $c1 &&
+	verify_no_mergehead &&
+	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -425,6 +446,54 @@ test_expect_success 'override config option --stat' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'override merge.options -n with branch mergeoptions --summary' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options -n branch.master.mergeoptions --summary -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated with --summary"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override merge.options -n with branch mergeoptions --stat' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options -n branch.master.mergeoptions --stat -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if ! grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was not generated with --stat"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'override merge.options --stat' '
+	git reset --hard c1 &&
+	test_tick &&
+	with_config merge.options --stat branch.master.mergeoptions -n -- \
+		merge c2 >diffstat.txt &&
+	verify_merge file result.1-5 msg.1-5 &&
+	verify_parents $c1 $c2 &&
+	if grep "^ file |  *2 +-$" diffstat.txt
+	then
+		echo "[OOPS] diffstat was generated"
+		false
+	fi
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
 	test_tick &&
-- 
1.6.2.rc2.332.g5d21b
