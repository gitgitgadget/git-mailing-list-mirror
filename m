From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] log --reflog: use dwim_log
Date: Thu, 08 Feb 2007 23:19:59 -0800
Message-ID: <7v4ppvvluo.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
	<Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<eqfu36$lb3$1@sea.gmane.org>
	<Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vveicw850.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702090127510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vtzxwuhb1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 08:20:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFQ3b-0007OZ-Ks
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946178AbXBIHUD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 02:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946177AbXBIHUD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 02:20:03 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48939 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946167AbXBIHUB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 02:20:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209072000.OVAY1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 02:20:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MKKz1W00K1kojtg0000000; Fri, 09 Feb 2007 02:20:00 -0500
In-Reply-To: <7vtzxwuhb1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Feb 2007 19:43:30 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39156>

When refs/remotes/gfi/master and refs/remotes/gfi/HEAD exist,
and the latter is a symref that points at the former, dwim_ref()
resolves string "gfi" to "refs/remotes/gfi/master" as expected,
but dwim_log() does not understand "gfi@{1.day}" and needs to be
told "gfi/master@{1.day}".  This is confusing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Junio C Hamano <junkio@cox.net> writes:

 > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
 >
 >> Since "git log origin/master" uses dwim_log() to match
 >> "refs/remotes/origin/master", it makes sense to do that for
 >> "git log --reflog", too.
 >
 > This is a bit sad.
 >
 > When there is remotes/origin/HEAD symref that points at
 > remotes/origin/master (and usually there is, in a repository
 > initialized with the current git-clone), you can say "git log
 > origin".  Even with this patch, I do not think dwim_log would
 > allow you to say "git log -g origin" to mean "git log -g
 > origin/master".

 I think there should be a cleaner way to fix this, but at least
 this seems to work.

 sha1_name.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f79a7c9..09c63ed 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -275,16 +275,29 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	*log = NULL;
 	for (p = ref_fmt; *p; p++) {
 		struct stat st;
-		char *path = mkpath(*p, len, str);
+		unsigned char hash[20];
+		char path[PATH_MAX];
+		char *ref, *it;
+
+		strcpy(path, mkpath(*p, len, str));
+		ref = resolve_ref(path, hash, 0, NULL);
+		if (!ref)
+			continue;
 		if (!stat(git_path("logs/%s", path), &st) &&
-		    S_ISREG(st.st_mode)) {
-			if (!logs_found++) {
-				*log = xstrdup(path);
-				resolve_ref(path, sha1, 0, NULL);
-			}
-			if (!warn_ambiguous_refs)
-				break;
+		    S_ISREG(st.st_mode))
+			it = path;
+		else if (strcmp(ref, path) &&
+			 !stat(git_path("logs/%s", ref), &st) &&
+			 S_ISREG(st.st_mode))
+			it = ref;
+		else
+			continue;
+		if (!logs_found++) {
+			*log = xstrdup(it);
+			hashcpy(sha1, hash);
 		}
+		if (!warn_ambiguous_refs)
+			break;
 	}
 	return logs_found;
 }
