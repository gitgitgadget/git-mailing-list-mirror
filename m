From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 15:58:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510171546580.3369@g5.osdl.org>
References: <200510162114.27429.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 00:58:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERdwL-0007YR-Q6
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVJQW6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 18:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJQW6m
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 18:58:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932365AbVJQW6l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 18:58:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9HMwdFC023341
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 15:58:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9HMwdbh015922;
	Mon, 17 Oct 2005 15:58:39 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200510162114.27429.blaisorblade@yahoo.it>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10196>



On Sun, 16 Oct 2005, Blaisorblade wrote:
>
> I already knew that git-checkout-cache -a -f is wrong. But I didn't know that 
> 
> git-checkout-index -a --prefix=/home/paolo/Uml/space.mnt/paolo/Linux-2.6.git/
> 
> is. It checks out the files in the cwd, then parses --prefix and does nothing 
> there, as no name is specified.

Yeah, somebody should really fix the command line parsing. 

I think it's only git-checkout-index that _really_ needs fixing, since it 
has such a fragile thing right now.

Here's a totally untested patch. Do you want to test it?

It also makes it illegal to mix "-a" and explicit filenames, since the 
semantics of that has now changed (before, the order of the filename and 
the "-a" mattered. Now it no longer does. Better disallow it, than let 
people maybe think they get something else that they do).

Danger, Will Robinson! Untested!

		Linus

---
diff --git a/checkout-index.c b/checkout-index.c
index 9784532..dab3778 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -87,8 +87,9 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, force_filename = 0;
+	int i;
 	int newfd = -1;
+	int all = 0;
 
 	if (read_cache() < 0) {
 		die("invalid cache");
@@ -96,58 +97,70 @@ int main(int argc, char **argv)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!force_filename) {
-			if (!strcmp(arg, "-a")) {
-				checkout_all();
-				continue;
-			}
-			if (!strcmp(arg, "--")) {
-				force_filename = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-f")) {
-				state.force = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-q")) {
-				state.quiet = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-n")) {
-				state.not_new = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-u")) {
-				state.refresh_cache = 1;
-				if (newfd < 0)
-					newfd = hold_index_file_for_update
-						(&cache_file,
-						 get_index_file());
-				if (newfd < 0)
-					die("cannot open index.lock file.");
-				continue;
-			}
-			if (!memcmp(arg, "--prefix=", 9)) {
-				state.base_dir = arg+9;
-				state.base_dir_len = strlen(state.base_dir);
-				continue;
-			}
-			if (arg[0] == '-')
-				usage(checkout_cache_usage);
-		}
-		if (state.base_dir_len) {
-			/* when --prefix is specified we do not
-			 * want to update cache.
-			 */
-			if (state.refresh_cache) {
-				close(newfd); newfd = -1;
-				rollback_index_file(&cache_file);
-			}
-			state.refresh_cache = 0;
+
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
+			all = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-f") || !strcmp(arg, "--force")) {
+			state.force = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
+			state.quiet = 1;
+			continue;
 		}
+		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-create")) {
+			state.not_new = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-u") || !strcmp(arg, "--index")) {
+			state.refresh_cache = 1;
+			if (newfd < 0)
+				newfd = hold_index_file_for_update
+					(&cache_file,
+					 get_index_file());
+			if (newfd < 0)
+				die("cannot open index.lock file.");
+			continue;
+		}
+		if (!memcmp(arg, "--prefix=", 9)) {
+			state.base_dir = arg+9;
+			state.base_dir_len = strlen(state.base_dir);
+			continue;
+		}
+		if (arg[0] == '-')
+			usage(checkout_cache_usage);
+		break;
+	}
+
+	if (state.base_dir_len) {
+		/* when --prefix is specified we do not
+		 * want to update cache.
+		 */
+		if (state.refresh_cache) {
+			close(newfd); newfd = -1;
+			rollback_index_file(&cache_file);
+		}
+		state.refresh_cache = 0;
+	}
+
+	/* Check out named files first */
+	for ( ; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (all)
+			die("git-checkout-index: don't mix '--all' and explicit filenames");
 		checkout_file(arg);
 	}
 
+	if (all)
+		checkout_all();
+
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
 	     commit_index_file(&cache_file)))
