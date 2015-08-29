From: Jeff King <peff@peff.net>
Subject: [PATCH v2] log: diagnose empty HEAD more clearly
Date: Sat, 29 Aug 2015 01:04:18 -0400
Message-ID: <20150829050418.GA23757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 07:04:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVYJm-0008OL-VI
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 07:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbH2FEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 01:04:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:51841 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751853AbbH2FEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 01:04:21 -0400
Received: (qmail 8422 invoked by uid 102); 29 Aug 2015 05:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Aug 2015 00:04:21 -0500
Received: (qmail 10360 invoked by uid 107); 29 Aug 2015 05:04:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Aug 2015 01:04:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Aug 2015 01:04:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276767>

On Fri, Aug 28, 2015 at 02:11:01PM -0700, Junio C Hamano wrote:

> * jk/log-missing-default-HEAD (2015-06-03) 1 commit
>  - log: diagnose empty HEAD more clearly
> 
>  "git init empty && git -C empty log" said "bad default revision 'HEAD'",
>  which was found to be a bit confusing to new users.
> 
>  What's the status of this one?

You and I both provided patches, and you queued mine, but I think there
was some question of whether the error messages were actually much
better. Here's a re-roll that tries to improve them by avoiding the word
"HEAD", which the user did not provide in the first place.

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
  fatal: your current branch 'master' does not have any commits yet

We also detect the case that 'HEAD' points to a broken ref;
this should be even less common, but is easy to see. Note
that we do not diagnose all possible cases. We rely on
resolve_ref, which means we do not get information about
complex cases. E.g., "--default master" would use dwim_ref
to find "refs/heads/master", but we notice only that
"master" does not exist. Similarly, a complex sha1
expression like "--default HEAD^2" will not resolve as a
ref.

But that's OK. We fall back to a generic error message in
those cases, and they are unlikely to be used anyway.
Catching an empty or broken "HEAD" improves the common case,
and the other cases are not regressed.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this doesn't take us any closer to a world where "git log" on
an empty HEAD silently exits with success (which your patch did). I
think it is somewhat orthogonal, though. If we wanted to do that we
would probably still die for a while (as your patch did), and it would
make sense to die using this diagnose function.

So I'd be happy if you wanted to resurrect yours on top, or squash them
together. But I do not really think it is worth dealing with the
compatibility surprises to make the change.

 revision.c     | 17 ++++++++++++++++-
 t/t4202-log.sh | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 5350139..af2a18e 100644
--- a/revision.c
+++ b/revision.c
@@ -2187,6 +2187,21 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	return 1;
 }
 
+static void NORETURN diagnose_missing_default(const char *def)
+{
+	unsigned char sha1[20];
+	int flags;
+	const char *refname;
+
+	refname = resolve_ref_unsafe(def, 0, sha1, &flags);
+	if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
+		die(_("your current branch appears to be broken"));
+
+	skip_prefix(refname, "refs/heads/", &refname);
+	die(_("your current branch '%s' does not have any commits yet"),
+	    refname);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -2316,7 +2331,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		struct object *object;
 		struct object_context oc;
 		if (get_sha1_with_context(revs->def, 0, sha1, &oc))
-			die("bad default revision '%s'", revs->def);
+			diagnose_missing_default(revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 35d2d7c..6ede069 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -894,4 +894,18 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
+test_expect_success 'log diagnoses bogus HEAD' '
+	git init empty &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_i18ngrep does.not.have.any.commits stderr &&
+	echo 1234abcd >empty/.git/refs/heads/master &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_i18ngrep broken stderr &&
+	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_i18ngrep broken stderr &&
+	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
+	test_i18ngrep broken stderr
+'
+
 test_done
-- 
2.5.1.739.g7891f6b
