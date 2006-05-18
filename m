From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 09:25:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605180917060.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
 <7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
 <7v64k3698l.fsf@assigned-by-dhcp.cox.net> <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605180807060.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 18:26:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FglJl-0000zm-NE
	for gcvg-git@gmane.org; Thu, 18 May 2006 18:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWERQZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 12:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWERQZi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 12:25:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbWERQZi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 12:25:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IGPWtH019355
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 09:25:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IGPVJg024896;
	Thu, 18 May 2006 09:25:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605180807060.10823@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20290>



On Thu, 18 May 2006, Linus Torvalds wrote:
> 
> But if people are ok with changing it from a "print a warning and ignore" 
> into an _error_, we could just move it into "add_cache_entry()".

This is the incremental patch to do that instead, if you prefer it.

Putting it into add_cache_entry() definitely has advantages, in that it 
should make it much harder for this bug to happen again - all users will 
now be verified.

With this one, it's now a fatal error to try to add a pathname that cannot 
be added, ie

	[torvalds@g5 git]$ git add .git/config 
	fatal: unable to add .git/config to index

and

	[torvalds@g5 git]$ git add foo/../bar 
	fatal: unable to add foo/../bar to index

instead of the old "Ignoring path xyz" warning that would end up silently 
succeeding on any other paths.

		Linus

---
diff --git a/builtin-add.c b/builtin-add.c
index 0346bb5..ac9ed2d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -172,11 +172,6 @@ static int add_file_to_index(const char 
 	if (lstat(path, &st))
 		die("%s: unable to stat (%s)", path, strerror(errno));
 
-	if (!verify_path(path)) {
-		fprintf(stderr, "Ignoring path %s\n", path);
-		return -1;
-	}
-		
 	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode))
 		die("%s: can only add regular files or symbolic links", path);
 
diff --git a/read-cache.c b/read-cache.c
index 6b323dd..9a272f8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -551,6 +551,8 @@ int add_cache_entry(struct cache_entry *
 
 	if (!ok_to_add)
 		return -1;
+	if (!verify_path(ce->name))
+		return -1;
 
 	if (!skip_df_check &&
 	    check_file_directory_conflict(ce, pos, ok_to_replace)) {
