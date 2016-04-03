From: Jeff King <peff@peff.net>
Subject: [sort-of-BUG] merge-resolve cannot resolve "content/mode" conflict
Date: Sun, 3 Apr 2016 01:26:28 -0400
Message-ID: <20160403052627.GA10487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 07:26:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amaYi-00007r-Db
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 07:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcDCF0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 01:26:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:43262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752780AbcDCF0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 01:26:31 -0400
Received: (qmail 787 invoked by uid 102); 3 Apr 2016 05:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 01:26:30 -0400
Received: (qmail 9745 invoked by uid 107); 3 Apr 2016 05:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 01:26:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 01:26:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290629>

Imagine a merge where one side changes the content of a path and the
other changes the mode. Here's a minimal reproduction:

  git init repo && cd repo &&

  echo base >file &&
  git add file &&
  git commit -m base &&

  echo changed >file &&
  git commit -am content &&

  git checkout -b side HEAD^
  chmod +x file &&
  git commit -am mode

If I merge that with merge-recursive, I get what you'd expect: mode
10755, and content "changed".

However, with merge-resolve, I get a conflict:

  $ git merge -s resolve master
  Trying really trivial in-index merge...
  error: Merge requires file-level merging
  Nope.
  Trying simple merge.
  Simple merge failed, trying Automatic merge.
  Auto-merging file
  ERROR: permissions conflict: 100644->100755,100644 in file
  fatal: merge program failed
  Automatic merge failed; fix conflicts and then commit the result.

I think this is only a half-bug, really. It's definitely a funny
situation, and it's not unreasonable for a merge driver to punt on a
funny situation rather than resolving it. But I would say:

  - it would probably be a nice improvement to resolve this as
    merge-recursive does

  - the "ERROR" message is silly and misleading; the permissions resolve
    just fine, it is only that the combination with the content-level
    change confuses the script (but the output does not mention that).

This is a leftover from my experiments with merge-resolve versus
merge-recursive last fall, which resulted in a few actual bug-fixes. I
looked into fixing this case, too, at that time. It seemed possible, but
a little more involved than you might think (because the logic is driven
by a bunch of case statements, and this adds a multiplicative layer to
the cases; we might need to resolve the permissions, and _then_ see if
the content can be resolved).

So I didn't actually come up with a patch, but I figured I'd write it up
here for posterity. And just didn't get around to it until now.

-Peff
