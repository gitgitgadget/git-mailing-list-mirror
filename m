From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] bash completion: complete refs for git-grep
Date: Tue, 6 Oct 2009 12:08:12 +0200
Message-ID: <14ac499280c9b17f862ab13201b48c64b4827713.1254823328.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 06 12:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv703-0000Qd-Oo
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 12:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892AbZJFKJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 06:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756855AbZJFKJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 06:09:56 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4587 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756842AbZJFKJz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 06:09:55 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 6 Oct
 2009 12:09:08 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 6 Oct
 2009 12:08:46 +0200
X-Mailer: git-send-email 1.6.5.rc2.251.g34f85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129620>

Attempt ref completion once we have seen a regular expression, to help
the user with entering the <treeish> arguments.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

The use-case for this is actually a bit protracted but came up on IRC
yesterday: pasky asked if there was a simple way to grep through a
certain file in all refs.

Turns out git-grep already has half the required support: when given a
series of refs, it prefixes the matches with the ref, so the output is
already in a useful format.

Sadly it does not appear to support --all, --branches or similar
(which would be material for a separate patch).  But bash completion
can step in here: with M-*, it can expand all possible completions for
the current word onto the command line.

This is still RFC because, as you can see in the code below, I tried
to avoid completing at all while the user still needs to supply a
regex.  Sadly, bash turns the COMPREPLY=() into filename completion
anyway.  Is there a way to prevent this?  Otherwise the regex
complication should probably just go away and we can complete refs
always.


 contrib/completion/git-completion.bash |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6fd7e1d..c8cced6 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1048,6 +1048,24 @@ _git_grep ()
 		return
 		;;
 	esac
+
+	local i c=1 have_regex=""
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		-e) ;;
+		-e*) have_regex="$c" ; break ;;
+		-*) ;;
+		*) have_regex="$c"; break ;;
+		esac
+		c=$((++c))
+	done
+
+	if [ -n "$have_regex" ]; then
+		__gitcomp "$(__git_refs)"
+		return
+	fi
+
 	COMPREPLY=()
 }
 
-- 
1.6.5.rc2.251.g34f85
