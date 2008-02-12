From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Tue, 12 Feb 2008 13:26:31 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2hD-0006C5-NE
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYBLV1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbYBLV1l
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:27:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54785 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336AbYBLV1i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 16:27:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLQVP3009286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 13:26:38 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1CLQVmC022998;
	Tue, 12 Feb 2008 13:26:31 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.038 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_32,J_CHICKENPOX_35,J_CHICKENPOX_37,J_CHICKENPOX_66,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73694>


This adds a new form of overview diffstat output, doing something that I 
have occasionally ended up doing manually (and badly, because it's 
actually pretty nasty to do), and that I think is very useful for an 
project like the kernel that has a fairly deep and well-separated 
directory structure with semantic meaning.

What I mean by that is that it's often interesting to see exactly which 
sub-directories are impacted by a patch, and to what degree - even if you 
don't perhaps care so much about the individual files themselves.

What makes the concept more interesting is that the "impact" is often 
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

         100.0% arch/x86/mm/

or something much more complex like

        commit e231c2e...
        Author: David Howells <dhowells@redhat.com>
        Date:   Thu Feb 7 00:15:26 2008 -0800

            Convert ERR_PTR(PTR_ERR(p)) instances to ERR_CAST(p)

	  20.5% crypto/
	   7.6% fs/afs/
	   7.6% fs/fuse/
	   7.6% fs/gfs2/
	   5.1% fs/jffs2/
	   5.1% fs/nfs/
	   5.1% fs/nfsd/
	   7.6% fs/reiserfs/
	  15.3% fs/
	   7.6% net/rxrpc/
	  10.2% security/keys/

