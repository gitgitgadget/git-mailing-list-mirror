From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-files: honour per-directory ignore file from higher directories.
Date: Thu, 09 Feb 2006 00:16:53 -0800
Message-ID: <7vmzh1eykq.fsf_-_@assigned-by-dhcp.cox.net>
References: <1138125570.24415.11.camel@dv>
	<20060125061140.GA8408@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 09:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F76zD-0002mz-UW
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 09:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422844AbWBIIQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 03:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWBIIQz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 03:16:55 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41355 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422844AbWBIIQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 03:16:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209081551.BHCB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 03:15:51 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060125061140.GA8408@mars.ravnborg.org> (Sam Ravnborg's message
	of "Wed, 25 Jan 2006 07:11:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15793>

When git-ls-files -o --exclude-per-directory=.gitignore is run
from a subdirectory, it did not read from .gitignore from its
parent directory.  Reading from them makes output from these two
commands consistent:

    $ git ls-files -o --exclude-per-directory=.gitignore Documentation
    $ cd Documentation &&
      git ls-files -o --exclude-per-directory=.gitignore

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * If there are positive feedbacks on this one, I consider it
   a safe enough candidate to be included in 1.2.0 release.

 ls-files.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

701ca744e386c2429ca44072ea987bbb4bdac7ce
diff --git a/ls-files.c b/ls-files.c
index 6af3b09..7024cf1 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -474,8 +474,28 @@ static void show_files(void)
 		const char *path = ".", *base = "";
 		int baselen = prefix_len;
 
-		if (baselen)
+		if (baselen) {
 			path = base = prefix;
+			if (exclude_per_dir) {
+				char *p, *pp = xmalloc(baselen+1);
+				memcpy(pp, prefix, baselen+1);
+				p = pp;
+				while (1) {
+					char save = *p;
+					*p = 0;
+					push_exclude_per_directory(pp, p-pp);
+					*p++ = save;
+					if (!save)
+						break;
+					p = strchr(p, '/');
+					if (p)
+						p++;
+					else
+						p = pp + baselen;
+				}
+				free(pp);
+			}
+		}
 		read_directory(path, base, baselen);
 		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
 		if (show_others)
-- 
1.1.6.gbb042
