From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/3] add push --current and remote.*.pushHeadOnly
Date: Mon, 20 Jul 2009 08:36:57 +0200
Message-ID: <1248071820-18289-1-git-send-email-bonzini@gnu.org>
Cc: gitster@pobox.com
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 08:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSmVJ-0007ck-JB
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 08:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZGTGhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbZGTGhI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 02:37:08 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56004 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZGTGhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 02:37:06 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSmUk-0003ie-6s; Mon, 20 Jul 2009 02:37:06 -0400
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123572>

This second series is gets rid of the most annoying part
(IMHO) of push.default = tracking, i.e. the fact that its
behavior cannot be achieved using git's ordinary tools.
While autosetuppush is enough to set the refspecs correctly,
push.tracking does not push _all_ tracked branches, but
only the current one (because it implicitly adds only
one refspec, while autosetuppush places them all in the
configuration).

What I introduce here is "git push --current" and a companion
remote.*.pushHeadOnly option to make it the default.  The
difference between "git push HEAD" and "git push --current"
is that the latter will still walk the remote.*.push refspecs,
but honor only the one matching HEAD.

Together with autosetuppush, this more or less achieves the
same result as push.tracking, at least for newly created
remotes.  A subsequent series will handle the transition.

v2 integrates changes from Nanako's review.  Patch 1 is new
and partially reverts bba0fd2 (push: do not give big warning
when no preference is configured, 2009-07-18).  Patch 2 is the
meat of the implementation.  Most of it actually touches the
transport mechanism, not builtin-push.c (which covers only
one detail about how to handle "git push --current" when
the remote does not have a corresponding push refspec).
Patch 3 adds remote.*.pushHeadOnly.

Paolo Bonzini (3):
      reintroduce PUSH_DEFAULT_UNSPECIFIED
      push: add --current
      push: add remote.*.pushHeadOnly configuration

 Documentation/config.txt   |    6 ++++
 Documentation/git-push.txt |   18 +++++++++++-
 builtin-push.c             |   17 +++++++++--
 cache.h                    |    1 +
 environment.c              |    2 +-
 http-push.c                |   27 ++++++++++++++----
 remote.c                   |   42 ++++++++++++++++++++++++-----
 remote.h                   |    3 ++
 t/t5516-fetch-push.sh      |   64 ++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |   22 ++++++++++++++-
 transport.h                |    1 +
 11 files changed, 183 insertions(+), 20 deletions(-)
