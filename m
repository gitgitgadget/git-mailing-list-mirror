From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 09:54:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
 <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz>
 <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz>
 <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org> <20050920150719.GB1836@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 18:55:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHlOx-0002vG-Hy
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbVITQzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVITQzZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:55:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932676AbVITQzY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 12:55:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8KGt3Bo001257
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 09:55:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8KGswKk026056;
	Tue, 20 Sep 2005 09:54:59 -0700
To: Petr Baudis <pasky@suse.cz>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <20050920150719.GB1836@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9008>



On Tue, 20 Sep 2005, Petr Baudis wrote:
> 
> I'll just drop the date revision specifier support from Cogito. I don't
> know if any measurable number of people actually use it in the real
> world anyway.

I think the date specifier makes sense for cg-log, though. 

Ie it doesn't make sense as a generic cg-*-id thing, but it _does_ make 
sense as a totally log-specific case.

Maybe it could use "-d" instead of "-r", since it's really a totally 
separate control. For example, there's nothing wrong with

	cg-log -d yesterday v2.6.12..

which would limit the revisions _both_ to a date _and_ to a version.

So it's just "diff against time" that makes no sense. But both "git log" 
and "git whatchanged" are sensible in time: there's no problem with saying 
"what commits happened in the last 24 hours", but there _is_ a problem 
with saying "show me the difference from 24 hours ago".

See? The "list of commits" is sensible, it's just the "one revision" thing 
that isn't.

Here's a stupid example of how to do this in git. 

With this silly patch, this like

	git whatchanged --since="1 month ago"
	git log --since="5 days ago"
	gitk --since=yesterday

all work. I don't know how _useful_ it is, but it's kind of cool.

(Side note: the "gitk" thing works really badly. gitk doesn't quote its 
arguments to "git-rev-list", so something like

	gitk --since="1 month ago"

does NOT work, while "--since=yesterday" does, because it has no spaces. 
Gaah. "Obi-Paul Mackerras, you're our only hope")

		Linus

---
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "quote.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -125,6 +126,27 @@ static int show_reference(const char *re
 	return 0;
 }
 
+static void show_datestring(const char *datestr)
+{
+	FILE *date;
+	static char buffer[100] = "--max-age=";
+	static char cmd[1000];
+	int len;
+
+	/* date handling requires both flags and revs */
+	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
+		return;
+	snprintf(cmd, sizeof(cmd), "date --date=%s +%%s", sq_quote(datestr));
+	date = popen(cmd, "r");
+	if (!date || !fgets(buffer + 10, sizeof(buffer) - 10, date))
+		die("git-rev-list: bad date string");
+	pclose(date);
+	len = strlen(buffer);
+	if (buffer[len-1] == '\n')
+		buffer[--len] = 0;
+	show(buffer);
+}
+
 int main(int argc, char **argv)
 {
 	int i, as_is = 0, verify = 0;
@@ -207,6 +229,10 @@ int main(int argc, char **argv)
 				printf("%s/.git\n", cwd);
 				continue;
 			}
+			if (!strncmp(arg, "--since=", 8)) {
+				show_datestring(arg+8);
+				continue;
+			}
 			if (verify)
 				die("Needed a single revision");
 			show_flag(arg);
