Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6CB1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcFSIsm (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 04:48:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47810 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbcFSIsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 04:48:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFAF1FEAA;
	Sun, 19 Jun 2016 08:48:37 +0000 (UTC)
Date:	Sun, 19 Jun 2016 08:48:37 +0000
From:	Eric Wong <e@80x24.org>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] prune: keep files created after process start
Message-ID: <20160619084837.GA22090@dcvr.yhbt.net>
References: <20160619031338.GA5161@dcvr.yhbt.net>
 <m2wpllhcut.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m2wpllhcut.fsf@linux-m68k.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > @@ -21,7 +22,7 @@ static int prune_tmp_file(const char *fullpath)
> >  	struct stat st;
> >  	if (lstat(fullpath, &st))
> >  		return error("Could not stat '%s'", fullpath);
> > -	if (st.st_mtime > expire)
> > +	if (st.st_mtime > expire || st.st_ctime >= start)
> 
> That will also mean objects created (or their inode changed) up to a
> second before the start of prune will not be removed.  For example,
> objects ejected out of a pack by a previous repack may be affected.

True, but I prefer to err on the side of keeping data rather than
removing it.   But keeping it can also be a liability (as it was
in my case :)  So, perhaps warn users instead:

diff --git a/builtin/prune.c b/builtin/prune.c
index d4cd054..c1642d1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -16,14 +16,22 @@ static int verbose;
 static unsigned long expire;
 static time_t start;
 static int show_progress = -1;
+static unsigned long ctime_matches;
 
 static int prune_tmp_file(const char *fullpath)
 {
 	struct stat st;
 	if (lstat(fullpath, &st))
 		return error("Could not stat '%s'", fullpath);
-	if (st.st_mtime > expire || st.st_ctime >= start)
+	if (st.st_mtime > expire || st.st_ctime > start)
 		return 0;
+
+	if (st.st_ctime == start) {
+		ctime_matches++;
+		warning("Keeping %s since it changed as we started", fullpath);
+		return 0;
+	}
+
 	if (show_only || verbose)
 		printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
@@ -48,8 +56,13 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
 		error("Could not stat '%s'", fullpath);
 		return 0;
 	}
-	if (st.st_mtime > expire || st.st_ctime >= start)
+	if (st.st_mtime > expire || st.st_ctime > start)
 		return 0;
+	if (st.st_ctime == start) {
+		ctime_matches++;
+		warning("Keeping %s since it changed as we started", fullpath);
+		return 0;
+	}
 	if (show_only || verbose) {
 		enum object_type type = sha1_object_info(sha1, NULL);
 		printf("%s %s\n", sha1_to_hex(sha1),
@@ -155,5 +168,12 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (is_repository_shallow())
 		prune_shallow(show_only);
 
+	if (ctime_matches) {
+		warning("%lu files kept since they changed as prune started",
+			ctime_matches);
+		warning("rerun prune after %s",
+			show_date(start, 0, DATE_MODE(NORMAL)));
+	}
+
 	return 0;
 }
