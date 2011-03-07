From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] documentation fix: git log -p does not imply -c.
Date: Mon, 7 Mar 2011 14:12:18 -0500
Message-ID: <20110307191218.GA20930@sigill.intra.peff.net>
References: <4D724A0F.7050904@gmail.com>
 <1299355004-3532-2-git-send-email-haircut@gmail.com>
 <7vbp1n4vhv.fsf@alter.siamese.dyndns.org>
 <20110307154712.GA11934@sigill.intra.peff.net>
 <7vtyfe22vy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 20:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwfr6-0000vH-Ao
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 20:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab1CGTMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 14:12:25 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58676 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781Ab1CGTMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 14:12:24 -0500
Received: (qmail 7105 invoked by uid 111); 7 Mar 2011 19:12:22 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 19:12:22 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 14:12:18 -0500
Content-Disposition: inline
In-Reply-To: <7vtyfe22vy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168603>

On Mon, Mar 07, 2011 at 10:37:21AM -0800, Junio C Hamano wrote:

> > Hmm. "git show" seems to show --cc, but "git log -p" does not show
> > anything.
> 
> The intention has always been to default to --cc since 0fe7c1d (built-in
> diff: assorted updates., 2006-04-29) for "diff" if I am not misremembering
> things, but you are right---"log" is a tad different.
> 
> The code does not want to use --cc by default for "log", and I don't think
> that should change.  See 1aec791 (git log: don't do merge diffs by
> default, 2006-04-19).

Thanks for the history. I think the doc problem was an inaccuracy that
snuck in during 272bd3c (Include diff options in the git-log manpage,
2007-11-01). Nearly identical text (without the inaccuracy) is in the
"Diff Format For Merges" section in diff-format.txt.

Furthermore, the copied text talks about diff-index and diff-tree, but
gets included inline in git-log(1) (although the part in diff-format.txt
does not get included in git-log's manpage)[1]. So probably it's
reasonable to clean it up to something like:

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..3d02da9 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -74,10 +74,12 @@ separate lines indicate the old and the new mode.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format; you can force showing
-full diff with the '-m' option.
+Any diff-generating command can take the `-c` or `--cc` option to
+produced a 'combined diff' when showing a merge. This is the default
+format when showing merge conflicts with linkgit:git-diff[1] or a merge
+commit with linkgit:git-show[1]. Note also that you can vie the full
+diff with the `-m` option.
+
 A 'combined diff' format looks like this:
 
 ------------

-- >8 --

Is there any way to get "git diff" to show combined-form besides an
index with conflicts? I couldn't convince it to show me a merge commit
beside its parents, since it doesn't have an equivalent to diff-tree's
--stdin option.

-Peff

[1] Reading over this, the whole section could use some editing. I think
this is another example that needs to be broken out into its own
user-visible manpage. That is, we have too much "if you use the -p
option to command X, or command Y by default, or command Z without
--raw, then you see this format". That's pretty dense. Instead command X
should have:

  -p::
  --stat::
  --summary::
  [etc]
    Generate diffs in this format. See "git help diff-formats" for
    details. The default format is "-p".

and then diff-format.txt should _just_ be a description of the diff
formats, without worrying about commands at all. And probably the text
above should be factored out as part of diff-options.txt. But that's all
part of a much bigger documentation architecture change that I am hoping
to get to eventually. For now, I think it's worth just tweaking this
text to stop being inaccurate.
