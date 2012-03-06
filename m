From: Thomas Rast <trast@inf.ethz.ch>
Subject: [RFC HACK] refresh_index: lstat() in inode order
Date: Tue, 6 Mar 2012 09:27:50 +0100
Message-ID: <871up6cewp.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:28:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pkU-0005Uh-FL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633Ab2CFI1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:27:54 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:8765 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758512Ab2CFI1x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:27:53 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:27:51 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:27:50 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192311>

Hi,

This is prompted by a recent lkml discussion[1] which is also backed up
by old stuff threads like[2] where Theodore Ts'o writes about
spd_readdir.

As explained at the links, ext3&4 seem to show suboptimal performance if
you do the common pattern of lstat()'ing everything returned by
readdir() and the corresponding inodes must be fetched from disk.  They
suggest (and spd_readdir does just this, in an LD_PRELOADable format)
sorting the entries by inode.

Let me emphasise: inodes fetched from disk.  This does not matter at all
for the cached case.

Probably this also applies to us in the search for untracked files, but
right now I don't care about that too much because I have git-status
configured not to show them.

However, a similar trick could be applied to lstat() across the index,
which *is* a big part of the work required to accurately display
repository status in git-status and git-diff.

The dirty hack below uses the inode field in the index to sort the index
entries prior to the real work of refresh_index.  I have been able to
measure a significant (in the statistical sense) speedup using
measurements like

  ( for i in $(seq 1 30); do
      sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
      /usr/bin/time -f "time %U %S %E" ~/dev/git/git-status 2>&1 | grep time
    done ) | tee results-patched

In numbers, across 30 trials for unpatched and patched git, my time
needed to get a cache-cold 'git status' went from 4.24s to 3.97s on
average, at p=0.006.

Note that this only has an effect if your directory has the inodes all
jumbled.  I tried doing bigger trials, but I do not have a realistic
work repository bigger than git.git.  You can look at the lstat() order
you are currently getting with

  strace -e lstat -v git status 2>&1 | egrep -o 'st_ino=[0-9]+'

With the patch it should be in good sorted order.  Note, however, that
at the very end it also runs lstat() on .git/refs/*; those will still be
out of order.

So I'd be interested to hear success (or non-success) stories from
people who are actively working with larger repos, perhaps linux-2.6 or
your favourite corporate repo.  The lkml posts also seem to say that it
only matters on ext3&4, not on btrfs, but perhaps other FSes also suffer
in this area.

I'd also be interested to hear from the refresh_index experts whether my
change works in principle, or is already flawed in some major way.  You
will note I sort by (inode,stage) to handle the search forward for the
highest stage entry, but maybe this is not the only twist.  (As written
it is also not thread-safe.)

I did run the test suite and it passes, so it can't be *that* bad.


Footnotes: 
[1]  https://lkml.org/lkml/2012/2/29/210

[2]  http://lkml.indiana.edu/hypermail/linux/kernel/0802.2/1076.html


---- 8< ----
diff --git i/read-cache.c w/read-cache.c
index 274e54b..b0d1942 100644
--- i/read-cache.c
+++ w/read-cache.c
@@ -1092,10 +1092,28 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 	printf(fmt, name);
 }
 
+static struct index_state *istate_for_cmp;
+
+int cmp_by_inode(const void *a, const void *b)
+{
+	struct cache_entry *ca, *cb;
+
+	ca = istate_for_cmp->cache[*(const int *)a];
+	cb = istate_for_cmp->cache[*(const int *)b];
+
+	if (ca->ce_ino < cb->ce_ino)
+		return -1;
+	if (ca->ce_ino > cb->ce_ino)
+		return 1;
+	if (ce_stage(ca) < ce_stage(cb))
+		return -1;
+	return 1;
+}
+
 int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
 		  char *seen, const char *header_msg)
 {
-	int i;
+	int i, j;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
@@ -1110,18 +1128,28 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	const char *typechange_fmt;
 	const char *added_fmt;
 	const char *unmerged_fmt;
+	int *by_inode_idx;
 
 	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
 	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
 	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
 	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
-	for (i = 0; i < istate->cache_nr; i++) {
+
+	by_inode_idx = xmalloc(istate->cache_nr * sizeof(int));
+	for (i = 0; i < istate->cache_nr; i++)
+		by_inode_idx[i] = i;
+	istate_for_cmp = istate;
+	qsort(by_inode_idx, istate->cache_nr, sizeof(int), cmp_by_inode);
+
+	for (j = 0; j < istate->cache_nr; j++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
 		int changed = 0;
 		int filtered = 0;
 
+		i = by_inode_idx[j];
+
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
