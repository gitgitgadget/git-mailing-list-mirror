From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Mon, 25 Jul 2011 23:14:12 -0600
Message-ID: <20110726051411.GB25046@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 07:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlZyJ-0000bm-FO
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 07:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab1GZFOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 01:14:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1GZFOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 01:14:16 -0400
Received: (qmail 16881 invoked by uid 107); 26 Jul 2011 05:14:45 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 01:14:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 23:14:12 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177841>

On Tue, Jul 26, 2011 at 10:03:31AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Jul 26, 2011 at 4:55 AM, Jeff King <peff@peff.net> wrote:
> > On Sun, Jul 24, 2011 at 12:11:29PM +0700, Nguyen Thai Ngoc Duy wrot=
e:
> >
> >> Can we have "git add--interactive --patch --match=3Dregex" where o=
nly
> >> (splitted if possible) hunks that match regex are shown?
> >
> > The patch below does this,
>=20
> Thanks!

So I did this as a quick "that should be really easy" proof of concept.
I'm not too interested personally in taking it all the way to an
acceptable patch.  I'm happy to help out with the perl parts, though, i=
f
you want to do the rest (C scaffolding for calling add--interactive,
tests, and docs).

> > =C2=A01. What does it mean to be "shown"? My patch auto-marks non-m=
atching
> > =C2=A0 =C2=A0 hunks as "do not stage". That means you can still swi=
tch back to
> > =C2=A0 =C2=A0 them in the hunk list and enable them if you want. An=
other option
> > =C2=A0 =C2=A0 would be to omit them entirely, and pretend that thos=
e hunks don't
> > =C2=A0 =C2=A0 exist.
>=20
> Either way is ok. Maybe the option in this case could be changed to
> --nostage=3Dregex to reflect the behavior.

I can't help but think there is some way to relate it to the
path-limiting that we do elsewhere. It's sort of like diffcore's "-G",
except that is about picking whole files, not individual hunks. I guess
most of git doesn't operate at the hunk level in quite the same way, so
there is no analagous part.

The more I think about it, it is probably simpler both conceptually and
in implementation to filter out those hunks entirely instead of marking
them used. The latter gives the user a chance to manually find them and
go back to them via 'J' and 'K'. But I find the chance that that is
useful to be much less than the chance that somebody gets confused or
annoyed by them being there (because they were iterating, or because
they did a "/" search).

And it's not like everything needs to be in a single "add" call. The
point of "add" is that you could call it multiple times, or even call
it, then check what "git diff" says, then decide you want to stage some
more.

> > =C2=A02. What should we do with non-text changes, like mode changes=
 are
> > =C2=A0 =C2=A0 full-file deletion?
>=20
> Probably invalid use case for --match.

Invalid, like we should have an error? I think that would be annoying,
because you want to be able to do "git add -p --match=3Dfoo" even when
there is an unrelated mode change. I think in the mindset of "this is a
filter for things you want to see", it probably makes sense to just
pretend they aren't there (and the user can always follow up with
another "add", as I mentioned above).

> > =C2=A03. What should be shown for a file with no matching hunks? Pr=
obably
> > =C2=A0 =C2=A0 nothing (i.e., as if it had been limited away by path=
name)? My
> > =C2=A0 =C2=A0 patch shows the header, but that is easy to fix.
>=20
> Printing "Nothing to add" would be nice.

If we treat it like path limiting, I think we could just print nothing
for that file. That is, doing:

  git add -p foo

would not even look at "bar" or print anything about it. Similarly:

  git add -p --match=3Dfoo

should probably say nothing whatsoever about files that didn't mention
foo at all.

=46or reference, here's the C scaffolding I used to test the patch I se=
nt
earlier. I didn't include it earlier because it made the perl bits hard
to find amidst all of the changes.

Probably the other interactive modes (checkout, reset, etc) should get =
a
similar option; it would just be a matter of passing the regex through
to the perl script.

---
diff --git a/builtin/add.c b/builtin/add.c
index 822ee3a..096dbc7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -220,20 +220,25 @@ static const char **validate_pathspec(int argc, c=
onst char **argv, const char *p
 }
=20
 int run_add_interactive(const char *revision, const char *patch_mode,
-			const char **pathspec)
+			const char *match, const char **pathspec)
 {
 	int status, ac, pc =3D 0;
 	const char **args;
+	struct strbuf match_arg =3D STRBUF_INIT;
=20
 	if (pathspec)
 		while (pathspec[pc])
 			pc++;
=20
-	args =3D xcalloc(sizeof(const char *), (pc + 5));
+	args =3D xcalloc(sizeof(const char *), (pc + 6));
 	ac =3D 0;
 	args[ac++] =3D "add--interactive";
 	if (patch_mode)
 		args[ac++] =3D patch_mode;
+	if (match) {
+		strbuf_addf(&match_arg, "--match=3D%s", match);
+		args[ac++] =3D match_arg.buf;
+	}
 	if (revision)
 		args[ac++] =3D revision;
 	args[ac++] =3D "--";
@@ -245,10 +250,12 @@ int run_add_interactive(const char *revision, con=
st char *patch_mode,
=20
 	status =3D run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
+	strbuf_release(&match_arg);
 	return status;
 }
=20
-int interactive_add(int argc, const char **argv, const char *prefix, i=
nt patch)
+int interactive_add(int argc, const char **argv, const char *prefix, i=
nt patch,
+		    const char *match)
 {
 	const char **pathspec =3D NULL;
=20
@@ -260,7 +267,7 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
=20
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
-				   pathspec);
+				   match, pathspec);
 }
