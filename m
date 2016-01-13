From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V4 0/2] specify commit by negative pattern
Date: Tue, 12 Jan 2016 21:51:11 -0700
Message-ID: <1452660671-5512-1-git-send-email-ischis2@cox.net>
References: <ED12DDDA0C004D23BDDB14973C675800@PhilipOakley>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 05:51:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJDP0-0005tJ-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 05:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbcAMEvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 23:51:18 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:49853 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbcAMEvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 23:51:17 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160113045116.ZYSO22785.fed1rmfepo202.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Tue, 12 Jan 2016 23:51:16 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id 5GrF1s00P2tqoqC01GrFpz; Tue, 12 Jan 2016 23:51:15 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020206.5695D7C3.0109,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=ybZZDoGAAAAA:8 a=TSbVqHtbAAAA:8 a=4qq2MKCmOREJwVZY8YIA:9
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 1707013F628;
	Tue, 12 Jan 2016 21:51:16 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <ED12DDDA0C004D23BDDB14973C675800@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283877>

Add support for negative pattern matching in the @^{/<pattern>} regex
pattern style, and consequentially the style revision specifiers. So
now you can find the first commit whose message doesn't match a
pattern, complementing the existing positive matching.
e.g.:

    $ git rebase -i @^{/!-^WIP}

My use-case is in having a "work, work, work, rebase, push"-style
workflow, which generates a lot of "WIP foo" commits. While rebasing is
usually handled via "git rebase -i origin/master", occasionally I will
already have several "good, but not yet ready to push" commits hanging
around while I finish work on related commits. In these situations, the
ability to quickly "git diff @^{/!-^WIP}" to get an overview of all
changes "since the last one I was happy with", can be useful.

This is the forth version of the patch series. The previous attempt
used the notation @^{/!WIP}, rather than @^{/!-WIP}, so the "modifier"
was the '!' character. Now, '!' is taken as an indicator that the
pattern is to be interpreted differently, and '-' is taken as an
indicator of how it is to be interpreted differently. This follows
recent discussion with "Junio C Hamano" <gitster@pobox.com> and much-less
recent discussion archived at:

http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477

In summary, '!' is to be used as an "escape hatch", for further
extension of the "name commit by pattern" functionality. Theorised future
extensions indicated things like "what was to be searched",
e.g.: @^{/!(a=author)}.  With only two interpretations of the '!'
leader, for now (including the '!!' literal notation), adding such a
verbose form, such as '@^{/!(negative)foo}', seemed inappropriate at this
time. In the event that such verbose forms are ever implemented, this new
form may act as a shorthand, for a basic case.

Will Palmer (2):
  test for '!' handling in rev-parse's named commits
  object name: introduce '^{/!-<negative pattern>}' notation

 Documentation/revisions.txt | 11 +++++-----
 sha1_name.c                 | 20 ++++++++++++-----
 t/t1511-rev-parse-caret.sh  | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.7.0-rc2
