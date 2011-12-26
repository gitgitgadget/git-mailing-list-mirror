From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Mon, 26 Dec 2011 11:51:52 -0400
Message-ID: <20111226155152.GA29582@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
 <7vlipz930t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 26 16:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfCqZ-0007yr-7U
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 16:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab1LZPwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 10:52:14 -0500
Received: from wren.kitenet.net ([80.68.85.49]:48531 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab1LZPwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 10:52:12 -0500
Received: from gnu.kitenet.net (dialup-4.153.8.110.Dial1.Atlanta1.Level3.net [4.153.8.110])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 12596119028;
	Mon, 26 Dec 2011 10:52:00 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id AAC6244992; Mon, 26 Dec 2011 10:51:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vlipz930t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187698>


--vGgW1X5XWziG23Ko
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Thanks. I do have a few comments.
>=20
> This hook is no longer a "post" fetch hook. The mechanism lets the object
> transfer phase does its work and then rewrites/tweaks the result before
> fetch completes. To an outside observer, what the hook does is an integral
> part of what "fetch" does, and not something that happens _after_ fetch
> completes. I am bad at naming things, but something along the lines of
> "tweak-fetch" that makes it clear that what happens in the hook is still
> part of the fetching may be a more appropriate name, methinks.

I'd be happy to call it tweak-fetch.

> I very much on purpose said that the hook "must read everything from its
> standard input, *and* *then* return..." in my response. Your "Demo" hook
> emits output as it reads its input with sed, but your main process invokes
> the hook, drains everything with write_in_full() before starting to read a
> single line, so I suspect that your hook will deadlock when its output
> pipe buffer fills up without being read by the main process. Of course,
> for this deadlock to actually happen, you need to be fetching quite a lot
> of refs.

Doesn't having the hook be fed by the async process/thread avoid this
problem? That's exactly why I did that, being familiar with the problem
=66rom stupid perl scripts like this one:

#!/usr/bin/perl
use FileHandle;
use IPC::Open2;
$pid =3D open2(*Reader, *Writer, "cat");
print Writer "stuff $_\n" for 1..100000; # blocks forever
close Writer;
print "got: $_" while <Reader>;

I've tested feeding large quantities of data through my demo hook
(just feed it all the lines repeated 100 thousand times) and have
not seen it block. And other code in git uses an async feeder similarly,
see for example convert.c's apply_filter(). So I think this is ok..?

> We seem to already have too many hook drivers, each of which hand-roll
> similar logic using run-command API. At some point, we would want to have
> a single "run_hook" helper function that takes:

This was also my feeling as I looked around the code.

> By formalizing the hook driver API that way, any hook driver that drives a
> tricky hook that may need a select(2) loop to avoid a deadlock in a way
> similar to your patch do would not have to worry about the issue, as the
> run_hook() helper would take care of it by reading from the hook's output
> pipe and drain the pipe by calling the "consumer" callback before calling
> the "generator" callback and feed more input to the hook to cause a
> deadlock.

Actually, run_hook would need to either have a select loop, or an async
feeder like I've used. The method you describe is itself prone to deadlock!
Consider a hook that *does* consume all its input before outputting anythin=
g.
The first call to the "consumer" callback would block.

>  - run a set of hooks on the same triggering condition. You may want to
>    have two "post-receive" hooks, one to feed an e-mail based notification
>    system and another to drive an autobuilder

Something I've always wanted, in fact..

> I have been wondering when would be the good time to refactor the hook
> driver API.  We can add your patch, after polishing it enough to make it
> ready for inclusion, independent of the hook API refactoring. But that
> would mean that it would require more work when refactoring the hook API,
> as we would have one more hand-rolled hook caller that is based on
> run_command().

On the other hand, I have uses for this hook that are blocked on it
getting into git, so would rather not see it hung up in a general
refactoring. If it helps, I'd be happy to help with a hook refactoring
later.

The latest version of my patch (attached) already lifts reading from the
hook out into a helper function, so should need not many changes in such
a refactoring -- most of my run_tweak_fetch_hook would simply go away
then. I've also cleaned it up a lot and and pretty happy with it now.

--=20
see shy jo

--5mCyUwZo2JvN/JJP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-preparations-for-tweak-fetch-hook.patch"
Content-Transfer-Encoding: quoted-printable

=46rom a06b5ef9908f56692a07fb37f5794c4122f10491 Mon Sep 17 00:00:00 2001
=46rom: Joey Hess <joey@kitenet.net>
Date: Mon, 26 Dec 2011 10:44:55 -0400
Subject: [PATCH 1/2] preparations for tweak-fetch hook

No behavior changes yet, only some groundwork for the next
change.

The refs_result structure combines a status code with a ref map,
which can be NULL even on success. This will be needed when
there's a tweak-fetch hook, because it can filter out all refs,
while still succeeding.

fetch_refs returns a refs_result, so that it can modify the ref_map.
---
 builtin/fetch.c |   54 +++++++++++++++++++++++++++++++++++----------------=
---
 1 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..70b9f89 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,11 @@ enum {
 	TAGS_SET =3D 2
 };
=20
+struct refs_result {
+	struct ref *new_refs;
+	int status;
+};
+
 static int all, append, dry_run, force, keep, multiple, prune, update_head=
_ok, verbosity;
 static int progress, recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
 static int tags =3D TAGS_DEFAULT;
@@ -89,6 +94,15 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_END()
 };
