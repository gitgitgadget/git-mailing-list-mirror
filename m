From: linux@horizon.com
Subject: git-name-rev off-by-one bug
Date: 28 Nov 2005 18:42:56 -0500
Message-ID: <20051128234256.1508.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Nov 29 05:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egx67-00069G-M5
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 05:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVK2E2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 23:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVK2E2E
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 23:28:04 -0500
Received: from science.horizon.com ([192.35.100.1]:33093 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750746AbVK2E2D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 23:28:03 -0500
Received: (qmail 1509 invoked by uid 1000); 28 Nov 2005 18:42:56 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12917>

I've been trying to wrap my head around git for a while now, and finding
things a bit confusing.  Basically, the reason that I'm scared to trust
it with my code is that all sharing is done via push and pull, and they
are done by merging, and merging isn't described very well anywhere.

There's lots of intimate *detail* of merge algorithms (hiding in, of all
places, the git-read-tree documentation, which is not the obvious place
for a beginner to look), but the important high-level questions like "what
happens to all my hard work if there's a merge conflict?" or "what if I
forget to git-update-index before doing the merge?" are not really clear.
I don't like to go ahead if I'm not confident I can get back.

(Being able to back up the object database is obviously simple, but what
happens if the index holds HEAD+1, the working directory holds HEAD+2,
and I try to mere the latest changes from origin?  Are either HEAD+1 or
HEAD+2 in danger of being lost, or will checking them in later overwrite
the merge, or what?)

Anyway, I'm doing some experiments and trying to understand it, and writing
what I learn as I go, which will hopefully be useful to someone.


Another very confusing thing is the ref syntax with all those ~12^3^22^2
suffixes.  The git tutorial uses "master^" and "master^2" syntax, but
doesn't actually explain it.

The meaning can be found on the second page of the git-rev-parse manual.
If, that is, you think to read that man page, and if you don't stop
reading after the first page tells you that it's a helper for scripts
not meant to be invoked directly by the end-user.

Trying to see if I understood what was going on, I picked a random rev out of
git-show-branch output and tried git-name-rev:

> $ git-name-rev 365a00a3f280f8697e4735e1ac5b42a1c50f7887
> 365a00a3f280f8697e4735e1ac5b42a1c50f7887 maint~404^1~7

(If you care, maint=93dcab2937624ebb97f91807576cddb242a55a46)

And was very confused when git-rev-parse didn't invert the operation:

> $ git-rev-parse maint~404^1~7
> f69714c38c6f3296a4bfba0d057e0f1605373f49

I spent a while verifying that I understood that ^1 == ^ == ~1, so
~404^1~7 = ~412, and that gave the same unwanted result:

> $ git-rev-parse maint~412
> f69714c38c6f3296a4bfba0d057e0f1605373f49

After confusing myself for a while, I looked to see why git-name-rev
would output such a redundant name and found that it was simply
wrong.  Fixing the symbolic name worked:

> $ git-rev-parse maint~404^2~7
> 365a00a3f280f8697e4735e1ac5b42a1c50f7887

You can either go with a minimal fix:
diff --git a/name-rev.c b/name-rev.c
index 7d89401..f7fa18c 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -61,9 +61,10 @@ copy_data:
 
 			if (generation > 0)
 				sprintf(new_name, "%s~%d^%d", tip_name,
-						generation, parent_number);
+						generation, parent_number+1);
 			else
-				sprintf(new_name, "%s^%d", tip_name, parent_number);
+				sprintf(new_name, "%s^%d", tip_name,
+						parent_number+1);
 
 			name_rev(parents->item, new_name,
 				merge_traversals + 1 , 0, 0);


Or you can get a bit more ambitious and write ~1 as ^:

diff --git a/name-rev.c b/name-rev.c
index 7d89401..82053c8 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -57,13 +57,17 @@ copy_data:
 			parents;
 			parents = parents->next, parent_number++) {
 		if (parent_number > 0) {
-			char *new_name = xmalloc(strlen(tip_name)+8);
+			unsigned const len = strlen(tip_name);
+			char *new_name = xmalloc(len+8);
 
-			if (generation > 0)
-				sprintf(new_name, "%s~%d^%d", tip_name,
-						generation, parent_number);
-			else
-				sprintf(new_name, "%s^%d", tip_name, parent_number);
+			memcpy(new_name, tip_name, len);
+
+			if (generation == 1)
+				new_name[len++] = '^';
+			else if (generation > 1)
+				len += sprintf(new_name+len, "~%d", generation);
+
+			sprintf(new_name+len, "^%d", parent_number+1);
 
 			name_rev(parents->item, new_name,
 				merge_traversals + 1 , 0, 0);


While I'm at it, I notice some unnecessary invocations of expr in some
of the shell scripts.  You can do it far more simply using the ${var#pat}
and ${var%pat} expansions to strip off leading and trailing patterns.
For example:

diff --git a/git-cherry.sh b/git-cherry.sh
index 867522b..c653a6a 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -23,8 +23,7 @@ case "$1" in -v) verbose=t; shift ;; esa
 
 case "$#,$1" in
 1,*..*)
-    upstream=$(expr "$1" : '\(.*\)\.\.') ours=$(expr "$1" : '.*\.\.\(.*\)$')
-    set x "$upstream" "$ours"
+    set x "${1%..*}" "${1#*..}"
     shift ;;
 esac
 
This works in dash and is in the POSIX spec.  It doesn't work in some
very old /bin/sh implementations (such as Solaris still ships), but I'm
pretty sure it was introduced at the same time as $(), and the scripts
use *that* all over the place.

% sh
$ uname -s -r
SunOS 5.9
$ foo=bar
$ echo ${foo#b}
bad substitution
$ echo `echo $foo`
bar
$ echo $(echo $foo)
syntax error: `(' unexpected

Anyway, if it's portable enough, it's faster.  Ah... I just found discussion
of this in late September, but it's not clear what the resolution was.
http://marc.theaimsgroup.com/?t=112746188000003


(Oh, yes: all of the above patches are released into the public domain.
Copyright abandoned.  Have fun.)
