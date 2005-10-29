From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with cg-clone
Date: Sat, 29 Oct 2005 12:59:31 -0700
Message-ID: <7vwtjwytzw.fsf@assigned-by-dhcp.cox.net>
References: <1130605726.5396.39.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 22:01:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVwrq-0006au-8T
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVJ2T7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVJ2T7e
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 15:59:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9943 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932133AbVJ2T7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 15:59:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051029195917.IJEX16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 15:59:17 -0400
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1130605726.5396.39.camel@blade> (Marcel Holtmann's message of
	"Sat, 29 Oct 2005 19:08:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10805>

Marcel Holtmann <marcel@holtmann.org> writes:

> I installed the latest git and cogito from their repositories and now
> the local clone command is failing:
>
> # cg-clone linux-2.6 test-2.6
> defaulting to local storage area
> Using hard links
> `/data/kernel/linux-2.6/.git/HEAD' -> `.git/refs/heads/.origin-fetching'
> error: Couldn't find 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404: not separate or in any pack
> Cannot obtain needed object 8a212ab6b8a4ccc6f3c3d1beba5f92655c576404
> while processing commit 0000000000000000000000000000000000000000.
> cg-fetch: objects fetch failed
> cg-clone: fetch failed

The attached patch should fix git-local-fetch which I think the
above problem is.  git-clone -l -s would be much faster if you
are doing a local clone, however.

---

diff --git a/local-fetch.c b/local-fetch.c
index 87a93de..0a07114 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -52,9 +52,10 @@ static int setup_indices(void)
 	return 0;
 }
 
-static int copy_file(const char *source, const char *dest, const char *hex,
+static int copy_file(const char *source, char *dest, const char *hex,
 		     int warn_if_not_exists)
 {
+	safe_create_leading_directories(dest);
 	if (use_link) {
 		if (!link(source, dest)) {
 			pull_say("link %s\n", hex);
@@ -150,7 +151,7 @@ static int fetch_file(const unsigned cha
 	static int object_name_start = -1;
 	static char filename[PATH_MAX];
 	char *hex = sha1_to_hex(sha1);
-	const char *dest_filename = sha1_file_name(sha1);
+	char *dest_filename = sha1_file_name(sha1);
 
  	if (object_name_start < 0) {
 		strcpy(filename, path); /* e.g. git.git */
