From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem with cg-clone
Date: Sat, 29 Oct 2005 12:57:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510291255230.3348@g5.osdl.org>
References: <1130605726.5396.39.camel@blade> <7vacgs157c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 21:57:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVwpZ-0005tv-NU
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 21:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVJ2T5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 15:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJ2T5b
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 15:57:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750874AbVJ2T5a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Oct 2005 15:57:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9TJvMFC017991
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Oct 2005 12:57:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9TJvKKP028141;
	Sat, 29 Oct 2005 12:57:21 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacgs157c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10804>



On Sat, 29 Oct 2005, Junio C Hamano wrote:
>
> Marcel Holtmann <marcel@holtmann.org> writes:
> 
> > Previously this was working fine and since cogito hasn't changed the
> > last few days, I suspect that git is at fault here or changed something.
> > Any ideas?
> 
> I think I know what is going on.
> 
> git-init-db does not create .git/objects/[0-9a-f]{2}/
> directories anymore, but git-local-fetch has not taught to
> create them on demand.

Here's a quick hack, totally untested, of course.

More properly it should use move_temp_to_file(), but if you're about to do 
a v0.99.9 release, maybe this could be good enough.

		Linus

---

diff --git a/local-fetch.c b/local-fetch.c
index 87a93de..21f5bf8 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -52,9 +52,20 @@ static int setup_indices(void)
 	return 0;
 }
 
-static int copy_file(const char *source, const char *dest, const char *hex,
+static int copy_file(const char *source, char *dest, const char *hex,
 		     int warn_if_not_exists)
 {
+	char *dir = strrchr(dest, '/');
+
+	if (dir) {
+		*dir = 0;
+		if (mkdir(dir, 0777)) {
+			if (errno != EEXIST)
+				perror(dir);
+		}
+		*dir = '/';
+	}
+
 	if (use_link) {
 		if (!link(source, dest)) {
 			pull_say("link %s\n", hex);
@@ -150,7 +161,7 @@ static int fetch_file(const unsigned cha
 	static int object_name_start = -1;
 	static char filename[PATH_MAX];
 	char *hex = sha1_to_hex(sha1);
-	const char *dest_filename = sha1_file_name(sha1);
+	char *dest_filename = sha1_file_name(sha1);
 
  	if (object_name_start < 0) {
 		strcpy(filename, path); /* e.g. git.git */
