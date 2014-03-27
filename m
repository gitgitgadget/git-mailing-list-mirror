From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 16/19] tree-diff: reuse base str(buf) memory on
 sub-tree recursion
Date: Thu, 27 Mar 2014 18:22:07 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140327142207.GB17333@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <301eb2377e0c5f670ffc26bda085d14dbee4f431.1393257006.git.kirr@mns.spb.ru>
 <xmqq61n3p913.fsf@gitster.dls.corp.google.com>
 <20140325092320.GC3777@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:18:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTB8u-0004BY-Dv
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbaC0OSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:18:48 -0400
Received: from forward20.mail.yandex.net ([95.108.253.145]:49889 "EHLO
	forward20.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaC0OSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:18:46 -0400
Received: from smtp19.mail.yandex.net (smtp19.mail.yandex.net [95.108.252.19])
	by forward20.mail.yandex.net (Yandex) with ESMTP id 3315F104413F;
	Thu, 27 Mar 2014 18:18:44 +0400 (MSK)
Received: from smtp19.mail.yandex.net (localhost [127.0.0.1])
	by smtp19.mail.yandex.net (Yandex) with ESMTP id C95D8BE00FB;
	Thu, 27 Mar 2014 18:18:43 +0400 (MSK)
Received: from unknown (unknown [93.185.17.156])
	by smtp19.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XLnxnVPZoh-IdDGSbDG;
	Thu, 27 Mar 2014 18:18:39 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 414ca13d-1a26-4df8-bb85-1556424c3734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395929923; bh=yA9gtyJOTfSXPahvsQo/PrnWxRYj9o7/Wcidtk1KbVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=IcGZuA/ZOxCPgb5/mEQFyl0PYKNZ0PH+i+BYwN9JFrscnif9D3jyqVaJbBFmmNXy3
	 ogiiHCVDowmKKU1rrIPWbBbLbVdh9VjxbZ2dcQxv7IRobkKLxmaHwz91LVNko+iV0+
	 jqE8e+HMi8sOKyFt/etr1/paAZQ5m+/LGrhOYV+Q=
Authentication-Results: smtp19.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WTBC3-0005UY-Qs; Thu, 27 Mar 2014 18:22:07 +0400
Content-Disposition: inline
In-Reply-To: <20140325092320.GC3777@mini.zxlink>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245279>

On Tue, Mar 25, 2014 at 01:23:20PM +0400, Kirill Smelkov wrote:
> On Mon, Mar 24, 2014 at 02:43:36PM -0700, Junio C Hamano wrote:
> > Kirill Smelkov <kirr@mns.spb.ru> writes:
> > 
> > > instead of allocating it all the time for every subtree in
> > > __diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
> > > callee just use it in stacking style, without memory allocations.
> > >
> > > This should be faster, and for me this change gives the following
> > > slight speedups for
> > >
> > >     git log --raw --no-abbrev --no-renames --format='%H'
> > >
> > >                 navy.git    linux.git v3.10..v3.11
> > >
> > >     before      0.618s      1.903s
> > >     after       0.611s      1.889s
> > >     speedup     1.1%        0.7%
> > >
> > > Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> > > ---
> > >
> > > Changes since v1:
> > >
> > >  - don't need to touch diff.h, as the function we are changing became static.
> > >
> > >  tree-diff.c | 36 ++++++++++++++++++------------------
> > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tree-diff.c b/tree-diff.c
> > > index aea0297..c76821d 100644
> > > --- a/tree-diff.c
> > > +++ b/tree-diff.c
> > > @@ -115,7 +115,7 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
> > >  	if (recurse) {
> > >  		strbuf_addch(base, '/');
> > >  		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> > > -				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
> > > +				 t2 ? t2->entry.sha1 : NULL, base, opt);
> > >  	}
> > >  
> > >  	strbuf_setlen(base, old_baselen);
> > 
> > I was scratching my head for a while, after seeing that there does
> > not seem to be any *new* code added by this patch in order to
> > store-away the original length and restore the singleton base buffer
> > to the original length after using addch/addstr to extend it.
> > 
> > But I see that the code has already been prepared to do this
> > conversion.  I wonder why we didn't do this earlier ;-)
> 
> The conversion to reusing memory started in 48932677 "diff-tree: convert
> base+baselen to writable strbuf" which allowed to avoid "quite a bit of
> malloc() and memcpy()", but for this to work allocation at diff_tree()
> entry had to be there.
> 
> In particular it had to be there, because diff_tree() accepted base as C
> string, not strbuf, and since diff_tree() was calling itself
> recursively - oops - new allocation on every subtree.
> 
> I've opened the door for avoiding allocations via splitting diff_tree
> into high-level and low-level parts. The high-level part still accepts
> `char *base`, but low-level function operates on strbuf and recurses
> into low-level self.
> 
> The high-level diff_tree_sha1() still allocates memory for every
> diff(tree1,tree2), but that is significantly lower compared to
> allocating memory on every subtree...
> 
> The lesson here is: better use strbuf for api unless there is a reason
> not to.
> 
> 
> > Looks good.  Thanks.
> 
> Thanks.

