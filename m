From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 12/28] clone: support remote shallow repository
Date: Thu,  5 Dec 2013 20:02:39 +0700
Message-ID: <1386248575-10206-13-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWm-000211-64
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab3LEM7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:32 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34137 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab3LEM7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:31 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so26037960pbc.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wVbe9vmTJwFsfM0ECzAeiUTgpKmgEiEciO1evGP7Zxs=;
        b=wkUJpgvQHnqcdlQqLozIuaRfIpJp+RYTkmEM6Q6E4kVwIJD/NSNA0DFiWsE25SkWCO
         f/JGU0Sg18WidoEbW0YNGNj4xbEdsER1ZWlT/CVakvrKmS0T4bho8VX/OnRNjCJDQ76d
         OykfdSWkHHlGVODMiDESsP97+uRmGUaKo1giqdi7g0P7itqpd87Bv/qQ3CPBAXEelMyk
         OMFX42L+D6UYyKPs9d7DG56X5KlVa0hJiOQSTeJ3jorTtecbAAZQmUdsXFvU/8c/+zqw
         wBSA6D151GGqRUt3DBU5RbAA7Pn+tZDRIlID4ZnoOPcpeRJguMmtMKbIpXkstxe0q50H
         9Hag==
X-Received: by 10.66.142.107 with SMTP id rv11mr89920706pab.17.1386248370567;
        Thu, 05 Dec 2013 04:59:30 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id e6sm37197860pbg.4.2013.12.05.04.59.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:14 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238868>

Cloning from a shallow repository does not follow the "8 steps for new
=2Egit/shallow" because if it does we need to get through step 6 for al=
l
refs. That means commit walking down to the bottom.

Instead the rule to create .git/shallow is simpler and, more
importantly, cheap: if a shallow commit is found in the pack, it's
probably used (i.e. reachable from some refs), so we add it. Others
are dropped.

One may notice this method seems flawed by the word "probably". A
shallow commit may not be reachable from any refs at all if it's
attached to an object island (a group of objects that are not
reachable by any refs).

If that object island is not complete, a new fetch request may send
more objects to connect it to some ref. At that time, because we
incorrectly installed the shallow commit in this island, the user will
not see anything after that commit (fsck is still ok). This is not
desired.

Given that object islands are rare (C Git never sends such islands for
security reasons) and do not really harm the repository integrity, a
tradeoff is made to surprise the user occasionally but work faster
everyday.

A new option --strict could be added later that follows exactly the 8
steps. "git prune" can also learn to remove dangling objects _and_ the
shallow commits that are attached to them from .git/shallow.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c      |  1 +
 builtin/fetch-pack.c |  2 +-
 fetch-pack.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 fetch-pack.h         |  4 ++++
 transport.c          | 11 ++++++++---
 transport.h          |  6 ++++++
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 900f564..0b182ce 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -889,6 +889,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	remote =3D remote_get(option_origin);
 	transport =3D transport_get(remote, remote->url[0]);
+	transport->cloning =3D 1;
=20
 	if (!transport->get_refs_list || (!is_local && !transport->fetch))
 		die(_("Don't know how to clone %s"), transport->url);
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c1d918f..927424b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,7 +153,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
=20
 	ref =3D fetch_pack(&args, fd, conn, ref, dest,
-			 sought, nr_sought, pack_lockfile_ptr);
+			 sought, nr_sought, NULL, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/fetch-pack.c b/fetch-pack.c
index 35d097e..e18a9fd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,6 +13,7 @@
 #include "transport.h"
 #include "version.h"
 #include "prio-queue.h"
+#include "sha1-array.h"
=20
 static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
@@ -774,6 +775,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
+				 struct shallow_info *si,
 				 char **pack_lockfile)
 {
 	struct ref *ref =3D copy_ref_list(orig_ref);
@@ -852,6 +854,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 	if (args->depth > 0)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
+	else if (args->cloning && si->shallow && si->shallow->nr)
+		alternate_shallow_file =3D setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
@@ -925,8 +929,11 @@ static int remove_duplicates_in_refs(struct ref **=
ref, int nr)
 	return dst;
 }
