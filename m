From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/5] Draft of API for git-vcs-*, transport.c code to use
 it.
Date: Tue, 24 Mar 2009 23:04:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242303410.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRD-00061j-Ig
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236AbZCYDEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757167AbZCYDEV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:21 -0400
Received: from iabervon.org ([66.92.72.58]:43758 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbZCYDES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:18 -0400
Received: (qmail 11089 invoked by uid 1000); 25 Mar 2009 03:04:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:15 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114550>

---
 Documentation/git-vcs.txt |   93 ++++++++++++++++++++++++++++++++++++++
 transport.c               |  109 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+), 0 deletions(-)
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
diff --git a/transport.c b/transport.c
index 8a37db5..fe78169 100644
--- a/transport.c
+++ b/transport.c
@@ -916,6 +916,113 @@ static int disconnect_git(struct transport *transport)
 	return 0;
 }
 
+static int fetch_refs_via_foreign(struct transport *transport,
+				  int nr_heads, struct ref **to_fetch)
+{
+	struct remote *remote = transport->remote;
+	struct child_process importer;
+	struct child_process fastimport;
+	struct ref *posn;
+	int i, count;
+	struct strbuf buf;
+
+	memset(&importer, 0, sizeof(importer));
+	importer.in = 0;
+	importer.no_stdin = 1;
+	importer.out = -1;
+	importer.err = 0;
+	importer.argv = xcalloc(5 + nr_heads, sizeof(*importer.argv));
+	strbuf_init(&buf, 80);
+	strbuf_addf(&buf, "vcs-%s", remote->foreign_vcs);
+	importer.argv[0] = buf.buf;
+	importer.argv[1] = "import";
+	importer.argv[2] = remote->name;
+	count = 0;
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		importer.argv[3 + count] = posn->name;
+		count++;
+	}
+	importer.git_cmd = 1;
+	if (count) {
+		start_command(&importer);
+
+		memset(&fastimport, 0, sizeof(fastimport));
+		fastimport.in = importer.out;
+		fastimport.argv = xcalloc(3, sizeof(*fastimport.argv));
+		fastimport.argv[0] = "fast-import";
+		fastimport.argv[1] = "--quiet";
+		fastimport.git_cmd = 1;
+		start_command(&fastimport);
+
+		finish_command(&importer);
+		finish_command(&fastimport);
+	}
+	strbuf_release(&buf);
+	for (i = 0; i < nr_heads; i++) {
+		posn = to_fetch[i];
+		if (posn->status & REF_STATUS_UPTODATE)
+			continue;
+		read_ref(posn->name, posn->old_sha1);
+		count++;
+	}
+	return 0;
+}
+
+static struct ref *get_refs_via_foreign(struct transport *transport)
+{
+	struct remote *remote = transport->remote;
+	struct child_process importer;
+	struct ref *ret = NULL;
+	struct ref **end = &ret;
+	struct strbuf buf;
+	memset(&importer, 0, sizeof(importer));
+	importer.in = 0;
+	importer.no_stdin = 1;
+	importer.out = -1;
+	importer.err = 0;
+	importer.argv = xcalloc(5, sizeof(*importer.argv));
+	strbuf_init(&buf, 80);
+	strbuf_addf(&buf, "vcs-%s", remote->foreign_vcs);
+	importer.argv[0] = buf.buf;
+	importer.argv[1] = "list";
+	importer.argv[2] = remote->name;
+	importer.git_cmd = 1;
+	start_command(&importer);
+
+	strbuf_reset(&buf);
+	while (1) {
+		char *eol, *eon;
+		if (strbuf_read(&buf, importer.out, 80) <= 0)
+			break;
+		while (1) {
+			eol = strchr(buf.buf, '\n');
+			if (!eol)
+				break;
+			*eol = '\0';
+			eon = strchr(buf.buf, ' ');
+			if (eon)
+				*eon = '\0';
+			*end = alloc_ref(buf.buf);
+			if (eon) {
+				if (strstr(eon + 1, "unchanged")) {
+					(*end)->status |= REF_STATUS_UPTODATE;
+					if (read_ref((*end)->name, (*end)->old_sha1))
+						die("Unchanged?");
+				}
+			}
+			end = &((*end)->next);
+			strbuf_remove(&buf, 0, eol - buf.buf + 1);
+		}
+	}
+
+	finish_command(&importer);
+	strbuf_release(&buf);
+	return ret;
+}
+
 static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -940,6 +1047,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->url = url;
 
 	if (remote && remote->foreign_vcs) {
+		ret->get_refs_list = get_refs_via_foreign;
+		ret->fetch = fetch_refs_via_foreign;
 	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
-- 
1.6.2.1.476.g9bf04b
