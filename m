From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-{list,parse}: optionally allow -<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 05:47:20 -0800
Message-ID: <20060129134720.GB3428@Muzzle>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net> <20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 14:47:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Cts-0005gI-Mj
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 14:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWA2NrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 08:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWA2NrW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 08:47:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:15315 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750975AbWA2NrW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 08:47:22 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 53AB12DC033;
	Sun, 29 Jan 2006 05:47:20 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 05:47:20 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060129134056.GA3428@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15218>

I also made this for my own private use, it's on top of the previous
one I made that is POSIX-friendly.  I don't if you or anyone wants
it merged mainline, but I like it :)

This will only be enabled if POSIX_SHMOSIX is defined at compile-time.

Some versions of head(1) and tail(1) allow their line limits to be
parsed this way.  I find --max-count to be a commonly used option,
and also similar in spirit to head/tail, so I decided to make life
easier on my worn out (and lazy :) fingers with this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Makefile          |    3 +++
 git-compat-util.h |    3 +++
 rev-list.c        |    7 ++++++-
 rev-parse.c       |    4 ++++
 4 files changed, 16 insertions(+), 1 deletions(-)

3b650b00deb7e51e5c9a8bdc4cc1eaaf4fc65029
diff --git a/Makefile b/Makefile
index 2e95353..9ef97ca 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,9 @@ endif
 ifdef NO_IPV6
 	ALL_CFLAGS += -DNO_IPV6
 endif
+ifdef POSIX_SHMOSIX
+	ALL_CFLAGS += -DPOSIX_SHMOSIX=1
+endif
 ifdef NO_SOCKADDR_STORAGE
 ifdef NO_IPV6
 	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in
diff --git a/git-compat-util.h b/git-compat-util.h
index f982b8e..46d331d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -154,4 +154,7 @@ static inline int sane_case(int x, int h
 #ifndef MAXPATHLEN
 #define MAXPATHLEN 256
 #endif
+#ifndef POSIX_SHMOSIX 
+#define POSIX_SHMOSIX 0
+#endif
 #endif
diff --git a/rev-list.c b/rev-list.c
index 33541cc..c85de51 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -731,7 +731,12 @@ int main(int argc, const char **argv)
 		char *dotdot;
 		struct commit *commit;
 		unsigned char sha1[20];
-
+		
+		/* accept, -<digit>, like some versions of head/tail  */
+		if (POSIX_SHMOSIX && (*arg == '-') && isdigit(arg[1])) {
+			max_count = atoi(arg + 1);
+			continue;
+		}
 		if (!strcmp(arg, "-n")) {
 			if (++i >= argc)
 				die("-n requires an argument");
diff --git a/rev-parse.c b/rev-parse.c
index 3790463..d9b3fa9 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -53,6 +53,10 @@ static int is_rev_argument(const char *a
 	};
 	const char **p = rev_args;
 
+	/* accept, -<digit>, like some versions of head/tail  */
+	if (POSIX_SHMOSIX && (*arg == '-') && isdigit(arg[1]))
+		return 1;
+
 	for (;;) {
 		const char *str = *p++;
 		int len;
-- 
1.1.4.g3b65
