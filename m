From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 3/7] fast-import: add feature command
Date: Fri,  4 Dec 2009 18:06:56 +0100
Message-ID: <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdF-000621-AH
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbZLDRH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbZLDRHY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:24 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50369 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbZLDRHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:14 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so3051335ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1DgO/R1UWy5vgtAD3Yuiubf6vzCCDTCugUE2Blp8ka0=;
        b=CzazmDpM9MjqwuyKNdU0wYjuKdQXYaHMhqpk2aV3WdMnSdqpzJIdodsPzYqfflM0we
         FyWM8qpOPP4yYXlMKfFoBkAY1tlAm/Cfp7JO6n0qE8HIWEFG1tfZDd+2WY+2YzElgmqe
         m8TDgIQ+KGjqGfd0nfhFFhPhfmG23ONGWtwvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MZd8A5p147nMzSdWwVd6LnetwZQyTjeKM0ax1RrR/dmhG7nlQR5a2FwQV8e63zO1AU
         6L9oIS/eoqMfCssnibwIoVgfIn18yi8NMd3w7VqPwdf9YKx2I6/iFgzmfAdx91bunVJO
         Gq0KHv6rGPiiz/SsYy3lVvWXhHNVUI7dORl+k=
Received: by 10.213.25.69 with SMTP id y5mr3411220ebb.54.1259946439596;
        Fri, 04 Dec 2009 09:07:19 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:18 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134543>

This allows the fronted to require a specific feature to be supported
by the frontend, or abort.

Also add support for four initial feature, date-format=, force=,
import-marks=, export-marks=.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Updated documentation, reject feature commands after a data command,
	as per Shawn's comments. Also factor out parse_one_feature from
	parse_feature so that we can re-use it in patch 4/7.

	This also has the previous 4/6 squashed in (which added tests)

 Documentation/git-fast-import.txt |   25 +++++++++++++
 fast-import.c                     |   38 ++++++++++++++++++++
 t/t9300-fast-import.sh            |   70 +++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 288032c..4357c21 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -303,6 +303,10 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`feature`::
+	Require that fast-import supports the specified feature, or
+	abort if it does not.
+
 `commit`
 ~~~~~~~~
 Create or update a branch with a new commit, recording one logical
@@ -846,6 +850,27 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`feature`
+~~~~~~~~~
+Require that fast-import supports the specified feature, or abort if
+it does not.
+
+....
+	'feature' SP <feature> LF
+....
+
+The <feature> part of the command may be any string matching
+^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
+
+Feature work identical as their option counterparts.
+
+The following features are currently supported:
+
+* date-format
+* import-marks
+* export-marks
+* force
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index 0458b03..ce0cd4e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -353,6 +353,7 @@ static struct recent_command *rc_free;
 static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
+static int seen_data_command;
 
 static void write_branch_report(FILE *rpt, struct branch *b)
 {
@@ -1704,6 +1705,11 @@ static int read_next_command(void)
 			if (stdin_eof)
 				return EOF;
 
+			if (!seen_data_command
+				&& prefixcmp(command_buf.buf, "feature ")) {
+				seen_data_command = 1;
+			}
+
 			rc = rc_free;
 			if (rc)
 				rc_free = rc->next;
@@ -2533,6 +2539,36 @@ static void parse_one_option(const char *option)
 	}
 }
 
+static int parse_one_feature(const char *feature)
+{
+	if (!prefixcmp(feature, "date-format=")) {
+		option_date_format(feature + 12);
+	} else if (!prefixcmp(feature, "import-marks=")) {
+		option_import_marks(feature + 13);
+	} else if (!prefixcmp(feature, "export-marks=")) {
+		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "force")) {
+		force_update = 1;
+	} else {
+		return 0;
+	}
+
+	return 1;
+}
+
+static void parse_feature(void)
+{
+	char *feature = command_buf.buf + 8;
+
+	if (seen_data_command)
+		die("Got feature command '%s' after data command", feature);
+
+	if (parse_one_feature(feature))
+		return;
+
+	die("This version of fast-import does not support feature %s.", feature);
+}
+
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
 	if (!strcmp(k, "pack.depth")) {
@@ -2612,6 +2648,8 @@ int main(int argc, const char **argv)
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
 			parse_progress();
+		else if (!prefixcmp(command_buf.buf, "feature "))
+			parse_feature();
 		else
 			die("Unsupported command: %s", command_buf.buf);
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b49815d..b2c521f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1254,4 +1254,74 @@ test_expect_success \
 	'Q: verify note for third commit' \
 	'git cat-file blob refs/notes/foobar:$commit3 >actual && test_cmp expect actual'
 
+###
+### series R (feature)
+###
+
+cat >input <<EOF
+feature no-such-feature-exists
+EOF
+
+test_expect_success 'R: abort on unsupported feature' '
+	test_must_fail git fast-import <input
+'
+
+cat >input <<EOF
+feature date-format=now
+EOF
+
+test_expect_success 'R: supported feature is accepted' '
+	git fast-import <input
+'
+
+cat >input << EOF
+blob
+data 3
+hi
+feature date-format=now
+EOF
+
+test_expect_success 'R: abort on receiving feature after data command' '
+	test_must_fail git fast-import <input
+'
+
+cat >input << EOF
+feature export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'R: export-marks feature results in a marks file being created' \
+    'cat input | git fast-import &&
+    grep :1 git.marks'
+
+test_expect_success \
+    'R: export-marks options can be overriden by commandline options' \
+    'cat input | git fast-import --export-marks=other.marks &&
+    grep :1 other.marks'
+
+cat >input << EOF
+feature import-marks=marks.out
+feature export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import to output marks works without any content' \
+    'cat input | git fast-import &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature import-marks=nonexistant.marks
+feature export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import marks prefers commandline marks file over the stream' \
+    'cat input | git fast-import --import-marks=marks.out &&
+    test_cmp marks.out marks.new'
+
 test_done
-- 
1.6.5.3.164.g07b0c