=20
 static int edit_patch(int argc, const char **argv, const char *prefix)
@@ -317,6 +324,7 @@ N_("The following paths are ignored by one of your =
=2Egitignore files:\n");
=20
 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;
+static const char *patch_match;
=20
 static struct option builtin_add_options[] =3D {
 	OPT__DRY_RUN(&show_only, "dry run"),
@@ -324,6 +332,8 @@ static struct option builtin_add_options[] =3D {
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive pickin=
g"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "select hunks interacti=
vely"),
+	OPT_STRING(0, "match", &patch_match, "regex",
+		   "find pattern within --patch hunks"),
 	OPT_BOOLEAN('e', "edit", &edit_interactive, "edit current diff and ap=
ply"),
 	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked fi=
les"),
@@ -384,7 +394,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	if (patch_interactive)
 		add_interactive =3D 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive))=
;
+		exit(interactive_add(argc - 1, argv + 1, prefix,
+				     patch_interactive, patch_match));
=20
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d647a31..8319bb2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -765,7 +765,8 @@ static int git_checkout_config(const char *var, con=
st char *value, void *cb)
 static int interactive_checkout(const char *revision, const char **pat=
hspec,
 				struct checkout_opts *opts)
 {
-	return run_add_interactive(revision, "--patch=3Dcheckout", pathspec);
+	return run_add_interactive(revision, "--patch=3Dcheckout", NULL,
+				   pathspec);
 }
=20
 struct tracking_name_data {
diff --git a/builtin/commit.c b/builtin/commit.c
index e50694e..24d90a4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -366,7 +366,8 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		old_index_env =3D getenv(INDEX_ENVIRONMENT);
 		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
=20
-		if (interactive_add(argc, argv, prefix, patch_interactive) !=3D 0)
+		if (interactive_add(argc, argv, prefix, patch_interactive,
+				    NULL) !=3D 0)
 			die(_("interactive add failed"));
=20
 		if (old_index_env && *old_index_env)
diff --git a/builtin/reset.c b/builtin/reset.c
index 811e8e2..924c104 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -165,7 +165,7 @@ static int interactive_reset(const char *revision, =
const char **argv,
 	if (*argv)
 		pathspec =3D get_pathspec(prefix, argv);
=20
-	return run_add_interactive(revision, "--patch=3Dreset", pathspec);
+	return run_add_interactive(revision, "--patch=3Dreset", NULL, pathspe=
c);
 }
=20
 static int read_from_tree(const char *prefix, const char **argv,
diff --git a/commit.h b/commit.h
index b23f33b..5ab0072 100644
--- a/commit.h
+++ b/commit.h
@@ -167,9 +167,10 @@ extern struct commit_list *get_shallow_commits(str=
uct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
=20
-extern int interactive_add(int argc, const char **argv, const char *pr=
efix, int patch);
+extern int interactive_add(int argc, const char **argv, const char *pr=
efix,
+			   int patch, const char *match);
 extern int run_add_interactive(const char *revision, const char *patch=
_mode,
-			       const char **pathspec);
+			       const char *match, const char **pathspec);
=20
 static inline int single_parent(struct commit *commit)
 {
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 2ee0908..07896d4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -86,6 +86,7 @@ sub colored {
 # command line options
 my $patch_mode;
 my $patch_mode_revision;
+my $patch_match;
=20
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
@@ -1277,6 +1278,17 @@ sub display_hunks {
 	return $i;
 }
=20
+sub want_hunk {
+	my ($re, $hunk) =3D @_;
+
+	return 1 if $hunk->{TYPE} ne 'hunk';
+
+	foreach my $line (@{$hunk->{TEXT}}) {
+		return 1 if $line =3D~ $re;
+	}
+	return 0;
+}
+
 sub patch_update_file {
 	my $quit =3D 0;
 	my ($ix, $num);
@@ -1301,6 +1313,20 @@ sub patch_update_file {
 	$num =3D scalar @hunk;
 	$ix =3D 0;
=20
+	if ($patch_match) {
+		# mark non-matching text hunks as "do not want"
+		foreach my $hunk (@hunk) {
+			if (!want_hunk($patch_match, $hunk)) {
+				$hunk->{USE} =3D 0;
+			}
+		}
+		# and then advance us to the first undecided hunk
+		while ($ix < $num) {
+			last unless defined $hunk[$ix]{USE};
+			$ix++;
+		}
+	}
+
 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
 		$other =3D '';
@@ -1606,6 +1632,10 @@ sub process_args {
 		} else {
 			$patch_mode =3D 'stage';
 			$arg =3D shift @ARGV or die "missing --";
+			if ($arg =3D~ /--match=3D(.*)/) {
+				$patch_match =3D qr/$1/;
+				$arg =3D shift @ARGV or die "missing --";
+			}
 		}
 		die "invalid argument $arg, expecting --"
 		    unless $arg eq "--";
