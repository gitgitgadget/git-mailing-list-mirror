From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Rewrite branch in C and make it a builtin.
Date: Fri, 1 Sep 2006 21:08:06 -0400
Message-ID: <20060902010806.GA24234@spearce.org>
References: <1156562127979-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 03:10:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJK1r-00059t-83
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 03:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIBBKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWIBBKb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 21:10:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22739 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750774AbWIBBKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 21:10:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJK1N-0005VP-FJ; Fri, 01 Sep 2006 21:10:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 164B720FB7C; Fri,  1 Sep 2006 21:08:06 -0400 (EDT)
To: krh@redhat.com, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <1156562127979-git-send-email-krh@redhat.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26314>

Kristian  H??gsberg <krh@redhat.com> wrote:
> A more or less straight port to C of the shell script version.

[snip]
> +static void create_reflog(struct ref_lock *lock)

I'm attaching a patch to the reflog code which introduces a new
force_log option.  You can use set this after you lock the ref
but before writing it, provided that the user supplied -l on
the command line.

This completely replaces the create_reflog function with common code.

I apologize for taking so long to get around to this but I've been
busy with other stuff lately.  :-)


-- 8> --
Add force_log flag to ref_lock to create logs when necessary.

Callers of lock_ref_sha1 or lock_any_ref_for_update may now set
lck->force_log = 1 if they want to create the associated reflog
during write_ref_sha1 if the log is missing.

If set this will override a false setting of the configuration
parameter core.logAllRefUpdates and create a missing log, at which
point future updates to the same ref would be logged as the log
is present.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 refs.c |    2 +-
 refs.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index aab14fc..b29e2f4 100644
--- a/refs.c
+++ b/refs.c
@@ -361,7 +361,7 @@ static int log_ref_write(struct ref_lock
 	char *logrec;
 	const char *committer;
 
-	if (log_all_ref_updates) {
+	if (log_all_ref_updates || lock->force_log) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
diff --git a/refs.h b/refs.h
index 553155c..d4798c9 100644
--- a/refs.h
+++ b/refs.h
@@ -7,7 +7,8 @@ struct ref_lock {
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
-	int force_write;
+	int force_write; /* force creating ref if not present */
+	int force_log;   /* force creating log if not present */
 };
 
 /*
-- 
1.4.2.ga2654


-- 
VGER BF report: U 0.5
