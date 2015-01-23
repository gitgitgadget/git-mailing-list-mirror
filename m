From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 2/2] Teach "guilt graph" the "-x exclude-pattern" option.
Date: Fri, 23 Jan 2015 15:21:07 +0100
Message-ID: <1422022867-7908-3-git-send-email-cederp@opera.com>
References: <1422022867-7908-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEf8H-0001Xh-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbbAWOWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:22:42 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64222 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbAWOWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:22:41 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so3359182wgh.10
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 06:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9FI3Nq76rd7NCFVHbdYujFqKSN2fxG7p7+5dbhPLi14=;
        b=RIIiz81yGqCHttvvsVDNfrDxRifMTHDYrLjtEH3QTzji67Ak4DfsXkqbTK7gH/4yk3
         JcNIDR46vCH/NBTkdV7LhWkit1DR3BXDbXHwL6w+h2b8+Hpkr0+e/Axi3h+rwIZoflbH
         uy2qmXYJpvK6HX8pipJPTFv71Xl7baYw8eS/3RPWwPAhIAqeYOMt3quuJBmHh1d5eAK4
         q/wHDCjLeCkzVtKSlehmOFoOEJgamV7a4fVNrXP5CewhpyKELwOqDTMECFtQHdbFICLk
         iwAvHpY2VwVahpNl+yr+RR+mL+RjYuUf7U+m327BQYJSCuQ92UpFVTr3hsfj5QzZWjwn
         3LZw==
X-Gm-Message-State: ALoCoQn+myXdib3RhefzBSxBoGmeH2NPd18p8K6TdFwYGC7m5eq6gsproA5gXCB+u01aV+td9AjW
X-Received: by 10.194.71.45 with SMTP id r13mr14157722wju.128.1422022959977;
        Fri, 23 Jan 2015 06:22:39 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id uq1sm2413134wjc.14.2015.01.23.06.22.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 06:22:39 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422022867-7908-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262931>

Some projects keep a ChangeLog which every commit modifies.  This
makes the graph a very uninteresting single line of commits.  It is
sometimes useful to see how the graph would look if we ignore the
ChangeLog file.

The new -x option is useful in situations like this.  It can be
repeated several times to ignore many files.  Each argument is saved
to a temporary file and "grep -v -f $TEMPORARY" is used to filter out
the file names you want to ignore.

Also added a minimal test case and documentation.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/guilt-graph.txt |  5 +++++
 guilt-graph                   | 24 ++++++++++++++++++------
 regression/t-033.out          | 12 ++++++++++++
 regression/t-033.sh           |  3 +++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/guilt-graph.txt b/Documentation/guilt-graph.txt
index f43206e..eeed321 100644
--- a/Documentation/guilt-graph.txt
+++ b/Documentation/guilt-graph.txt
@@ -16,6 +16,11 @@ patches.
 
 OPTIONS
 -------
+-x <pattern>::
+	Ignore files that matches the given grep pattern. Can be
+	repeated to ignore several files. This can be useful to ignore
+	for instance ChangeLog files that every commit modifies.
+
 <patchname>::
 	Instead of starting with the topmost applied patch, start with
 	<patchname>.
diff --git a/guilt-graph b/guilt-graph
index d90c2f1..4d5fe46 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -3,7 +3,7 @@
 # Copyright (c) Josef "Jeff" Sipek, 2007-2013
 #
 
-USAGE="[<patchname>]"
+USAGE="[-x exclude-pattern]... [<patchname>]"
 if [ -z "$GUILT_VERSION" ]; then
 	echo "Invoking `basename "$0"` directly is no longer supported." >&2
 	exit 1
@@ -11,6 +11,22 @@ fi
 
 _main() {
 
+cache="$GUILT_DIR/$branch/.graphcache.$$"
+xclude="$GUILT_DIR/$branch/.graphexclude.$$"
+trap "rm -rf \"$cache\" \"$xclude\"" 0
+mkdir "$cache"
+>"$xclude"
+
+while [ $# -gt 0 ]; do
+    if [ "$1" = "-x" ] && [ $# -ge 2 ]; then
+	echo "$2" >> "$xclude"
+	shift
+	shift
+    else
+	break
+    fi
+done
+
 if [ $# -gt 1 ]; then
 	usage
 fi
@@ -39,10 +55,6 @@ getfiles()
 	git diff-tree -r "$1^" "$1" | cut -f2
 }
 
-cache="$GUILT_DIR/$branch/.graphcache.$$"
-mkdir "$cache"
-trap "rm -rf \"$cache\"" 0
-
 disp "digraph G {"
 
 current="$top"
@@ -66,7 +78,7 @@ while [ "$current" != "$base" ]; do
 	rm -f "$cache/dep"
 	touch "$cache/dep"
 
-	getfiles $current | while read f; do
+	getfiles $current | grep -v -f "$xclude" | while read f; do
 		# hash the filename
 		fh=`echo "$f" | sha1 | cut -d' ' -f1`
 		if [ -e "$cache/$fh" ]; then
diff --git a/regression/t-033.out b/regression/t-033.out
index c120d4f..1ed371f 100644
--- a/regression/t-033.out
+++ b/regression/t-033.out
@@ -88,3 +88,15 @@ digraph G {
 	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
 	"891bc14b5603474c9743fd04f3da888644413dc5" -> "ff2775f8d1dc753f635830adcc3a067e0b681e2d"; // ?
 }
+%% The same graph, but excluding deps introduced by file.txt.
+% guilt graph -x file.txt
+digraph G {
+# checking rev bc7df666a646739eaf559af23cab72f2bfd01f0e
+	"bc7df666a646739eaf559af23cab72f2bfd01f0e" [label="a-\"better&quicker'-patch.patch"]
+# checking rev 891bc14b5603474c9743fd04f3da888644413dc5
+	"891bc14b5603474c9743fd04f3da888644413dc5" [label="c.patch"]
+# checking rev c7014443c33d2b0237293687ceb9cbd38313df65
+	"c7014443c33d2b0237293687ceb9cbd38313df65" [label="b.patch"]
+# checking rev ff2775f8d1dc753f635830adcc3a067e0b681e2d
+	"ff2775f8d1dc753f635830adcc3a067e0b681e2d" [label="a.patch"]
+}
diff --git a/regression/t-033.sh b/regression/t-033.sh
index 9fe1827..ae22914 100755
--- a/regression/t-033.sh
+++ b/regression/t-033.sh
@@ -59,3 +59,6 @@ cmd git add file.txt
 cmd guilt refresh
 fixup_time_info "a-\"better&quicker'-patch.patch"
 cmd guilt graph
+
+echo "%% The same graph, but excluding deps introduced by file.txt."
+cmd guilt graph -x file.txt
-- 
2.1.0