Thanks again. Here it goes adjusted to __diff_tree_sha1 -> ll_diff_tree_sha1 renaming:

(please keep author email)
---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Mon, 24 Feb 2014 20:21:48 +0400
Subject: [PATCH v3] tree-diff: reuse base str(buf) memory on sub-tree recursion

instead of allocating it all the time for every subtree in
ll_diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
callee just use it in stacking style, without memory allocations.

This should be faster, and for me this change gives the following
slight speedups for

    git log --raw --no-abbrev --no-renames --format='%H'

                navy.git    linux.git v3.10..v3.11

    before      0.618s      1.903s
    after       0.611s      1.889s
    speedup     1.1%        0.7%

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---

Changes since v2:

 - adjust to __diff_tree_sha1 -> ll_diff_tree_sha1 renaming.

Changes since v1:

 - don't need to touch diff.h, as the function we are changing became
   static.

 tree-diff.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 7fbb022..8c8bde6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -8,7 +8,7 @@
 
 
 static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			     const char *base_str, struct diff_options *opt);
+			     struct strbuf *base, struct diff_options *opt);
 
 /*
  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
@@ -123,7 +123,7 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 	if (recurse) {
 		strbuf_addch(base, '/');
 		ll_diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-				  t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+				  t2 ? t2->entry.sha1 : NULL, base, opt);
 	}
 
 	strbuf_setlen(base, old_baselen);
@@ -146,12 +146,10 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 }
 
 static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			     const char *base_str, struct diff_options *opt)
+			     struct strbuf *base, struct diff_options *opt)
 {
 	struct tree_desc t1, t2;
 	void *t1tree, *t2tree;
-	struct strbuf base;
-	int baselen = strlen(base_str);
 
 	t1tree = fill_tree_descriptor(&t1, old);
 	t2tree = fill_tree_descriptor(&t2, new);
@@ -159,17 +157,14 @@ static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 	/* Enable recursion indefinitely */
 	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
 
-	strbuf_init(&base, PATH_MAX);
-	strbuf_add(&base, base_str, baselen);
-
 	for (;;) {
 		int cmp;
 
 		if (diff_can_quit_early(opt))
 			break;
 		if (opt->pathspec.nr) {
-			skip_uninteresting(&t1, &base, opt);
-			skip_uninteresting(&t2, &base, opt);
+			skip_uninteresting(&t1, base, opt);
+			skip_uninteresting(&t2, base, opt);
 		}
 		if (!t1.size && !t2.size)
 			break;
@@ -181,7 +176,7 @@ static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
 			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
 			    (t1.entry.mode != t2.entry.mode))
-				show_path(&base, opt, &t1, &t2);
+				show_path(base, opt, &t1, &t2);
 
 			update_tree_entry(&t1);
 			update_tree_entry(&t2);
@@ -189,18 +184,17 @@ static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 
 		/* t1 < t2 */
 		else if (cmp < 0) {
-			show_path(&base, opt, &t1, /*t2=*/NULL);
+			show_path(base, opt, &t1, /*t2=*/NULL);
 			update_tree_entry(&t1);
 		}
 
 		/* t1 > t2 */
 		else {
-			show_path(&base, opt, /*t1=*/NULL, &t2);
+			show_path(base, opt, /*t1=*/NULL, &t2);
 			update_tree_entry(&t2);
 		}
 	}
 
-	strbuf_release(&base);
 	free(t2tree);
 	free(t1tree);
 	return 0;
@@ -217,7 +211,7 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, struct strbuf *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -314,13 +308,19 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 	q->nr = 1;
 }
 
-int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
+int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base_str, struct diff_options *opt)
 {
+	struct strbuf base;
 	int retval;
 
-	retval = ll_diff_tree_sha1(old, new, base, opt);
-	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
-		try_to_follow_renames(old, new, base, opt);
+	strbuf_init(&base, PATH_MAX);
+	strbuf_addstr(&base, base_str);
+
+	retval = ll_diff_tree_sha1(old, new, &base, opt);
+	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
+		try_to_follow_renames(old, new, &base, opt);
+
+	strbuf_release(&base);
 
 	return retval;
 }
-- 
1.9.rc0.143.g6fd479e
