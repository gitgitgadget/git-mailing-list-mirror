From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict
 for connectivity check
Date: Fri, 3 May 2013 14:09:38 +0700
Message-ID: <20130503070938.GA5239@duynguyen-vnpc.dek-tpc.internal>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-5-git-send-email-pclouds@gmail.com>
 <7vvc722s0h.fsf@alter.siamese.dyndns.org>
 <CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
 <7vvc711h4m.fsf@alter.siamese.dyndns.org>
 <CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
 <7vk3ngzi6o.fsf@alter.siamese.dyndns.org>
 <7vbo8szh4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 03 09:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYA7r-0000Xd-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 09:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761844Ab3ECHJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 03:09:47 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55983 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176Ab3ECHJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 03:09:46 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so778778pab.34
        for <git@vger.kernel.org>; Fri, 03 May 2013 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hPGcPQ+ghRQMAEMQIH9IdKSwrdlryp0d/gNv+zFvh4s=;
        b=SAR37POAPfs1GQrug5g2IisyRiNm/q1RBy6C5DbpEf++wys6b7Qcft0oGaUprXB1sS
         XcDMYBdjid9CKiaBFtDV2GiHdibqiirikk2GBFnle8bt4ZcisRv/S5Hafqq0eGttpElE
         8tO30PVlIScaiwZb9pIFuYmzx+vbn5UeUNa0GXcDoMOPZk4zAack2U0O8XYgHH9m6N5C
         OLqT3tXdAF8EK0M9JuvsC1FubFIO94DwQ8YVC6q1kx6WyLafk7ZjvXSwPoyRC8Qz3Irx
         r3vSwMsEGWhHs//kbOE5A7ghXsybcJWS+HmgONNCVEBbEFf9FOsmvn2QCFZMcUAmQCui
         /qqA==
X-Received: by 10.68.228.2 with SMTP id se2mr12606627pbc.76.1367564985918;
        Fri, 03 May 2013 00:09:45 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ov2sm10524889pbc.34.2013.05.03.00.09.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 00:09:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 03 May 2013 14:09:38 +0700
Content-Disposition: inline
In-Reply-To: <7vbo8szh4y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223292>

On Thu, May 02, 2013 at 11:55:57PM -0700, Junio C Hamano wrote:
> Let's illustrate.  Imagine your project as a whole has this history:

[snip]

OK I agree my approach is flawed. But if all these are met, we can be
sure the new refs are good, correct?

 - all refs point to an object in the pack
 - there are no dangling pointers in any object in the pack
 - all objects in the pack does not point to any objects outside the
   pack

We can check all these for the clone case with the patch below, even
if somehow we get some bad objects in the cloned repository before the
new pack arrives.

-- 8< --
Subject: [PATCH] clone: open a shortcut for connectivity check

In order to make sure the cloned repository is good, we run "rev-list
--objects --not --all $new_refs" on the repository. This is expensive
on large repositories. This patch attempts to mitigate the impact in
this special case.

In the "good" clone case, we only have one pack. If all of the
following are met, we can be sure that all objects reachable from the
new refs exist, which is the intention of running "rev-list ...":

 - all refs point to an object in the pack
 - there are no dangling pointers in any object in the pack
 - all objects in the pack does not point to objects outside the pack

The second and third checks can be done with the help of index-pack as
a slight modification of --strict check (which introduces a new
condition for the shortcut: pack transfer must be used and the number
of objects large enough to call index-pack). The first is checked in
check_everything_connected after we get an "ok" from index-pack.

"index-pack + new checks" is still faster than "index-pack + rev-list"
currently, which is the whole point of this patch. If any of the
conditions fails, we fall back to good old and expensive "rev-list
=2E.". In that case it's even more expensive because we have to pay for
the new checks in index-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-pack.txt |  3 +++
 builtin/clone.c                  | 11 ++++++++---
 builtin/index-pack.c             | 35 ++++++++++++++++++++++++++------=
---
 connected.c                      | 34 ++++++++++++++++++++++++++++++++=
+-
 connected.h                      |  5 +++++
 fetch-pack.c                     | 11 ++++++++++-
 fetch-pack.h                     |  4 +++-
 transport.c                      |  4 ++++
 transport.h                      |  2 ++
 9 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
index bde8eec..7a4e055 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -74,6 +74,9 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
=20
+--check-self-contained-and-connected::
+	Die if the pack contains broken links. For internal use only.
+
 --threads=3D<n>::
 	Specifies the number of threads to spawn when resolving
 	deltas. This requires that index-pack be compiled with
