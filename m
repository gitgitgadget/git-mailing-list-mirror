From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Mon, 27 Mar 2006 22:21:49 -0800
Message-ID: <7vu09jks1u.fsf@assigned-by-dhcp.cox.net>
References: <7v1wwnnyvt.fsf@assigned-by-dhcp.cox.net>
	<13360.1143515503@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 08:21:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO7aU-0004aW-VN
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 08:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWC1GVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 01:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWC1GVv
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 01:21:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42740 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932201AbWC1GVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 01:21:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328062150.UUZO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 01:21:50 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18112>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>  - I wonder what the dependency is, since ALL_LDFLAGS is not
>  - modified on AIX, [...]
>
> Specifically, -lcrypto.  Mine is in a funny place, so I need
> LDFLAGS passed in.

Thanks.  That is the right fix, then.

>  - > Once it builds, only one test "fails" on AIX 5.1 with 
>  - > 1.3.0.rc1, t5500-fetch-pack.sh, but it looks like it's some
>  - > odd tool problem in the tester + my setup and not a real bug.
>  - 
>  - Curious and would appreciate more details.
>
> I just found it.  The progress meter stuff in pack-objects
> splats all over the output.  So trash/client/log.txt is
> completely mangled.  Everything functions correctly, but
> the textual output is garbage.  If I set progress to 0 in 
> pack-objects.c, everthing's happy.

Hmph.  We do fprintf(stderr, "blah\r") to draw them.  The
standard says that "standard error stream is not fully
buffered", but I guess it does not necessarily mean it is
unbuffered, so we probably need to fflush(3) there.  Would
something like this help?

-- >8 --
diff --git a/fetch-clone.c b/fetch-clone.c
index da1b3ff..252e5ec 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -230,6 +230,7 @@
 					total >> 20,
 					1000*((total >> 10) & 1023)>>10,
 					avg_bytes / avg_time );
+				fflush(stderr);
 			}
 		}
 	}
diff --git a/imap-send.c b/imap-send.c
index e33c78b..dcfa8d8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1345,6 +1345,7 @@
 	while (1) {
 		unsigned percent = n * 100 / total;
 		fprintf( stderr, "%4u%% (%d/%d) done\r", percent, n, total );
+		fflush(stderr);
 		if (!split_msg( &all_msgs, &msg, &ofs ))
 			break;
 		r = imap_store_msg( ctx, &msg, &uid );
diff --git a/pack-objects.c b/pack-objects.c
index 49357c6..7c85348 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -360,6 +360,7 @@
 			if (progress_update || percent != last_percent) {
 				fprintf(stderr, "%4u%% (%u/%u) done\r",
 					percent, written, nr_result);
+				fflush(stderr);
 				progress_update = 0;
 				last_percent = percent;
 			}
@@ -570,6 +571,7 @@
  already_added:
 	if (progress_update) {
 		fprintf(stderr, "Counting objects...%d\r", nr_objects);
+		fflush(stderr);
 		progress_update = 0;
 	}
 	if (exclude)
@@ -912,6 +914,7 @@
 			if (percent != last_percent || progress_update) {
 				fprintf(stderr, "%4u%% (%u/%u) done\r",
 					percent, processed, nr_result);
+				fflush(stderr);
 				progress_update = 0;
 				last_percent = percent;
 			}
diff --git a/read-tree.c b/read-tree.c
index eaff444..6a2aa16 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -325,6 +325,7 @@
 				    progress_update) {
 					fprintf(stderr, "%4u%% (%u/%u) done\r",
 						percent, cnt, total);
+					fflush(stderr);
 					last_percent = percent;
 				}
 			}
diff --git a/unpack-objects.c b/unpack-objects.c
index 815a1b3..8596f9b 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -220,6 +220,7 @@
 			last_sec = now.tv_sec;
 			last_percent = percentage;
 			fprintf(stderr, "%4u%% (%u/%u) done\r", percentage, nr, total);
+			fflush(stderr);
 		}
 	}
 	switch (type) {
