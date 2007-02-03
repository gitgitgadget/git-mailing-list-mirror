From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing to a non-bare repository
Date: Sat, 03 Feb 2007 11:42:11 -0800
Message-ID: <7vabzv58q4.fsf@assigned-by-dhcp.cox.net>
References: <45C3FB08.1020805@midwinter.com>
	<7vfy9ndiqp.fsf@assigned-by-dhcp.cox.net>
	<45C459DD.8080201@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Feb 03 20:42:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDQm7-0003aQ-4i
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 20:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXBCTmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 14:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXBCTmN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 14:42:13 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:51167 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751363AbXBCTmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 14:42:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203194212.YRV1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 14:42:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id K7iB1W00i1kojtg0000000; Sat, 03 Feb 2007 14:42:11 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38589>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> I don't say "Push needs to behave like a fast forward pull",
> because that's wrong.  You can't just change the workdir,
> possibly due to permissions problems.  But push has to abort
> if you try to forward HEAD on the remote, except if it is
> bare, of course.

You can tweak receive-pack.c::update() to do that, perhaps along
the lines of this.

---
diff --git a/receive-pack.c b/receive-pack.c
index 7311c82..ccd48e4 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -9,6 +9,7 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
+static char *current_branch;
 static int deny_non_fast_forwards = 0;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
@@ -115,6 +116,18 @@ static int update(struct command *cmd)
 			     name);
 	}
 
+	if (!is_bare_repository()) {
+		/*
+		 * Pusing into a live repository.  updating .git/HEAD
+		 * or the current branch is a no-no...
+		 */
+		if (strncmp(name, "refs/", 5) ||
+		    (current_branch && !strcmp(name, current_branch))) {
+			cmd->error_string = "update current";
+			return error("refusing to update the current branch '%s' in a live repository", name);
+		}
+	}
+
 	strcpy(new_hex, sha1_to_hex(new_sha1));
 	strcpy(old_hex, sha1_to_hex(old_sha1));
 
@@ -436,6 +449,13 @@ int main(int argc, char **argv)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	if (!is_bare_repository()) {
+		unsigned char h[20];
+		const char *head = resolve_ref("HEAD", h, 0, NULL);
+		if (head && strcmp("HEAD", head))
+			current_branch = xstrdup(head);
+	}
+
 	write_head_info();
 
 	/* EOF */
