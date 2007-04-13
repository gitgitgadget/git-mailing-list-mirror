From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach "git-read-tree -u" to check out submodules as a directory
Date: Thu, 12 Apr 2007 21:32:48 -0700
Message-ID: <7v7isghp1r.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704122102320.4061@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcDSw-0007i1-Em
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXDMEcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXDMEcu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:32:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48802 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXDMEcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:32:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413043250.SBVK1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 00:32:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mUYo1W00d1kojtg0000000; Fri, 13 Apr 2007 00:32:49 -0400
In-Reply-To: <Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 21:08:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44385>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> @@ -136,8 +147,13 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
>  						 "symlink %s (%s)", path, strerror(errno));
>  		}
>  		break;
> +	case S_IFDIRLNK:
> +		if (to_tempfile)
> +			return error("git-checkout-index: cannot create temporary subproject %s", path);
> +		if (mkdir(path, 0777) < 0)
> +			return error("git-checkout-index: cannot create subproject directory %s", path);
> +		break;
>  	default:
>  		return error("git-checkout-index: unknown file mode for %s", path);
>  	}
>  

Hmm.  Perhaps something like this on top?

diff --git a/entry.c b/entry.c
index 9545e89..0874d61 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,23 @@
 #include "cache.h"
 #include "blob.h"
 
+static int make_directory(const char *path, int unlink_as_needed)
+{
+	if (mkdir(path, 0777) < 0) {
+		if (errno == EEXIST) {
+			struct stat st;
+			if (unlink_as_needed &&
+			    !unlink(path) &&
+			    !mkdir(path, 0777))
+				return 0; /* ok */
+			if (!stat(path, &st) && S_ISDIR(st.st_mode))
+				return 0; /* ok */
+		}
+		return -1;
+	}
+	return 0;
+}
+
 static void create_directories(const char *path, struct checkout *state)
 {
 	int len = strlen(path);
@@ -8,19 +25,14 @@ static void create_directories(const char *path, struct checkout *state)
 	const char *slash = path;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
+		int unlink_as_needed;
+
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		if (mkdir(buf, 0777)) {
-			if (errno == EEXIST) {
-				struct stat st;
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
-					continue;
-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
-					continue; /* ok */
-			}
+		unlink_as_needed = (state->base_dir_len < len && state->force);
+		if (make_directory(buf, unlink_as_needed) < 0)
 			die("cannot create directory at %s", buf);
-		}
 	}
 	free(buf);
 }
@@ -150,7 +162,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 	case S_IFDIRLNK:
 		if (to_tempfile)
 			return error("git-checkout-index: cannot create temporary subproject %s", path);
-		if (mkdir(path, 0777) < 0)
+		if (make_directory(path, 0))
 			return error("git-checkout-index: cannot create subproject directory %s", path);
 		break;
 	default:
