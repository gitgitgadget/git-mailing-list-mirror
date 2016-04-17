From: Andreas Mohr <andi@lisas.de>
Subject: [BUG] git rev-parse :/ "regex" syntax not really regex?
Date: Sun, 17 Apr 2016 15:37:41 +0200
Message-ID: <20160417133741.GA28931@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arn0l-0003ce-95
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbcDQNpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 09:45:05 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:37910 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcDQNpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:45:04 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Apr 2016 09:45:04 EDT
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id DECCF4572C; Sun, 17 Apr 2016 15:37:41 +0200 (CEST)
Content-Disposition: inline
X-Priority: none
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291759>

Hello all,

I just wanted to shortly mention that to me it seems
that while
git help rev-parse
says
       :/<text>, e.g. :/fix nasty bug
           A colon, followed by a slash, followed by a text, names a commit whose commit message matches the specified regular expression. This name returns the
           youngest matching commit which is reachable from any ref. If the commit message starts with a !  you have to repeat that; the special sequence :/!, followed
           by something else than !, is reserved for now. The regular expression can match any part of the commit message. To match messages starting with a string, one
           can use e.g.  :/^foo.
, the supported syntax seems to be decidedly not really regex,
as opposed to
git log --grep

Creating a minimal reproducing repo sample
with e.g. a dummy commit series of the following commit titles:

My commit last
My commit
My commit first

and doing searches via
  git rev-parse :/'^My commi\w'
  git rev-parse :/'^My commit$'
  git rev-parse :/'^My commit'
  git log --grep='^My commit$' --format=%H <---- that one seems to work fully reliably

will yield surprising results
(returning most recent commit rather than commit title exact-match one),
and no amount of fiddling with various regex flavour syntax deviations
managed to fix it for me.

Unless I happened to misunderstand git's regex flavour, or something else...
(hmm, perhaps it's a try-match-single-line vs. multi-line content issue,
which perhaps does not work by specifying the trailing $)


$ git --version
git version 2.5.5

(same irritating behaviour also encountered on some older version, perhaps 2.0/2.1 range)


If this bug is confirmed, then I could suggest two variants:
- fix rev-parse's handling of :/ to actually do the correct thing, if easily possible
- simply fix rev-parse's docs to correctly indicate
  that unfortunately it is NOT fully regex capable,
  and ensure also having added a reference to the (much?) more reliably working
  git log --grep.

If this bug is not confirmed, then the question would be
what kind of potential documentation / usability weaknesses
successfully managed to lead me astray
and thus would need to be fixed.

Thanks,

Andreas Mohr