diff --git a/builtin/clone.c b/builtin/clone.c
index dad4265..427bec4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -542,13 +542,15 @@ static void update_remote_refs(const struct ref *=
refs,
 			       const struct ref *mapped_refs,
 			       const struct ref *remote_head_points_at,
 			       const char *branch_top,
-			       const char *msg)
+			       const char *msg,
+			       struct transport *transport)
 {
 	const struct ref *rm =3D mapped_refs;
=20
 	if (0 <=3D option_verbosity)
 		printf(_("Checking connectivity... "));
-	if (check_everything_connected(iterate_ref_map, 0, &rm))
+	if (check_everything_connected_with_transport(iterate_ref_map,
+						      0, &rm, transport))
 		die(_("remote did not send all necessary objects"));
 	if (0 <=3D option_verbosity)
 		printf(_("done\n"));
@@ -893,6 +895,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 					     option_upload_pack);
+
+		if (transport->smart_options)
+			transport->smart_options->check_self_contained_and_connected =3D 1;
 	}
=20
 	refs =3D transport_get_remote_refs(transport);
@@ -954,7 +959,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		transport_fetch_refs(transport, mapped_refs);
=20
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf);
+			   branch_top.buf, reflog_msg.buf, transport);
=20
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
=20
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1fd56d9..6aa7bb6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -77,8 +77,10 @@ static int nr_threads;
=20
 static int from_stdin;
 static int strict;
+static int do_fsck_object;
 static int verbose;
 static int show_stat;
+static int check_self_contained_and_connected;
=20
 static struct progress *progress;
=20
@@ -187,13 +189,13 @@ static int mark_link(struct object *obj, int type=
, void *data)
=20
 /* The content of each linked object must have been checked
    or it must be already present in the object database */
-static void check_object(struct object *obj)
+static unsigned check_object(struct object *obj)
 {
 	if (!obj)
-		return;
+		return 0;
=20
 	if (!(obj->flags & FLAG_LINK))
-		return;
+		return 0;
=20
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
@@ -201,17 +203,20 @@ static void check_object(struct object *obj)
 		if (type !=3D obj->type || type <=3D 0)
 			die(_("object of unexpected type"));
 		obj->flags |=3D FLAG_CHECKED;
-		return;
+		return 1;
 	}
+
+	return 0;
 }
=20
-static void check_objects(void)
+static unsigned check_objects(void)
 {
-	unsigned i, max;
+	unsigned i, max, foreign_nr;
=20
 	max =3D get_max_object_index();
 	for (i =3D 0; i < max; i++)
-		check_object(get_indexed_object(i));
+		foreign_nr +=3D check_object(get_indexed_object(i));
+	return foreign_nr;
 }
=20
=20
@@ -756,7 +761,8 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 			obj =3D parse_object_buffer(sha1, type, size, buf, &eaten);
 			if (!obj)
 				die(_("invalid %s"), typename(type));
-			if (fsck_object(obj, 1, fsck_error_function))
+			if (do_fsck_object &&
+			    fsck_object(obj, 1, fsck_error_function))
 				die(_("Error in object"));
 			if (fsck_walk(obj, mark_link, NULL))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(ob=
j->sha1));
@@ -1490,6 +1496,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
+	unsigned foreign_nr =3D 1;	/* zero is a "good" value, assume bad */
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
@@ -1511,6 +1518,10 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 				fix_thin_pack =3D 1;
 			} else if (!strcmp(arg, "--strict")) {
 				strict =3D 1;
+				do_fsck_object =3D 1;
+			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
+				strict =3D 1;
+				check_self_contained_and_connected =3D 1;
 			} else if (!strcmp(arg, "--verify")) {
 				verify =3D 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
@@ -1624,7 +1635,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
 	free(deltas);
 	if (strict)
-		check_objects();
+		foreign_nr =3D check_objects();
=20
 	if (show_stat)
 		show_pack_info(stat_only);
@@ -1650,5 +1661,11 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	if (index_name =3D=3D NULL)
 		free((void *) curr_index);
=20
+	/*
+	 * Let the caller know this pack is not self contained
+	 */
+	if (check_self_contained_and_connected && foreign_nr)
+		return 1;
+
 	return 0;
 }
