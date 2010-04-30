From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 5/5] pretty: add aliases for pretty formats
Date: Fri, 30 Apr 2010 20:35:28 +0100
Message-ID: <1272656128-2002-6-git-send-email-wmpalmer@gmail.com>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2u-0008Of-EY
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934279Ab0D3TgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:36:11 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57368 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab0D3Tfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:35:44 -0400
Received: by mail-ww0-f46.google.com with SMTP id 34so446912wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZUl6xwBzioJ/CEzIgtt/rPAdH9nhua7eTAbZlm+6TEY=;
        b=DFNQQ5CuanBK/gBhOMs287g3VPhtAmLz822Qe4CKG02Jpst3hO46zC5BPCEs22uC6t
         5e/97LxGjrkuDnvdS6DYDUHu9tcLzOauKvKv7JgOf8+KZn+OscUImo5avGBVENaOL/62
         UCZjE9AZCU+uXUQ8fyaSYFOHgVwuJVmL/li2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W6AR0BoNNwCFoMOLN11Q2H55yso6HfGROApube4JyHVST9f37EVcd+QUjmSCpnzdlw
         NuXVYlQ7IXicVN+m3PIn1tf8LgkdzQps6mSyT8KDY6Vn6c8z4z15tVJ04lwu4+8qQGWh
         0Dk7UPMidgahb4kdTpCPy0zC8L4F6dyr4S5BI=
Received: by 10.216.90.206 with SMTP id e56mr2367655wef.167.1272656143087;
        Fri, 30 Apr 2010 12:35:43 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146056>

previously the only ways to alias a --pretty format within git were
either to set the format as your default format (via the format.pretty
configuration variable), or by using a regular git alias. This left the
definition of more complicated formats to the realm of "builtin or
nothing", with user-defined formats usually being reserved for quick
one-offs.

Here we allow user-defined formats to enjoy more or less the same
benefits of builtins. By defining pretty.myalias, "myalias" can be
used in place of whatever would normally come after --pretty=. This
can be a format:, tformat:, raw (ie, defaulting to tformat), or the name
of another builtin or user-defined pretty format.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/config.txt         |    9 ++++++
 Documentation/pretty-formats.txt |    7 ++++-
 pretty.c                         |   57 ++++++++++++++++++++++++++++++++++++-
 t/t4205-log-pretty-formats.sh    |   47 +++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..3987b2d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1466,6 +1466,15 @@ pager.<cmd>::
 	it takes precedence over this option.  To disable pagination for
 	all commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
+pretty.<name>::
+	Alias for a --pretty= format string, as specified in
+	linkgit:git-log[1]. Any aliases defined here can be used just
+	as the built-in pretty formats could. For example, defining
+	"format.pretty.hash = format:%H" would cause the invocation
+	"git log --pretty=hash" to be equivalent to running
+	"git log --pretty=format:%H". Note that an alias with the same
+	name as a built-in format will be silently ignored.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 5861256..bb0f0d2 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -11,7 +11,12 @@ have limited your view of history: for example, if you are
 only interested in changes related to a certain directory or
 file.
 
-Here are some additional details for each format:
+There are several built-in formats, and you can define
+additional formats by setting a pretty.<name>
+config option to either another format name, or a
+'format:' string, as described below (see
+linkgit:git-config[1]). Here are the details of the
+built-in formats:
 
 * 'oneline'
 
diff --git a/pretty.c b/pretty.c
index 3d1c4a9..9780e32 100644
--- a/pretty.c
+++ b/pretty.c
@@ -18,7 +18,9 @@ static struct cmt_fmt_map {
 	int is_alias;
 	const char *user_format;
 } *commit_formats = NULL;
+static size_t builtin_formats_len = 0;
 static size_t commit_formats_len = 0;
