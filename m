From: Jeff King <peff@peff.net>
Subject: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 15:20:52 -0400
Message-ID: <20150514192052.GB9329@peff.net>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
 <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
 <20150514191637.GA9329@peff.net>
 <xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Coppens <alex@nativetouch.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 21:21:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysygm-0008QM-7x
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbbENTUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:20:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:58745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933340AbbENTUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:20:55 -0400
Received: (qmail 21035 invoked by uid 102); 14 May 2015 19:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 14:20:54 -0500
Received: (qmail 26619 invoked by uid 107); 14 May 2015 19:20:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 15:20:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 15:20:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269073>

On Thu, May 14, 2015 at 12:19:25PM -0700, Junio C Hamano wrote:

> > It looks like we need to pay more attention to the return value of
> > setup_rerere, which is what is supposed to take the lock.
> 
> Good spotting.  The normal rerere does check, but rerere-forget
> codepath seems to forget it.

Here's a patch.

-- >8 --
Subject: rerere: exit silently on "forget" when rerere is disabled

If you run "git rerere forget foo" in a repository that does
not have rerere enabled, git hits an internal error:

  $ git init -q
  $ git rerere forget foo
  fatal: BUG: attempt to commit unlocked object

The problem is that setup_rerere() will not actually take
the lock if the rerere system is disabled. We should notice
this and return early. We can return with a success code
here, because we know there is nothing to forget.

Signed-off-by: Jeff King <peff@peff.net>
---
 rerere.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rerere.c b/rerere.c
index 31644de..94aea9a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -659,6 +659,8 @@ int rerere_forget(struct pathspec *pathspec)
 		return error("Could not read index");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
+	if (fd < 0)
+		return 0;
 
 	unmerge_cache(pathspec);
 	find_conflict(&conflict);
-- 
2.4.1.396.g7ba6d7b