=20
-static void update_shallow(struct fetch_pack_args *args)
+static void update_shallow(struct fetch_pack_args *args,
+			   struct shallow_info *si)
 {
+	int i;
+
 	if (args->depth > 0 && alternate_shallow_file) {
 		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
 			unlink_or_warn(git_path("shallow"));
@@ -935,6 +942,42 @@ static void update_shallow(struct fetch_pack_args =
*args)
 			commit_lock_file(&shallow_lock);
 		return;
 	}
+
+	if (!si->shallow || !si->shallow->nr)
+		return;
+
+	if (alternate_shallow_file) {
+		/*
+		 * The temporary shallow file is only useful for
+		 * index-pack and unpack-objects because it may
+		 * contain more roots than we want. Delete it.
+		 */
+		if (*alternate_shallow_file)
+			unlink(alternate_shallow_file);
+		free((char*)alternate_shallow_file);
+	}
+
+	if (args->cloning) {
+		/*
+		 * remote is shallow, but this is a clone, there are
+		 * no objects in repo to worry about. Accept any
+		 * shallow points that exist in the pack (iow in repo
+		 * after get_pack() and reprepare_packed_git())
+		 */
+		struct sha1_array extra =3D SHA1_ARRAY_INIT;
+		unsigned char (*sha1)[20] =3D si->shallow->sha1;
+		for (i =3D 0; i < si->shallow->nr; i++)
+			if (has_sha1_file(sha1[i]))
+				sha1_array_append(&extra, sha1[i]);
+		if (extra.nr) {
+			setup_alternate_shallow(&shallow_lock,
+						&alternate_shallow_file,
+						&extra);
+			commit_lock_file(&shallow_lock);
+		}
+		sha1_array_clear(&extra);
+		return;
+	}
 }
=20
 struct ref *fetch_pack(struct fetch_pack_args *args,
@@ -942,9 +985,11 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 		       const struct ref *ref,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
+		       struct sha1_array *shallow,
 		       char **pack_lockfile)
 {
 	struct ref *ref_cpy;
+	struct shallow_info si;
=20
 	fetch_pack_setup();
 	if (nr_sought)
@@ -954,8 +999,11 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
-	update_shallow(args);
+	prepare_shallow_info(&si, shallow);
+	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
+				&si, pack_lockfile);
 	reprepare_packed_git();
+	update_shallow(args, &si);
+	clear_shallow_info(&si);
 	return ref_cpy;
 }
diff --git a/fetch-pack.h b/fetch-pack.h
index 9b08388..ce59537 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -4,6 +4,8 @@
 #include "string-list.h"
 #include "run-command.h"
=20
+struct sha1_array;
+
 struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
@@ -20,6 +22,7 @@ struct fetch_pack_args {
 	unsigned stateless_rpc:1;
 	unsigned check_self_contained_and_connected:1;
 	unsigned self_contained_and_connected:1;
+	unsigned cloning:1;
 };
=20
 /*
@@ -33,6 +36,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought,
 		       int nr_sought,
+		       struct sha1_array *shallow,
 		       char **pack_lockfile);
=20
 #endif
diff --git a/transport.c b/transport.c
index 90453df..91c4667 100644
--- a/transport.c
+++ b/transport.c
@@ -456,6 +456,7 @@ struct git_transport_data {
 	int fd[2];
 	unsigned got_remote_heads : 1;
 	struct sha1_array extra_have;
+	struct sha1_array shallow;
 };
=20
 static int set_git_option(struct git_transport_options *opts,
@@ -512,7 +513,9 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
=20
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
+			 for_push ? REF_NORMAL : 0,
+			 &data->extra_have,
+			 transport->cloning ? &data->shallow : NULL);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -539,17 +542,19 @@ static int fetch_refs_via_pack(struct transport *=
transport,
 	args.depth =3D data->options.depth;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
+	args.cloning =3D transport->cloning;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
-				 NULL, NULL);
+				 NULL,
+				 transport->cloning ? &data->shallow : NULL);
 		data->got_remote_heads =3D 1;
 	}
=20
 	refs =3D fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, to_fetch, nr_heads,
+			  dest, to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
diff --git a/transport.h b/transport.h
index b3679bb..59842d4 100644
--- a/transport.h
+++ b/transport.h
@@ -35,6 +35,12 @@ struct transport {
 	 */
 	unsigned cannot_reuse : 1;
=20
+	/*
+	 * A hint from caller that it will be performing a clone, not
+	 * normal fetch. IOW the repository is guaranteed empty.
+	 */
+	unsigned cloning : 1;
+
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
--=20
1.8.5.1.25.g8667982
