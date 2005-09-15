From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 09:03:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
References: <43290EFF.3070604@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 18:06:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwDA-0004IC-PX
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbVIOQDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbVIOQDm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:03:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030503AbVIOQDm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 12:03:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FG3cBo029202
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 09:03:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FG3VL7008485;
	Thu, 15 Sep 2005 09:03:35 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290EFF.3070604@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8611>



On Wed, 14 Sep 2005, H. Peter Anvin wrote:
> 
> On that note, though, it would be very nice if there was a way to run 
> git-daemon in a chroot, or otherwise restrict it to a specific 
> subhierarchy of the filesystem.

Hmm.. That should work fine. You can already just run it that way by just 
wrapping it in "chroot", but if you don't want that for some reason, how 
about a patch like this?

It compiles. That's just about all I can say about it.

		Linus

---
diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -1,11 +1,19 @@
+/* setresuid/setresgid. GNU? Who are you kidding, glibc? */
+#define _GNU_SOURCE
+
 #include "cache.h"
 #include "pkt-line.h"
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
 #include <sys/time.h>
+#include <sys/types.h>
 #include <netdb.h>
 #include <netinet/in.h>
+#include <unistd.h>
+
+#include <pwd.h>
+#include <grp.h>
 
 static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
 
@@ -326,10 +334,50 @@ static int serve(int port)
 	}
 }
 
+/*
+ * This will drop our effective uid/gid to the real one,
+ * even if no "--user=" or "--group=" arguments were used.
+ *
+ * So it's not a no-op even without that.
+ */
+static void set_user_group(const char *user, const char *group)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char *end;
+
+	if (user) {
+		struct passwd *pw = getpwnam(user);
+		if (pw) {
+			uid = pw->pw_uid;
+			gid = pw->pw_gid;
+		} else {
+			uid = strtol(user, &end, 10);
+			if (*end || end == user)
+				die("invalid user name '%s'", user);
+		}
+	}
+	if (group) {
+		struct group *grp = getgrnam(group);
+		if (grp) {
+			gid = grp->gr_gid;
+		} else {
+			gid = strtol(group, &end, 10);
+			if (*end || end == group)
+				die("invalid group name '%s'", group);
+		}
+	}
+	if (!uid || !gid)
+		die("I refuse to run as root");
+	if (setresgid(gid, gid, gid) || setresuid(uid, uid, uid))
+		die("I can't run as %d:%d", uid, gid);
+}
+
 int main(int argc, char **argv)
 {
 	int port = DEFAULT_GIT_PORT;
 	int inetd_mode = 0;
+	const char *user = NULL, *group = NULL;
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -350,9 +398,32 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+		if (!strncmp(arg, "--chroot=", 9)) {
+			if (chroot(arg+9) < 0)
+				die("unable to chroot to '%s': %s", arg+9, strerror(errno));
+			if (chdir("/") < 0)
+				die("unable to chdir to new root");
+
+			user = user ? user : "nobody";
+			group = group ? group : "nobody";
+			continue;
+		}
+
+		if (!strncmp(arg, "--user=", 7)) {
+			user = arg+7;
+			continue;
+		}
+
+		if (!strncmp(arg, "--group=", 8)) {
+			group = arg + 8;
+			continue;
+		}
+
 		usage(daemon_usage);
 	}
 
+	set_user_group(user, group);
+
 	if (inetd_mode) {
 		fclose(stderr); //FIXME: workaround
 		return execute();
