From: Johan Herland <johan@herland.net>
Subject: Testing performance of the notes lookup code (Was: [PATCHv3 6/8] First
 draft of notes tree parser with support for fanout subtrees)
Date: Thu, 30 Jul 2009 02:18:39 +0200
Message-ID: <200907300218.40203.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net>
 <1248834326-31488-7-git-send-email-johan@herland.net>
 <alpine.DEB.1.00.0907291842360.7626@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git@vger.kernel.org, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:18:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJMC-0005p4-5n
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbZG3ASp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbZG3ASp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:18:45 -0400
Received: from mx.getmail.no ([84.208.15.66]:37498 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754966AbZG3ASo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:18:44 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00KEBJJ75D90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:18:43 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK008ZFJJ4YL20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:18:42 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.30.621
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0907291842360.7626@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124419>

On Wednesday 29 July 2009, Johannes Schindelin wrote:
> On Wed, 29 Jul 2009, Johan Herland wrote:
> > This is a relatively straightforward implementation of parsing notes
> > trees that use fanout directories to limit the size of individual tree
> > objects. This first draft uses a simple linked list for holding
> > unparsed subtree references (to be parsed on demand), and as such, this
> > first draft concentrates more on correctness than performance (AFAICS
> > from t3302, there is no measurable performance impact when no fanout
> > subtrees are present).
>
> I know you want to have something working first and optimize then, but I
> imagined that the hashmap can actually contain the entries of the partial
> hashes, too.  You'll need to extend the data type, of course, to be able
> to say just how many digits of the SHA-1 are valid, and I guess for
> consistency you'll need to pad with 0s.

Thanks for the ideas. I will look into this once I have a set of
performance tests that I feel give a better picture of the notes parsing
performance.

> BTW have you done any performance benchmarks?  If so, how do they look?

I've just started. As I said above, t3302 (which has no fanout) is not
negatively affected by my current implementation. However this does not
say much (only that the current draft doesn't screw up completely...).

I've started making some scripts for more accurately testing the
performance of the notes parsing code at different fanout levels.
At the end of this email you will find a patch with my current state of
these scripts. (This patch is not meant to be included in the jh/notes
topic. It is only extra scripts for those interested in testing the
performance of this particular piece of code.)


METHODOLOGY

So far, there are 3 scripts:
- create_test_repo.sh: Creates a repo with 100,000 commits and one note
  object per commit. Also creates 3 notes trees, each holding all
  100,000 notes, but in different fanout structures:
  - refs/notes/fanout0: all 100,000 notes directly inside the root tree.
  - refs/notes/fanout1: notes are stored in a 2/38 structure (i.e. split
    into 256 subtrees within the root tree).
  - refs/notes/fanout2: notes are stored in a 2/2/36 structure (i.e. an
    additional 256-fanout within each of the 256 subtrees).

- verify_correctness.sh: Verify that the "git log" output for each of the
  3 notes refs is as expected. This is just to verify that the notes
  parsing code is actually doing the right job.

- test_performance.sh: For each of the 3 notes refs, run "git log -n 10"
  100 times, and report the time used. I feel this gives a more accurate
  impression of the real-world performance of the notes parsing code,
  since we:
  - Test the code at several fanout levels
  - Only lookup _some_ of the notes (looking up _all_ of the notes, i.e.
    "git log" without -n, is clearly the worst-case scenario for any code
    that loads subtree on-demand).

There is also a config script - config.sh - where you can tweak all of
the above test parameters.


PRELIMINARY RESULTS

Running the above test_performance.sh on the current state of jh/notes
give the following output on my machine:

  $ ./test_performance.sh
  Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 0...
  30.56user 2.08system 0:32.71elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+1038490minor)pagefaults 0swaps

  Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 1...
  1.64user 0.20system 0:01.88elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+104883minor)pagefaults 0swaps

  Timing 100 reps of 'git log -n 10 refs/heads/master >/dev/null' at fanout level 2...
  0.48user 0.18system 0:00.65elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+94283minor)pagefaults 0swaps

...which indicates that even with my straightforward first draft based on
a simple linked list, there are huge performance wins in using one or more
fanout levels.


THE SCRIPTS

---
 notes_performance/config.sh             |    9 +++
 notes_performance/create_test_repo.sh   |   90 +++++++++++++++++++++++++++++++
 notes_performance/test_performance.sh   |   31 +++++++++++
 notes_performance/verify_correctness.sh |   32 +++++++++++
 4 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 notes_performance/config.sh
 create mode 100755 notes_performance/create_test_repo.sh
 create mode 100755 notes_performance/test_performance.sh
 create mode 100755 notes_performance/verify_correctness.sh

