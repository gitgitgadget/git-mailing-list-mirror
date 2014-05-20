From: Jeff King <peff@peff.net>
Subject: Re: format-patch crashes with a huge patchset
Date: Tue, 20 May 2014 02:49:20 -0400
Message-ID: <20140520064920.GB5222@sigill.intra.peff.net>
References: <20140519193556.GA987@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmdra-0002Bl-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 08:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbaETGtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 02:49:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:55542 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750699AbaETGtW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 02:49:22 -0400
Received: (qmail 9516 invoked by uid 102); 20 May 2014 06:49:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 May 2014 01:49:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2014 02:49:20 -0400
Content-Disposition: inline
In-Reply-To: <20140519193556.GA987@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249646>

On Mon, May 19, 2014 at 10:35:56PM +0300, Michael S. Tsirkin wrote:

> I tried to fump the whole history of qemu with format-patch.
> It crashes both with v2.0.0-rc2-21-g6087111
> and with git 1.8.3.1:
> 
> ~/opt/libexec/git-core/git-format-patch --follow -o patches/all
> e63c3dc74bfb90e4522d075d0d5a7600c5145745..

You can't use "--follow" without specifying a single pathspec. Running
"git log --follow" notices and blocks this, but format-patch doesn't
(and segfaults later when the follow code assumes there is a pathspec).

I think we need:

-- >8 --
Subject: move "--follow needs one pathspec" rule to diff_setup_done

Because of the way "--follow" is implemented, we must have
exactly one pathspec. "git log" enforces this restriction,
but other users of the revision traversal code do not. For
example, "git format-patch --follow" will segfault during
try_to_follow_renames, as we have no pathspecs at all.

We can push this check down into diff_setup_done, which is
probably a better place anyway. It is the diff code that
introduces this restriction, so other parts of the code
should not need to care themselves.

Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I didn't include a test, as I don't think the current behavior is what
we want in the long run. That is, it would be nice if eventually
--follow learned to be more flexible. Any test for this would
necessarily be looking for the opposite of that behavior. But maybe it's
worth it to just have in the meantime, and anyone who works on --follow
can rip out the test.

 builtin/log.c | 8 ++------
 diff.c        | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..3b6a6bb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -158,13 +158,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->show_notes)
 		init_display_notes(&rev->notes_opt);
 
-	if (rev->diffopt.pickaxe || rev->diffopt.filter)
+	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
+	    DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES))
 		rev->always_show_header = 0;
-	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
-		rev->always_show_header = 0;
-		if (rev->diffopt.pathspec.nr != 1)
-			usage("git logs can only follow renames on one pathname at a time");
-	}
 
 	if (source)
 		rev->show_source = 1;
diff --git a/diff.c b/diff.c
index f72769a..68bb8c5 100644
--- a/diff.c
+++ b/diff.c
@@ -3325,6 +3325,9 @@ void diff_setup_done(struct diff_options *options)
 	}
 
 	options->diff_path_counter = 0;
+
+	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
+		die(_("--follow requires exactly one pathspec"));
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
-- 
2.0.0.rc1.436.g03cb729
