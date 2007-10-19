From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 03:39:39 -0400
Message-ID: <20071019073938.GN14735@spearce.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 09:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IimSn-0000gr-KC
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 09:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289AbXJSHjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 03:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760471AbXJSHjr
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 03:39:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50914 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbXJSHjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 03:39:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IimSJ-0004Tf-BE; Fri, 19 Oct 2007 03:39:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 751AF20FBAE; Fri, 19 Oct 2007 03:39:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61664>

David Symonds <dsymonds@gmail.com> wrote:
> On 19/10/2007, Jeff King <peff@peff.net> wrote:
> > This makes the fetch output much more terse. It is likely to
> > be very controversial. Here's an example of the new output:
> >
> > Indexing objects: 100% (1061/1061), done.
> > Resolving deltas: 100% (638/638), done.
> > ==> git://repo.or.cz/git/spearce.git
> >  * branch gitk -> origin/gitk
> >  * branch maint -> origin/maint (fast forward)
> >  * branch master -> origin/master (fast forward)
> >  * branch next -> origin/next (fast forward)
> >  - branch pu -> origin/pu (non-fast forward, refused)
> >  * branch todo -> origin/todo (fast forward)
> > ==> git://repo.or.cz/git/spearce.git
> >  * tag v1.5.3.2 -> v1.5.3.2
> 
> What about making it even more terse so it's even easier to visually
> scan: (mainly thinking that fast-forwarding is so common it could be
> considered the "default")

What about this on top of Jeff's patch?

$ git fetch jc
...
==> git://repo.or.cz/alt-git.git
 * tag junio-gpg-pub ......................... (new)
 * tag v1.5.0 .......................... (tag moved)

$ git fetch me
...
==> git://repo.or.cz/git/spearce.git
 * branch gitk -> spearce/gitk ............... (new)
 * branch maint -> spearce/maint
 * branch master -> spearce/master
 * branch next -> spearce/next
 * branch pu -> spearce/pu ......... (forced update)
 * branch todo -> spearce/todo ............... (new)

The width of the terminal is computed to produce the ... padding.
I used a very narrow terminal to produce the above so it doesn't
linewrap badly in email.  If we cannot get the terminal width then
we just don't produce the padding.

We also only show the URL once now, and only if at least one ref
was somehow changed.  This way we avoid showing the URL on a no-op
or twice when we are fetching tags too.

--8>--
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 35fbfae..9d48f06 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -14,6 +14,7 @@ static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upl
 static int append, force, tags, no_tags, update_head_ok, verbose, quiet;
 static char *default_rla = NULL;
 static struct transport *transport;
+static int ws_cols, shown_url;
 
 static void unlock_pack(void)
 {
@@ -143,6 +144,50 @@ static int s_update_ref(const char *action,
 	return 0;
 }
 
+static void show_update(const char *status,
+		const char *remote_name,
+		const char *op,
+		const char *local_name,
+		const char *reason)
+{
+	if (!shown_url) {
+		fprintf(stderr, "==> %s\n", transport->url);
+		shown_url = 1;
+	}
+
+	fputc(' ', stderr);
+	fputs(status, stderr);
+
+	fputc(' ', stderr);
+	fputs(remote_name, stderr);
+
+	if (op) {
+		fputc(' ', stderr);
+		fputs(op, stderr);
+	}
+
+	if (local_name) {
+		fputc(' ', stderr);
+		fputs(local_name, stderr);
+	}
+
+	if (reason) {
+		if (ws_cols) {
+			size_t n = strlen(status) + strlen(remote_name) + 2;
+			if (op)
+				n += 1 + strlen(op);
+			if (local_name)
+				n += 1 + strlen(local_name);
+			n = ws_cols - n - strlen(reason) - 4;
+			fputc(' ', stderr);
+			while (n--)
+				fputc('.', stderr);
+		}
+		fprintf(stderr, " (%s)", reason);
+	}
+	fputc('\n', stderr);
+}
+
 static int update_local_ref(struct ref *ref,
 			    const char *note,
 			    int verbose)
@@ -164,14 +209,13 @@ static int update_local_ref(struct ref *ref,
 	if (!*ref->name) {
 		/* Not storing */
 		if (verbose)
-			fprintf(stderr, " * branch %s -> FETCH_HEAD\n", note);
+			show_update("* branch", note, "->", "FETCH_HEAD", NULL);
 		return 0;
 	}
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbose)
-			fprintf(stderr, " - %s == %s\n",
-				note, pretty_ref);
+			show_update("-", note, "==", pretty_ref, "unchanged");
 		return 0;
 	}
 
