From: Jeff King <peff@peff.net>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 15:41:30 -0400
Message-ID: <20140523194129.GA19088@sigill.intra.peff.net>
References: <87ha4golck.fsf@osv.gnss.ru>
 <20140523105047.GA2249@serenity.lan>
 <87k39ck9r9.fsf@osv.gnss.ru>
 <20140523123503.GB726@sigill.intra.peff.net>
 <xmqqr43kju8o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergei Organov <osv@javad.com>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 21:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnvLV-0008Pt-21
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbaEWTld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 15:41:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:58298 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750936AbaEWTlc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 15:41:32 -0400
Received: (qmail 763 invoked by uid 102); 23 May 2014 19:41:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 14:41:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 15:41:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr43kju8o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250019>

On Fri, May 23, 2014 at 10:11:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One thing that this misses (as does your original script) is the
> > reflogs. Doing "branch -m" to rename a branch will actually move the
> > reflogs, too, but there is otherwise no way to access that
> > functionality.
> >
> > It does not seem unreasonable to teach "git update-ref" to do renames to
> > take advantage of this (it would be fairly simple; the logic is already
> > encapsulated internally in a rename_ref function).
> 
> Sounds sensible.

It's not much code to do the basics, and a patch is below. There are a
few open ends, though:

  1. There's no documentation (looking for where to put it, I feel like
     the manpage could stand to be reorganized a bit).

  2. It doesn't do anything with the --no-deref flag. I'm not sure what
     specifying a symref for either argument would/should do.

     As a side note, I also notice that you can specify --no-no-deref.
     Probably that option should be using PARSE_OPT_NONEG and offering
     "--deref" and "--no-deref" as opposites.

  3. Should it overwrite, or fail if the destination exists? "git
     branch" has a "-f" option, but we don't here.

  4. It doesn't implement rename for --stdin mode. Not strictly
     necessary, but it would be nice to keep that in sync with the
     regular command-line options.

This isn't really my itch to scratch, so I'm not all that inclined to
work on it more[1]. But without addressing 1 and 2, I'm not sure it's
really fit for inclusion. Maybe somebody wants to try to pick it up and
build on top?

-Peff

[1] Mostly when I say things like "it would be fairly simple", I wonder
    if I am being accurate, so I sometimes try to back it up with code.
    In this case the basics _are_ simple, but there are definitely some
    details to be worked out. So I was half-right. ;)

-- >8 --
Subject: teach update-ref a "--rename" option

You can rename a branch with "branch -m", but there is no
plumbing mechanism to rename an arbitrary ref. You can
simulate it with:

  git update-ref newname oldname &&
  git update-ref -d oldname

but that drops the reflog from oldname. This patch instead
allows:

  git update-ref --rename oldname newname

which copies the reflog.

Unlike "git branch -m", it does not munge the branch config
(since this plumbing command is purely about refs), nor does
it allow a missing "oldname" to mean an implicit HEAD
(because it is plumbing, and we are better to make the
caller be explicit than risk a surprise).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-ref.c  | 23 ++++++++++++++++++++++-
 t/t1400-update-ref.sh | 23 ++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5c208bb..ac97894 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -8,6 +8,7 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [options] -d <refname> [<oldval>]"),
 	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
+	N_("git update-ref [options] --rename <refname> <refname>"),
 	N_("git update-ref [options] --stdin [-z]"),
 	NULL
 };
@@ -19,6 +20,18 @@ static const struct ref_update **updates;
 static char line_termination = '\n';
 static int update_flags;
 
+static int do_rename_ref(const char *from, const char *to)
+{
+	struct strbuf msg = STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&msg, "update-ref: renamed %s to %s", from, to);
+	ret = rename_ref(from, to, msg.buf);
+	strbuf_release(&msg);
+
+	return !!ret;
+}
+
 static struct ref_update *update_alloc(void)
 {
 	struct ref_update *update;
@@ -251,9 +264,11 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	int rename = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
+		OPT_BOOL( 0 , "rename", &rename, N_("rename the reference")),
 		OPT_BOOL( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
@@ -268,7 +283,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		if (delete || no_deref || argc > 0)
+		if (delete || rename || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
@@ -279,6 +294,12 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
 
+	if (rename) {
+		if (delete || argc < 2 || argc > 2)
+			usage_with_options(git_update_ref_usage, options);
+		return do_rename_ref(argv[0], argv[1]);
+	}
+
 	if (delete) {
 		if (argc < 1 || argc > 2)
 			usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e130c52..c4008e8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -23,6 +23,7 @@ test_expect_success setup '
 m=refs/heads/master
 n_dir=refs/heads/gu
 n=$n_dir/fixes
+d=refs/heads/dst
 
 test_expect_success \
 	"create $m" \
@@ -255,8 +256,28 @@ test_expect_success \
 	 test '"$D"' = $(cat o) &&
 	 test "warning: Log .git/logs/'"$m unexpectedly ended on $ld"'." = "$(cat e)"'
 
+test_expect_success 'rename a ref' '
+	git rev-parse --verify $m >expect &&
 
-rm -f .git/$m .git/logs/$m expect
+	# set the date to match the reflog entries we created
+	# above, which do not follow test_tick; otherwise
+	# the we write an out-of-order entry into the reflog,
+	# which confuses the reflog parser
+	GIT_COMMITTER_DATE=$ld \
+	git update-ref --rename $m $d &&
+
+	test_must_fail git rev-parse --verify $m &&
+	git rev-parse --verify $d >o &&
+	test_cmp expect o
+'
+
+test_expect_success 'renames copy reflogs' '
+	echo "$C" >expect &&
+	git rev-parse --verify "$d@{2005-05-26 23:32:00}" >o &&
+	test_cmp expect o
+'
+
+rm -f .git/$m .git/logs/$m .git/$d .git/logs/$d expect
 
 test_expect_success \
     'creating initial files' \
-- 
2.0.0.rc1.436.g03cb729
