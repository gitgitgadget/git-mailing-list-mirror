From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Tue, 12 Feb 2008 16:54:22 -0800
Message-ID: <7v1w7h1xs1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org>
 <alpine.LFD.1.00.0802121346560.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5uQ-0008HC-IO
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbYBMAyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbYBMAyv
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:54:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbYBMAyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:54:49 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E46F32A98;
	Tue, 12 Feb 2008 19:54:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 976842A91; Tue, 12 Feb 2008 19:54:25 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802121346560.2920@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 12 Feb 2008 13:56:13 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73724>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Why? That directory has a binary file, which doesn't have a "line count", 
> so --dirstat actually ends up using the byte-count instead there, which 
> inflates the macosx numbers a lot (same is true of git-gui/lib/, just to a 
> smaller degree).
>
> I don't think that's necessarily a bug, but it's certainly misleading. 
> Does it matter? Not to me, because the kernel generally doesn't have those 
> kinds of issues (no binary blobs that ever really change), but I did want 
> to point out that there's room for perhaps improving things. Maybe we 
> could add a byte count in general to the diffstat data structures and 
> always just count bytes changed rather than lines changed. Or maybe we 
> should consider binary files to have something like "32 bytes per virtual 
> line" or something.

You can drop the "line count" idea and instead count the "amount
of damage" done to the preimage, just like we do in the rename
similarity computation.

The attached patch is just an outline.  There may need special
cases for unmerged paths.

Comparison with your examples is a bit interesting:

    (non cumulative)            (linus, non cumulative)
      18.6% crypto/              20.5% crypto/             
       7.7% fs/afs/               7.6% fs/afs/             
      10.9% fs/fuse/              7.6% fs/fuse/            
       7.4% fs/gfs2/              7.6% fs/gfs2/            
       5.3% fs/jffs2/             5.1% fs/jffs2/       
       4.9% fs/nfs/               5.1% fs/nfs/             
       4.5% fs/nfsd/              5.1% fs/nfsd/            
       7.4% fs/reiserfs/          7.6% fs/reiserfs/    
      14.4% fs/                  15.3% fs/         
       7.4% net/rxrpc/            7.6% net/rxrpc/      
      10.8% security/keys/       10.2% security/keys/  

So it does not change much for text-only project.  But the big
binary file difference is now in the noise:

    (git)                       (linus, git)                 
      12.4% Documentation/       10.0% Documentation/        
       7.3% contrib/              4.9% contrib/              
       6.0% git-gui/lib/          5.7% git-gui/lib/  
      12.9% git-gui/po/          13.9% git-gui/macosx/       
      23.0% git-gui/              8.7% git-gui/po/   
       7.3% gitk-git/            31.4% git-gui/              
      14.1% t/                    4.6% gitk-git/     
                                 13.1% t/                

git-gui/lib is about 220k while macosx is 30k, when counted with
"find $there -type f | xargs cat | wc -c", so this reflects the
reality much better.

I also suspect --cumulative should imply --dirstat but that is a
different patch if ever.

 diff.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index dd374d4..8ad04ac 100644
--- a/diff.c
+++ b/diff.c
@@ -990,18 +990,23 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 	}
 }
 
-struct diffstat_dir {
-	struct diffstat_file **files;
-	int nr, percent, cumulative;
+struct dirstat_file {
+	const char *name;
+	unsigned long changed;
 };
 
-static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
+struct dirstat_dir {
+	struct dirstat_file *files;
+	int alloc, nr, percent, cumulative;
+};
+
+static long gather_dirstat(struct dirstat_dir *dir, unsigned long changed, const char *base, int baselen)
 {
 	unsigned long this_dir = 0;
 	unsigned int sources = 0;
 
 	while (dir->nr) {
-		struct diffstat_file *f = *dir->files;
+		struct dirstat_file *f = dir->files;
 		int namelen = strlen(f->name);
 		unsigned long this;
 		char *slash;
@@ -1016,7 +1021,7 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 			this = gather_dirstat(dir, changed, f->name, newbaselen);
 			sources++;
 		} else {
-			this = f->added + f->deleted;
+			this = f->changed;
 			dir->files++;
 			dir->nr--;
 			sources += 2;
@@ -1044,17 +1049,58 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 	return this_dir;
 }
 
-static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
+static void show_dirstat(struct diff_options *options)
 {
 	int i;
 	unsigned long changed;
-	struct diffstat_dir dir;
+	struct dirstat_dir dir;
+	struct diff_queue_struct *q = &diff_queued_diff;
+
+	dir.files = NULL;
+	dir.alloc = 0;
+	dir.nr = 0;
+	dir.percent = options->dirstat_percent;
+	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
 
-	/* Calculate total changes */
 	changed = 0;
-	for (i = 0; i < data->nr; i++) {
-		changed += data->files[i]->added;
-		changed += data->files[i]->deleted;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *name;
+		unsigned long copied, added, damage;
+
+		name = p->one->path ? p->one->path : p->two->path;
+
+		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
+			diff_populate_filespec(p->one, 0);
+			diff_populate_filespec(p->two, 0);
+			diffcore_count_changes(p->one, p->two, NULL, NULL, 0,
+					       &copied, &added);
+			diff_free_filespec_data(p->one);
+			diff_free_filespec_data(p->two);
+		} else if (DIFF_FILE_VALID(p->one)) {
+			diff_populate_filespec(p->one, 1);
+			copied = added = 0;
+			diff_free_filespec_data(p->one);
+		} else if (DIFF_FILE_VALID(p->two)) {
+			diff_populate_filespec(p->two, 1);
+			copied = 0;
+			added = p->two->size;
+			diff_free_filespec_data(p->two);
+		} else
+			continue;
+
+		/*
+		 * Original minus copied is the removed material,
+		 * added is the new material.  They are both damages
+		 * made to the preimage.
+		 */
+		damage = (p->one->size - copied) + added;
+
+		ALLOC_GROW(dir.files, dir.nr + 1, dir.alloc);
+		dir.files[dir.nr].name = name;
+		dir.files[dir.nr].changed = damage;
+		changed += damage;
+		dir.nr++;
 	}
 
 	/* This can happen even with many files, if everything was renames */
@@ -1062,10 +1108,6 @@ static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
 		return;
 
 	/* Show all directories with more than x% of the changes */
-	dir.files = data->files;
-	dir.nr = data->nr;
-	dir.percent = options->dirstat_percent;
-	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
 	gather_dirstat(&dir, changed, "", 0);
 }
 
@@ -3024,7 +3066,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIRSTAT)) {
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -3034,8 +3076,6 @@ void diff_flush(struct diff_options *options)
 			if (check_pair_status(p))
 				diff_flush_stat(p, options, &diffstat);
 		}
-		if (output_format & DIFF_FORMAT_DIRSTAT)
-			show_dirstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -3045,6 +3085,8 @@ void diff_flush(struct diff_options *options)
 		free_diffstat_info(&diffstat);
 		separator++;
 	}
+	if (output_format & DIFF_FORMAT_DIRSTAT)
+		show_dirstat(options);
 
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
 		for (i = 0; i < q->nr; i++)
