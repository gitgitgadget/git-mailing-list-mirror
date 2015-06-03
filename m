From: Jeff King <peff@peff.net>
Subject: [PATCH] log: diagnose empty HEAD more clearly
Date: Wed, 3 Jun 2015 04:14:32 -0400
Message-ID: <20150603081432.GA32000@peff.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
 <20150603062005.GA20580@peff.net>
 <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 10:14:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z03p4-0006vv-9l
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbFCIOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 04:14:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:40279 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752713AbbFCIOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 04:14:36 -0400
Received: (qmail 12859 invoked by uid 102); 3 Jun 2015 08:14:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 03:14:36 -0500
Received: (qmail 17588 invoked by uid 107); 3 Jun 2015 08:14:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 04:14:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 04:14:32 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270663>

On Tue, Jun 02, 2015 at 11:48:30PM -0700, Junio C Hamano wrote:

> I am kind of surprised after reading these two threads that my
> take on this issue has changed over time, as my knee-jerk
> reaction before reading them was the opposite, something
> along the lines of "This is only immediately after 'git init'; why
> bother?". Or depending on my mood, that "How stupid do you
> have to be..." sounds exactly like a message I may advocate
> for us to send. Perhaps I grew more bitter with age.

I think it is one of those cases where the message makes sense when you
know how git works. But a new user who does not even know what "HEAD" or
a ref actually is may find it a bit confusing. Saying "we can't run
git-log, your repository empty!" may seem redundantly obvious even to
such a new user. But saying "bad revision 'HEAD'" may leave them saying
"eh, what is HEAD and why is it bad?".

> Jokes aside, I wonder why we did not pursue that "default to
> HEAD only when HEAD points at a branch that exists"
> approach, with the definition of "exists" being "either a file
> exists under the $GIT_DIR/refs/heads directory with any
> (including corrupt) contents, or an entry in the packed refs
> file exists with any (including corrupt) contents". With or
> without the error exit and warning, that sounds like a very
> sensible way to set the default, at least to me.

My concern there would be risk of regression. I.e., that we would take
some case which used to error out and turn it into a silent noop. So I'd
prefer to keep the behavior the same, and just modify the error code
path. The end result is pretty similar to the user, because we obviously
cannot produce any actual output either way.

Something like:

-- >8 --
Subject: log: diagnose empty HEAD more clearly

If you init or clone an empty repository, the initial
message from running "git log" is not very friendly:

  $ git init
  Initialized empty Git repository in /home/peff/foo/.git/
  $ git log
  fatal: bad default revision 'HEAD'

Let's detect this situation and write a more friendly
message:

  $ git log
  fatal: default revision 'HEAD' points to an unborn branch 'master'

We also detect the case that 'HEAD' points to a broken ref;
this should be even less common, but is easy to see. Note
that we do not diagnose all possible cases. We rely on
resolve_ref, which means we do not get information about
complex cases. E.g., "--default master" would use dwim_ref
to find "refs/heads/master", but we notice only that
"master" does not exist. Similarly, a complex sha1
expression like "--default HEAD^2" will not resolve as a
ref.

But that's OK. We fall back to the existing error message in
those cases, and they are unlikely to be used anyway.
Catching an empty or broken "HEAD" improves the common case,
and the other cases are not regressed.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not a big fan of the new error message, either, just because the
term "unborn" is also likely to be confusing to new users.

We can also probably get rid of mentioning "HEAD" completely. It is
always the default unless the user has overridden it explicitly. So we
could go with something like:

  fatal: your default branch 'master' does not contain any commits

or something. I dunno. Bikeshed colors welcome. Adding:

  advise("try running 'git commit'");

is probably too pedantic. ;)

 revision.c     | 19 ++++++++++++++++++-
 t/t4202-log.sh | 11 +++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddbaa0..775df8b 100644
--- a/revision.c
+++ b/revision.c
@@ -2170,6 +2170,23 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	return 1;
 }
 
+static void NORETURN diagnose_missing_default(const char *def)
+{
+	unsigned char sha1[20];
+	int flags;
+	const char *refname;
+
+	refname = resolve_ref_unsafe(def, 0, sha1, &flags);
+	if (!(flags & REF_ISSYMREF))
+		die(_("bad default revision '%s'"), def);
+	if (flags & REF_ISBROKEN)
+		die(_("default revision '%s' points to a broken branch"), def);
+
+	skip_prefix(refname, "refs/heads/", &refname);
+	die(_("default revision '%s' points to an unborn branch '%s'"),
+	    def, refname);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -2299,7 +2316,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object *object;
 		struct object_context oc;
 		if (get_sha1_with_context(revs->def, 0, sha1, &oc))
-			die("bad default revision '%s'", revs->def);
+			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..71d8326 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -871,4 +871,15 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
+test_expect_success 'log diagnoses bogus HEAD' '
+	git init empty &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_i18ngrep unborn stderr &&
+	echo 1234abcd >empty/.git/refs/heads/master &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_i18ngrep broken stderr &&
+	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
+	test_i18ngrep bad.default.revision stderr
+'
+
 test_done
-- 
2.4.2.745.g0aa058d