diff --git a/notes_performance/config.sh b/notes_performance/config.sh
new file mode 100644
index 0000000..13abae8
--- /dev/null
+++ b/notes_performance/config.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+GIT=../../git
+
+num_commits=100000
+repo_dir=test_repo
+
+log_length=10
+log_reps=100
diff --git a/notes_performance/create_test_repo.sh b/notes_performance/create_test_repo.sh
new file mode 100755
index 0000000..fee3535
--- /dev/null
+++ b/notes_performance/create_test_repo.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+source ./config.sh
+
+# Create a test repo with $num_commits commits, and one note object per commit.
+# The repo has the following refs:
+# - refs/heads/master pointing to the last commit
+# - refs/notes/fanout0 referencing all notes with no fanout
+# - refs/notes/fanout1 referencing all notes with 2/38 fanout
+# - refs/notes/fanout2 referencing all notes with 2/2/36 fanout
+
+if [ -d $repo_dir ]; then
+	echo "Skipping repo creation, $repo_dir already exists"
+	exit 1
+fi
+
+mkdir $repo_dir &&
+cd $repo_dir &&
+$GIT init &&
+nr=0 &&
+echo "Creating $num_commits commits..." 1>&2 &&
+while [ $nr -lt $num_commits ]; do
+	nr=$(($nr+1)) &&
+	cat <<INPUT_END
+commit refs/heads/master
+committer Foo Bar <foobar@example.com> 1234567890 +0000
+data <<COMMIT
+commit #$nr
+COMMIT
+
+M 644 inline file
+data <<EOF
+file in commit #$nr
+EOF
+
+INPUT_END
+
+done |
+$GIT fast-import --quiet &&
+echo "done" 1>&2 &&
+(
+	echo "Creating $num_commits notes..." 1>&2 &&
+	nr=0 &&
+	while [ $nr -lt $num_commits ]; do
+		nr=$(($nr+1)) &&
+		cat <<INPUT_END
+blob
+mark :$nr
+data <<EOF
+note for commit #$nr
+EOF
+
+INPUT_END
+
+	done &&
+	echo "done" 1>&2 &&
+	for fanout_levels in 0 1 2; do
+		notes_ref="refs/notes/fanout$fanout_levels" &&
+		echo "Creating notes tree with fanout level $fanout_levels..." 1>&2 &&
+		cat <<INPUT_END &&
+commit $notes_ref
+committer Foo Bar <foobar@example.com> 1234567890 +0000
+data <<COMMIT
+notes with fanout level $fanout_levels
+COMMIT
+
+INPUT_END
+
+		nr=$num_commits &&
+		$GIT rev-list refs/heads/master |
+		while read sha1; do
+			case $fanout_levels in
+			0)
+				note_path=$sha1
+			;;
+			1)
+				note_path="${sha1:0:2}/${sha1:2}"
+			;;
+			2)
+				note_path="${sha1:0:2}/${sha1:2:2}/${sha1:4}"
+			;;
+			esac &&
+			echo "M 100644 :$nr $note_path" &&
+			nr=$(($nr-1))
+		done &&
+		echo "done" 1>&2
+	done
+) |
+$GIT fast-import --quiet &&
+$GIT gc
diff --git a/notes_performance/test_performance.sh b/notes_performance/test_performance.sh
new file mode 100755
index 0000000..65a5dbf
--- /dev/null
+++ b/notes_performance/test_performance.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+source ./config.sh
+
+# Test "git log -n $log_length" for each of the 3 notes refs
+# - refs/notes/fanout0
+# - refs/notes/fanout1
+# - refs/notes/fanout2
+
+if [ ! -d $repo_dir ]; then
+	echo "Cannot test performance, $repo_dir missing"
+	exit 1
+fi
+
+cd $repo_dir &&
+cat > time_notes <<EOF &&
+	i=0 &&
+	while [ \$i -lt $log_reps ]; do
+		$GIT log -n $log_length refs/heads/master >/dev/null &&
+		i=\$((\$i+1))
+	done
+
+EOF
+
+for fanout_levels in 0 1 2; do
+	echo "Timing $log_reps reps of 'git log -n $log_length refs/heads/master >/dev/null' at fanout level $fanout_levels..." &&
+	notes_ref="refs/notes/fanout$fanout_levels" &&
+	$GIT config core.notesRef $notes_ref &&
+	/usr/bin/time sh time_notes &&
+	echo
+done
diff --git a/notes_performance/verify_correctness.sh b/notes_performance/verify_correctness.sh
new file mode 100755
index 0000000..ca40223
--- /dev/null
+++ b/notes_performance/verify_correctness.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+source ./config.sh
+
+# Verify proper contents of git log for each of the 3 notes refs
+# - refs/notes/fanout0
+# - refs/notes/fanout1
+# - refs/notes/fanout2
+
+if [ ! -d $repo_dir ]; then
+	echo "Cannot verify correctness, $repo_dir missing"
+	exit 1
+fi
+
+cd $repo_dir &&
+for fanout_levels in 0 1 2; do
+	echo "Verifying correct git log at fanout level $fanout_levels" &&
+	notes_ref="refs/notes/fanout$fanout_levels" &&
+	$GIT config core.notesRef $notes_ref &&
+	$GIT log | grep "^    " > output &&
+	nr=$num_commits &&
+	while [ $nr -gt 0 ]; do
+		echo "    commit #$nr" &&
+		echo "    note for commit #$nr" &&
+		nr=$(($nr-1));
+	done > expect &&
+	echo "done" &&
+	diff -u expect output || {
+		echo "Failed verification of fanout level $fanout_levels"
+		exit 1
+	}
+done
-- 
1.6.4.rc3.138.ga6b98.dirty


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
