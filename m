From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 16:31:38 -0500
Message-ID: <20100120213137.GA9107@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
 <20100120205452.GA8843@coredump.intra.peff.net>
 <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:31:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXi9Q-0005v3-HT
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab0ATVbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754348Ab0ATVbl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:31:41 -0500
Received: from peff.net ([208.65.91.99]:41638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab0ATVbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:31:40 -0500
Received: (qmail 10052 invoked by uid 107); 20 Jan 2010 21:36:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 16:36:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 16:31:38 -0500
Content-Disposition: inline
In-Reply-To: <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137585>

On Wed, Jan 20, 2010 at 12:59:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is splitting on blank lines an error? I don't think so. The original
> > format was never strictly defined, but given the --pretty=raw format, it
> > seems like a fairly obvious thing to do.
> >
> > I am inclined to cut the notes output from --pretty=raw, and let callers
> > ask for them explicitly with --show-notes or something similar. We can
> > leave them on by default in the "normal" output. This will still break
> > scripts doing "git log | ./script", but I don't think we have ever
> > condoned that practice.
> 
> Sounds like a plan.

We can start with this patch, which clears up Joey's problem.

-- >8 --
Subject: [PATCH] don't show notes for --pretty=raw

The --pretty=raw format of the log family is likely to be
used by scripts. Such scripts may parse the output into
records on blank lines, since doing so in the past has
always worked. However, with the recently added notes
output, such parsers will see an extra stanza for any
commits that have notes.

This patch turns off the notes output for the raw format to
avoid breaking such scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c         |    2 +-
 t/t3301-notes.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 9001379..0674027 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1094,7 +1094,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (fmt != CMIT_FMT_ONELINE)
+	if (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW)
 		get_commit_notes(commit, sb, encoding,
 				 NOTES_SHOW_HEADER | NOTES_INDENT);
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1e34f48..4c3de9d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -147,4 +147,18 @@ test_expect_success 'show -m and -F notes' '
 	test_cmp expect-m-and-F output
 '
 
+cat >expect << EOF
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+tree e070e3af51011e47b183c33adf9736736a525709
+parent 1584215f1d29c65e99c6c6848626553fdd07fd75
+author A U Thor <author@example.com> 1112912173 -0700
+committer C O Mitter <committer@example.com> 1112912173 -0700
+
+    4th
+EOF
+test_expect_success 'git log --pretty=raw does not show notes' '
+	git log -1 --pretty=raw >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.6.6.510.g159cf
