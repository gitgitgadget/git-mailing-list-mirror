From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC PATCH 2/3] Add specification of git-vcs helpers
Date: Sun, 11 Jan 2009 15:12:08 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901110334350.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6gx-0008Ht-6h
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZAKUMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbZAKUMM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:12:12 -0500
Received: from iabervon.org ([66.92.72.58]:48384 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbZAKUMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:12:09 -0500
Received: (qmail 30919 invoked by uid 1000); 11 Jan 2009 20:12:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:12:08 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105215>

So far, I've actually used list and import; I've also implemented an 
export, but haven't figured out exactly how the user should cause it to be 
used.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-vcs.txt |   93 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs.txt

diff --git a/Documentation/git-vcs.txt b/Documentation/git-vcs.txt
new file mode 100644
index 0000000..fa02b76
--- /dev/null
+++ b/Documentation/git-vcs.txt
@@ -0,0 +1,93 @@
+git-vcs-*(1)
+============
+
+NAME
+----
+git-vcs-* - Helper programs for interoperation with foreign systems
+
+SYNOPSIS
+--------
+'git vcs-<system>' <command> [options] [arguments]
+
+DESCRIPTION
+-----------
+
+These programs are normally not used directly by end users, but are
+invoked by various git programs that interact with remote repositories
+when the repository they would operate on is part of a foreign
+system.
+
+Each 'git vcs-<system>' is a helper for interoperating with a
+particular version control system. Different helpers have different
+capabilities (limited both be the particular helper and by the
+capabilities of the system they connect to), and they report what
+capabilities they support.
+
+In general, these programs interact with a portion of the refs
+namespace that isn't used by the rest of git. The configuration will
+then (generally) map these refs into the remotes namespace. This
+allows the importer to do whatever it wants with its refs without
+affecting the state visible to normal git programs.
+
+COMMANDS
+--------
+
+'capabilities'::
+	Prints the capabilities of the helper, one per line. These are:
+	 - import: the basic import command
+	 - marks: import should be done with a saved marks file
+	 - find-new-branches: detect new branches
+	 - export: the general export command
+	 - fork: create a new branch and export to it
+	 - anonymous-fork: make commits on a branch without an inherent name
+	 - merge: merge branches (of whatever type the system supports)
+
+	If the helper doesn't support "merge", the default for pull is
+	to rebase instead of merging.
+
+'list'::
+	Takes the remote name, and outputs the names of refs. These
+	may be followed, after a single space, by "changed" or
+	"unchanged", indicating whether the foreign repository has
+	changed from the state in the ref. If the helper doesn't know,
+	it doesn't have to provide a value. (In particular, it
+	shouldn't do expensive operations, such as importing the
+	content, to see whether it matches.)
+
+'import'::
+	Takes the remote name and a list of names of refs, and imports
+	whatever it describes, by outputting it in git-fast-import
+	format.
+
+'export'::
+	Sends the branch to the foreign system and reimports it in
+	fast-import format.
+
+	Reads a list of commits from stdin, where each commit has no
+	parents which were neither produced by an earlier import nor
+	appearing earlier in the list, where some commit has the old
+	value of the branch as a parent, and where all commits listed
+	are ancestors of the last one. Furthermore:
+
+	 - if the system doesn't support merges, each of these commits
+	   has only a single parent;
+
+	 - if the system doesn't support anonymous branches, the first
+	   commit has the old value of the branch as a parent (if the
+	   branch already had a value), and all parents are either the
+	   commit listed immediately before or produced by an earlier
+	   import;
+
+	 - if the system doesn't support many-way merges, each commit
+	   has at most two parents.
+
+	export produces output in fast-import format giving the
+	content after a round-trip through the foreign system. This
+	also contains extra headers to report the mapping of original
+	git commits to reimported git commits (to facilitate rewriting
+	local branches to use the history-as-reimported instead of the
+	git-only version).
+
+	export reports how much it managed to export by producing
+	commits in the fast-import stream that replace the listed
+	items that were successfully exported.
-- 
1.6.0.6
