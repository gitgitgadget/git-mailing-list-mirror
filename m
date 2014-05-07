From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Tue, 6 May 2014 23:00:37 -0400
Message-ID: <20140507030037.GB20726@sigill.intra.peff.net>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <1399072451-15561-2-git-send-email-dturner@twopensource.com>
 <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
 <1399421211.11843.53.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 07 05:03:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whs99-0008QR-GM
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 05:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbaEGDAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 23:00:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:46406 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755110AbaEGDAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 23:00:39 -0400
Received: (qmail 31417 invoked by uid 102); 7 May 2014 03:00:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 22:00:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 23:00:37 -0400
Content-Disposition: inline
In-Reply-To: <1399421211.11843.53.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248279>

On Tue, May 06, 2014 at 05:06:51PM -0700, David Turner wrote:

> On Tue, 2014-05-06 at 15:24 -0700, Junio C Hamano wrote:
> > dturner@twopensource.com writes:
> > 
> > > From: David Turner <dturner@twitter.com>
> > >
> > > Signed-off-by: David Turner <dturner@twitter.com>
> > 
> > Ehh, why?
> 
> Briefly, because otherwise ./t7811-grep-open.sh fails when run under
> watchman.
> 
> This is actually something that I think I'm doing wrong, but I can't see
> what the sensible way to do it is.  When we go to write the fs_cache (in
> an atexit hook), we use get_fs_cache_file() from environment.c.  This is
> a relative path, because all of the other similar paths are.  So if we
> have chdired, then we fail.

It sounds like a reasonable code-hygiene thing, too. It looks like we
are only doing the chdir to impact the environment of the pager, and
affecting the global environment of the parent process is a side effect.
It happens not to cause problems now because we exit immediately, but
anybody who adds code after run_pager has to deal with it (and that is
basically what you are doing here). Something like cleaning up tempfiles
would be similarly affected.

That being said, this really seems like something that the run-command
interface should be doing, since it can handle the chdir in the forked
child. And indeed, it seems to support that.

Maybe:

-- >8 --
Subject: grep: use run-command's "dir" option for --open-files-in-pager

Git generally changes directory to the repository root on
startup.  When running "grep --open-files-in-pager" from a
subdirectory, we chdir back to the original directory before
running the pager, so that we can feed the relative
pathnames to the pager.

We currently do this chdir manually, but we can ask
run_command to do it for us. This is fewer lines of code,
and as a bonus, the chdir is limited to the child process,
which avoids any unexpected surprises for code running after
the pager (there isn't any currently, but this is
future-proofing).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 69ac2d8..43af5b7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -361,9 +361,7 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 		argv[i] = path_list->items[i].string;
 	argv[path_list->nr] = NULL;
 
-	if (prefix && chdir(prefix))
-		die(_("Failed to chdir: %s"), prefix);
-	status = run_command_v_opt(argv, RUN_USING_SHELL);
+	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, prefix, NULL);
 	if (status)
 		exit(status);
 	free(argv);
-- 
2.0.0.rc1.436.g03cb729
