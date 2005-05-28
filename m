From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Adjust diff-helper to diff-tree -v -z changes.
Date: Fri, 27 May 2005 21:05:38 -0700
Message-ID: <7vvf54xael.fsf_-_@assigned-by-dhcp.cox.net>
References: <42971EB4.2050403@oberhumer.com>
	<Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org>
	<7vfyw8zg1w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 06:03:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbsY3-0000CE-Ce
	for gcvg-git@gmane.org; Sat, 28 May 2005 06:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVE1EFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 00:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVE1EFs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 00:05:48 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25041 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261765AbVE1EFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 00:05:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528040537.SSHZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 00:05:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyw8zg1w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 11:20:43 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The latest change to diff-tree -z output adds an extra line
termination after non diff-raw material (the header and the
commit message).  To compensate for this change, stop adding the
output termination of our own.  "diff-tree -v -z" piped to
"diff-helper -z" would give different result from "diff-tree -v"
piped to "diff-helper" without this change.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-helper.c |    5 ++++-
1 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -15,6 +15,7 @@ static const char *diff_helper_usage =
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
+	const char *garbage_flush_format;
 
 	strbuf_init(&sb);
 
@@ -30,6 +31,8 @@ int main(int ac, const char **av) {
 			usage(diff_helper_usage);
 		ac--; av++;
 	}
+	garbage_flush_format = (line_termination == 0) ? "%s" : "%s\n";
+
 	/* the remaining parameters are paths patterns */
 
 	diff_setup(0);
@@ -134,7 +137,7 @@ int main(int ac, const char **av) {
 		if (pickaxe)
 			diffcore_pickaxe(pickaxe, pickaxe_opts);
 		diff_flush(DIFF_FORMAT_PATCH, 0);
-		printf("%s\n", sb.buf);
+		printf(garbage_flush_format, sb.buf);
 	}
 	if (1 < ac)
 		diffcore_pathspec(av + 1);
------------------------------------------------

