From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 02 Apr 2006 12:52:35 -0700
Message-ID: <824.1144007555@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0604021159110.3050@g5.osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 21:52:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ8cp-0007on-Cv
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 21:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDBTwg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWDBTwg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 15:52:36 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:922 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932364AbWDBTwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 15:52:35 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k32JqZgH000826
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 12:52:35 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k32JqZNU000825
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 12:52:35 -0700 (PDT)
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.64.0604021159110.3050@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18281>

And Linus Torvalds writes:
 - 
 - so it really really looks like fgets() would have problems with a SIGALRM 
 - coming in and doesn't just re-try on EINTR. Can Solaris stdio _really_ be 
 - that broken? (Yeah, yeah, it may be "conforming". It's also so incredibly 
 - programmer-unfriendly that it's not even funny)

Yes, it is that broken.  I haven't encountered the problem 
consistently in git myself, so I can't tell you if the patch 
works.  Google finds similar reports and patches for BOINC, ruby,
and a few other projects.

Solaris folks will say you should be using sigaction with
SA_RESTART.  IIRC, SA_RESTART isn't guaranteed to be there 
or work, but all the systems I deal with right now have it.
So an alternate patch for this one use is appended...  Other
uses of signal could be changed to sigaction, too.  And
progress_update "should" be sig_atomic_t.

Passes the pack-objects tests, but I can't make the problem 
happen on demand.  (I have seen it occur before, but never
during make test, and I'd not tracked it down...)

Jason
----
diff --git a/pack-objects.c b/pack-objects.c
index ccfaa5f..1faa0bb 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -877,10 +877,21 @@ static int try_delta(struct unpacked *cu
 	return 0;
 }
 
-static void progress_interval(int signum)
+static void progress_interval(int);
+
+static void setup_progress_signal(void)
+{
+	struct sigaction sa;
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+}
+
+void progress_interval(int signum)
 {
-	signal(SIGALRM, progress_interval);
 	progress_update = 1;
+	setup_progress_signal();
 }
 
 static void find_deltas(struct object_entry **list, int window, int depth)
@@ -1094,7 +1105,7 @@ int main(int argc, char **argv)
 		v.it_interval.tv_sec = 1;
 		v.it_interval.tv_usec = 0;
 		v.it_value = v.it_interval;
-		signal(SIGALRM, progress_interval);
+		setup_progress_signal();
 		setitimer(ITIMER_REAL, &v, NULL);
 		fprintf(stderr, "Generating pack...\n");
 	}
