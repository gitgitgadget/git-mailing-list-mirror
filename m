From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] possible memory leak in diff.c::diff_free_filepair()
Date: Sat, 13 Aug 2005 14:31:59 -0700
Message-ID: <7viry9le0g.fsf@assigned-by-dhcp.cox.net>
References: <87y876gl1r.wl@mail2.atmark-techno.com>
	<7viry9my6k.fsf@assigned-by-dhcp.cox.net>
	<877jepo87m.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 23:35:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E43eR-0007kA-9N
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 23:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVHMVcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 17:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVHMVcB
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 17:32:01 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3757 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932269AbVHMVcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 17:32:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813213158.LCEI550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 17:31:58 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <877jepo87m.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Sun, 14 Aug 2005 06:09:01 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> oops.  probably my english wasn't clear. my patch fixes
> diff_free_filepair().

No, my reading of your patch when I wrote that message was
wrong.  The attached is what I ended up doing based on your
patch.  It does not seem to barf with the following test on
either git repository itself nor recent linux-2.6 repository,
which is a good sign.

    $ export MALLOC_CHECK_=2
    $ ./git-rev-list HEAD |
      ./git-diff-tree --stdin -r -B -C --find-copies-harder |
      sed -ne '/^[^:]/p;/ [MRCDA][0-9][0-9]*	/p'

When the command is run on linux-2.6 repository, virtual memory
consumption of git-diff-tree command skyrockets to about half a
gig, because it maps all files in two adjacent revisions of the
entire kernel tree.  But it seems to reclaim things reasonably
well and goes back down to less than 10m when it starts to
process the next commit pair.

------------
From: Yasushi SHOJI <yashi@atmark-techno.com>
Date: 1123930736 +0900
[PATCH] plug memory leak in diff.c::diff_free_filepair()

When I run git-diff-tree on big change, it seems the command eats so
much memory.  so I just put git under valgrind to see what's going on.
diff_free_filespec_data() doesn't free diff_filespec itself.

[jc: I ended up doing things slightly differently from Yasushi's
patch.  The original idea was to use free_filespec_data() only to
free the data portion and keep useing the filespec itself, but
no existing code seems to do things that way, so I just yanked
that part out.]

Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.c           |    9 ++++-----
 diffcore-break.c |    4 ++--
 diffcore.h       |    2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

20226fa40d48069b55cf165c9e197a003e1608a8
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -405,14 +405,13 @@ int diff_populate_filespec(struct diff_f
 	return 0;
 }
 
-void diff_free_filespec_data(struct diff_filespec *s)
+void diff_free_filespec(struct diff_filespec *s)
 {
 	if (s->should_free)
 		free(s->data);
 	else if (s->should_munmap)
 		munmap(s->data, s->size);
-	s->should_free = s->should_munmap = 0;
-	s->data = NULL;
+	free(s);
 }
 
 static void prep_temp_blob(struct diff_tempfile *temp,
@@ -769,8 +768,8 @@ struct diff_filepair *diff_queue(struct 
 
 void diff_free_filepair(struct diff_filepair *p)
 {
-	diff_free_filespec_data(p->one);
-	diff_free_filespec_data(p->two);
+	diff_free_filespec(p->one);
+	diff_free_filespec(p->two);
 	free(p);
 }
 
diff --git a/diffcore-break.c b/diffcore-break.c
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -231,8 +231,8 @@ static void merge_broken(struct diff_fil
 
 	dp = diff_queue(outq, d->one, c->two);
 	dp->score = p->score;
-	diff_free_filespec_data(d->two);
-	diff_free_filespec_data(c->one);
+	diff_free_filespec(d->two);
+	diff_free_filespec(c->one);
 	free(d);
 	free(c);
 }
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -43,7 +43,7 @@ extern void fill_filespec(struct diff_fi
 			  unsigned short);
 
 extern int diff_populate_filespec(struct diff_filespec *, int);
-extern void diff_free_filespec_data(struct diff_filespec *);
+extern void diff_free_filespec(struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
