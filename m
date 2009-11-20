From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] "log --stdin" updates
Date: Fri, 20 Nov 2009 09:40:30 -0500
Message-ID: <20091120144030.GB5419@coredump.intra.peff.net>
References: <1258716315-2213-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBUfC-0008Ko-Pf
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 15:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZKTOk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 09:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbZKTOk2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 09:40:28 -0500
Received: from peff.net ([208.65.91.99]:43400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbZKTOk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 09:40:27 -0500
Received: (qmail 25751 invoked by uid 107); 20 Nov 2009 14:44:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Nov 2009 09:44:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2009 09:40:30 -0500
Content-Disposition: inline
In-Reply-To: <1258716315-2213-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133349>

On Fri, Nov 20, 2009 at 03:25:12AM -0800, Junio C Hamano wrote:

> These three come on top of 61ab67a (Teach --stdin option to "log" family,
> 2009-11-03), which gave "--stdin" to the log family of commands (e.g. log,
> rev-list).  The earlier patch allowed you to feed only the revs (which was
> what gitk originally wanted), but after zero or more revs (one rev per
> line), you can now feed a line that consists of "--" and then pathspecs
> (one path per line).

This looks like a good API feature, though I am curious about the
missing "4/3" that was the motivation (of course, with a feature
like this, it may be for your out-of-git script, but as I said, I am
curious :) ). Is it a response to

  http://article.gmane.org/gmane.comp.version-control.git/133268

?

The implementation looks good from my cursory reading. Tests and docs
are of course missing. We don't seem to have any rev-list --stdin tests
already. Maybe even something as simple as:

  git rev-list HEAD -- file >expect &&
  (echo HEAD; echo --; echo file) | git rev-list --stdin >actual &&
  test_cmp expect actual

For docs, maybe squash this in (it mentions the pathspecs, but also
loosens --stdin to be available for "git log" and friends, which should
have been part of 61ab67a).

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bf66116..b44fdd9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -243,12 +243,14 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/remotes` are listed
 	on the command line as '<commit>'.
 
-ifdef::git-rev-list[]
 --stdin::
 
 	In addition to the '<commit>' listed on the command
-	line, read them from the standard input.
+	line, read them from the standard input. If a '--' separator is
+	seen, stop reading commits and start reading paths to limit the
+	result.
 
+ifdef::git-rev-list[]
 --quiet::
 
 	Don't print anything to standard output.  This form
