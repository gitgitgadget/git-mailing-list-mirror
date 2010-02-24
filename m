From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 2/3] Different views on a repository
Date: Wed, 24 Feb 2010 16:57:29 +0100
Message-ID: <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de>
References: <cover.1267029680.git.agruen@suse.de>
	<f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 18:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKlC-0001kE-FM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab0BXRKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:10:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49404 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab0BXRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:10:26 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 624D28B45E
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:10:25 +0100 (CET)
In-Reply-To: <f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140958>

Add --view options in upload-pack and receive-pack so that a repository
on the server side can be made to look like several independent
repositories on the client side.

This is implemented by transforming ref names: for example, with
--view=one/, refs/heads/one/master on the server will look like
refs/heads/master to the client, refs/tags/one/v1 will look like
refs/tags/v1, etc.

This allows to transparently share repositories on the server which
have a lot of objects in common without complicating things for the
client, and without breaking garbage collection.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/git-receive-pack.txt |    8 +++++-
 Documentation/git-upload-pack.txt  |    9 ++++++-
 builtin-receive-pack.c             |   20 ++++++++++++++++
 refs.c                             |   44 ++++++++++++++++++++++++++++++++++++
 refs.h                             |    3 ++
 upload-pack.c                      |   11 +++++++++
 6 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2790eeb..09d7d0c 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -8,7 +8,7 @@ git-receive-pack - Receive what is pushed into the repository
 
 SYNOPSIS
 --------
-'git-receive-pack' <directory>
+'git-receive-pack' [--view=<prefix>] <directory>
 
 DESCRIPTION
 -----------
@@ -34,6 +34,12 @@ are not fast-forwards.
 
 OPTIONS
 -------
+--view=<prefix>::
+	Prepend <prefix> to all ref names.  For example, --view=one/ will
+	turn refs/tags/v1 into refs/tags/one/v1 on the receiving end.  Together
+	with the --view option of linkgit:git-upload-pack[1], this allows to
+	make one respository look like multiple independent repositories.
+
 <directory>::
 	The repository to sync into.
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 71ca4ef..0eee0ba 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,7 +8,7 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 
 SYNOPSIS
 --------
-'git-upload-pack' [--strict] [--timeout=<n>] <directory>
+'git-upload-pack' [--strict] [--timeout=<n>] [--view=<prefix>] <directory>
 
 DESCRIPTION
 -----------
@@ -30,6 +30,13 @@ OPTIONS
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
 
+--view=<prefix>::
+	Only upload refs which start with <prefix>, and hide <prefix> from the
+	remote side.  For example, --view=one/ will skip refs/heads/master
+	and turn refs/tags/one/v1 into refs/tags/v1.  Together with the --view
+	option of linkgit:git-receive-pack, this allows to make one respository
+	look like multiple independent repositories.
+
 <directory>::
 	The repository to sync from.
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 77cbc2a..44d7055 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -32,6 +32,7 @@ static int use_sideband;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
+static const char *view;
 static const char *head_name;
 static int sent_capabilities;
 
@@ -107,6 +108,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
+	if (view) {
+		refname = ref_to_view(refname, view);
+		if (!refname)
+			return 0;
+	}
+
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
 	else
@@ -548,6 +555,15 @@ static void read_head_info(void)
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 		}
+		if (view) {
+			const char *r;
+
+			r = view_to_ref(refname, view);
+			if (r) {
+				refname = r;
+				reflen = strlen(refname);
+			}
+		}
 		cmd = xmalloc(sizeof(struct command) + reflen + 1);
 		hashcpy(cmd->old_sha1, old_sha1);
 		hashcpy(cmd->new_sha1, new_sha1);
@@ -736,6 +752,10 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				stateless_rpc = 1;
 				continue;
 			}
+			if (!prefixcmp(arg, "--view=")) {
+				view = arg + 7;
+				continue;
+			}
 
 			usage(receive_pack_usage);
 		}
diff --git a/refs.c b/refs.c
index f3fcbe0..b1f3951 100644
--- a/refs.c
+++ b/refs.c
@@ -1829,3 +1829,47 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 	free(short_name);
 	return xstrdup(ref);
 }
+
+const char *ref_to_view(const char *refname, const char *view)
+{
+	static char *buffer;
+	int prefix_len, view_len, suffix_len;
+	const char *r, *suffix;
+
+	if (prefixcmp(refname, "refs/"))
+		return NULL;
+	r = strchr(refname + 5, '/');
+	if (!r)
+		return NULL;
+	r++;
+	view_len = strlen(view);
+	if (strncmp(r, view, view_len))
+		return NULL;
+	suffix = r + view_len;
+	prefix_len = r - refname;
+	suffix_len = strlen(suffix);
+	buffer = xrealloc(buffer, prefix_len + suffix_len + 1);
+	sprintf(buffer, "%.*s%s", prefix_len, refname, suffix);
+	return buffer;
+}
+
+const char *view_to_ref(const char *refname, const char *view)
+{
+	static char *buffer;
+	int prefix_len, view_len, suffix_len;
+	const char *r, *suffix;
+
+	view_len = strlen(view);
+	if (prefixcmp(refname, "refs/"))
+		return NULL;
+	r = strchr(refname + 5, '/');
+	if (!r)
+		return NULL;
+	r++;
+	prefix_len = r - refname;
+	suffix = r + view_len;
+	suffix_len = strlen(suffix);
+	buffer = xrealloc(buffer, prefix_len + view_len + suffix_len + 1);
+	sprintf(buffer, "%.*s%s%s", prefix_len, refname, view, suffix);
+	return buffer;
+}
diff --git a/refs.h b/refs.h
index f7648b9..390e812 100644
--- a/refs.h
+++ b/refs.h
@@ -98,4 +98,7 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+extern const char *ref_to_view(const char *refname, const char *view);
+extern const char *view_to_ref(const char *refname, const char *view);
+
 #endif /* REFS_H */
diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..bc72471 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -34,6 +34,7 @@ static struct object_array have_obj;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
+static const char *view;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
  */
@@ -629,6 +630,12 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
+	if (view) {
+		refname = ref_to_view(refname, view);
+		if (!refname)
+			return 0;
+	}
+
 	if (capabilities)
 		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
 			0, capabilities);
@@ -711,6 +718,10 @@ int main(int argc, char **argv)
 			daemon_mode = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--view=")) {
+			view = arg + 7;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
-- 
1.6.6.243.gff6d2
