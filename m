From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Auto Packing message twice?
Date: Sun, 31 Aug 2014 11:26:15 +0700
Message-ID: <20140831042615.GA7862@lanh>
References: <5401B56F.6000907@gmail.com>
 <CACsJy8Ch5WW2rF4vGrM2xyFqn2-1FgPw-kO_wLtBY8-+WqM-1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 06:26:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNwic-00061P-6H
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 06:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbaHaE0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 00:26:08 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34152 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaHaE0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 00:26:06 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so9425119pad.32
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 21:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w17H+IKkuAe07R1r806C22q3PS4XiWLPEvmkP/G0cpQ=;
        b=B+op6ET3l9w9jv2/ZDweOlTk75Dam6B6xON4bWzHAZVv8r2dX9mBZmBwrQ20cP8EjR
         kwMVHzfhjZ+BzmxTiwCvjiHB2X+1dPVoEtqBzBJALhQjYCW0kOy7d7BCb6Ac9nNREKt+
         /paQZjqdCBi32PImMZeIZrf0V4Dq17OSICGGWUTYP0K6ZQAmQrItgLWxw65TpDFIZAjG
         91iMDEuELnXt+tZ3v+nb1MtnygwACV/t1xb0Vd2Sdr52sYx3cwfd/am/X4sRUo0rcD5l
         xuXJlo6v+bCRoi3TYjmMEhTpD6a0Ky0FtJk4kMj0uLVFRp6rM2ye0ob41T1x6c5eVRxM
         PJAA==
X-Received: by 10.70.131.12 with SMTP id oi12mr29026376pdb.116.1409459165558;
        Sat, 30 Aug 2014 21:26:05 -0700 (PDT)
Received: from lanh ([115.73.242.67])
        by mx.google.com with ESMTPSA id aq1sm4149323pbc.96.2014.08.30.21.26.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 21:26:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:26:15 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8Ch5WW2rF4vGrM2xyFqn2-1FgPw-kO_wLtBY8-+WqM-1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256277>

On Sat, Aug 30, 2014 at 09:12:57PM +0700, Duy Nguyen wrote:
> On Sat, Aug 30, 2014 at 6:28 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> > Auto packing the repository in background for optimum performance.
> > See "git help gc" for manual housekeeping.
> > Auto packing the repository in background for optimum performance.
> > See "git help gc" for manual housekeeping.
> >
> > Obviously it should only report once?
> > The reporting is done from within function cmd_gc(...),
> > which makes me wonder, if it also packs twice?
> 
> The problem is we print this message before checking if gc is running
> in background. Problem is we keep the lockafter forking/detaching
> because locking before forking means two processes holding the lock
> and I don't think there's a way to say "release the lock in parent
> process".

I'm wrong. It's more about the gc.pid update code, which should record
the running pid (i.e. after fork), so I can't really move
lock_repo_for_gc() code to the parent process. If we just peek ahead
in gc.pid to see if any gc is already running, there's a chance that a
new gc will start after the check, and before we update gc.pid. So
still false messages.

> And we can't print this message after detaching either
> because stdout is already closed then. But this definitely needs some
> improvement to avoid confusion.

If we do not use daemonized() then it's possible. Though
NO_POSIX_GOODIES is now sprinkled in more places.

-- 8< --
diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..f04b5dc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -280,6 +280,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int force = 0;
 	const char *name;
 	pid_t pid;
+	int forked = 0;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -327,21 +328,30 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		if (!quiet) {
-			if (detach_auto)
-				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
-			else
-				fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
+		if (!quiet && !detach_auto) {
+			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
 			if (gc_before_repack())
 				return -1;
-			/*
-			 * failure to daemonize is ok, we'll continue
-			 * in foreground
-			 */
-			daemonize();
+#ifndef NO_POSIX_GOODIES
+			switch (fork()) {
+			case 0:
+				forked = 1;
+				break;
+
+			case -1:
+				/*
+				 * failure to daemonize is ok, we'll continue
+				 * in foreground
+				 */
+				break;
+
+			default:
+				exit(0);
+			}
+#endif
 		}
 	} else
 		add_repack_all_option();
@@ -354,6 +364,23 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		    name, (uintmax_t)pid);
 	}
 
+	if (auto_gc && !quiet && detach_auto) {
+		if (forked)
+			fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
+		else
+			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
+		fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
+	}
+#ifndef NO_POSIX_GOODIES
+	if (forked) {
+		if (setsid() == -1)
+			die_errno("setsid failed");
+		close(0);
+		close(1);
+		close(2);
+		sanitize_stdfds();
+	}
+#endif
 	if (gc_before_repack())
 		return -1;
 
-- 8< --