+static size_t commit_formats_alloc = 0;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
 
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
@@ -30,6 +32,51 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
+static int git_pretty_formats_config(const char *var, const char *value, void *cb)
+{
+	struct cmt_fmt_map *commit_format = NULL;
+	const char *name;
+	const char *fmt;
+	int i;
+
+	if (prefixcmp(var, "pretty."))
+		return 0;
+
+	name = &var[7];
+	for (i=0; i<builtin_formats_len; i++) {
+		if (!strcmp(commit_formats[i].name, name))
+			return 0;
+	}
+
+	for (i=builtin_formats_len; i<commit_formats_len; i++) {
+		if (!strcmp(commit_formats[i].name, name)) {
+			commit_format = &commit_formats[i];
+			break;
+		}
+	}
+
+	if (!commit_format) {
+		ALLOC_GROW(commit_formats, commit_formats_len+1,
+			   commit_formats_alloc);
+		commit_format = &commit_formats[commit_formats_len];
+		commit_formats_len++;
+	}
+
+	commit_format->name = xstrdup(name);
+	commit_format->format = CMIT_FMT_USERFORMAT;
+	git_config_string(&fmt, var, value);
+	if (!prefixcmp(fmt, "format:") || !prefixcmp(fmt, "tformat:")) {
+		commit_format->is_tformat = fmt[0] == 't';
+		fmt = strchr(fmt, ':') + 1;
+	} else if (strchr(fmt, '%'))
+		commit_format->is_tformat = 1;
+	else
+		commit_format->is_alias = 1;
+	commit_format->user_format = fmt;
+
+	return 0;
+}
+
 static void setup_commit_formats(void)
 {
 	struct cmt_fmt_map builtin_formats[] = {
@@ -42,10 +89,12 @@ static void setup_commit_formats(void)
 		{ "oneline",	CMIT_FMT_ONELINE,	1 }
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
-	commit_formats = xcalloc(commit_formats_len,
-				 sizeof(*builtin_formats));
+	builtin_formats_len = commit_formats_len;
+	ALLOC_GROW(commit_formats, commit_formats_len, commit_formats_alloc);
 	memcpy(commit_formats, builtin_formats,
 	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
+
+	git_config(git_pretty_formats_config, NULL);
 }
 
 static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
@@ -112,6 +161,10 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 
 	rev->commit_format = commit_format->format;
 	rev->use_terminator = commit_format->is_tformat;
+	if( commit_format->format == CMIT_FMT_USERFORMAT ){
+		save_user_format(rev, commit_format->user_format,
+				 commit_format->is_tformat);
+	}
 }
 
 /*
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index a33f157..d8673fb 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -66,4 +66,51 @@ test_expect_success "log --pretty=raw should NOT respect --abbrev-commit" \
 	git log -1 --pretty=raw --abbrev-commit > actual &&
 	test_cmp expected actual'
 
+test_expect_success "alias builtin format" \
+	"git log --pretty=oneline >expected &&
+	git config pretty.test-alias oneline &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias masking builtin format" \
+	"git log --pretty=oneline >expected &&
+	git config pretty.oneline '%H' &&
+	git log --pretty=oneline >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias user-defined format" \
+	"git log --pretty='format:%h' >expected &&
+	git config pretty.test-alias 'format:%h' &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias user-defined tformat" \
+	"git log --pretty='tformat:%h' >expected &&
+	git config pretty.test-alias 'tformat:%h' &&
+	git log --pretty=test-alias >actual &&
+	test_cmp expected actual"
+
+test_expect_code 128 "alias non-existant format" \
+	"git config pretty.test-alias format-that-will-never-exist &&
+	git log --pretty=test-alias"
+
+test_expect_success "alias of an alias" \
+	"git log --pretty='tformat:%h' >expected &&
+	git config pretty.test-foo 'tformat:%h' &&
+	git config pretty.test-bar test-foo &&
+	git log --pretty=test-bar >actual &&
+	test_cmp expected actual"
+
+test_expect_success "alias masking an alias" \
+	"git log --pretty=format:'Two %H' >expected &&
+	git config pretty.duplicate 'format:One %H' &&
+	git config --add pretty.duplicate 'format:Two %H' &&
+	git log --pretty=duplicate >actual &&
+	test_cmp expected actual"
+
+test_expect_code 128 "alias loop" \
+	"git config pretty.test-foo test-bar &&
+	git config pretty.test-bar test-foo &&
+	git log --pretty=test-foo"
+
 test_done
-- 
1.7.1.rc1.13.gbb0a0a.dirty
