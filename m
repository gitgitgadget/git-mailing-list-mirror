From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC] Speeding up a null fetch
Date: Sun, 11 Feb 2007 23:32:13 +0000
Message-ID: <200702112332.14698.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 00:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOBH-0000uI-75
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXBKXcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXBKXcX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:32:23 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:37518 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825AbXBKXcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:32:22 -0500
Received: (qmail 26412 invoked by uid 103); 11 Feb 2007 23:32:20 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2551. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.062825 secs); 11 Feb 2007 23:32:20 -0000
Received: from unknown (HELO beast.quantumfyre.co.uk) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 11 Feb 2007 23:32:20 +0000
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39330>

I was investigating replacing an existing subversion setup with git, and
was mostly pleased with the results - until it came to trying to update a
clone ... which took very much longer than the original clone.

An artifical test repository that has similar features (~25000 commits,
~8000 tags, ~900 branches and a 2.5Gb packfile) when running locally
takes ~20m to clone and ~48m to fetch (with no new commits in the
original repository - i.e. the fetch does not update anything) with a
current code base (i.e. newer than 1.5.0-rc4).  As a side note,
performance was actually better with an older version - packed refs
makes things quite a bit worse (clone was only ~30m with 1.4 IIRC).

Investigation showed that the main culprit seemed to be show-ref
having to build a sorted list of all refs for every ref that was being
checked.  So I used the patch below to reduce this to a single call to
show-ref (unless the ref had been updated).  With this patch the fetch
timed dropped to just under 1m - obviously quite a lot faster (better
than I expected in fact).

However, this seems more band-aid than fix, and I wondered if someone
more familiar with the git internals could point me in the right
direction for a better fix, e.g. should I look at rewriting fetch in C?

diff --git a/Makefile b/Makefile
index 5d31e6d..6baf043 100644
--- a/Makefile
+++ b/Makefile
@@ -120,7 +120,7 @@ ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
-prefix = $(HOME)
+prefix = $(HOME)/git
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 template_dir = $(prefix)/share/git-core/templates/
@@ -188,7 +188,7 @@ SCRIPT_PERL = \
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  git-cherry-pick git-status git-instaweb
+	  git-cherry-pick git-status git-instaweb git-ref-diff.py
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
diff --git a/git-fetch.sh b/git-fetch.sh
index 357cac2..ce135a5 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -108,11 +108,12 @@ ls_remote_result=$(git ls-remote $exec "$remote") ||
 
 append_fetch_head () {
     head_="$1"
-    remote_="$2"
-    remote_name_="$3"
-    remote_nick_="$4"
-    local_name_="$5"
-    case "$6" in
+    local_head_="$2"
+    remote_="$3"
+    remote_name_="$4"
+    remote_nick_="$5"
+    local_name_="$6"
+    case "$7" in
     t) not_for_merge_='not-for-merge' ;;
     '') not_for_merge_= ;;
     esac
@@ -151,10 +152,15 @@ append_fetch_head () {
 	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
     fi
 
-    update_local_ref "$local_name_" "$head_" "$note_"
+    update_local_ref "$local_name_" "$head_" "$note_" "$local_head_"
 }
 
 update_local_ref () {
+    if [ "$2" == "$4" ]; then
+	[ "$verbose" ] && echo >&2 "* $1: same as $3"
+	return 0
+    fi
+
     # If we are storing the head locally make sure that it is
     # a fast forward (aka "reverse push").
 
@@ -392,7 +398,7 @@ fetch_main () {
       (
 	  git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref ||
 	  echo failed "$remote"
-      ) |
+      ) | git-ref-diff.py "$reflist" |
       (
 	trap '
 		if test -n "$keepfile" && test -f "$keepfile"
@@ -402,7 +408,7 @@ fetch_main () {
 	' 0
 
         keepfile=
-	while read sha1 remote_name
+	while read sha1 remote_name local_sha1
 	do
 	  case "$sha1" in
 	  failed)
@@ -441,7 +447,7 @@ fetch_main () {
 	      esac
 	  done
 	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
-	  append_fetch_head "$sha1" "$remote" \
+	  append_fetch_head "$sha1" "$local_sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" \
 		  "$not_for_merge" || exit
         done
diff --git a/git-ref-diff.py b/git-ref-diff.py
new file mode 100755
index 0000000..2b30e4c
--- /dev/null
+++ b/git-ref-diff.py
@@ -0,0 +1,33 @@
+#!/usr/bin/python
+
+import os
+import re
+import sys
+
+ref_map_re = re.compile("^\.?\+?(?P<remote>.*?):(?P<local>.*)$")
+
+refs = {}
+refsp = os.popen("git-show-ref")
+for ref in refsp.readlines():
+    (sha, ref) = ref.strip().split(' ')
+    refs[ref] = sha
+refsp.close()
+
+ref_map = {}
+for line in sys.argv[1].split('\n'):
+    ref_map_m = ref_map_re.search(line)
+    if ref_map_m:
+        remote = ref_map_m.group('remote')
+        local = ref_map_m.group('local')
+        ref_map[remote] = local
+
+while True:
+    try:
+        (sha, ref) = raw_input().split(' ')
+    except EOFError:
+        sys.exit(0)
+    lref = ref_map.get(ref, None)
+    if refs.has_key(lref):
+        print "%s %s %s" % (sha, ref, refs[lref])
+    else:
+        print "%s %s -" % (sha, ref)

-- 
Julian

 --- 
Why bother building any more nuclear warheads until we use the ones we have?
