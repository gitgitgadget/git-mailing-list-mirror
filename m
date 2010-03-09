From: Markus Duft <markus.duft@salomon.at>
Subject: git interix support
Date: Tue, 09 Mar 2010 11:35:02 +0100
Organization: Salomon Automation GmbH
Message-ID: <4B962456.20600@salomon.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030601020709040203060108"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXt-0001Do-3S
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab0CILJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 06:09:47 -0500
Received: from smtp.salomon.at ([193.186.16.13]:51459 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752843Ab0CILJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 06:09:45 -0500
X-Greylist: delayed 2024 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 06:09:45 EST
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id o29AZwaI023433
	for <git@vger.kernel.org>; Tue, 9 Mar 2010 11:35:59 +0100 (MET)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Mar 2010 11:35:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100308 Lightning/1.0b2pre Thunderbird/3.0.3
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 09 Mar 2010 10:35:58.0094 (UTC) FILETIME=[4E1A52E0:01CABF74]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141824>

This is a multi-part message in MIME format.
--------------030601020709040203060108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hey.

i have "ported" git to interix (haha, wasn't so much of a problem after
all ;)). i have a small patch (attached). i know that it sure doesn't
have production quality yet, but i try gathering ideas/input here.

additionally to the patch i'm setting:

147     if [[ ${CHOST} == *-interix* ]] ; then
148         myopts="${myopts} NO_IPV6=YesPlease"
149         myopts="${myopts} NO_MEMMEM=YesPlease"
150         myopts="${myopts} NO_MKDTEMP=YesPlease"
151         myopts="${myopts} NO_STRTOUMAX=YesPlease"
152         myopts="${myopts} NO_STRTOULL=YesPlease"
153         myopts="${myopts} NO_INET_NTOP=YesPlease"
154         myopts="${myopts} NO_INET_PTON=YesPlease"
155         myopts="${myopts} NO_NSEC=YesPlease"
156         myopts="${myopts} NO_MKSTEMPS=YesPlease"
157     fi

interix lacks propper poll() support (poll is there but broken), so some
of the things in git have to be disabled for now, or replaced by a
select() code (but that'd take precious time of mine to implement (argh)).

any comments on the patch? any chance to get stuff upstream?

(BTW. i know that this is not the most current git release i'm patching
(1.6.6.1), and i'll have to forward port the patch at some point anyway
- i hope i'll get to this soon...)

Thanks in advance!

Cheers, Markus

--------------030601020709040203060108
Content-Type: text/plain;
 name="git-1.6.6.1-interix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="git-1.6.6.1-interix.patch"

diff -ru git-1.6.6.1.orig/builtin-upload-archive.c git-1.6.6.1/builtin-upload-archive.c
--- git-1.6.6.1.orig/builtin-upload-archive.c	2010-03-09 10:51:28 +0100
+++ git-1.6.6.1/builtin-upload-archive.c	2010-03-09 11:06:45 +0100
@@ -132,8 +132,9 @@
 	packet_flush(1);
 
 	while (1) {
-		struct pollfd pfd[2];
 		int status;
+#ifndef __INTERIX
+		struct pollfd pfd[2];
 
 		pfd[0].fd = fd1[0];
 		pfd[0].events = POLLIN;
@@ -156,6 +157,8 @@
 			if (process_input(pfd[0].fd, 1))
 				continue;
 
+#endif
+
 		if (waitpid(writer, &status, 0) < 0)
 			error_clnt("%s", lostchild);
 		else if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
diff -ru git-1.6.6.1.orig/daemon.c git-1.6.6.1/daemon.c
--- git-1.6.6.1.orig/daemon.c	2010-03-09 10:51:28 +0100
+++ git-1.6.6.1/daemon.c	2010-03-09 11:00:50 +0100
@@ -14,6 +14,8 @@
 #define NI_MAXSERV 32
 #endif
 
+#ifndef __INTERIX /* not available on interix! */
+
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
@@ -922,8 +924,13 @@
 	return service_loop(socknum, socklist);
 }
 
+#endif /* __INTERIX */
+
 int main(int argc, char **argv)
 {
+#ifdef __INTERIX
+	die("not implemented on interix!");
+#else /* !__INTERIX */
 	int listen_port = 0;
 	char *listen_addr = NULL;
 	int inetd_mode = 0;
@@ -1121,4 +1128,5 @@
 		store_pid(pid_file);
 
 	return serve(listen_addr, listen_port, pass, gid);
+#endif /* __INTERIX */
 }
diff -ru git-1.6.6.1.orig/git-compat-util.h git-1.6.6.1/git-compat-util.h
--- git-1.6.6.1.orig/git-compat-util.h	2010-03-09 10:51:29 +0100
+++ git-1.6.6.1/git-compat-util.h	2010-03-09 10:53:59 +0100
@@ -93,7 +93,9 @@
 #include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
+#ifndef __INTERIX
 #include <sys/poll.h>
+#endif
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #ifndef NO_SYS_SELECT_H
@@ -104,7 +106,11 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#ifndef __INTERIX
 #include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
diff -ru git-1.6.6.1.orig/upload-pack.c git-1.6.6.1/upload-pack.c
--- git-1.6.6.1.orig/upload-pack.c	2010-03-09 10:51:33 +0100
+++ git-1.6.6.1/upload-pack.c	2010-03-09 10:58:02 +0100
@@ -150,6 +150,7 @@
 
 static void create_pack_file(void)
 {
+#ifndef __INTERIX
 	struct async rev_list;
 	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
@@ -328,6 +329,9 @@
  fail:
 	send_client_data(3, abort_msg, sizeof(abort_msg));
 	die("git upload-pack: %s", abort_msg);
+#else /* __INTERIX */
+	die("git upload-pack: not implemented on interix!");
+#endif /* __INTERIX */
 }
 
 static int got_sha1(char *hex, unsigned char *sha1)

--------------030601020709040203060108--
