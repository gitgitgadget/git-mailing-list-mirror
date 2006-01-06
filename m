From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Fri, 06 Jan 2006 14:37:27 -0800
Message-ID: <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
References: <dp3qpb$7uk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Dh-0007b1-Ca
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWAFWhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWAFWhx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56769 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964864AbWAFWha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223509.HYBE17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:09 -0500
To: John Ellson <ellson@research.att.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14215>

John Ellson <ellson@research.att.com> writes:

> Suggested fix:  Use '_' instead of '-'

I wonder if the right fix is to change the git-describe output
before the current output becomes too widespread.  After all,
somebody might be tempted to use 1.0.6-g58e3 as a tagname ;-).
For example, if we say "1.0.6:58e3" there is no ambiguity, but
probably binary packagers would not like colon either X-<.

More seriously, I do not think git-describe based versioning
scheme meshes well with binary packagers.  There is no guaranee
1.0.6-g58e3 comes before 1.0.6-g4e7a2 (it does not).  To really
fix this problem, I think the rpm target of the main Makefile
needs to be modified to include something monotonicly increasing
(e.g. number of seconds since the base commit encoded in base26,
or something silly like that) between the base version and the
abbreviated object name, but the development being distributed,
my today's version on top of 1.0.6 may be way behind your
yesterday's version, so some centralized coordination (read:
manual version assignment by the maintainer, or automated
assignment but only reserved for the maintainer and unavailable
to mere mortals) might be needed to truly solve this.  In that
sense, maybe leaving the interim version unbuildable for binary
packaging might be considered a feature.

What Linus did with git-describe is good for people who do not
install prebuilt binaries, or know how to override (false)
downgrade refusal by package managers.

I vaguely recall that Debian does not like underscores at random
places, but we know both RPM and Debian can handle multiple
dots, so if you insist using the git-describe based version to
build binary packages, I suspect dot instead of underscore would
be a better choice.  Since I do not understand what that "g"
stands for anyway, how about doing something like this instead?

Note that the part about "describe --stamp" is not really a
serious counterproposal.  If I cut a binary package out of my
master and then one of my topic branches, it is very likely they
will get confused time ordering when they happen to find the
same base revision.  This patch is for discussion only and I
will not even keep it in the proposed updates branch.  I would
however welcome if somebody polishes it up and makes it suitable
for binary packaging purposes ;-).

-- >8 --
[PATCH] sanitize describe output used in GIT_VERSION

It is reported that RPM does not like '-' in version name, which
unfortunately is what the new "git-describe" based interim
versioning scheme gives.

This does three things:

 - GIT-VERSION-GEN avoids '-' characters and replaces them with '.'.

 - git-describe --stamp flag adds number of seconds since the
   base revision until the named revision, between the base
   revision name and the abbreviated object name.

 - GIT-VERSION-GEN uses describe --stamp to make commits
   monotonically increasing to keep binary package managers
   happier, unless you have multiple branches or skewed clocks.

---
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 0efe82a..ca0e781 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -8,7 +8,7 @@ git-describe - Show the most recent tag 
 
 SYNOPSIS
 --------
-'git-describe' [--all] [--tags] [--abbrev=<n>] <committish>...
+'git-describe' [--all] [--tags] [--abbrev=<n>] [--stamp] <committish>...
 
 DESCRIPTION
 -----------
@@ -35,6 +35,12 @@ OPTIONS
 	Instead of using the default 8 hexadecimal digits as the
 	abbreviated object name, use <n> digits.
 
+--stamp::
+	Add a timestamp string, expressed as number of seconds
+	between the commit times of the base commit and the
+	named commit, encoded in base26 (a-z), between the base
+	version name and abbreviated object name.
+
 
 EXAMPLES
 --------
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 845b9dc..f6ed589 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -2,8 +2,8 @@
 
 GVF=GIT-VERSION-FILE
 
-VN=$(git-describe --abbrev=4 HEAD 2>/dev/null) || VN=v1.0.GIT
-VN=$(expr "$VN" : v'\(.*\)')
+VN=$(git-describe --abbrev=4 --stamp HEAD 2>/dev/null) || VN=v1.0.GIT
+VN=$(echo "$VN" | sed -e 's/^v//' -e 's/-g\([^-]*\)$/-\1/' -e 's/-/./g')
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
diff --git a/describe.c b/describe.c
index 84d96b5..0414100 100644
--- a/describe.c
+++ b/describe.c
@@ -13,6 +13,7 @@ static int tags = 0;	/* But allow any ta
 
 #define DEFAULT_ABBREV 8 /* maybe too many */
 static int abbrev = DEFAULT_ABBREV;
+static int stamp = 0; /* show timestamps between base and abbrev */
 
 static int names = 0, allocs = 0;
 static struct commit_name {
@@ -98,6 +99,39 @@ static int compare_names(const void *_a,
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }
 
+static void describe_it(struct commit *cmit, struct commit_name *name)
+{
+	const char *ab = find_unique_abbrev(cmit->object.sha1, abbrev);
+	if (stamp) {
+		unsigned long t1 = name->commit->date;
+		unsigned long t2 = cmit->date;
+		char tstamp[11]; /* 26^13 < 2^64 < 26^14 */
+		int i;
+
+		/* It had better be the former unless there is something
+		 * really really screwy with your clock.
+		 */
+		if (t1 < t2) {
+			unsigned long t = t2 - t1;
+			for (i = 0; i < sizeof(tstamp) && t; i++) {
+				unsigned long d = t % 26;
+				t /= 26;
+				tstamp[i] = d + 'a';
+			}
+		}
+		else {
+			tstamp[0] = '0';
+			i = 1;
+		}
+		printf("%s-", name->path);
+		while (0 < i)
+			putchar(tstamp[--i]);
+		printf("-g%s\n", ab);
+	}
+	else
+		printf("%s-g%s\n", name->path, ab);
+}
+
 static void describe(struct commit *cmit)
 {
 	struct commit_list *list;
@@ -122,8 +156,7 @@ static void describe(struct commit *cmit
 		struct commit *c = pop_most_recent_commit(&list, SEEN);
 		n = match(c);
 		if (n) {
-			printf("%s-g%s\n", n->path,
-			       find_unique_abbrev(cmit->object.sha1, abbrev));
+			describe_it(cmit, n);
 			return;
 		}
 	}
@@ -146,6 +179,10 @@ int main(int argc, char **argv)
 			tags = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--stamp")) {
+			stamp = 1;
+			continue;
+		}
 		if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
 			if (abbrev < 4 || 40 <= abbrev)
