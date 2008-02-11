From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 12:59:18 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOfpo-0004Ps-N0
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbYBKVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYBKVEa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:04:30 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50597 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154AbYBKVE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 16:04:29 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BL0EDO027839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 13:01:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BKxIZY032660;
	Mon, 11 Feb 2008 12:59:39 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-1.532 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_32,J_CHICKENPOX_35,J_CHICKENPOX_37,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73583>


This adds a new form of diffstat output, something that I have 
occasionally ended up doing manually (and badly, because it's actually 
pretty nasty to do), and that I think is very useful for an "overview" 
kind of thing in a project like the kernel that has a fairly deep and 
well-separated directory structure with semantic meaning.

What I mean by that is that it's often interesting from a patch standpoint 
to see which sub-directories are impacted by a patch, and to what degree.

What makes that more interesting is that the "impact" is often 
hierarchical: in the kernel, for example, something could either have a 
very localized impact to "fs/ext3/" and then it's interesting to see that 
such a patch changes mostly that subdirectory, but you could have another 
patch that changes some generic VFS-layer issue which affects _many_ 
subdirectories that are all under "fs/", but none - or perhaps just a 
couple of them - of the individual filesystems are interesting in 
themselves.

So what commonly happens is that you may have big changes in a specific 
sub-subdirectory, but still also significant separate changes to the 
subdirectory leading up to that - maybe you have significant VFS-level 
changes, but *also* changes under that VFS layer in the NFS-specific 
directories, for example. In that case, you do want the low-level parts 
that are significant to show up, but then the insignificant ones should 
show up as under the more generic top-level directory.

This patch shows all of that with "--dirstat". The output can be either 
something simple like

	commit 81772fe...
	Author: Thomas Gleixner <tglx@linutronix.de>
	Date:   Sun Feb 10 23:57:36 2008 +0100

	    x86: remove over noisy debug printk
	
	    pageattr-test.c contains a noisy debug printk that people reported.
	    The condition under which it prints (randomly tapping into a mem_map[]
	    hole and not being able to c_p_a() there) is valid behavior and not
	    interesting to report.
	
	    Remove it.
	
	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
	    Acked-by: Ingo Molnar <mingo@elte.hu>
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
	
	 100% arch/x86/mm/
	 1 files changed, 0 insertions(+), 7 deletions(-)

or something much more complex like

	commit e231c2e...
	Author: David Howells <dhowells@redhat.com>
	Date:   Thu Feb 7 00:15:26 2008 -0800
	
	    Convert ERR_PTR(PTR_ERR(p)) instances to ERR_CAST(p)

	  20% crypto/
	   7% fs/afs/
	   7% fs/fuse/
	   7% fs/gfs2/
	   5% fs/jffs2/
	   5% fs/nfs/
	   5% fs/nfsd/
	   7% fs/reiserfs/
	  15% fs/
	   7% net/rxrpc/
	  10% security/keys/
	 28 files changed, 39 insertions(+), 39 deletions(-)

