From: Jim Meyering <jim@meyering.net>
Subject: git-diff: must --exit-code work with --ignore* options?
Date: Fri, 22 May 2009 16:01:57 +0200
Message-ID: <87k549dyne.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 22 16:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7VK9-0003aG-BF
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 16:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbZEVOCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 10:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZEVOCF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 10:02:05 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:46824 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbZEVOCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 10:02:04 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 704634B00A5
	for <git@vger.kernel.org>; Fri, 22 May 2009 16:01:59 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 8F41F4B00B3
	for <git@vger.kernel.org>; Fri, 22 May 2009 16:01:57 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6C0798BC4; Fri, 22 May 2009 16:01:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119731>

git-diff's --quiet option works how I'd expect with --ignore-space-at-eol
as long as I'm also using --no-index:

    $ echo>b; echo \ >c; git diff --no-index --quiet --ignore-space-at-eol b c \
      && echo good
    good

But in what I think of as normal operation (i.e., without --no-index),
--exit-code (or --quiet) makes git-diff say there were differences,
even when they have been ignored:

    # do this in an empty directory
    $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
    $ git diff --ignore-space-at-eol --quiet || echo bad
    bad

Same problem with --ignore-space-change.

-------------------
In the surprising case, builtin-diff.c's builtin_diff_files calls
diff_result_code, which returns nonzero due to this:

          if (diff_queued_diff.nr)
                  DIFF_OPT_SET(options, HAS_CHANGES);
          else
                  DIFF_OPT_CLR(options, HAS_CHANGES);

However, the queued diffs may contain only ignorable changes.

With --no-index, it takes a different code path and uses
diffopt.found_changes to produce the desired exit status.
