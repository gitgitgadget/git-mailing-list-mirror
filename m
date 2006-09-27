From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 03:13:55 -0700
Message-ID: <7vfyedd3bw.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<20060926234309.b16aa44e.seanlkml@sympatico.ca>
	<20060927042850.GB9460@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 12:14:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSWQR-0003Gg-NF
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 12:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509AbWI0KN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 06:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965510AbWI0KN6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 06:13:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49115 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965509AbWI0KN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 06:13:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927101356.VOVT12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 06:13:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TNDs1V00E1kojtg0000000
	Wed, 27 Sep 2006 06:13:53 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27897>

Shawn Pearce <spearce@spearce.org> writes:

> However people are ignoring the fact that receive-pack doesn't
> update the reflog.  As of current `next` its *still* doing the ref
> updates by hand, rather than going through the common library code
> in refs.c.

This is unfortunately on top of many things, but judging from
the number of deleted lines and added lines, I think it is going
in the right direction.

One thing that makes "the common library code" less useful is
that lock_ref_sha1() and its cousin lock_any_ref_for_update() do
not let the caller to tell why a ref could not be locked ("did
it not exist?  did the old_sha1 not match?"  and in
lock_ref_sha1()'s case "did the ref have funny characters?").

-- >8 --
[PATCH] Teach receive-pack about ref-log

This converts receive-pack to use the standard ref locking code
instead of its own.  As a side effect, it automatically records
the "push" event to ref-log if enabled.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 receive-pack.c |   88 ++++++++++----------------------------------------------
 1 files changed, 15 insertions(+), 73 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index abbcb6a..f0b4cb4 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -41,34 +41,6 @@ struct command {
 
 static struct command *commands;
 
-static int is_all_zeroes(const char *hex)
-{
-	int i;
-	for (i = 0; i < 40; i++)
-		if (*hex++ != '0')
-			return 0;
-	return 1;
-}
-
-static int verify_old_ref(const char *name, char *hex_contents)
-{
-	int fd, ret;
-	char buffer[60];
-
-	if (is_all_zeroes(hex_contents))
-		return 0;
-	fd = open(name, O_RDONLY);
-	if (fd < 0)
-		return -1;
-	ret = read(fd, buffer, 40);
-	close(fd);
-	if (ret != 40)
-		return -1;
-	if (memcmp(buffer, hex_contents, 40))
-		return -1;
-	return 0;
-}
-
 static char update_hook[] = "hooks/update";
 
 static int run_update_hook(const char *refname,
@@ -105,8 +77,8 @@ static int update(struct command *cmd)
 	const char *name = cmd->ref_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	char new_hex[60], *old_hex, *lock_name;
-	int newfd, namelen, written;
+	char new_hex[41], old_hex[41];
+	struct ref_lock *lock;
 
 	cmd->error_string = NULL;
 	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5)) {
@@ -115,59 +87,27 @@ static int update(struct command *cmd)
 			     name);
 	}
 
-	namelen = strlen(name);
-	lock_name = xmalloc(namelen + 10);
-	memcpy(lock_name, name, namelen);
-	memcpy(lock_name + namelen, ".lock", 6);
-
 	strcpy(new_hex, sha1_to_hex(new_sha1));
-	old_hex = sha1_to_hex(old_sha1);
+	strcpy(old_hex, sha1_to_hex(old_sha1));
 	if (!has_sha1_file(new_sha1)) {
 		cmd->error_string = "bad pack";
 		return error("unpack should have generated %s, "
 			     "but I can't find it!", new_hex);
 	}
-	safe_create_leading_directories(lock_name);
-
-	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (newfd < 0) {
-		cmd->error_string = "can't lock";
-		return error("unable to create %s (%s)",
-			     lock_name, strerror(errno));
-	}
-
-	/* Write the ref with an ending '\n' */
-	new_hex[40] = '\n';
-	new_hex[41] = 0;
-	written = write(newfd, new_hex, 41);
-	/* Remove the '\n' again */
-	new_hex[40] = 0;
-
-	close(newfd);
-	if (written != 41) {
-		unlink(lock_name);
-		cmd->error_string = "can't write";
-		return error("unable to write %s", lock_name);
-	}
-	if (verify_old_ref(name, old_hex) < 0) {
-		unlink(lock_name);
-		cmd->error_string = "raced";
-		return error("%s changed during push", name);
-	}
 	if (run_update_hook(name, old_hex, new_hex)) {
-		unlink(lock_name);
 		cmd->error_string = "hook declined";
 		return error("hook declined to update %s", name);
 	}
-	else if (rename(lock_name, name) < 0) {
-		unlink(lock_name);
-		cmd->error_string = "can't rename";
-		return error("unable to replace %s", name);
-	}
-	else {
-		fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
-		return 0;
+
+	lock = lock_any_ref_for_update(name, old_sha1);
+	if (!lock) {
+		cmd->error_string = "failed to lock";
+		return error("failed to lock %s", name);
 	}
+	write_ref_sha1(lock, new_sha1, "push");
+
+	fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
+	return 0;
 }
 
 static char update_post_hook[] = "hooks/post-update";
@@ -318,9 +258,11 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
-	if(!enter_repo(dir, 0))
+	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
+	git_config(git_default_config);
+
 	write_head_info();
 
 	/* EOF */
-- 
1.4.2.1.gf80a
