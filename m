From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Release config lock if the regex is invalid
Date: Sun, 07 May 2006 19:38:11 -0700
Message-ID: <7v7j4xi6lo.fsf@assigned-by-dhcp.cox.net>
References: <20060507213612.27887.28600.stgit@dv.roinet.com>
	<Pine.LNX.4.63.0605080229220.32508@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:38:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcvdf-0006C9-9V
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWEHCiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWEHCiN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:38:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51597 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932255AbWEHCiN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 22:38:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508023812.DEUL27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 22:38:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605080229220.32508@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 8 May 2006 02:32:52 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19752>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is not enough. There are quite a few exit paths. Notice the "goto 
> out_free"? That is where this must go.
>
> This patch is totally untested but obviously correct:

except that many places you already close(fd) and
unlink(lock_file).  

Somehow it vaguely reminds me of recent "kernel in C++" thread
in the other mailing list, which I do not want people to start
talking about here, but moving all the clean-up code to exit
path indeed makes things simpler to read.

How about doing something like this?

-- >8 --
diff --git a/config.c b/config.c
index 11d65f8..adb5ce4 100644
--- a/config.c
+++ b/config.c
@@ -420,7 +420,7 @@ int git_config_set_multivar(const char* 
 	const char* value_regex, int multi_replace)
 {
 	int i;
-	int fd, in_fd;
+	int fd = -1, in_fd;
 	int ret;
 	char* config_filename = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
@@ -478,15 +478,11 @@ int git_config_set_multivar(const char* 
 		if ( ENOENT != errno ) {
 			error("opening %s: %s", config_filename,
 			      strerror(errno));
-			close(fd);
-			unlink(lock_file);
 			ret = 3; /* same as "invalid config file" */
 			goto out_free;
 		}
 		/* if nothing to unset, error out */
 		if (value == NULL) {
-			close(fd);
-			unlink(lock_file);
 			ret = 5;
 			goto out_free;
 		}
@@ -514,8 +510,6 @@ int git_config_set_multivar(const char* 
 				fprintf(stderr, "Invalid pattern: %s\n",
 					value_regex);
 				free(store.value_regex);
-				close(fd);
-				unlink(lock_file);
 				ret = 6;
 				goto out_free;
 			}
@@ -551,8 +545,6 @@ int git_config_set_multivar(const char* 
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen == 0 && value == NULL) ||
 				(store.seen > 1 && multi_replace == 0)) {
-			close(fd);
-			unlink(lock_file);
 			ret = 5;
 			goto out_free;
 		}
@@ -601,8 +593,6 @@ int git_config_set_multivar(const char* 
 		unlink(config_filename);
 	}
 
-	close(fd);
-
 	if (rename(lock_file, config_filename) < 0) {
 		fprintf(stderr, "Could not rename the lock file?\n");
 		ret = 4;
@@ -612,10 +602,14 @@ int git_config_set_multivar(const char* 
 	ret = 0;
 
 out_free:
+	if (0 <= fd)
+		close(fd);
 	if (config_filename)
 		free(config_filename);
-	if (lock_file)
+	if (lock_file) {
+		unlink(lock_file);
 		free(lock_file);
+	}
 	return ret;
 }
 
