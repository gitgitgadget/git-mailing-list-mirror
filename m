From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Delivery Status Notification (Failure)
Date: Sat, 6 Apr 2013 00:49:11 -0400
Message-ID: <20130406044911.GA26544@sigill.intra.peff.net>
References: <CAECh7fANnQDfSNHvOUH7AhyVNciypCKLXadY-jFxso4etCuvrg@mail.gmail.com>
 <047d7b3a85a201067604d9a948e8@google.com>
 <CAECh7fD6SKtfZudByeVD_HUjxN-fHBF1bA+pVM6=gV=Jy5Uhwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Drew Gross <drew.a.gross@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSM-0001b9-Rg
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855Ab3DFEtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 00:49:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58585 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab3DFEtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 00:49:20 -0400
Received: (qmail 21256 invoked by uid 107); 6 Apr 2013 04:51:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Apr 2013 00:51:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Apr 2013 00:49:11 -0400
Content-Disposition: inline
In-Reply-To: <CAECh7fD6SKtfZudByeVD_HUjxN-fHBF1bA+pVM6=gV=Jy5Uhwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220233>

On Sat, Apr 06, 2013 at 12:15:33AM -0400, Drew Gross wrote:

> I'm am trying to patch git to refuse to commit if there are both staged and
> unstaged changes, and I pass the -a flag. I expected this simple addition
> to parse_and_validate_options() in commit.c to accomplish most of what I
> want:
> 
> if (all && s->workdir_dirty)
>     die(_("Cannot commit with -a if there are staged and unstaged changes"));
> 
> But when compiled, this will commit anyway even with staged and unstaged
> files. I think I misunderstanding the workdir_dirty flag. Can someone help
> me?

I am not sure if that is a good safety measure in general. But
ignoring that question for a moment, there are a few issues with your
proposed implementation:

  1. workdir_dirty only talks about unstaged changes; it sounds like you
     want to check for both staged and unstaged.

  2. no flags in in the wt_status struct are set until wt_status_collect
     is called; you need to put your check later. But of course by the
     time we call it, we have already updated the index, so you would
     not know anymore which changes were already in the index and which
     were added by "-a".

  3. we do not always run wt_collect_status (e.g., if you are not going
     to run an editor, we do not bother going to the effort to create
     the commit template).

So you'd probably need something more like this:

diff --git a/builtin/commit.c b/builtin/commit.c
index 4620437..ebb5480 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1061,6 +1061,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (status_format != STATUS_FORMAT_NONE)
 		dry_run = 1;
 
+	wt_status_collect(s);
+	if (all && s->change.nr && s->workdir_dirty)
+		die("Cannot use '-a' with staged and unstaged changes");
+
 	return argc;
 }
 

Note that this may run the diff-index and diff-files procedures twice
(once here, and once later if we actually call run_status). If were
doing this for real (and I do not think it is something we want to take
upstream anyway), you would want to make sure that information was
cached.

-Peff
