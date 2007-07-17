From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 01:28:59 -0700
Message-ID: <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:29:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAiQf-0001hF-Of
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 10:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbXGQI3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 04:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbXGQI3F
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 04:29:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51124 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbXGQI3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 04:29:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717082902.ZJJJ1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 04:29:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QYV01X0051kojtg0000000; Tue, 17 Jul 2007 04:29:00 -0400
In-Reply-To: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
	(Thomas Glanzmann's message of "Mon, 16 Jul 2007 19:12:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52749>

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

> Calling unlink on a directory on a Solaris UFS filesystem as root makes it
> inconsistent. Thanks to Johannes Sixt for the obvious fix.
> ---
>  entry.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 82bf725..1f2e34d 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -14,10 +14,10 @@ static void create_directories(const char *path, const struct checkout *state)
>  		if (mkdir(buf, 0777)) {
>  			if (errno == EEXIST) {
>  				struct stat st;
> -				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
> -					continue;
>  				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
>  					continue; /* ok */
> +				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
> +					continue;
>  			}
>  			die("cannot create directory at %s", buf);
>  		}
> -- 
> 1.5.2.1

This is wrong.  If the filesystem has a symlink and we would
want a directory there, we should unlink().  So at least the
stat there needs to be lstat().

I wonder if anybody involved in the discussion has actually
tested this patch (or the other one, that has the same problem)?

Does the following replacement work for you?  It adds far more
lines than your version, but they are mostly comments to make it
clear why we do things this way.

---
 entry.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index f9e7dc5..42fda36 100644
--- a/entry.c
+++ b/entry.c
@@ -8,17 +8,40 @@ static void create_directories(const char *path, const struct checkout *state)
 	const char *slash = path;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
+		struct stat st;
+		int stat_status;
+
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
+
+		if (len <= state->base_dir_len)
+			/*
+			 * checkout-index --prefix=<dir>; <dir> is
+			 * allowed to be a symlink to an existing
+			 * directory.
+			 */
+			stat_status = stat(buf, &st);
+		else
+			/*
+			 * if there currently is a symlink, we would
+			 * want to replace it with a real directory.
+			 */
+			stat_status = lstat(buf, &st);
+
+		if (!stat_status && S_ISDIR(st.st_mode))
+			continue; /* ok, it is already a directory. */
+		
+		/*
+		 * We know stat_status == 0 means something exists
+		 * there and this mkdir would fail, but that is an
+		 * error codepath; we do not care, as we unlink and
+		 * mkdir again in such a case.
+		 */
 		if (mkdir(buf, 0777)) {
-			if (errno == EEXIST) {
-				struct stat st;
-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
-					continue;
-			}
+			if (errno == EEXIST && state->force &&
+			    !unlink(buf) && !mkdir(buf, 0777))
+				continue;
 			die("cannot create directory at %s", buf);
 		}
 	}
