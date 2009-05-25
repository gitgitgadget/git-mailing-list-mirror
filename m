From: Jeff King <peff@peff.net>
Subject: Re: git merge remote branch says "Merge commit ..."?
Date: Mon, 25 May 2009 05:44:52 -0400
Message-ID: <20090525094452.GC22382@coredump.intra.peff.net>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <loom.20090522T172429-73@post.gmane.org> <20090522175401.GB11640@coredump.intra.peff.net> <200905222030.34301.j6t@kdbg.org> <20090523091711.GB20416@coredump.intra.peff.net> <7vljoo2mql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Eric Raible <raible@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:45:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Wjv-0006VY-Jt
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZEYJoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZEYJoy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:44:54 -0400
Received: from peff.net ([208.65.91.99]:50888 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbZEYJox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:44:53 -0400
Received: (qmail 2767 invoked by uid 107); 25 May 2009 09:44:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 05:44:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 05:44:52 -0400
Content-Disposition: inline
In-Reply-To: <7vljoo2mql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119909>

On Sat, May 23, 2009 at 02:26:58AM -0700, Junio C Hamano wrote:

> > Right. We could probably use similar logic in "git merge". I'm not sure
> > if it is worth the trouble to end up with "Merge branch 'master' of
> > origin" instead of "Merge remote branch 'origin/master'".
> 
> I do not think it is worth doing that to lose information, either.

So would you be in favor of this patch?

-- >8 --
Subject: [PATCH] merge: indicate remote tracking branches in merge message

Previously when merging directly from a local tracking
branch like:

  git merge origin/master

The merge message said:

   Merge commit 'origin/master'

     * commit 'origin/master':
       ...

Instead, let's be more explicit about what we are merging:

   Merge remote branch 'origin/master'

     * origin/master:
       ...

We accomplish this by recognizing remote tracking branches
in git-merge when we build the simulated FETCH_HEAD output
that we feed to fmt-merge-msg.

Signed-off-by: Jeff King <peff@peff.net>
---
This is not quite identical to the one I posted before; it adds the
magic "of ." at the end of the line, which matches how regular
non-remote branches are handled.

 builtin-merge.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..b6f60e9 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -378,6 +378,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		goto cleanup;
 	}
 
+	strbuf_setlen(&buf, 0);
+	strbuf_addstr(&buf, "refs/remotes/");
+	strbuf_addstr(&buf, remote);
+	resolve_ref(buf.buf, branch_head, 0, 0);
+
+	if (!hashcmp(remote_head->sha1, branch_head)) {
+		strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+				sha1_to_hex(branch_head), remote);
+		goto cleanup;
+	}
+
 	/* See if remote matches <name>^^^.. or <name>~<number> */
 	for (len = 0, ptr = remote + strlen(remote);
 	     remote < ptr && ptr[-1] == '^';
-- 
1.6.3.1.250.g01b8b.dirty
