From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 17:06:46 +0700
Message-ID: <20130213100646.GA24993@lanh>
References: <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
 <511AAA92.4030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Feb 13 11:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ZET-00045Y-TB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 11:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933621Ab3BMKGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 05:06:05 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:36674 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817Ab3BMKGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 05:06:03 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so485433dad.24
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SkaPFDvOgiyqoG19ESx0NBYgREQNRquAmltoKO80AQ0=;
        b=MBRS4Bio9Qeee3mUsLGHSOE374WgoiO8mRh/dDs5rn8dfEAJslWnV+6sX9NUtM0nU+
         ogvM4PMpviUV2M/XPvAbFtWI+jAkbvF9DKIHRvRA7G5weTSRqKwhu8twu0Rh5dE88Z0y
         ZhmuWEQFCoWQ5xLe95PD9Weq8HG+0L3f/J4/y76szrqAVZi+F15JJP7QORG1MAuomubt
         D0I/n46JTSujaWL8gvGKd73XTvq+uGfQMPLI2YqGsddCEP03NSsg9FlqV4Xf6QfUyzgC
         xQ47xRbPvxDrQK7bIFZpuXAOgBf6Fi4Plnmxyoaz0M6XmdvL6uumMVG577IygNQJ1lAW
         qW5A==
X-Received: by 10.66.78.1 with SMTP id x1mr62406367paw.2.1360749961730;
        Wed, 13 Feb 2013 02:06:01 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id z10sm82296989pay.7.2013.02.13.02.05.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 02:06:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 17:06:46 +0700
Content-Disposition: inline
In-Reply-To: <511AAA92.4030508@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216244>

On Tue, Feb 12, 2013 at 09:48:18PM +0100, Karsten Blees wrote:

> However, the difference between git status -uall and -uno was always
> about 1.3 s in all fscache versions, even though
> opendir/readdir/closedir was served entirely from the cache. I added
> a bit of performance tracing to find the cause, and I think most of
> the time spent in wt_status_collect_untracked can be eliminated:
> 
> 1.) 0.939 s is spent in dir.c/excluded (i.e. checking
> .gitignore). This check is done for *every* file in the working
> copy, including files in the index. Checking the index first could
> eliminate most of that, i.e.:
> 
> (Note: patches are for discussion only, I'm aware that they may have
> unintended side effects...)
>
> @@ -1097,6 +1097,8 @@ static enum path_treatment treat_path(struct dir_struct *dir,
>                 return path_ignored;
>         strbuf_setlen(path, baselen);
>         strbuf_addstr(path, de->d_name);
> +       if (cache_name_exists(path->buf, path->len, ignore_case))
> +               return path_ignored;
>         if (simplify_away(path->buf, path->len, simplify))
>                 return path_ignored;

The below patch passes the test suite for me and still does the same
thing. On my Linux box, running "git status" on gentoo-x86.git with
this patch saves 0.05s (0.548s without the patch, 0.505s with the
patch, best number of 20 runs).

And I just realized gentoo-x86.git does not have any .gitignore. On
webkit.git, it cuts "git status" time from 1.121s down to
0.762s. Unless I'm mistaken, "git add" should have the same benefit on
normal case too. Good finding!

-- 8< --
diff --git a/dir.c b/dir.c
index 57394e4..4b4cf60 100644
--- a/dir.c
+++ b/dir.c
@@ -1244,7 +1244,19 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = is_excluded(dir, path->buf, &dtype);
+	int exclude;
+
+	if (dtype == DT_UNKNOWN)
+		dtype = get_dtype(de, path->buf, path->len);
+
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    !(dir->flags & DIR_COLLECT_IGNORED) &&
+	    dtype == DT_REG &&
+	    cache_name_exists(path->buf, path->len, ignore_case))
+		return path_ignored;
+
+	exclude = is_excluded(dir, path->buf, &dtype);
+
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1256,9 +1268,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
 
-	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, path->buf, path->len);
-
 	switch (dtype) {
 	default:
 		return path_ignored;
-- 8< --
