From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/5] RFC: patterns for branch list
Date: Thu, 25 Aug 2011 10:30:16 +0200
Message-ID: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVKb-0008OO-2r
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab1HYIa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44029 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab1HYIaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:25 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1CF5C20BE2;
	Thu, 25 Aug 2011 04:30:25 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Aug 2011 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=x2bcQIZZJKjRG7nMX0J/g9+Tg
	Zg=; b=cpazNjITe24a2XjGWCTOa71Ts3IA6jt8C6VEMI2mjlV6oMAlkzYR1DiRy
	EQS8bsQoFbGFr57ktPz6IB87URYg/hRHTKALYkHtgwotSFdodXh4JGcmyDC+i41J
	W/Jm0VEve3Ixc8GXS6TvBnwmVgOAmpqDPcCVMUbAYs4WAINytE=
X-Sasl-enc: bpctpRMkGB1/CRL/CiO3GoCLY0RRljdN5KsgoG9zWOlj 1314261024
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8DC0A840175;
	Thu, 25 Aug 2011 04:30:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180068>

This mini series is about introducing patterns to the list mode of
'git branch' much like the pattern for 'git tag -l'. There are several
related things which are to be considered for the ui design:

git log
=======

For "log" and friends, "--glob" is a means to specify revision arguments by
matching refs. Note that we have

--branches[=<pattern>] matching in refs/heads
--tags[=<pattern>] matching in refs/tags
--glob=<glob-pattern> matching in refs/

git tag
=======

For "tag", we have a pattern matching in refs/tags, but only in the list mode
of "tag", which is invoked by "-l", or automatically when there are no
arguments. There is no pattern related option, it's "always on" in list mode.
I.e., in list mode it behaves much like

git log --no-walk --oneline --tags=

with a different format string, and an optional argument stuck at the end of
the line. (git for-each-ref is another related interface, but plumbing, so I'll
skip it here.)

git branch
==========

Analogous to "git tag", "branch" has several modes, one of which is list mode.
It is currently activated (and possibly modified) by "-v" and "-vv", and when
there are no arguments. So, at the least,

git branch -v[v] <pattern>

should match just like "git tag -l <pattern>" does. And that is what the first
patch in my series does.

Then we need an option to invoke list mode. The natural candidate "-l" is taken
by the badly named reflog option, which is why I suggested "--list" and moving
the reflog option to "-g" over time.

I'm open to other suggestions as long as they keep and improve the consistency
between "git tag" and "git branch". I never liked their different implicit
modes/subcommands but have been around long enough to know that they are there
to stay.

"git tag" should probably learn the same long option and others. And why not
verify tags given by a pattern?

Both "tag" and "branch" could activate list mode automatically on an invalid
tag name rather than dieing:

git tag v1.7.6\*
Warning: tag 'v1.7.6*' not found.
v1.7.6
v1.7.6-rc0
v1.7.6-rc1
v1.7.6-rc2
v1.7.6-rc3
v1.7.6.1

On the other hand, one might think about implementing both list modes (tag and
branch) using the revision machinery and custom format strings, or
for-each-ref; rather than both differently as it is now.

'-l' is the natural short option name for '--list'. This is taken for the
rarely used or needed 'create reflog' option. I'd change the latter to
'-g,--create-reflog' (cmp. log) and take '-l,--list' but know the reaction
already.

-v[v] sanity
============

'-v' and '-vv' both take considerable time (because they need to walk).
It makes more sense to have '-v' display cheap output (upstream name)
and '-vv' add expensive output (ahead/behind info). '-vvv' could add super
expensive info (ahead/equivalent/behind a la cherry-mark).

These are changes to current porcelain ui behaviour, so I deem this to be OK
(too late for 1.7.7, of course). The option renaming needs a transition
(not done in this series).

Michael J Gruber (5):
  branch: allow pattern arguments
  branch: introduce --list argument
  t6040; test branch -vv [independent, can go in as is testing current behaviour]
  branch: restructure -v vs. -vv
  branch: give patchsame count with -vvv

 Documentation/git-branch.txt |   20 +++++++++---
 builtin/branch.c             |   65 +++++++++++++++++++++++++----------------
 remote.c                     |   12 ++++++--
 remote.h                     |    2 +-
 t/t3203-branch-output.sh     |   24 +++++++++++++++
 t/t6040-tracking-info.sh     |   41 ++++++++++++++++++++++++--
 wt-status.c                  |    2 +-
 7 files changed, 127 insertions(+), 39 deletions(-)

-- 
1.7.6.845.gc3c05
