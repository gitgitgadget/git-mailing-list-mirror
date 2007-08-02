From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle the errors from chdir in set_work_tree
Date: Thu, 02 Aug 2007 14:58:41 -0700
Message-ID: <7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGigx-0007FN-IY
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXHBV6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbXHBV6n
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:58:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61381 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbXHBV6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:58:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802215841.GOAP26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:58:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9yh1X00T1kojtg0000000; Thu, 02 Aug 2007 17:58:42 -0400
In-Reply-To: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com>
	(Alex Riesen's message of "Thu, 2 Aug 2007 17:27:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54621>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> These I haven't seen yet. Wouldn't like such a surprise though.
> ...
> @@ -220,8 +220,10 @@ const char *set_work_tree(const char *dir)
>  		if (!is_absolute_path(dir))
>  			set_git_dir(make_absolute_path(dir));
>  		dir = dir_buffer;
> -		chdir(dir);
> -		strcat(rel, "/");
> +		if (chdir(dir))
> +			rel = NULL;
> +		else
> +			strcat(rel, "/");
>  		inside_git_dir = 0;
>  	} else {
>  		rel = NULL;

Shouldn't it die() instead, though?

Consolidating two of your patches, would this be Ok?

-- >8 --
Fix work-tree related breakages

In set_work_tree(), variable rel needs to be reinitialized to
NULL on every call (it should not be static).

Make sure the incoming dir variable is not too long before
copying to the temporary buffer, and make sure chdir to the
resulting directory succeeds.

---

 setup.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 3653092..4945eb3 100644
--- a/setup.c
+++ b/setup.c
@@ -201,26 +201,32 @@ int is_inside_work_tree(void)
  */
 const char *set_work_tree(const char *dir)
 {
-	char dir_buffer[PATH_MAX];
-	static char buffer[PATH_MAX + 1], *rel = NULL;
-	int len, postfix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
+	char dir_buffer[PATH_MAX], *rel = NULL;
+	static char buffer[PATH_MAX + 1];
+	int len, suffix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
 
 	/* strip the variable 'dir' of the postfix "/.git" if it has it */
 	len = strlen(dir);
-	if (len > postfix_len && !strcmp(dir + len - postfix_len,
-				"/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
-			strncpy(dir_buffer, dir, len - postfix_len);
+	if (len > suffix_len &&
+	    !strcmp(dir + len - suffix_len, "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
+		if ((len - suffix_len) >= sizeof(dir_buffer))
+			die("directory name too long");
+		memcpy(dir_buffer, dir, len - suffix_len);
+		dir_buffer[len - suffix_len] = '\0';
 
 		/* are we inside the default work tree? */
 		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
 	}
+
 	/* if rel is set, the cwd is _not_ the current working tree */
 	if (rel && *rel) {
 		if (!is_absolute_path(dir))
 			set_git_dir(make_absolute_path(dir));
 		dir = dir_buffer;
-		chdir(dir);
-		strcat(rel, "/");
+		if (chdir(dir))
+			die("cannot chdir to %s: %s", dir, strerror(errno));
+		else
+			strcat(rel, "/");
 		inside_git_dir = 0;
 	} else {
 		rel = NULL;