=20
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct string_list *list =3D (struct string_list *)cbdata;
+	struct string_list_item *item =3D string_list_insert(list, refname);
+	item->util =3D (void *)sha1;
+	return 0;
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -507,17 +521,24 @@ static int quickfetch(struct ref *ref_map)
 	return check_everything_connected(iterate_ref_map, 1, &rm);
 }
=20
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+static struct refs_result fetch_refs(struct transport *transport,
+		struct ref *ref_map)
 {
-	int ret =3D quickfetch(ref_map);
-	if (ret)
-		ret =3D transport_fetch_refs(transport, ref_map);
-	if (!ret)
-		ret |=3D store_updated_refs(transport->url,
+	struct refs_result res;
+	res.status =3D quickfetch(ref_map);
+	if (res.status)
+		res.status =3D transport_fetch_refs(transport, ref_map);
+	if (!res.status) {
+		res.new_refs =3D ref_map
+		res.status |=3D store_updated_refs(transport->url,
 				transport->remote->name,
-				ref_map);
+				res.new_refs);
+	}
+	else {
+		res.new_refs =3D ref_map;
+	}
 	transport_unlock_pack(transport);
-	return ret;
+	return res;
 }
=20
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref=
_map)
@@ -542,15 +563,6 @@ static int prune_refs(struct refspec *refs, int ref_co=
unt, struct ref *ref_map)
 	return result;
 }
=20
-static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
-{
-	struct string_list *list =3D (struct string_list *)cbdata;
-	struct string_list_item *item =3D string_list_insert(list, refname);
-	item->util =3D (void *)sha1;
-	return 0;
-}
-
 static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm =3D *head;
