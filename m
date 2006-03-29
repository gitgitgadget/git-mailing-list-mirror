From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support for pickaxe matching regular expressions
Date: Wed, 29 Mar 2006 02:16:33 +0200
Message-ID: <20060329001633.GF27689@pasky.or.cz>
References: <15693.1143575188@lotus.CS.Berkeley.EDU> <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOMR-0003ln-IK
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWC2AQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWC2AQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:16:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5016 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964868AbWC2AQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 19:16:28 -0500
Received: (qmail 6142 invoked by uid 2001); 29 Mar 2006 02:16:33 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603281500280.15714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18146>

Dear diary, on Wed, Mar 29, 2006 at 01:03:05AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 28 Mar 2006, Mark Wooding wrote:
> > Urgh.  So, which regex library do people want to use? ;-)  (My vote's
> > for pcre.)
> 
> ... No regexps, ...

To toss a random feature idea around, in the recent days I've found
myself thinking about regexp pickaxe several times.

And while already tossing stuff, what about a naive proof-of-concept
patch?  A silly example:

	git-whatchanged --pickaxe-regex -p -S' +$' | less -p '^[-+ ].* +$'

Then keep hitting 'n'. Good that most of the matches are deletions. :)
(Or commit messages.)

---

git-diff-* --pickaxe-regex will change the -S pickaxe to match
POSIX extended regular expressions instead of fixed strings.

The regex.h library is a rather stupid interface and I like pcre too, but
with any luck it will be everywhere we will want to run Git on, it being
POSIX.2 and all. I'm not sure if we can expect platforms like AIX to
conform to POSIX.2 or if win32 has regex.h. We might add a flag to
Makefile if there is a portability trouble potential.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/diff-options.txt |    4 ++
 diff.c                         |    2 +
 diff.h                         |    1 +
 diffcore-pickaxe.c             |   68 ++++++++++++++++++++++++++++++----------
 4 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2a0275e..ec6811c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -69,6 +69,10 @@
 	changeset, not just the files that contain the change
 	in <string>.
 
+--pickaxe-regex::
+	Make the <string> not a plain string but an extended POSIX
+	regex to match.
+
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
diff --git a/diff.c b/diff.c
index 8b37477..e006adb 100644
--- a/diff.c
+++ b/diff.c
@@ -883,6 +883,8 @@ int diff_opt_parse(struct diff_options *
 		options->filter = arg + 14;
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts = DIFF_PICKAXE_ALL;
+	else if (!strcmp(arg, "--pickaxe-regex"))
+		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
 	else if (!strncmp(arg, "-B", 2)) {
 		if ((options->break_opt =
 		     diff_scoreopt_parse(arg)) == -1)
diff --git a/diff.h b/diff.h
index 8fac465..564c94f 100644
--- a/diff.h
+++ b/diff.h
@@ -112,6 +112,7 @@ #define DIFF_DETECT_RENAME	1
 #define DIFF_DETECT_COPY	2
 
 #define DIFF_PICKAXE_ALL	1
+#define DIFF_PICKAXE_REGEX	2
 
 extern void diffcore_std(struct diff_options *);
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 50e46ab..d89f314 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -1,12 +1,15 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+#include <regex.h>
+
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
 
 static unsigned int contains(struct diff_filespec *one,
-			     const char *needle, unsigned long len)
+			     const char *needle, unsigned long len,
+			     regex_t *regexp)
 {
 	unsigned int cnt;
 	unsigned long offset, sz;
@@ -17,15 +20,28 @@ static unsigned int contains(struct diff
 	sz = one->size;
 	data = one->data;
 	cnt = 0;
-
-	/* Yes, I've heard of strstr(), but the thing is *data may
-	 * not be NUL terminated.  Sue me.
-	 */
-	for (offset = 0; offset + len <= sz; offset++) {
-		/* we count non-overlapping occurrences of needle */
-		if (!memcmp(needle, data + offset, len)) {
-			offset += len - 1;
+
+	if (regexp) {
+		regmatch_t regmatch;
+		int flags = 0;
+
+		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
+			flags |= REG_NOTBOL;
+			data += regmatch.rm_so;
+			if (*data) data++;
 			cnt++;
+		}
+
+	} else { /* Classic exact string match */
+		/* Yes, I've heard of strstr(), but the thing is *data may
+		 * not be NUL terminated.  Sue me.
+		 */
+		for (offset = 0; offset + len <= sz; offset++) {
+			/* we count non-overlapping occurrences of needle */
+			if (!memcmp(needle, data + offset, len)) {
+				offset += len - 1;
+				cnt++;
+			}
 		}
 	}
 	return cnt;
@@ -36,10 +52,24 @@ void diffcore_pickaxe(const char *needle
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
 	int i, has_changes;
+	regex_t regex, *regexp = NULL;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 
+	if (opts & DIFF_PICKAXE_REGEX) {
+		int err;
+		err = regcomp(&regex, needle, REG_EXTENDED | REG_NEWLINE);
+		if (err) {
+			/* The POSIX.2 people are surely sick */
+			char errbuf[1024];
+			regerror(err, &regex, errbuf, 1024);
+			regfree(&regex);
+			die("invalid pickaxe regex: %s", errbuf);
+		}
+		regexp = &regex;
+	}
+
 	if (opts & DIFF_PICKAXE_ALL) {
 		/* Showing the whole changeset if needle exists */
 		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
@@ -48,16 +78,16 @@ void diffcore_pickaxe(const char *needle
 				if (!DIFF_FILE_VALID(p->two))
 					continue; /* ignore unmerged */
 				/* created */
-				if (contains(p->two, needle, len))
+				if (contains(p->two, needle, len, regexp))
 					has_changes++;
 			}
 			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len))
+				if (contains(p->one, needle, len, regexp))
 					has_changes++;
 			}
 			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len) !=
-				 contains(p->two, needle, len))
+				 contains(p->one, needle, len, regexp) !=
+				 contains(p->two, needle, len, regexp))
 				has_changes++;
 		}
 		if (has_changes)
@@ -80,16 +110,16 @@ void diffcore_pickaxe(const char *needle
 				if (!DIFF_FILE_VALID(p->two))
 					; /* ignore unmerged */
 				/* created */
-				else if (contains(p->two, needle, len))
+				else if (contains(p->two, needle, len, regexp))
 					has_changes = 1;
 			}
 			else if (!DIFF_FILE_VALID(p->two)) {
-				if (contains(p->one, needle, len))
+				if (contains(p->one, needle, len, regexp))
 					has_changes = 1;
 			}
 			else if (!diff_unmodified_pair(p) &&
-				 contains(p->one, needle, len) !=
-				 contains(p->two, needle, len))
+				 contains(p->one, needle, len, regexp) !=
+				 contains(p->two, needle, len, regexp))
 				has_changes = 1;
 
 			if (has_changes)
@@ -97,6 +127,10 @@ void diffcore_pickaxe(const char *needle
 			else
 				diff_free_filepair(p);
 		}
+
+	if (opts & DIFF_PICKAXE_REGEX) {
+		regfree(&regex);
+	}
 
 	free(q->queue);
 	*q = outq;



-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
