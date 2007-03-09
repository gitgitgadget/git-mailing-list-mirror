From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH] git-parse-remote: Support dummy remote `.' in branch.<name>.remote
Date: Fri, 09 Mar 2007 16:53:00 +0100
Message-ID: <45F182DC.9090507@lu.unisi.ch>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 16:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPhPB-0005hR-FV
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 16:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993132AbXCIPxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993133AbXCIPxG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 10:53:06 -0500
Received: from server.usilu.net ([195.176.178.200]:49548 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2993134AbXCIPxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 10:53:04 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Mar 2007 16:53:00 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
X-OriginalArrivalTime: 09 Mar 2007 15:53:00.0081 (UTC) FILETIME=[03593210:01C76263]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41800>

This patch adds support for a dummy remote `.' to avoid having to declare
a fake remote like

	[remote "local"]
		url = .
		fetch = refs/heads/*:refs/heads/*

A configuration variable is provided, "branch.forcelocalupdates", which
fakes the fetch line to read "+refs/heads/*:refs/heads/*".

A subsequent patch, which will be submitted after this and the
--track/--no-track patch goes in, will add support for the `.'
remote in `git-branch --track'.

It is important to notice that the `.' remote only works in
branch.<name>.remote by design.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/config.txt |   10 ++++++++++
 git-parse-remote.sh      |   15 ++++++++++++++-
 t/t5520-pull.sh          |   13 +++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

	Andy Parkins wrote:

	> I think what you want is something that I would like too.  If you specify "." 
	> to a git-pull it means to use the local repository not a remote.  It would be 
	> great if one could have:
	> 
	> [remote "origin"]
        > url = git://git.kernel.org/pub/scm/git/git.git
        > fetch = refs/heads/master:refs/remotes/origin/master
	> [branch "master"]
        > remote = .
        > merge = refs/remotes/origin/master
	>
	> That way a "git pull" on master wouldn't need to make a remote connection in 
	> order to do a merge (which is the way I like it).  However, I remember there 
	> was a reason this wouldn't work, but I don't remember what it was  :-) 

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..0e72c3e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -272,6 +272,16 @@ branch.<name>.merge::
 	`git fetch`) to lookup the default branch for merging. Without
 	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
+	If you wish to setup `git pull` so that it merges into <name> from
+	another branch in the local repository, you can point
+	branch.<name>.merge to the desired branch, and use the special setting
+	`.` (a period) for branch.<name>.remote.
+
+branch.forcelocalupdates::
+	If set to true, merges from the local repository (i.e. when
+	branch.<name>.remote is the special setting `.`) are performed
+	even if they do not result in a fast forward update.  The default
+	is true.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 99e7184..60c4b08 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -9,6 +9,9 @@ get_data_source () {
 	*/*)
 		echo ''
 		;;
+	.)
+		echo builtin
+		;;
 	*)
 		if test "$(git-config --get "remote.$1.url")"
 		then
@@ -31,6 +34,9 @@ get_remote_url () {
 	'')
 		echo "$1"
 		;;
+	builtin)
+		echo "$1"
+		;;
 	config)
 		git-config --get "remote.$1.url"
 		;;
@@ -57,7 +63,7 @@ get_default_remote () {
 get_remote_default_refs_for_push () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches)
+	'' | branches | builtin)
 		;; # no default push mapping, just send matching refs.
 	config)
 		git-config --get-all "remote.$1.push" ;;
@@ -128,6 +134,13 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		set explicit "HEAD:" ;;
+	builtin)
+		if test $(git-config --bool "branch.forcelocalupdates" || echo true) = true
+		then
+			set $(expand_refs_wildcard . +refs/heads/*:refs/heads/*)
+		else
+			set $(expand_refs_wildcard . refs/heads/*:refs/heads/*)
+		fi ;;
 	config)
 		set $(expand_refs_wildcard "$1" \
 			$(git-config --get-all "remote.$1.fetch")) ;;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7eb3783..c424e5b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,5 +29,18 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
 
+test_expect_success 'test . as a remote' '
+
+	git branch copy master &&
+	git config branch.copy.remote . &&
+	git config branch.copy.merge refs/heads/master &&
+	echo updated >file &&
+	git commit -a -m updated &&
+	git checkout copy &&
+	test `cat file` = file &&
+	git pull &&
+	test `cat file` = updated
+'
+
 test_done
 
