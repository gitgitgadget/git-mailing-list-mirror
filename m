From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Have git-revert, git-cherry-pick use $GIT_DIR/COMMIT_MSG instead of ./.msg.
Date: Mon, 7 May 2007 10:53:37 +0000
Message-ID: <20070507105337.28685.qmail@895eb57f5f8cba.315fe32.mid.smarden.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org> <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 12:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl0qI-0003He-GX
	for gcvg-git@gmane.org; Mon, 07 May 2007 12:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbXEGKxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbXEGKxT
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 06:53:19 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:32879 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932286AbXEGKxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 06:53:18 -0400
Received: (qmail 28686 invoked by uid 1000); 7 May 2007 10:53:37 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46441>

On Fri, May 04, 2007 at 05:28:21PM +0200, Alex Riesen wrote:
> On 5/4/07, Gerrit Pape <pape@smarden.org> wrote:
> >git-revert and git-cherry-pick left behind the commit message file ./.msg,
> >have them use the -f option to git-commit to properly cleanup the
> >automatically created file.
>
> Could we also have the files in $GIT_DIR instead of in working directory?

Yes, .git/COMMIT_MSG is already used by git-commit and git-svn, and can be
used here too.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-revert.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 9acdf47..5aff283 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -126,14 +126,15 @@ char *get_encoding(const char *message)
 	return NULL;
 }
 
-struct lock_file msg_file;
+static const char* msg_file;
+struct lock_file msg_file_lock;
 static int msg_fd;
 
 static void add_to_msg(const char *string)
 {
 	int len = strlen(string);
 	if (write_in_full(msg_fd, string, len) < 0)
-		die ("Could not write to .msg");
+		die ("Could not write to %s", msg_file);
 }
 
 static void add_message_to_msg(const char *message)
@@ -280,7 +281,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 * reverse of it if we are revert.
 	 */
 
-	msg_fd = hold_lock_file_for_update(&msg_file, ".msg", 1);
+	msg_file = git_path("COMMIT_MSG");
+	msg_fd = hold_lock_file_for_update(&msg_file_lock, msg_file, 1);
 
 	encoding = get_encoding(message);
 	if (!encoding)
@@ -344,11 +346,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					i++;
 			}
 		}
-		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
-			die ("Error wrapping up .msg");
+		if (close(msg_fd) || commit_lock_file(&msg_file_lock) < 0)
+			die ("Error wrapping up %s", msg_file);
 		unlink(target);
-		if (rename(".msg", target))
-			die ("Could not move .msg to %s", target);
+		if (rename(msg_file, target))
+			die ("Could not move %s to %s", msg_file, target);
 		fprintf(stderr, "Automatic %s failed.  "
 			"After resolving the conflicts,\n"
 			"mark the corrected paths with 'git-add <paths>'\n"
@@ -361,8 +363,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 		exit(1);
 	}
-	if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
-		die ("Error wrapping up .msg");
+	if (close(msg_fd) || commit_lock_file(&msg_file_lock) < 0)
+		die ("Error wrapping up %s", msg_file);
 	fprintf(stderr, "Finished one %s.\n", me);
 
 	/*
@@ -376,10 +378,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!no_commit) {
 		if (edit)
-			return execl_git_cmd("commit", "-n", "-f", ".msg",
+			return execl_git_cmd("commit", "-n", "-f", msg_file,
 				"-e", NULL);
 		else
-			return execl_git_cmd("commit", "-n", "-f", ".msg",
+			return execl_git_cmd("commit", "-n", "-f", msg_file,
 				NULL);
 	}
 	if (reencoded_message)
-- 
1.5.1.2
