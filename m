From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Mon, 29 Oct 2012 18:35:21 -0400
Message-ID: <20121029223521.GJ20513@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
 <20121029060524.GB4457@sigill.intra.peff.net>
 <508EE4E4.1080407@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxwo-0001KV-KO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761078Ab2J2Wf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:35:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43157 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761051Ab2J2WfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:35:24 -0400
Received: (qmail 24867 invoked by uid 107); 29 Oct 2012 22:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 18:36:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 18:35:21 -0400
Content-Disposition: inline
In-Reply-To: <508EE4E4.1080407@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208653>

On Mon, Oct 29, 2012 at 09:19:48PM +0100, Peter Oberndorfer wrote:

> I could reproduce with my 0x3000 bytes file on linux. The buffer is not
> read with a trailing null byte it is mapped by mmap in
> diff_populate_filespec...
> So i think we will not get away with expecting a trailing null :-/

Thanks for the reproduction recipe. I was testing with "git log", which
does not use the mmap optimization.

> For me the key to reproduce the problem was to have 2 commits.
> Adding the file in the root commit it did not work. [1]

You probably would need to pass "--root" for it to do the diff of the
initial commit.

The patch below fixes it, but it's terribly inefficient (it just detects
the situation and reallocates). It would be much better to disable the
reuse_worktree_file mmap when we populate the filespec, but it is too
late to pass an option; we may have already populated from an earlier
diffcore stage.

I guess if we teach the whole diff code that "-G" (and --pickaxe-regex)
is brittle, we can disable the optimization from the beginning based on
the diff options. I'll take a look.

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b097fa7..88d1a8f 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -80,6 +80,29 @@ static void fill_one(struct diff_filespec *one,
 	if (DIFF_FILE_VALID(one)) {
 		*textconv = get_textconv(one);
 		mf->size = fill_textconv(*textconv, one, &mf->ptr);
+
+		/*
+		 * Horrible, horrible hack. If we are going to feed the result
+		 * to regexec, we must make sure it is NUL-terminated, but we
+		 * will not be if we have mmap'd a file and never munged it.
+		 *
+		 * We would do much better to turn off the reuse_worktree_file
+		 * optimization in the first place, which is the sole source of
+		 * these mmaps.
+		 */
+		if (one->should_munmap && !*textconv) { mf->ptr =
+			xmallocz(one->size); memcpy(mf->ptr, one->data,
+						    one->size);
+
+			/*
+			 * Attach the result to the filespec, which will
+			 * properly free it eventually.
+			 */
+			munmap(one->data, one->size);
+			one->should_munmap = 0;
+			one->data = mf->ptr;
+			one->should_free = 1;
+		}
 	} else {
 		memset(mf, 0, sizeof(*mf));
 	}
