From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 5/3] Alternative --dirstat implementation,
 based on diffstat analysis
Date: Tue, 12 Apr 2011 11:26:49 +0200
Message-ID: <201104121126.49881.johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:27:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ZsF-00087Q-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901Ab1DLJ06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 05:26:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41961 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756810Ab1DLJ05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:26:57 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ006878WW4J90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:26:56 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8D30D1EA5567_DA41ADAB	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:26:50 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 56EC61EA2A9C_DA41ADAF	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:26:50 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ00EK18WQEZ20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:26:50 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <201104121122.56870.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171386>

This patch adds an alternative implementation of show_dirstat(), called
show_dirstat_based_on_diffstat(), which uses the more expensive diffstat
analysis (as opposed to --dirstat's own (inexpensive) analysis) to derive
the numbers from which the --dirstat output is computed.

The alternative implementation is controlled by a new config variable called
diff.dirstatBasedOnDiffstat.

In linux-2.6.git, running

  time git diff v2.6.20..v2.6.30 --dirstat=0 > /dev/null

with and without diff.dirstatBasedOnDiffstat enabled yields the following
average runtimes on my machine:

- disabled: ~6.0 s
- enabled:  ~9.7 s

So, as expected, there's a considerable performance hit (>60%) by going
through the full diffstat analysis. As such, the new option is probably
only useful if you really need the --dirstat numbers to be consistent with
the numbers returned from the other --*stat options.

In --dirstat-by-file mode, the diffstat analysis is obviously a waste of time,
so --dirstat-by-file automatically disabled diff.dirstatBasedOnDiffstat.

Signed-off-by: Johan Herland <johan@herland.net>
---

This might not be worth applying at all, but if it is, I can send a re-roll
with documentation and more user-friendlyness.


Have fun! :)

...Johan

 diff.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 5376d01..a496ba6 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
+static int dirstat_based_on_diffstat;
 static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -103,6 +104,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_no_prefix = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.dirstatbasedondiffstat")) {
+		dirstat_based_on_diffstat = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
@@ -1619,6 +1624,43 @@ found_damage:
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
+static void show_dirstat_based_on_diffstat(struct diffstat_t *data, struct diff_options 
*options)
+{
+	int i;
+	unsigned long changed;
+	struct dirstat_dir dir;
+
+	if (data->nr == 0)
+		return;
+
+	dir.files = NULL;
+	dir.alloc = 0;
+	dir.nr = 0;
+	dir.percent = options->dirstat_percent;
+	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+
+	changed = 0;
+	for (i = 0; i < data->nr; i++) {
+		struct diffstat_file *file = data->files[i];
+		unsigned long damage;
+
+		damage = file->added + file->deleted;
+		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
+		dir.files[dir.nr].name = file->name;
+		dir.files[dir.nr].changed = damage;
+		changed += damage;
+		dir.nr++;
+	}
+
+	/* This can happen even with many files, if everything was renames */
+	if (!changed)
+		return;
+
+	/* Show all directories with more than x% of the changes */
+	qsort(dir.files, dir.nr, sizeof(dir.files[0]), dirstat_compare);
+	gather_dirstat(options, &dir, changed, "", 0);
+}
+
 static void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
@@ -4012,7 +4054,12 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
+	// --dirstat-by-file REALLY don't need the full diffstat analysis
+	if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE))
+		dirstat_based_on_diffstat = 0;
+
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT) ||
+	    ((output_format & DIFF_FORMAT_DIRSTAT) && dirstat_based_on_diffstat)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -4027,10 +4074,12 @@ void diff_flush(struct diff_options *options)
 			show_stats(&diffstat, options);
 		if (output_format & DIFF_FORMAT_SHORTSTAT)
 			show_shortstats(&diffstat, options);
+		if (output_format & DIFF_FORMAT_DIRSTAT)
+			show_dirstat_based_on_diffstat(&diffstat, options);
 		free_diffstat_info(&diffstat);
 		separator++;
 	}
-	if (output_format & DIFF_FORMAT_DIRSTAT)
+	if ((output_format & DIFF_FORMAT_DIRSTAT) && !dirstat_based_on_diffstat)
 		show_dirstat(options);
 
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
-- 
1.7.5.rc1.3.g4d7b
