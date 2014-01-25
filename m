From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug with git-diff --quiet
Date: Sat, 25 Jan 2014 11:03:15 +0700
Message-ID: <20140125040315.GA26556@lanh>
References: <20140123024525.B726248918@mail.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
X-From: git-owner@vger.kernel.org Sat Jan 25 04:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6uNV-0004yT-Ft
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 04:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbaAYD5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 22:57:41 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:40266 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAYD5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 22:57:41 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so3942316pbb.25
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 19:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jH7kpT2LVxquQeBtqL/gCRioXm5j5yR59qIfdttv9Uw=;
        b=CzJiMYU1EkBHLMh4Xrb1gVDHKjhx3f4CGgX6+2k8b12AdT0DyU3mcCU7kWozPBiL0u
         0E8mFjURVaG07SWFg9f5E4xFYPZnSQ36gVRXXavUqcEOFDJ9BgO1UnuKPLULC3Q+feou
         ukM8WWposNZoENRF4dRM+KgO1qlHtLd5OLngvwE9/A5Bz9h96se9JZw8QA1+xjhKcr3U
         4AU7wY2vlW2eUT645cemXQBRLLAjU69MpBb2Y8y8w77GraYfmDnyWf79FaRpCKMPrBUs
         XpaBCmsPaIHVSsrEfL9leDLriNZTvSxxJcPordVNhKJrTQ7nuYEOaNB1wWm8hr1hEaEZ
         3Ofw==
X-Received: by 10.66.148.134 with SMTP id ts6mr17488110pab.113.1390622260493;
        Fri, 24 Jan 2014 19:57:40 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id i10sm22469755pat.11.2014.01.24.19.57.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 19:57:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 25 Jan 2014 11:03:15 +0700
Content-Disposition: inline
In-Reply-To: <20140123024525.B726248918@mail.valinux.co.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241059>

On Thu, Jan 23, 2014 at 11:45:25AM +0900, IWAMOTO Toshihiro wrote:
> I found "git-diff --quiet" returns a zero exit status even if there's
> a change.  The following sequence reproduces the bug:
> 
>   $ mkdir foo
>   $ cd foo
>   $ git init
>   $ echo a > a.txt
>   $ echo b >b.txt
>   $ git add ?.txt
>   $ git commit
>   $ echo b >> b.txt
>   $ touch a.txt
>   $ git diff --quiet; echo $?
>   
> Interestingly, if you issue "git-diff --quiet" again, it returns the
> expected exit status 1.

Because stat info in index is updated and diff_change() won't be
called again on a.txt.

> The problem is in the optimization code in run_diff_files().  The
> function finds a.txt has different stat(2) data from .git/index and
> calls diff_change(), which sets DIFF_OPT_HAS_CHANGES.  As the flag
> makes diff_can_quit_early() return 1, run_diff_files()'s loop finishes
> without calling diff_change() for b.txt.
> 
> Then, diffcore_std() examines diff_queued_diff and clears
> DIFF_OPT_HAS_CHANGES, because a.txt is unchanged.
> This is how a change in b.txt is ignored by git-diff --quiet.

Thanks for the analysis. Perhaps we could make diff_change test
whether a.txt is unchanged so it does not set HAS_CHANGES prematurely?
Maybe something like below.

By the time diffcore_skip_stat_unmatch() is called, everything is
cached, so there's not much of performance regression. We still do
memcmp() twice (in diff_filespec_is_identical), but I think that has
less impact than removing diff_can_quit_early().

-- 8< --
diff --git a/diff.c b/diff.c
index 6b4cd0e..5226fc0 100644
--- a/diff.c
+++ b/diff.c
@@ -4697,6 +4697,33 @@ static int diff_filespec_is_identical(struct diff_filespec *one,
 	return !memcmp(one->data, two->data, one->size);
 }
 
+static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
+{
+	/*
+	 * 1. Entries that come from stat info dirtiness
+	 *    always have both sides (iow, not create/delete),
+	 *    one side of the object name is unknown, with
+	 *    the same mode and size.  Keep the ones that
+	 *    do not match these criteria.  They have real
+	 *    differences.
+	 *
+	 * 2. At this point, the file is known to be modified,
+	 *    with the same mode and size, and the object
+	 *    name of one side is unknown.  Need to inspect
+	 *    the identical contents.
+	 */
+	if (!DIFF_FILE_VALID(p->one) || /* (1) */
+	    !DIFF_FILE_VALID(p->two) ||
+	    (p->one->sha1_valid && p->two->sha1_valid) ||
+	    (p->one->mode != p->two->mode) ||
+	    diff_populate_filespec(p->one, 1) ||
+	    diff_populate_filespec(p->two, 1) ||
+	    (p->one->size != p->two->size) ||
+	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
+		return 1;
+	return 0;
+}
+
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
 	int i;
@@ -4707,27 +4734,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
-		/*
-		 * 1. Entries that come from stat info dirtiness
-		 *    always have both sides (iow, not create/delete),
-		 *    one side of the object name is unknown, with
-		 *    the same mode and size.  Keep the ones that
-		 *    do not match these criteria.  They have real
-		 *    differences.
-		 *
-		 * 2. At this point, the file is known to be modified,
-		 *    with the same mode and size, and the object
-		 *    name of one side is unknown.  Need to inspect
-		 *    the identical contents.
-		 */
-		if (!DIFF_FILE_VALID(p->one) || /* (1) */
-		    !DIFF_FILE_VALID(p->two) ||
-		    (p->one->sha1_valid && p->two->sha1_valid) ||
-		    (p->one->mode != p->two->mode) ||
-		    diff_populate_filespec(p->one, 1) ||
-		    diff_populate_filespec(p->two, 1) ||
-		    (p->one->size != p->two->size) ||
-		    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
+		if (diff_filespec_check_stat_unmatch(p))
 			diff_q(&outq, p);
 		else {
 			/*
@@ -4890,6 +4897,7 @@ void diff_change(struct diff_options *options,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *p;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
@@ -4916,10 +4924,17 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_sha1, new_sha1_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
+	p = diff_queue(&diff_queued_diff, one, two);
 
-	diff_queue(&diff_queued_diff, one, two);
-	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
-		DIFF_OPT_SET(options, HAS_CHANGES);
+	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+		return;
+
+	if (DIFF_OPT_TST(options, QUICK) &&
+	    options->skip_stat_unmatch &&
+	    !diff_filespec_check_stat_unmatch(p))
+		return;
+
+	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
-- 8< --

> Here's a obvious fix for this bug, but I think you can find a better
> fix. Thanks in advance.
> 
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index 346cac6..0b8c58d 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -105,9 +105,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		int changed;
>  		unsigned dirty_submodule = 0;
>  
> -		if (diff_can_quit_early(&revs->diffopt))
> -			break;
> -
>  		if (!ce_path_match(ce, &revs->prune_data))
>  			continue;
>  
> --
> IWAMOTO Toshihiro