where that latter example is an example of significant work in some 
individual fs/*/ subdirectories (like the patches to reiserfs accounting 
for 7% of the whole), but then discounting those individual filesystems, 
there's also 15% other things left over under fs/ in general.

Note that the "15% fs/" mentioned above is the stuff that is under fs/ but 
that was _not_ significant enough to report on its own. So the above does 
_not_ mean that 15% of the work was under fs/ per se, because that 15% 
does *not* include the already-reported 7% of afs, 7% of fuse etc.

The reporting limit has been arbitrarily set at 3%, which seems to be a 
pretty good cut-off, but I made it an option variable in case anybody 
would ever want to make it a dynamic cutoff.

NOTE! The percentages are purely about the total lines added and removed, 
not anything smarter (or dumber) than that. Also note that you should not 
generally expect things to add up to 100%: not only does it round down, we 
don't report leftover scraps (they add up to the top-level change count, 
but we don't even bother reporting that, it only reports subdirectories).

Quite frankly, as a top-level manager this is really convenient for me, 
but it's going to be very boring for git itself since there are few 
subdirectories. Also, don't expect things to make tons of sense if you 
combine this with "-M" and there are cross-directory renames etc.

But even for git itself, you can get some fun statistics. Try out

	git log --dirstat

and see the occasional mentions of things like Documentation/, git-gui/, 
gitweb/ and gitk-git/. Or try out something like

	git diff --dirstat v1.5.0..v1.5.4

which does kind of git an overview that shows *something*. But in general, 
the output is more exciting for big projects with deeper structure, and 
doing a

	git diff --dirstat v2.6.24..v2.6.25-rc1

on the kernel is what I actually wrote this for!

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Yeah, I'm proud of how small I could make this really cool feature. I had 
put off doing this because I always expected it to be harder than it was. 
But it was easy because I think I came up with a clever way to do it.

 diff.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 diff.h |    2 +
 2 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 5b8afdc..da91bdd 100644
--- a/diff.c
+++ b/diff.c
@@ -980,6 +980,71 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 	}
 }
 
+struct diffstat_dir {
+	struct diffstat_file **files;
+	int nr, percent;
+};
+
+static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
+{
+	unsigned long this_dir = 0;
+
+	while (dir->nr) {
+		struct diffstat_file *f = *dir->files;
+		int namelen = strlen(f->name);
+		unsigned long this;
+		char *slash;
+
+		if (namelen < baselen)
+			break;
+		if (memcmp(f->name, base, baselen))
+			break;
+		slash = strchr(f->name + baselen, '/');
+		if (slash) {
+			int newbaselen = slash + 1 - f->name;
+			this = gather_dirstat(dir, changed, f->name, newbaselen);
+		} else {
+			this = f->added + f->deleted;
+			dir->files++;
+			dir->nr--;
+		}
+		this_dir += this;
+	}
+
+	if (baselen) {
+		int percent = this_dir * 100 / changed;
+		if (percent >= dir->percent) {
+			printf("%4d%% %.*s\n", percent, baselen, base);
+			return 0;
+		}
+	}
+	return this_dir;
+}
+
+static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
+{
+	int i;
+	unsigned long changed;
+	struct diffstat_dir dir;
+
+	/* Calculate total changes */
+	changed = 0;
+	for (i = 0; i < data->nr; i++) {
+		changed += data->files[i]->added;
+		changed += data->files[i]->deleted;
+	}
+
+	/* This can happen even with many files, if everything was renames */
+	if (!changed)
+		return;
+
+	/* Show all directories with more than x% of the changes */
+	dir.files = data->files;
+	dir.nr = data->nr;
+	dir.percent = options->dirstat_percent;
+	gather_dirstat(&dir, changed, "", 0);
+}
+
 static void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
@@ -2043,6 +2108,7 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+	options->dirstat_percent = 3;
 	options->context = 3;
 	options->msg_sep = "";
 
@@ -2084,6 +2150,7 @@ int diff_setup_done(struct diff_options *options)
 					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
 					    DIFF_FORMAT_SHORTSTAT |
+					    DIFF_FORMAT_DIRSTAT |
 					    DIFF_FORMAT_SUMMARY |
 					    DIFF_FORMAT_PATCH);
 
@@ -2095,6 +2162,7 @@ int diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_NUMSTAT |
 				      DIFF_FORMAT_DIFFSTAT |
 				      DIFF_FORMAT_SHORTSTAT |
+				      DIFF_FORMAT_DIRSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
 		DIFF_OPT_SET(options, RECURSIVE);
@@ -2205,6 +2273,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
+	else if (!strcmp(arg, "--dirstat"))
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
@@ -2923,7 +2993,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIRSTAT)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -2933,6 +3003,8 @@ void diff_flush(struct diff_options *options)
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
+		if (output_format & DIFF_FORMAT_DIRSTAT)
+			show_dirstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
diff --git a/diff.h b/diff.h
index 073d5cb..3181263 100644
--- a/diff.h
+++ b/diff.h
@@ -30,6 +30,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
+#define DIFF_FORMAT_DIRSTAT	0x0020
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
@@ -80,6 +81,7 @@ struct diff_options {
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
+	int dirstat_percent;
 	int setup;
 	int abbrev;
 	const char *msg_sep;
