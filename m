From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH] upload-pack: expand capability advertises additional
	refs
Date: Fri, 28 Aug 2009 10:30:07 -0700
Message-ID: <20090828173007.GX1033@spearce.org>
References: <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org> <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 19:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh5HG-0006O1-1P
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 19:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbZH1RaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbZH1RaI
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 13:30:08 -0400
Received: from george.spearce.org ([209.20.77.23]:40919 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZH1RaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 13:30:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 00E51381FD; Fri, 28 Aug 2009 17:30:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090826021057.GL1033@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127317>

The expand capability and associated command permits the client
to ask for information about refs which were not in the initial
advertisement sent when the connection was first opened.

In the below exchange the server initially only advertises its
current HEAD, refs/heads and refs/tags namespaces.  However,
the client has been instructed to fetch anything which matches
refs/remotes/jc/*.

Since no matching refs appeared in the initial advertisement,
the client requests the server to expand the desired pattern,
and terminates its expand request list with a flush.

Upon receiving a flush from the client, the server displays any
local refs which match any of the expand patterns requested,
and then closes this secondary advertisement list with a flush.
If no refs matched, the server immediately returns a flush.

If multiple expand patterns match the same ref, the ref is returned
only once in the secondary advertisement, avoid confusing the client
with duplicate results.

  S: 008f... HEAD\0...include-tag expand
  S: 0043... refs/heads/build-next
  S: 0040... refs/tags/v1.6.4.1
  S: 0043... refs/tags/v1.6.4.1^{}
  S: 0000

  C: 001dexpand refs/remotes/jc/*
  C: 0000

  S: 0043... refs/remotes/jc/maint
  S: 0044... refs/remotes/jc/master
  S: 0000

  C: 0031want ...
  C: 0000

Repository owners can control the set of refs which are sent as part
of the initial advertisement by configuring upload.advertise in the
repository configuration file.  If not set this is assumed to be
"refs/*", matching the prior behavior of advertising every local ref.

Fetch clients which are not using the anonymous git:// protocol
and which do not support the expand protocol extension may still
force the server to expand its configured upload.advertise set by
passing the --expand=<pattern> command line flag as part of the
--upload-pack= command line given to clone or fetch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Shawn O. Pearce <sop@google.com>
---

 This is roughly my final server side version of this proposal.
 I still need to write the client code, but want to at least get
 this out there for further discussion.

 Documentation/config.txt          |   10 +++
 Documentation/git-upload-pack.txt |   10 +++-
 upload-pack.c                     |  131 +++++++++++++++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..07907b6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1489,6 +1489,16 @@ transfer.unpackLimit::
 	not set, the value of this variable is used instead.
 	The default value is 100.
 
+upload.advertise::
+	The default set of refs to advertise when a fetch or
+	clone client connects to this repository.  Additional
+	local refs not in the default advertisement can still
+	be guessed and requested by clients through additional
+	network round trips.  Refs may be expressed as a complete
+	name ("refs/heads/master") or as a pattern expected by
+	remote.<name>.fetch (such as "refs/heads/*").  If not
+	specified, all refs are advertised ("refs/*").
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b8e49dc..4cd9cc0 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,7 +8,7 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 
 SYNOPSIS
 --------
-'git upload-pack' [--strict] [--timeout=<n>] <directory>
+'git upload-pack' [--strict] [--timeout=<n>] [--expand=<pattern> ...] <directory>
 
 DESCRIPTION
 -----------
@@ -30,6 +30,14 @@ OPTIONS
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
 
+--expand=<pattern>::
+	Expand the requested pattern and advertise matching refs,
+	even if those refs were not matched by upload.advertise.
+	This option may be repeated to request expansion of more
+	than one pattern.  This option is intended only as an
+	escape hatch for older clients to fetch from a server
+	which has hidden interesting refs.
+
 <directory>::
 	The repository to sync from.
 
diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..890c1c5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,8 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "remote.h"
+#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -30,6 +32,19 @@ static int multi_ack, nr_our_refs;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 static int shallow_nr;
+
+struct adv_ref {
+	struct adv_ref *next;
+	char *name;
+	unsigned pattern:1;
+};
+static struct adv_ref *to_advertise;
+static struct adv_ref **advertise_tail = &to_advertise;
+static int configured_advertise;
+
+static struct ref *local_refs;
+static struct ref **refs_tail = &local_refs;
+
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -470,6 +485,69 @@ static int get_common_commits(void)
 	}
 }
 
+static void push_advertise(const char *name)
+{
+	struct adv_ref *adv = xcalloc(1, sizeof(*adv));
+	adv->name = xstrdup(name);
+	adv->pattern = !!strchr(adv->name, '*');
+	*advertise_tail = adv;
+	advertise_tail = &adv->next;
+}
+
+static int upload_pack_config(const char *var, const char *value, void *cb)
+{
+	if (strcmp(var, "upload.advertise") == 0) {
+		configured_advertise = 1;
+		push_advertise(value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
+static int send_ref(struct string_list_item *item, void *cb_data);
+static void send_refs(void)
+{
+	struct ref *to_send = NULL, **tail = &to_send;
+	struct ref *ref;
+	struct adv_ref *adv, *next_adv;
+	struct string_list sorted_names;
+
+	for (adv = to_advertise; adv; adv = next_adv) {
+		struct refspec spec;
+
+		memset(&spec, 0, sizeof(spec));
+		spec.pattern = adv->pattern;
+		spec.src = adv->name;
+		spec.dst = adv->name;
+		next_adv = adv->next;
+		get_fetch_map(local_refs, &spec, &tail, 1);
+
+		free(adv->name);
+		free(adv);
+	}
+	to_advertise = NULL;
+	advertise_tail = &to_advertise;
+
+	/* We may have duplicate copies of the same ref above, if
+	 * two advertise records matched the same local name.  To
+	 * avoid sending the same ref twice to the client, we put
+	 * them into a sorted list and then skip duplicates as we
+	 * output them.
+	 */
+	memset(&sorted_names, 0, sizeof(sorted_names));
+	for (ref = to_send; ref; ref = ref->next)
+		string_list_append(ref->name, &sorted_names)->util = ref;
+	sort_string_list(&sorted_names);
+
+	ref = NULL;
+	for_each_string_list(send_ref, &sorted_names, &ref);
+
+	string_list_clear(&sorted_names, 0);
+	free_refs(to_send);
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = {0, 0, NULL};
@@ -484,11 +562,22 @@ static void receive_needs(void)
 		unsigned char sha1_buf[20];
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
-		if (!len)
+		if (!len) {
+			if (to_advertise) {
+				send_refs();
+				continue;
+			}
 			break;
+		}
 		if (debug_fd)
 			write_in_full(debug_fd, line, len);
 
+		if (!prefixcmp(line, "expand ")) {
+			if (line[len - 1] == '\n')
+				line[len - 1] = 0;
+			push_advertise(line + 7);
+			continue;
+		}
 		if (!prefixcmp(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
@@ -603,13 +692,22 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int send_ref(struct string_list_item *item, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag";
-	struct object *o = parse_object(sha1);
+		" include-tag expand";
+	struct ref **last_ref = cb_data;
+	struct ref *ref = item->util;
+	const char *refname = ref->name;
+	const unsigned char *sha1 = ref->new_sha1;
+	struct object *o;
+
+	if (*last_ref && !strcmp(refname, (*last_ref)->name))
+		return 0;
+	*last_ref = ref;
 
+	o = parse_object(sha1);
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
@@ -631,12 +729,26 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static int scan_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct ref *r = alloc_ref(refname);
+	hashcpy(r->new_sha1, sha1);
+	*refs_tail = r;
+	refs_tail = &r->next;
+	return 0;
+}
+
 static void upload_pack(void)
 {
+	git_config(upload_pack_config, NULL);
+	if (!configured_advertise)
+		push_advertise("refs/*");
+
+	head_ref(scan_ref, NULL);
+	for_each_ref(scan_ref, NULL);
+
 	reset_timeout();
-	head_ref(send_ref, NULL);
-	for_each_ref(send_ref, NULL);
-	packet_flush(1);
+	send_refs();
 	receive_needs();
 	if (want_obj.nr) {
 		get_common_commits();
@@ -652,6 +764,7 @@ int main(int argc, char **argv)
 
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs = 0;
+	push_advertise("HEAD");
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -667,6 +780,10 @@ int main(int argc, char **argv)
 			daemon_mode = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--expand=")) {
+			push_advertise(arg + 9);
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
-- 
1.6.4.1.341.gf2a44
