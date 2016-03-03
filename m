From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index-pack: --clone-bundle option
Date: Thu, 03 Mar 2016 14:57:08 -0800
Message-ID: <xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
	<xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
	<20160303222902.GB26712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 23:57:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abcBN-0007yp-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 23:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbcCCW5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 17:57:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756944AbcCCW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 17:57:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEC9B49CF2;
	Thu,  3 Mar 2016 17:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KEmUXOYQ0HSid7qCm7etH6nbv30=; b=biq64V
	JrOpTC/LX2nBWBJzGiEkgIfiXUG3yXzQXV1vvdJlYWNsZSc4pOvSlMX99AoU4buo
	jL4Enujg46BwqbrF8seWrnVhvTjqwLUEzk2ce6ootg95GaosXTAJXIt5NnsYLN8l
	Nqdvklo3QWK4sm5Fi7dhpQXg5/HfjwEZ+n+9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/vTs30j5ydWBDXdRUIQ6hkKdti/Nprf
	/MyugkEchKrNxMzg2BgfzyG8mvI9k0O77ZSzIjx0Fyi3t5aKX8pFW+I7RV5sAnQi
	z7CjR55TnTWNu4RtZXVUWo23i8WmsMfMe7q/8kKtv6+cta+MA4q59y+nJEjzzRsY
	jUJj0uEFO+U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A768049CF1;
	Thu,  3 Mar 2016 17:57:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 11F9149CED;
	Thu,  3 Mar 2016 17:57:10 -0500 (EST)
In-Reply-To: <20160303222902.GB26712@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 3 Mar 2016 17:29:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42BE58C2-E193-11E5-B87C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288222>

Teach a new option "--clone-bundle" to "git index-pack" to create a
split bundle file that uses an existing packfile as its data part.

The expected "typical" preparation for helping initial clone would
start by preparing a packfile that contains most of the history and
add another packfile that contains the remainder (e.g. the objects
that are only reachable from reflog entries).  The first pack can
then be used as the data part of a split bundle and these two files
can be served as static files to bootstrap the clients without
incurring any more CPU cycles to the server side.

Among the objects in the packfile, the ones that are not referenced
by no other objects are identified and recorded as the "references"
in the resulting bundle.  As the packfile does not record any ref
information, however, the names of the "references" recorded in the
bundle need to be synthesized; we arbitrarily choose to record the
object whose name is $SHA1 as refs/objects/$SHA1.

Note that this name choice does not matter very much in the larger
picture.  As an initial clone that bootstraps from a clone-bundle is
expected to do a rough equivalent of:

    # create a new repository
    git init new-repository &&
    git remote add origin $URL &&

    # prime the object store and anchor the history to temporary
    # references
    git fetch $bundle 'refs/*:refs/temporary/*' &&

    # fetch the more recent history from the true origin
    git fetch origin &&
    git checkout -f &&

    # remove the temporary refs
    git for-each-ref -z --format=%(refname) refs/temporary/ |
    xargs -0 git update-ref -d

the names recorded in the bundle will not really matter to the end
result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The upcoming "another one" looks like this.

 Documentation/git-index-pack.txt | 10 ++++++-
 builtin/index-pack.c             | 57 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..ade2812 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -9,7 +9,7 @@ git-index-pack - Build pack index file for an existing packed archive
 SYNOPSIS
 --------
 [verse]
-'git index-pack' [-v] [-o <index-file>] <pack-file>
+'git index-pack' [-v] [-o <index-file>] [--clone-bundle] <pack-file>
 'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
                  [<pack-file>]
 
@@ -35,6 +35,14 @@ OPTIONS
 	fails if the name of packed archive does not end
 	with .pack).
 
+--clone-bundle::
+	Write a split bundle file that uses the <pack-file> as its
+	data.  The <pack-file> must not contain any broken links, or
+	the bundle file will not be written.  The prerequisite list
+	of the resulting bundle will be empty.  The reference list
+	of the resulting bundle points at tips of the history in the
+	<pack-file>.
+
 --stdin::
 	When this flag is provided, the pack is read from stdin
 	instead and a copy is then written to <pack-file>. If
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a5588a2..8fc04b0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -13,7 +13,7 @@
 #include "thread-utils.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] [--clone-bundle] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -1373,9 +1373,40 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	free(sorted_by_pos);
 }
 
+static void write_bundle_file(const char *filename, unsigned char *sha1,
+			      const char *packname)
+{
+	int fd = open(filename, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	struct strbuf buf = STRBUF_INIT;
+	struct stat st;
+	int i;
+
+	if (stat(packname, &st))
+		die(_("cannot stat %s"), packname);
+
+	strbuf_addstr(&buf, "# v3 git bundle\n");
+	strbuf_addf(&buf, "size: %lu\n", (unsigned long) st.st_size);
+	strbuf_addf(&buf, "sha1: %s\n", sha1_to_hex(sha1));
+	strbuf_addf(&buf, "data: %s\n\n", packname);
+
+	for (i = 0; i < nr_objects; i++) {
+		struct object *o = lookup_object(objects[i].idx.sha1);
+		if (!o || (o->flags & FLAG_LINK))
+			continue;
+		strbuf_addf(&buf, "%s refs/objects/%s\n",
+			    sha1_to_hex(o->oid.hash),
+			    sha1_to_hex(o->oid.hash));
+	}
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+		die(_("cannot write bundle header for %s"), packname);
+	close(fd);
+	strbuf_release(&buf);
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *keep_name, const char *keep_msg,
+		  const char *bundle_name, int foreign_nr,
 		  unsigned char *sha1)
 {
 	const char *report = "pack";
@@ -1457,6 +1488,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			input_offset += err;
 		}
 	}
+
+	if (bundle_name) {
+		if (foreign_nr)
+			warning(_("not writing bundle for an incomplete pack"));
+		else
+			write_bundle_file(bundle_name, sha1, final_pack_name);
+	}
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
@@ -1612,12 +1650,14 @@ static const char *derive_filename(const char *pack_name, const char *suffix,
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
+	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, clone_bundle = 0;
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
-	struct strbuf index_name_buf = STRBUF_INIT,
-		      keep_name_buf = STRBUF_INIT;
+	const char *bundle_name = NULL;
+	struct strbuf index_name_buf = STRBUF_INIT;
+	struct strbuf keep_name_buf = STRBUF_INIT;
+	struct strbuf bundle_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1661,6 +1701,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verify = 1;
 				show_stat = 1;
 				stat_only = 1;
+			} else if (!strcmp(arg, "--clone-bundle")) {
+				strict = 1;
+				clone_bundle = 1;
+				check_self_contained_and_connected = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
 			} else if (starts_with(arg, "--keep=")) {
@@ -1718,10 +1762,14 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("--fix-thin cannot be used without --stdin"));
+	if (clone_bundle && from_stdin)
+		die(_("--clone-bundle cannot be used with --stdin"));
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
 	if (keep_msg && !keep_name && pack_name)
 		keep_name = derive_filename(pack_name, ".keep", &keep_name_buf);
+	if (clone_bundle)
+		bundle_name = derive_filename(pack_name, ".bndl", &bundle_name_buf);
 
 	if (verify) {
 		if (!index_name)
@@ -1768,6 +1816,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
 		      keep_name, keep_msg,
+		      bundle_name, foreign_nr,
 		      pack_sha1);
 	else
 		close(input_fd);
-- 
2.8.0-rc0-133-g6d295b5
