From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-push: resurrect parsing of Push: lines
Date: Sun, 30 Apr 2006 15:59:05 -0700
Message-ID: <7vvesqwtza.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604301405150.2026@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viroqyb69.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 00:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaKsq-0007sY-Ga
	for gcvg-git@gmane.org; Mon, 01 May 2006 00:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWD3W7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWD3W7I
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 18:59:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58504 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751231AbWD3W7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 18:59:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430225906.HTUB25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 18:59:06 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7viroqyb69.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 30 Apr 2006 15:02:22 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19362>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> The C'ification of push left these behind.
>
>> +#define MAX_REFSPECS 10
>> +static int current_refspec = 0;
>> +static char *refspecs_[MAX_REFSPECS];
>
> While this fix makes perfect sense, I think MAX_URI set to 16 is
> reasonable hard limit, but I am not happy about giving hard
> limit to MAX_REFSPECS -- that's a regression from the shell
> script one.

So how about this as a replacement?

 - You are going to discard refspecs_[] if there were any
   command line stuff anyway, so do not even bother storing them
   in a separate array.  Just do add_refspec() on them if you
   are going to use it after you are done.

 - The function get_uri() is not about URI anymore, so rename it
   appropriately.

 - Fix the double call to get_uri() Sean noticed.

-- >8 --
diff --git a/builtin-push.c b/builtin-push.c
index 4e659f0..9a861b5 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -68,14 +68,11 @@ static void set_refspecs(const char **re
 	expand_refspecs();
 }
 
-#define MAX_REFSPECS 10
-static int current_refspec = 0;
-static char *refspecs_[MAX_REFSPECS];
-
 static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 {
 	int n = 0;
 	FILE *f = fopen(git_path("remotes/%s", repo), "r");
+	int has_explicit_refspec = refspec_nr;
 
 	if (!f)
 		return -1;
@@ -103,10 +100,14 @@ static int get_remotes_uri(const char *r
 		while (isspace(p[-1]))
 			*--p = 0;
 
-		if (!is_refspec && n < MAX_URI)
-			uri[n++] = strdup(s);
-		else if (is_refspec && current_refspec < MAX_REFSPECS)
-			refspecs_[current_refspec++] = strdup(s);
+		if (!is_refspec) {
+			if (n < MAX_URI)
+				uri[n++] = strdup(s);
+			else
+				error("more than %d URL's specified, ignoreing the rest", MAX_URI);
+		}
+		else if (is_refspec && !has_explicit_refspec)
+			add_refspec(strdup(s));
 	}
 	fclose(f);
 	if (!n)
@@ -146,13 +147,17 @@ static int get_branches_uri(const char *
 	return 1;
 }
 
-static int get_uri(const char *repo, const char *uri[MAX_URI])
+/*
+ * Read remotes and branches file, fill the push target URI
+ * list.  If there is no command line refspecs, read Push: lines
+ * to set up the *refspec list as well.
+ * return the number of push target URIs
+ */
+static int read_config(const char *repo, const char *uri[MAX_URI])
 {
 	int n;
 
 	if (*repo != '/') {
-		current_refspec = 0;
-
 		n = get_remotes_uri(repo, uri);
 		if (n > 0)
 			return n;
@@ -169,18 +174,15 @@ static int get_uri(const char *repo, con
 static int do_push(const char *repo)
 {
 	const char *uri[MAX_URI];
-	int i, n = get_uri(repo, uri);
+	int i, n;
 	int remote;
 	const char **argv;
 	int argc;
 
-	n = get_uri(repo, uri);
+	n = read_config(repo, uri);
 	if (n <= 0)
 		die("bad repository '%s'", repo);
 
-	if (refspec_nr == 0)
-		set_refspecs((const char**)refspecs_, current_refspec);
-
 	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
 	argv[0] = "dummy-send-pack";
 	argc = 1;
