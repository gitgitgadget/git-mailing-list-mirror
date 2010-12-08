From: mmr15@case.edu
Subject: [PATCH 2/3] diffstat: Use new diffstat config values
Date: Tue,  7 Dec 2010 21:44:22 -0500
Message-ID: <1291776263-16320-2-git-send-email-matthew.ruffalo@case.edu>
References: <7vzksr280s.fsf@alter.siamese.dyndns.org>
 <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
Cc: Matthew Ruffalo <matthew.ruffalo@case.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 03:45:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQA1j-0000bJ-5H
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab0LHCoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:44:54 -0500
Received: from mpv2.tis.cwru.edu ([129.22.105.37]:21862 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0LHCox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:44:53 -0500
Received: from mpv8.TIS.CWRU.edu (mpv8.tis.CWRU.Edu [129.22.105.116])
	by mpv2.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id ATN15788
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:44 -0500
Received: from mail-vw0-f54.google.com (mail-vw0-f54.google.com [209.85.212.54])
	by mpv8.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id PFD79844
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:40 -0500
Received: by mail-vw0-f54.google.com with SMTP id 9so505793vws.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 18:44:40 -0800 (PST)
Received: by 10.220.181.135 with SMTP id by7mr1740951vcb.258.1291776280219;
        Tue, 07 Dec 2010 18:44:40 -0800 (PST)
Received: from mmr15-box.discordia.local (cpe-184-56-199-68.neo.res.rr.com [184.56.199.68])
        by mx.google.com with ESMTPS id r11sm54692vbx.11.2010.12.07.18.44.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 18:44:39 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.401.g13ba73
In-Reply-To: <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A020204.4CFEF124.00BB,ss=1,fgs=0,
	ip=209.85.212.54,
	so=2010-02-10 23:06:36,
	dmn=2009-09-10 00:05:08,
	mode=single engine
X-Junkmail-IWF: false
X-Junkmail-Status: score=5/49, host=mpv2.tis.cwru.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163164>

From: Matthew Ruffalo <matthew.ruffalo@case.edu>

Previously, the diffstat width could only be specified with the
command-line options '--width' and '--name-width'. This patch adds
support for config file options 'diffstat.width' and
'diffstat.namewidth'.

The diffstat width values are obtained in this order (of increasing
precedence):

 1. Compile-time defaults (80 width, 50 namewidth)
 2. Standard git config mechanism
 3. Command-line options

This required removing the diffstat options from 'struct diff_options'
and adding these values as static ints in diff.c. This preserves the
style of "config options are static ints, command-line options are
diff_options members". stat_opt now directly sets the global options.

Signed-off-by: Matthew Ruffalo <matthew.ruffalo@case.edu>
---
 diff.c |   24 ++++++++++++++++++------
 diff.h |    2 --
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 75938e4..d88c7f4 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,8 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static int diff_stat_width;
+static int diff_stat_name_width;
 static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -148,6 +150,16 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
+	if (!strcmp(var, "diffstat.width")) {
+		diff_stat_width = git_config_int(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "diffstat.namewidth")) {
+		diff_stat_name_width = git_config_int(var, value);
+		return 0;
+	}
+
 	return git_color_default_config(var, value, cb);
 }
 
@@ -1247,8 +1259,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		line_prefix = msg->buf;
 	}
 
-	width = options->stat_width ? options->stat_width : DIFF_STAT_DEFAULT_WIDTH;
-	name_width = options->stat_name_width ? options->stat_name_width : DIFF_STAT_DEFAULT_NAME_WIDTH;
+	width = diff_stat_width ? diff_stat_width : DIFF_STAT_DEFAULT_WIDTH;
+	name_width = diff_stat_name_width ? diff_stat_name_width : DIFF_STAT_DEFAULT_NAME_WIDTH;
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
@@ -3057,8 +3069,8 @@ static int stat_opt(struct diff_options *options, const char **av)
 {
 	const char *arg = av[0];
 	char *end;
-	int width = options->stat_width;
-	int name_width = options->stat_name_width;
+	int width = diff_stat_width;
+	int name_width = diff_stat_name_width;
 	int argcount = 1;
 
 	arg += strlen("--stat");
@@ -3098,8 +3110,8 @@ static int stat_opt(struct diff_options *options, const char **av)
 	if (*end)
 		return 0;
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	options->stat_name_width = name_width;
-	options->stat_width = width;
+	diff_stat_name_width = name_width;
+	diff_stat_width = width;
 	return argcount;
 }
 
diff --git a/diff.h b/diff.h
index 7b509c5..011f2ac 100644
--- a/diff.h
+++ b/diff.h
@@ -122,8 +122,6 @@ struct diff_options {
 	const char *stat_sep;
 	long xdl_opts;
 
-	int stat_width;
-	int stat_name_width;
 	const char *word_regex;
 	enum diff_words_type word_diff;
 
-- 
1.7.1
