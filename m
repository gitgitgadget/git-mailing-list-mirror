From: Matthew Ruffalo <mmr15@case.edu>
Subject: [PATCH/RFC 2/3] diffstat: Use new diff.stat config values
Date: Sun, 28 Nov 2010 18:51:33 -0500
Message-ID: <4CF2EB05.5090300@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 00:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMr5g-0001qZ-35
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 00:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab0K1Xz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 18:55:27 -0500
Received: from mpv2.tis.CWRU.Edu ([129.22.105.37]:30450 "EHLO
	mpv2.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab0K1Xz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 18:55:26 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2010 18:55:26 EST
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv2.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id ATF11086
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:52:10 -0500
Received: from mail-qw0-f54.google.com (mail-qw0-f54.google.com [209.85.216.54])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OUP45919
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:51:35 -0500
Received: by mail-qw0-f54.google.com with SMTP id 8so2966389qwg.13
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 15:51:35 -0800 (PST)
Received: by 10.229.214.73 with SMTP id gz9mr4258946qcb.226.1290988295233;
        Sun, 28 Nov 2010 15:51:35 -0800 (PST)
Received: from [10.0.8.11] (cpe-184-56-209-12.neo.res.rr.com [184.56.209.12])
        by mx.google.com with ESMTPS id s28sm2780600qcp.21.2010.11.28.15.51.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 15:51:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162366>

>From f3ca8d4222776fb38a2def4fb9c4691c09c1e0fd Mon Sep 17 00:00:00 2001
From: Matthew Ruffalo <matthew.ruffalo@case.edu>
Date: Sun, 28 Nov 2010 14:44:00 -0500
Subject: [PATCH 2/3] diffstat: Use new diff.stat config values

Previously, the diffstat width could only be specified with the
command-line options '--width' and '--name-width'. This patch adds
support for config file options 'diff.stat.width' and
'diff.stat.namewidth'.

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
index a151681..d2a3e44 100644
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
@@ -148,6 +150,16 @@ int git_diff_basic_config(const char *var, const
char *value, void *cb)
        if (!prefixcmp(var, "submodule."))
                return parse_submodule_config_option(var, value);
 
+       if (!strcmp(var, "diff.stat.width")) {
+               diff_stat_width = git_config_int(var, value);
+               return 0;
+       }
+
+       if (!strcmp(var, "diff.stat.namewidth")) {
+               diff_stat_name_width = git_config_int(var, value);
+               return 0;
+       }
+
        return git_color_default_config(var, value, cb);
 }
 
@@ -1247,8 +1259,8 @@ static void show_stats(struct diffstat_t *data,
struct diff_options *options)
                line_prefix = msg->buf;
        }
 
-       width = options->stat_width ? options->stat_width :
DIFF_STAT_DEFAULT_WIDTH;
-       name_width = options->stat_name_width ? options->stat_name_width
: DIFF_STAT_DEFAULT_NAME_WIDTH;
+       width = diff_stat_width ? diff_stat_width : DIFF_STAT_DEFAULT_WIDTH;
+       name_width = diff_stat_name_width ? diff_stat_name_width :
DIFF_STAT_DEFAULT_NAME_WIDTH;
 
        /* Sanity: give at least 5 columns to the graph,
         * but leave at least 10 columns for the name.
@@ -3053,8 +3065,8 @@ static int stat_opt(struct diff_options *options,
const char **av)
 {
        const char *arg = av[0];
        char *end;
-       int width = options->stat_width;
-       int name_width = options->stat_name_width;
+       int width = diff_stat_width;
+       int name_width = diff_stat_name_width;
        int argcount = 1;
 
        arg += strlen("--stat");
@@ -3094,8 +3106,8 @@ static int stat_opt(struct diff_options *options,
const char **av)
        if (*end)
                return 0;
        options->output_format |= DIFF_FORMAT_DIFFSTAT;
-       options->stat_name_width = name_width;
-       options->stat_width = width;
+       diff_stat_name_width = name_width;
+       diff_stat_width = width;
        return argcount;
 }
 
diff --git a/diff.h b/diff.h
index 7b509c5..011f2ac 100644
--- a/diff.h
+++ b/diff.h
@@ -122,8 +122,6 @@ struct diff_options {
        const char *stat_sep;
        long xdl_opts;
 
-       int stat_width;
-       int stat_name_width;
        const char *word_regex;
        enum diff_words_type word_diff;
 
-- 
1.7.1
