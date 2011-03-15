From: Jeff King <peff@peff.net>
Subject: Re: git-reset HEAD --permissions-only
Date: Mon, 14 Mar 2011 21:32:23 -0400
Message-ID: <20110315013223.GB31865@sigill.intra.peff.net>
References: <illts0$c6q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 02:32:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzJ7g-0003nM-E0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab1COBc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 21:32:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41638
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab1COBc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 21:32:26 -0400
Received: (qmail 16423 invoked by uid 107); 15 Mar 2011 01:32:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 21:32:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 21:32:23 -0400
Content-Disposition: inline
In-Reply-To: <illts0$c6q$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169043>

On Mon, Mar 14, 2011 at 03:29:51PM -0500, Neal Kreitzinger wrote:

> Is there a way to only reset the file permissions of the working-tree
> to match HEAD file permissions without resetting the content of the
> files?

Not directly, but you could munge a patch to do so and apply it in
reverse. For example:

  git diff "$@" |
  perl -ne '
    if (/^diff/) { $diff = $_ }
    elsif (/^old mode/) { print $diff, $_ }
    elsif (/^new mode/) { print $_ }
  ' |
  git apply -R

Which seems a little more complicated than it needs to be, but we don't
(AFAIK) have a way to say "show me only the mode changes from this
diff in an applicable form". The closest would be "git diff --summary",
but you cannot directly apply it (and I would hesitate to recommend
parsing it).

You could also use "git checkout -p", which is designed for exactly this
sort of picking-apart of a patch, but it has no way to specify "say yes
to all of the mode changes, no to everything else"; you have to manually
approve each hunk. Which doesn't work if you have a lot of these files.

I guess for mode changes, you don't care if you chmod something that is
already fine. So yet another way to do it would be:

  git ls-files -sz |
  perl -0ne '
    /100(\d+).*?\t(.*)/ or next;
    -e $2 or next;
    chmod(oct($1), $2)
      or die "chmod failed: $!";
  '

Hope that helps,
-Peff