diff --git a/connected.c b/connected.c
index 1e89c1c..fae8d64 100644
--- a/connected.c
+++ b/connected.c
@@ -2,7 +2,12 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
+#include "transport.h"
=20
+int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb=
_data)
+{
+	return check_everything_connected_with_transport(fn, quiet, cb_data, =
NULL);
+}
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -14,7 +19,10 @@
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb=
_data)
+int check_everything_connected_with_transport(sha1_iterate_fn fn,
+					      int quiet,
+					      void *cb_data,
+					      struct transport *transport)
 {
 	struct child_process rev_list;
 	const char *argv[] =3D {"rev-list", "--objects",
@@ -22,10 +30,23 @@ int check_everything_connected(sha1_iterate_fn fn, =
int quiet, void *cb_data)
 	char commit[41];
 	unsigned char sha1[20];
 	int err =3D 0;
+	struct packed_git *new_pack =3D NULL;
=20
 	if (fn(cb_data, sha1))
 		return err;
=20
+	if (transport && transport->smart_options &&
+	    transport->smart_options->self_contained_and_connected &&
+	    transport->pack_lockfile &&
+	    !suffixcmp(transport->pack_lockfile, ".keep")) {
+		struct strbuf idx_file =3D STRBUF_INIT;
+		strbuf_addstr(&idx_file, transport->pack_lockfile);
+		strbuf_setlen(&idx_file, idx_file.len - 5); /* ".keep" */
+		strbuf_addstr(&idx_file, ".idx");
+		new_pack =3D add_packed_git(idx_file.buf, idx_file.len, 1);
+		strbuf_release(&idx_file);
+	}
+
 	if (quiet)
 		argv[5] =3D "--quiet";
=20
@@ -42,6 +63,17 @@ int check_everything_connected(sha1_iterate_fn fn, i=
nt quiet, void *cb_data)
=20
 	commit[40] =3D '\n';
 	do {
+		/*
+		 * If index-pack already checked that:
+		 * - there are no dangling pointers in the new pack
+		 * - the pack is self contained
+		 * Then if the updated ref is in the new pack, then we
+		 * are sure the ref is good and not sending it to
+		 * rev-list for verification.
+		 */
+		if (new_pack && find_pack_entry_one(sha1, new_pack))
+			continue;
+
 		memcpy(commit, sha1_to_hex(sha1), 40);
 		if (write_in_full(rev_list.in, commit, 41) < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
diff --git a/connected.h b/connected.h
index 7e4585a..0b060b7 100644
--- a/connected.h
+++ b/connected.h
@@ -1,6 +1,8 @@
 #ifndef CONNECTED_H
 #define CONNECTED_H
=20
+struct transport;
+
 /*
  * Take callback data, and return next object name in the buffer.
  * When called after returning the name for the last object, return -1
@@ -16,5 +18,8 @@ typedef int (*sha1_iterate_fn)(void *, unsigned char =
[20]);
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  */
 extern int check_everything_connected(sha1_iterate_fn, int quiet, void=
 *cb_data);
+extern int check_everything_connected_with_transport(sha1_iterate_fn, =
int quiet,
+						     void *cb_data,
+						     struct transport *transport);
=20
 #endif /* CONNECTED_H */
diff --git a/fetch-pack.c b/fetch-pack.c
index 17cfa88..75c6f05 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -690,6 +690,7 @@ static int get_pack(struct fetch_pack_args *args,
 	const char **av;
 	int do_keep =3D args->keep_pack;
 	struct child_process cmd;
+	int ret;
=20
 	memset(&demux, 0, sizeof(demux));
 	if (use_sideband) {
@@ -741,11 +742,14 @@ static int get_pack(struct fetch_pack_args *args,
 				strcpy(keep_arg + s, "localhost");
 			*av++ =3D keep_arg;
 		}
+		if (args->check_self_contained_and_connected)
+			*av++ =3D "--check-self-contained-and-connected";
 	}
 	else {
 		*av++ =3D "unpack-objects";
 		if (args->quiet || args->no_progress)
 			*av++ =3D "-q";
+		args->check_self_contained_and_connected =3D 0;
 	}
 	if (*hdr_arg)
 		*av++ =3D hdr_arg;
@@ -766,7 +770,12 @@ static int get_pack(struct fetch_pack_args *args,
 		close(cmd.out);
 	}
=20
-	if (finish_command(&cmd))
+	ret =3D finish_command(&cmd);
+	if (!ret || (args->check_self_contained_and_connected && ret =3D=3D 1=
))
+		args->self_contained_and_connected =3D
+			args->check_self_contained_and_connected &&
+			ret =3D=3D 0;
+	else
 		die("%s failed", argv[0]);
 	if (use_sideband && finish_async(&demux))
 		die("error in sideband demultiplexer");
diff --git a/fetch-pack.h b/fetch-pack.h
index dc5266c..40f08ba 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,7 +16,9 @@ struct fetch_pack_args {
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		check_self_contained_and_connected:1,
+		self_contained_and_connected:1;
 };
=20
 /*
diff --git a/transport.c b/transport.c
index ba5d8af..359a671 100644
--- a/transport.c
+++ b/transport.c
@@ -534,6 +534,8 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.check_self_contained_and_connected =3D
+		data->options.check_self_contained_and_connected;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
@@ -551,6 +553,8 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 		refs =3D NULL;
 	data->conn =3D NULL;
 	data->got_remote_heads =3D 0;
+	data->options.self_contained_and_connected =3D
+		args.self_contained_and_connected;
=20
 	free_refs(refs_tmp);
=20
diff --git a/transport.h b/transport.h
index fcb1d25..4edebc5 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,8 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned check_self_contained_and_connected : 1;
+	unsigned self_contained_and_connected : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
--=20
1.8.2.82.gc24b958
-- 8< --