where that latter example is an example of significant work in some 
individual fs/*/ subdirectories (like the patches to reiserfs accounting 
for 7.6% of the whole), but then discounting those individual filesystems, 
there's also 15.3% other "random" things that weren't worth reporting on 
their oen left over under fs/ in general (either in that directory itself, 
or in subdirectories of fs/ that didn't have enough changes to be reported 
individually).

I'd like to stress that the "15.3% fs/" mentioned above is the stuff that 
is under fs/ but that was _not_ significant enough to report on its own.  
So the above does _not_ mean that 15.3% of the work was under fs/ per se, 
because that 15.3% does *not* include the already-reported 7.6% of afs, 
7.6% of fuse etc.

If you want to enable "cumulative" directory statistics, you can use the
"--cumulative" flag, which adds up percentages recursively even when
they have been already reported for a sub-directory.  That cumulative
output is disabled if *all* of the changes in one subdirectory come from
a deeper subdirectory, to avoid repeating subdirectories all the way to
the root.

For an example of the cumulative reporting, the above commit becomes

	commit e231c2e...
	Author: David Howells <dhowells@redhat.com>
	Date:   Thu Feb 7 00:15:26 2008 -0800

	    Convert ERR_PTR(PTR_ERR(p)) instances to ERR_CAST(p)

	  20.5% crypto/
	   7.6% fs/afs/
	   7.6% fs/fuse/
	   7.6% fs/gfs2/
	   5.1% fs/jffs2/
	   5.1% fs/nfs/
	   5.1% fs/nfsd/
	   7.6% fs/reiserfs/
	  61.5% fs/
	   7.6% net/rxrpc/
	  10.2% security/keys/

in which the commit percentages now obviously add up to much more than 
100%: now the changes that were already reported for the sub-directories 
under fs/ are then cumulatively included in the whole percentage of fs/ 
(ie now shows 61.5% as opposed to the 15.3% without the cumulative 
reporting).

The default reporting limit has been arbitrarily set at 3%, which seems
to be a pretty good cut-off, but you can specify the cut-off manually by
giving it as an option parameter (eg "--dirstat=5" makes the cut-off be
at 5% instead)

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

This is a re-send of all my changes rolled up into one single patch. One 
of the reasons is that the "report percentages in tenths of percent" 
simply changed the examples in the original commit message. Another is 
that I actually made the "--cumulative" flag much more useful in practice 
by making it avoid reporting the subdirectories where all the percentages 
came from just a single already-reported sub-subdirectory.

The --cumulative thing still has the odd property of having all the 
percentages add up to more than 100%, but quite often it is now what you 
really want, and you can, for example, get output like this:

	  27.5% security/selinux/include/
	 100.0% security/selinux/

which means that everything is in "security/selinux", but within that 
directory we also show that 27.5% was within the include subdirectory. 
Note how it now no longer gives a "100.0% security/" report, since that 
would be purely redundant information.

Another example of this new semantic:

	  23.8% include/asm-sparc/
	  76.1% include/asm-sparc64/
	 100.0% include/

here, "100% include/" _is_ reported, because while the 100% did come from 
the already reported subdirectories, it didn't come from a _single_ one, 
so it basically means that you don't ever have to mentally add up things, 
and we only avoid reporting upper-level directory statistics when there 
really is no point to it.

With this change, "--cumulative" suddenly makes tons of sense to me. For 
example, for the 2.6.24..2.6.25-rc1 changes in the kernel (with a 2% 
cutoff), it now gives:

 - "git diff --dirstat=2 --cumulative v2.6.24..v2.6.25-rc1" output:

	   2.4% Documentation/
	   3.2% arch/arm/
	   2.0% arch/cris/
	   2.3% arch/powerpc/boot/
	   2.3% arch/powerpc/configs/
	   6.9% arch/powerpc/
	   3.2% arch/sh/
	   2.3% arch/x86/kernel/
	   6.9% arch/x86/
	  31.3% arch/
	   2.0% drivers/char/
	   2.0% drivers/infiniband/
	   2.9% drivers/media/video/
	   3.7% drivers/media/
	   2.4% drivers/net/wireless/iwlwifi/
	   7.3% drivers/net/wireless/
	  14.3% drivers/net/
	   2.8% drivers/scsi/
	  37.2% drivers/
	   3.5% fs/
	   2.0% include/asm-x86/
	  10.3% include/
	   6.0% net/
	   3.7% sound/

and now you can see at a glance that 31.3 was in arch/, and 37.2% was in 
drivers/. So this is a case where --cumulative actually makes sense (but 
it probably still doesn't make sense if you do a "git log --dirstat" and 
look at just individual commits that tend to be more about a single 
change).

Anyway, it's a bit larger now, but my explanations and blathering is
still much bigger than the patch itself ;)

 diff.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 diff.h |    3 ++
 2 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index cd8bc4d..ad0ff28 100644
--- a/diff.c
+++ b/diff.c
@@ -990,6 +990,85 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 	}
 }
 
+struct diffstat_dir {
+	struct diffstat_file **files;
+	int nr, percent, cumulative;
+};
+
+static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
+{
+	unsigned long this_dir = 0;
+	unsigned int sources = 0;
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
+			sources++;
+		} else {
+			this = f->added + f->deleted;
+			dir->files++;
+			dir->nr--;
+			sources += 2;
+		}
+		this_dir += this;
+	}
+
+	/*
+	 * We don't report dirstat's for 
+	 *  - the top level
+	 *  - or cases where everything came from a single directory
+	 *    under this directory (sources == 1).
+	 */
+	if (baselen && sources != 1) {
+		int permille = this_dir * 1000 / changed;
+		if (permille) {
+			int percent = permille / 10;
+			if (percent >= dir->percent) {
+				printf("%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
+				if (!dir->cumulative)
+					return 0;
+			}
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
+	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
+	gather_dirstat(&dir, changed, "", 0);
+}
+
 static void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
@@ -2058,6 +2137,7 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+	options->dirstat_percent = 3;
 	options->context = 3;
 	options->msg_sep = "";
 
@@ -2099,6 +2179,7 @@ int diff_setup_done(struct diff_options *options)
 					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
 					    DIFF_FORMAT_SHORTSTAT |
+					    DIFF_FORMAT_DIRSTAT |
 					    DIFF_FORMAT_SUMMARY |
 					    DIFF_FORMAT_PATCH);
 
@@ -2110,6 +2191,7 @@ int diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_NUMSTAT |
 				      DIFF_FORMAT_DIFFSTAT |
 				      DIFF_FORMAT_SHORTSTAT |
+				      DIFF_FORMAT_DIRSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
 		DIFF_OPT_SET(options, RECURSIVE);
@@ -2220,6 +2302,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
+	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
+		options->output_format |= DIFF_FORMAT_DIRSTAT;
+	else if (!strcmp(arg, "--cumulative"))
+		options->output_format |= DIFF_FORMAT_CUMULATIVE;
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
@@ -2938,7 +3024,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIRSTAT)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -2948,6 +3034,8 @@ void diff_flush(struct diff_options *options)
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
+		if (output_format & DIFF_FORMAT_DIRSTAT)
+			show_dirstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
diff --git a/diff.h b/diff.h
index 073d5cb..8c6bb54 100644
--- a/diff.h
+++ b/diff.h
@@ -30,6 +30,8 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
+#define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_CUMULATIVE	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
@@ -80,6 +82,7 @@ struct diff_options {
 	int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
+	int dirstat_percent;
 	int setup;
 	int abbrev;
 	const char *msg_sep;
