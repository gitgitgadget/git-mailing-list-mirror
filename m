From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-bundle create - use lock_file
Date: Sun, 12 Aug 2007 10:44:06 -0700
Message-ID: <7v1we8k5qx.fsf@assigned-by-dhcp.cox.net>
References: <11869231822803-git-send-email-mdl123@verizon.net>
	<11869280491451-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 19:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKHU9-0002A7-6j
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 19:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762637AbXHLRoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764912AbXHLRoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 13:44:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52744 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbXHLRoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 13:44:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812174406.XWHK325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 13:44:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b5k61X00V1kojtg0000000; Sun, 12 Aug 2007 13:44:07 -0400
In-Reply-To: <11869280491451-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Sun, 12 Aug 2007 10:14:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55693>

Mark Levedahl <mdl123@verizon.net> writes:

> git bundle create would leave an invalid, partially written bundle if
> an error occured during creation. Fix that using lock_file.
>
> Signed-off-by: Mark Levedahl <mdl123@verizon.net>
> ---
>  struct lock_file is now static.
>  *caller* closes the lock file before commiting / rolling back.

I think you broke the support to write a bundle out to the
standard output by giving "-" as the path.

Also, the whole point of the "NEEDSWORK" suggestion to use
lockfile was because you do not have to do lwrite_or_die() in
the first place ;-).  When you exit before committing lockfiles
you hold, atexit handler rolls back and unlink them for you.

The following might be a better replacement.

By the way, by using lockfile's "create temporary, generate into
it and then rename to final", we are allowing an overwrite of an
existing bundle, which we did not allow earlier.  Is this check
something we would want to preserve?

---

 builtin-bundle.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index f4b4f03..1b65006 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -189,7 +189,9 @@ static int list_heads(struct bundle_header *header, int argc, const char **argv)
 static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
+	static struct lock_file lock;
 	int bundle_fd = -1;
+	int bundle_to_stdout;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(5 * sizeof(const char *));
 	int i, ref_count = 0;
@@ -198,14 +200,11 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	struct child_process rls;
 	FILE *rls_fout;
 
-	/*
-	 * NEEDSWORK: this should use something like lock-file
-	 * to create temporary that is cleaned up upon error.
-	 */
-	bundle_fd = (!strcmp(path, "-") ? 1 :
-			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
-	if (bundle_fd < 0)
-		return error("Could not create '%s': %s", path, strerror(errno));
+	bundle_to_stdout = !strcmp(path, "-");
+	if (bundle_to_stdout)
+		bundle_fd = 1;
+	else
+		bundle_fd = hold_lock_file_for_update(&lock, path, 1);
 
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
@@ -341,6 +340,9 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	}
 	if (finish_command(&rls))
 		return error ("pack-objects died");
+	close(bundle_fd);
+	if (!bundle_to_stdout)
+		commit_lock_file(&lock);
 	return 0;
 }
 
