From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rev-{list,parse}: allow -<n> as shorthand for --max-count=<n>
Date: Sun, 29 Jan 2006 16:28:02 -0800
Message-ID: <20060130002802.GD15482@Muzzle>
References: <20060124072946.GA9468@Muzzle> <7vd5iicauh.fsf@assigned-by-dhcp.cox.net> <20060125063325.GA7953@mail.yhbt.net> <20060129134056.GA3428@Muzzle> <20060129134720.GB3428@Muzzle> <7v64o2kcym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 01:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3Mts-0005vv-3p
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 01:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWA3A2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 19:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWA3A2F
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 19:28:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36052 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751210AbWA3A2E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 19:28:04 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id D25FF2DC035;
	Sun, 29 Jan 2006 16:28:02 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sun, 29 Jan 2006 16:28:02 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64o2kcym.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15254>

This will be enabled unless POSIXLY_CORRECT or POSIX_ME_HARDER is set
in the environment.

Some versions of head(1) and tail(1) allow their line limits to be
parsed this way.  I find --max-count to be a commonly used option,
and also similar in spirit to head/tail, so I decided to make life
easier on my worn out (and lazy :) fingers with this patch.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-compat-util.h |    8 ++++++++
 rev-list.c        |    5 +++++
 rev-parse.c       |    4 ++++
 3 files changed, 17 insertions(+), 0 deletions(-)

7a8d6dda7dacadc90377fc56d28d5d03493199c4
diff --git a/git-compat-util.h b/git-compat-util.h
index f982b8e..b2512ba 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -154,4 +154,12 @@ static inline int sane_case(int x, int h
 #ifndef MAXPATHLEN
 #define MAXPATHLEN 256
 #endif
+
+static inline int posixly_correct(void)
+{
+	if (getenv("POSIXLY_CORRECT") || getenv("POSIX_ME_HARDER"))
+		return 1;
+	return 0;
+}
+
 #endif
diff --git a/rev-list.c b/rev-list.c
index 4565755..f29d32a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -749,6 +749,11 @@ int main(int argc, const char **argv)
 		struct commit *commit;
 		unsigned char sha1[20];
 
+		/* accept, -<digit>, like some versions of head/tail  */
+		if (!posixly_correct() && (*arg == '-') && isdigit(arg[1])) {
+			max_count = atoi(arg + 1);
+			continue;
+		}
 		if (!strcmp(arg, "-n")) {
 			if (++i >= argc)
 				die("-n requires an argument");
diff --git a/rev-parse.c b/rev-parse.c
index 3c99a79..2966a33 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -53,6 +53,10 @@ static int is_rev_argument(const char *a
 	};
 	const char **p = rev_args;
 
+	/* accept, -<digit>, like some versions of head/tail  */
+	if (!posixly_correct() && (*arg == '-') && isdigit(arg[1]))
+		return 1;
+
 	for (;;) {
 		const char *str = *p++;
 		int len;
-- 
1.1.5.ga7f5-dirty
