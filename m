From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] add pretty format configuration to git log/show/whatchanged
Date: Sun,  2 Mar 2008 01:15:24 +0800
Message-ID: <1204391724-566-1-git-send-email-crquan@gmail.com>
References: <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org>
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 18:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVVJo-0007G6-Gi
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 18:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbYCARPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 12:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbYCARPk
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 12:15:40 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:1664 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYCARPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 12:15:39 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2167330gve.37
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o52sJw8hRFh0gkfHYDzoaRvGEFeIBjXNzNh6qZdUGrQ=;
        b=HHuodogWylmW1cfYwcqYeiT82I74fT8jtQtkc+ksonifq2HNaOiPH9mbsXAI9e/5+t+Zlk2rt372GVrFwAZTLeXAbacOfEhZwRM7mpyCKEQoMGpVV3ipy3iXVeuZ6+tggKPJPJqtkMEffRYmK51i1HXIoyTEokQcaZMPe20Zaac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ua0XC1XtTT93SJRqF+tOgJCSMQUNL6fDcoS4mBG3a2IlaoBxT3uhJqANlQwIarLWmWG0CEpJYN+RGgOdqoBDOEtgawJ0rFkCtdSZ4cNMSzOdCU7xYFSFhoi0nDkffmlBPHoNgSo6nZRPjPwmNZHsbxtK+IfU4Lb9wQG6BBH848s=
Received: by 10.114.192.1 with SMTP id p1mr13526050waf.47.1204391736358;
        Sat, 01 Mar 2008 09:15:36 -0800 (PST)
Received: from tux ( [121.34.60.168])
        by mx.google.com with ESMTPS id l36sm21715120waf.1.2008.03.01.09.15.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 09:15:35 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sun,  2 Mar 2008 01:15:24 +0800
X-Mailer: git-send-email 1.5.3.8
In-Reply-To: <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75687>

 * New configuration variable "format.pretty" can be used
    in git log/show/whatchanged.

the "format.pretty" configuration's design background is that I often use
"--pretty=fuller" on my command line, and different "--pretty=format:..."
 on my different local repos, I hope there is a configuration to store this
to git-config.

after applying the patch, rev->commit_format in `git log/show/whatchanged`
 will be initialized in the following order:
1. call to gitconfig will set static fmt_pretty according to git-config:
   if the user never config "format.pretty", fmt_pretty doesn't need to be
   initialized;
2. rev->commit_format set to CMIT_FMT_DEFAULT in init_revisions;
3. set rev->commit_format according to fmt_pretty if the user has configured
   "format.pretty" in git-config;
4. setup_revisions will accept "--pretty=" from the command line;

so the pretty format's setting precedence is:
1. the command line "--pretty=";
2. "format.pretty" from the gitconfig;
3. default CMIT_FMT_DEFAULT;

here documentation of `git config/log/show/whatchanged` also updated.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 Documentation/config.txt          |    5 +++++
 Documentation/git-whatchanged.txt |    9 ++++-----
 Documentation/pretty-options.txt  |    8 ++++++++
 builtin-log.c                     |   10 +++++++++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4027726..8a0dff9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -556,6 +556,11 @@ format.suffix::
 	`.patch`. Use this variable to change that suffix (make sure to
 	include the dot if you want it).
 
+format.pretty::
+	The default pretty format for log/show/whatchanged command,
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 54947b6..a6e7bd4 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -38,11 +38,6 @@ OPTIONS
 	Show git internal diff output, but for the whole tree,
 	not just the top level.
 
---pretty=<format>::
-	Controls the output format for the commit logs.
-	<format> can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'.
-
 -m::
 	By default, differences for merge commits are not shown.
 	With this flag, show differences to that commit from all
@@ -51,6 +46,10 @@ OPTIONS
 However, it is not very useful in general, although it
 *is* useful on a file-by-file basis.
 
+include::pretty-options.txt[]
+
+include::pretty-formats.txt[]
+
 Examples
 --------
 git-whatchanged -p v2.6.12.. include/scsi drivers/scsi::
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 973d8dd..15e01fa 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -4,6 +4,14 @@
 	where '<format>' can be one of 'oneline', 'short', 'medium',
 	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
 	When omitted, the format defaults to 'medium'.
++
+Note: now you can specify the default pretty format in the repository
+configuration (see linkgit:git-config[1]), like this in .git/config:
++
+-----------------------
+[format]
+	pretty = fuller
+-----------------------
 
 --abbrev-commit::
 	Instead of showing the full 40-byte hexadecimal commit object
diff --git a/builtin-log.c b/builtin-log.c
index bbadbc0..0f7ee1f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -20,6 +20,7 @@
 
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static const char *fmt_pretty;
 
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
@@ -53,7 +54,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	int decorate = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
-	rev->commit_format = CMIT_FMT_DEFAULT;
+	if (fmt_pretty)
+		rev->commit_format = get_commit_format(fmt_pretty);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
@@ -221,6 +223,12 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "format.pretty")) {
+		if (!value)
+			config_error_nonbool(var);
+		fmt_pretty = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "format.subjectprefix")) {
 		if (!value)
 			config_error_nonbool(var);
-- 
1.5.4.2

