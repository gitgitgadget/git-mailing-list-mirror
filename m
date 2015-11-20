From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] rebase: broken behavior with --keep-empty
Date: Fri, 20 Nov 2015 13:04:38 +0100
Message-ID: <1448021080-4994-1-git-send-email-ps@pks.im>
Cc: ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 13:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzkR0-0006vj-UE
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 13:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759960AbbKTMEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 07:04:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43173 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbbKTMEy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 07:04:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B9FB420179
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 07:04:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 20 Nov 2015 07:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=CPx7LURxltwQ7N8YkQl6WOpDtw
	4=; b=jkXFcPEmb7QMn+2oN5qk51bbvwCmcl+GGrncyDU06lvclKmKPR7SQlB2fb
	enc+mcszONJ0L7umyk69gvJ+tBIlQRgjPMHIunHmwPTYp0YD9eT9+ziXWGYr3ciV
	UKaSzxFPIAbREk+8V2QKnSVIAkpSOEzJr52lYOHTW6YzUbt7g=
X-Sasl-enc: D9LJUuXpGjg2yk232Mntn0ZsrVNDh0dQoOtJ7Cin4Jh+ 1448021093
Received: from localhost (i59f7870a.versanet.de [89.247.135.10])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0E2A8C016EE;
	Fri, 20 Nov 2015 07:04:52 -0500 (EST)
X-Mailer: git-send-email 2.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281515>

I've recently run into broken behavior with `git-rebase` and
`--keep-empty`. As soon as `--keep-empty` is specified, we fall
back on using `git cherry-pick` instead of `git am` for rebasing
the commits, which seems to not work correctly.

In fact I guess there are two different bugs in here. The first
bug is in using `git cherry-pick --allow-empty` instead of `git
cherry-pick --keep-redundant-commits`, as judging from
git-rebase(1) we also want to keep commits that are already
included in the branch that is being rebased upon whe we use
`--keep-empty`.

The second bug is that we fail to correctly record the
rebasing-state when using cherry-pick. This causes us to end up
in cherry-picking mode as soon as the invoked cherry-pick command
runs into any error (e.g. due to a conflict or the broken
behavior with `--allow-empty`). There is also no possibility to
get back into rebase-mode from here.

I've written two tests that document these breakages, as well as
a fix to the first described breakage. I did not fix the second
breakage of not recording rebase-state, though, as this is
somewhat more involved.

Patrick

Patrick Steinhardt (2):
  rebase: test broken behavior with --keep-empty
  rebase: fix preserving commits with --keep-empty

 git-rebase--am.sh |  2 +-
 t/t3400-rebase.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.6.3