@@ -183,16 +227,14 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		fprintf(stderr,
-			" - %s: Cannot fetch into the current branch.\n",
-			pretty_ref);
+		show_update("-", pretty_ref, NULL, NULL,
+			"Cannot fetch into the current branch.");
 		return 1;
 	}
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		fprintf(stderr, " * tag %s -> %s\n",
-			note, pretty_ref);
+		show_update("* tag", note, NULL, NULL, "tag moved");
 		return s_update_ref("updating tag", ref, 0);
 	}
 
@@ -200,17 +242,13 @@ static int update_local_ref(struct ref *ref,
 	updated = lookup_commit_reference(ref->new_sha1);
 	if (!current || !updated) {
 		const char *msg;
-		const char *what;
 		if (!strncmp(ref->name, "refs/tags/", 10)) {
-			msg = "storing tag";
-			what = "tag";
-		}
-		else {
-			msg = "storing head";
-			what = "branch";
+			msg = "storing new tag";
+			show_update("* tag", note, NULL, NULL, "new");
+		} else {
+			msg = "storing new head";
+			show_update("* branch", note, "->", pretty_ref, "new");
 		}
-		fprintf(stderr, " * %s %s -> %s\n",
-			what, note, pretty_ref);
 		return s_update_ref(msg, ref, 0);
 	}
 
@@ -218,19 +256,14 @@ static int update_local_ref(struct ref *ref,
 	strcpy(newh, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 
 	if (in_merge_bases(current, &updated, 1)) {
-		fprintf(stderr, " * branch %s -> %s (fast forward)\n",
-			note, pretty_ref);
+		show_update("* branch", note, "->", pretty_ref, NULL);
 		return s_update_ref("fast forward", ref, 1);
 	}
 	if (!force && !ref->force) {
-		fprintf(stderr,
-			" - branch %s -> %s (non-fast forward, refused)\n",
-			note, pretty_ref);
+		show_update("- branch", note, "->", pretty_ref, "non-fast forward, refused");
 		return 1;
 	}
-	fprintf(stderr,
-		" * branch %s -> %s (non-fast forward)\n",
-		note, pretty_ref);
+	show_update("* branch", note, "->", pretty_ref, "forced update");
 	return s_update_ref("forced-update", ref, 1);
 }
 
@@ -243,8 +276,6 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 	const char *what, *kind;
 	struct ref *rm;
 
-	fprintf(stderr, "==> %s\n", url);
-
 	fp = fopen(git_path("FETCH_HEAD"), "a");
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
@@ -440,6 +471,13 @@ static void set_option(const char *name, const char *value)
 			name, transport->url);
 }
 
+static void determine_window_size(void)
+{
+	struct winsize ws;
+	if (!ioctl(2, TIOCGWINSZ, &ws))
+		ws_cols = ws.ws_col;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -565,6 +603,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		ref_nr = j;
 	}
 
+	determine_window_size();
 	signal(SIGINT, unlock_pack_on_signal);
 	atexit(unlock_pack);
 	return do_fetch(transport, parse_ref_spec(ref_nr, refs), ref_nr);
diff --git a/git-compat-util.h b/git-compat-util.h
index f23d934..e823aca 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -44,6 +44,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include <sys/types.h>
+#include <sys/ioctl.h>
 #include <dirent.h>
 #include <sys/time.h>
 #include <time.h>

-- 
Shawn.
