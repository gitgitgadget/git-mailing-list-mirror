From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 2 Apr 2006 13:28:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604021312510.3050@g5.osdl.org>
References: <824.1144007555@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 22:28:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ9BY-0004u7-W2
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 22:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWDBU2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 16:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWDBU2a
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 16:28:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932127AbWDBU23 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 16:28:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k32KSREX019148
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Apr 2006 13:28:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k32KSReH021768;
	Sun, 2 Apr 2006 13:28:27 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <824.1144007555@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18282>



On Sun, 2 Apr 2006, Jason Riedy wrote:
> 
> Solaris folks will say you should be using sigaction with
> SA_RESTART.  IIRC, SA_RESTART isn't guaranteed to be there 
> or work, but all the systems I deal with right now have it.

I think we might as well do that _too_.

However, once you use "sigaction()", you don't need to re-arm the signal 
handler any more, so I'd suggest a simpler patch like this instead..

Junio, I think this confirms/explains the Solaris breakage.

I'll re-send the "anal stdio semantics" version of the patch on top of 
this in the next email.

			Linus
----
Subject: Fix Solaris stdio signal handling stupidities

This uses sigaction() to install the SIGALRM handler with SA_RESTART, so
that Solaris stdio doesn't break completely when a signal interrupts a
read.

Thanks to Jason Riedy for confirming the silly Solaris signal behaviour.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

diff --git a/pack-objects.c b/pack-objects.c
index ccfaa5f..1817b58 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -58,7 +58,7 @@ static int nr_objects = 0, nr_alloc = 0,
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
-static volatile int progress_update = 0;
+static volatile sig_atomic_t progress_update = 0;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -879,7 +879,6 @@ static int try_delta(struct unpacked *cu
 
 static void progress_interval(int signum)
 {
-	signal(SIGALRM, progress_interval);
 	progress_update = 1;
 }
 
@@ -1025,6 +1024,23 @@ static int reuse_cached_pack(unsigned ch
 	return 1;
 }
 
+static void setup_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
 int main(int argc, char **argv)
 {
 	SHA_CTX ctx;
@@ -1090,13 +1106,8 @@ int main(int argc, char **argv)
 	prepare_packed_git();
 
 	if (progress) {
-		struct itimerval v;
-		v.it_interval.tv_sec = 1;
-		v.it_interval.tv_usec = 0;
-		v.it_value = v.it_interval;
-		signal(SIGALRM, progress_interval);
-		setitimer(ITIMER_REAL, &v, NULL);
 		fprintf(stderr, "Generating pack...\n");
+		setup_progress_signal();
 	}
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
