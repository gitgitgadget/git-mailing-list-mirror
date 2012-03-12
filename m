From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 06/11] perf: dereference to a commit when building
Date: Mon, 12 Mar 2012 16:10:02 +0100
Message-ID: <2d1921e1faf6e5927edd6c620ba71b07e8965979.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76tG-0001iv-DM
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab2CLPKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:17 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739Ab2CLPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:13 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:08 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192876>

So far the automatic compilation in 'run' just ran rev-parse on the
user input.  This means the user could test once for v1.7.9 and once
for 828ea97 (Git 1.7.9, 2012-01-27) and the script would never realize
that they are actually the same.  Even more confusingly, the user
could test 828ea97d and ask about './aggregate.perl v1.7.9' and it
would not find any results.

Dereference to a commit when constructing the directory name to avoid
this.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/aggregate.perl |    2 +-
 t/perf/run            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 9c781fa..4586840 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -52,7 +52,7 @@ sub format_times {
 	my $dir;
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
-		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
+		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg."^{commit}");
 		$dir = "build/".$rev;
 	} else {
 		$arg =~ s{/*$}{};
diff --git a/t/perf/run b/t/perf/run
index 886290b..e4f9c22 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -45,7 +45,7 @@ run_dirs_helper () {
 		shift
 	fi
 	if [ ! -d "$mydir" ]; then
-		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
+		rev=$(git rev-parse --verify "$mydir^{commit}" 2>/dev/null) ||
 		die "'$mydir' is neither a directory nor a valid revision"
 		if [ ! -d build/$rev ]; then
 			unpack_git_rev $rev
-- 
1.7.10.rc0.230.g16d90