@@ -673,6 +685,7 @@ static int do_fetch(struct transport *transport,
 	struct string_list_item *peer_item =3D NULL;
 	struct ref *ref_map;
 	struct ref *rm;
+	struct refs_result res;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
=20
 	for_each_ref(add_existing, &existing_refs);
@@ -710,7 +723,9 @@ static int do_fetch(struct transport *transport,
=20
 	if (tags =3D=3D TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
-	if (fetch_refs(transport, ref_map)) {
+	res =3D fetch_refs(transport, ref_map);
+	ref_map =3D res.new_refs;
+	if (res.status) {
 		free_refs(ref_map);
 		return 1;
 	}
@@ -750,7 +765,8 @@ static int do_fetch(struct transport *transport,
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-			fetch_refs(transport, ref_map);
+			res =3D fetch_refs(transport, ref_map);
+			ref_map =3D res.new_refs;
 		}
 		free_refs(ref_map);
 	}
--=20
1.7.7.3


--5mCyUwZo2JvN/JJP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-add-tweak-fetch-hook.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 073b0921bb5988628e7af423924c410f522f403a Mon Sep 17 00:00:00 2001
=46rom: Joey Hess <joey@kitenet.net>
Date: Mon, 26 Dec 2011 10:53:27 -0400
Subject: [PATCH 2/2] add tweak-fetch hook

The tweak-fetch hook is fed lines on stdin for all refs that were fetched,
and outputs on stdout possibly modified lines. Its output is parsed and
used when git fetch updates the remote tracking refs, records the entries
in FETCH_HEAD, and produces its report.
---
 Documentation/githooks.txt |   29 +++++++
 builtin/fetch.c            |  191 ++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 219 insertions(+), 1 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..be2624c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -162,6 +162,35 @@ This hook can be used to perform repository validity c=
hecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+tweak-fetch
+~~~~~~~~~~
+
+This hook is invoked by 'git fetch' (commonly called by 'git pull'), after
+refs have been fetched from the remote repository. It is not executed, if
+nothing was fetched.
+
+The output of the hook is used to update the remote-tracking branches, and
+`.git/FETCH_HEAD`, in preparation for for a later merge operation done by
+'git merge'.
+
+It takes no arguments, but is fed a line of the following format on
+its standard input for each ref that was fetched.
+
+  <sha1> SP not-for-merge|merge SP <remote-refname> SP <local-refname> LF
+
+Where the "not-for-merge" flag indicates the ref is not to be merged into =
the
+current branch, and the "merge" flag indicates that 'git merge' should
+later merge it. The `<remote-refname>` is the remote's name for the ref
+that was pulled, and `<local-refname>` is a name of a remote-tracking bran=
ch,
+like "refs/remotes/origin/master", or can be empty if the fetched ref is n=
ot
+being stored in a local refname.
+
+The hook must consume all of its standard input, and output back lines
+of the same format. It can modify its input as desired, including
+adding or removing lines, updating the sha1 (i.e. re-point the
+remote-tracking branch), changing the merge flag, and changing the
+`<local-refname>` (i.e. use different remote-tracking branch).
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 70b9f89..5434b6f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,6 +103,194 @@ static int add_existing(const char *refname, const un=
signed char *sha1,
 	return 0;
 }
=20
+static const char tweak_fetch_hook[] =3D "tweak-fetch";
+
+int feed_tweak_fetch_hook (int in, int out, void *data)
+{
+	struct ref *ref;
+	struct strbuf buf =3D STRBUF_INIT;
+	int ret;
+
+	for (ref =3D data; ref; ref =3D ref->next) {
+		strbuf_addstr(&buf, sha1_to_hex(ref->old_sha1));
+		strbuf_addch(&buf, ' ');
+		strbuf_addstr(&buf, ref->merge ? "merge" : "not-for-merge");
+		strbuf_addch(&buf, ' ');
+		if (ref->name)
+			strbuf_addstr(&buf, ref->name);
+		strbuf_addch(&buf, ' ');
+		if (ref->peer_ref && ref->peer_ref->name)
+			strbuf_addstr(&buf, ref->peer_ref->name);
+		strbuf_addch(&buf, '\n');
+	}
+
+	ret =3D write_in_full(out, buf.buf, buf.len) !=3D buf.len;
+	if (ret)
+		warning("%s hook failed to consume all its input",
+				tweak_fetch_hook);
+	close(out);
+	strbuf_release(&buf);
+	return ret;
+}
+=09
+struct ref *parse_tweak_fetch_hook_line (char *l,=20
+		struct string_list *existing_refs)
+{
+	struct ref *ref =3D NULL, *peer_ref =3D NULL;
+	struct string_list_item *peer_item =3D NULL;
+	char *words[4];
+	int i, word=3D0;
+	char *problem;
+
+	for (i=3D0; l[i]; i++) {
+		if (isspace(l[i])) {
+			l[i]=3D'\0';
+			words[word]=3Dl;
+			l+=3Di+1;
+			i=3D0;
+			word++;
+			if (word > 3) {
+				problem=3D"too many words";
+				goto unparsable;
+			}
+		}
+	}
+	if (word < 3) {
+		problem=3D"not enough words";
+		goto unparsable;
+	}
+=09
+	ref =3D alloc_ref(words[2]);
+	peer_ref =3D ref->peer_ref =3D alloc_ref(l);
+	ref->peer_ref->force=3D1;
+
+	if (get_sha1_hex(words[0], ref->old_sha1)) {
+		problem=3D"bad sha1";
+		goto unparsable;
+	}
+
+	if (strcmp(words[1], "merge") =3D=3D 0) {
+		ref->merge=3D1;
+	}
+	else if (strcmp(words[1], "not-for-merge") !=3D 0) {
+		problem=3D"bad merge flag";
+		goto unparsable;
+	}
+
+	peer_item =3D string_list_lookup(existing_refs, peer_ref->name);
+	if (peer_item)
+		hashcpy(peer_ref->old_sha1, peer_item->util);
+
+	return ref;
+
+ unparsable:
+	warning("%s hook output a wrongly formed line: %s",
+			tweak_fetch_hook, problem);
+	free(ref);
+	free(peer_ref);
+	return NULL;
+}
+
+struct refs_result read_tweak_fetch_hook (int in) {
+	struct refs_result res;
+	FILE *f;
+	struct strbuf buf;
+	struct string_list existing_refs =3D STRING_LIST_INIT_NODUP;
+	struct ref *ref, *prevref=3DNULL;
+
+	res.status =3D 0;
+	res.new_refs =3D NULL;
+
+	f =3D fdopen(in, "r");
+	if (f =3D=3D NULL) {
+		res.status =3D 1;
+		return res;
+	}
+
+	strbuf_init(&buf, 128);
+	for_each_ref(add_existing, &existing_refs);
+
+	while (strbuf_getline(&buf, f, '\n') !=3D EOF) {
+		char *l =3D strbuf_detach(&buf, NULL);
+		ref =3D parse_tweak_fetch_hook_line(l, &existing_refs);
+		if (ref) {
+			if (prevref) {
+				prevref->next=3Dref;
+				prevref=3Dref;
+			}
+			else {
+				res.new_refs =3D prevref =3D ref;
+			}
+		}
+		else {
+			res.status =3D 1;
+		}
+		free(l);
+	}
+
+	string_list_clear(&existing_refs, 0);
+	strbuf_release(&buf);
+	fclose(f);
+	return res;
+}
+
+/* The hook is fed lines of the form:
+ * <sha1> SP <not-for-merge|merge> SP <remote-refname> SP <local-refname> =
LF
+ * And should output rewritten lines of the same form.
+ */
+struct ref *run_tweak_fetch_hook (struct ref *fetched_refs)
+{
+	struct child_process hook;
+	const char *argv[2];
+	struct async async;
+	struct refs_result res;
+
+	if (! fetched_refs)
+		return fetched_refs;
+
+	argv[0] =3D git_path("hooks/%s", tweak_fetch_hook);
+	if (access(argv[0], X_OK) < 0)
+		return fetched_refs;
+	argv[1] =3D NULL;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv =3D argv;
+	hook.in =3D -1;
+	hook.out =3D -1;
+	if (start_command(&hook))
+		return fetched_refs;
+
+	/* Use an async writer to feed the hook process.
+	 * This allows the hook to read and write a line at
+	 * a time without blocking. */
+	memset(&async, 0, sizeof(async));
+	async.proc =3D feed_tweak_fetch_hook;
+	async.data =3D fetched_refs;
+	async.out =3D hook.in;
+	if (start_async(&async)) {
+		close(hook.in);
+		close(hook.out);
+		finish_command(&hook);
+		return fetched_refs;
+	}
+	res =3D read_tweak_fetch_hook(hook.out);
+	res.status |=3D finish_async(&async);
+	res.status |=3D finish_command(&hook);
+
+	if (res.status) {
+		warning("%s hook failed, ignoring its output", tweak_fetch_hook);
+		free(res.new_refs);
+		return fetched_refs;
+	}
+	else {
+		/* The new_refs are returned, to be used in place of
+		 * fetched_refs, so it is not needed anymore and can
+		 * be freed here. */
+		free_refs(fetched_refs);
+		return res.new_refs;
+	}
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -529,7 +717,8 @@ static struct refs_result fetch_refs(struct transport *=
transport,
 	if (res.status)
 		res.status =3D transport_fetch_refs(transport, ref_map);
 	if (!res.status) {
-		res.new_refs =3D ref_map
+		res.new_refs =3D run_tweak_fetch_hook(ref_map);
+
 		res.status |=3D store_updated_refs(transport->url,
 				transport->remote->name,
 				res.new_refs);
--=20
1.7.7.3


--5mCyUwZo2JvN/JJP--

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTviYFMkQ2SIlEuPHAQjo0BAAgfLeKb/5/Bo2fDBXpf0fqVb3HIGxEMv8
rcUYkQhBHCAEN3zlI22IqYs5fMg832NJHhUSo/0Brz3u12duheKla9EHPGwaHGcQ
LRKbyLjh51o0kJnkG3izpjv2TLEwMilXmZiQSsNOiKP1SKFhfj3M16s1zUAQW5S3
LlP/2y/eIUI8NhCHyGvk+jgD/y0hBtj8ia18HcWNx/+4qNdojqTO7YRWDlf7E2kg
siuJtRuQlQXvBnnSz7lhBtMvTBGEUub+UvCLiuAHgoBJDcbmRHtOhtcKUKikwXqn
Sjm7VdyYEBzteOeGj4tc2BD1/i00FLWJ/O3QJhEYjKcYJtrOqvOm5VrNGZb6SIM+
FqeJU/iW5JtPFSETr6YPIW0HdeJBcQRzFQ4/IbxTsl0RpdmrlvxHf5McH0IRVE0W
GdajrnqrF48wTv5vShyaGyLWlxEzY9c1Caw5bRtDdXfoB0Rbgkg6H/jy6xe2+V8a
zTaGyN+Shrpx3RNZ5W/s+7qehW7gPK4hfe10djhSuITNUJtwWrI5CQ+XOhgjY/h7
OJlUskXI3yurWK7PpB8sLwALz8RODFPWwa67rzG3yeASLiL7/OdX4TfFLma1mTnr
U5HfHerceilmRkC0HFWbNRJs216IAVHYWXo8CPe2CBQFmMfjyPU2/CrJzcAqDiTR
AgL8y+VYA6Y=
=UZRp
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
