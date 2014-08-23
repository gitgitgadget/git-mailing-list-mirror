From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] git-prompt: do not look for refs/stash in $GIT_DIR
Date: Sat, 23 Aug 2014 01:26:51 -0400
Message-ID: <20140823052650.GA18075@peff.net>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3qv-0006tk-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbaHWF0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:26:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:57234 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbaHWF0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:26:52 -0400
Received: (qmail 13553 invoked by uid 102); 23 Aug 2014 05:26:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:26:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:26:51 -0400
Content-Disposition: inline
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255728>

Since dd0b72c (bash prompt: use bash builtins to check stash
state, 2011-04-01), git-prompt checks whether we have a
stash by looking for $GIT_DIR/refs/stash. Generally external
programs should never do this, because they would miss
packed-refs.

That commit claims that packed-refs does not pack
refs/stash, but that is not quite true. It does pack the
ref, but due to a bug, fails to prune the ref. When we fix
that bug, we would want to be doing the right thing here.

Signed-off-by: Jeff King <peff@peff.net>
---
I know we are pretty sensitive to forks in the prompt code (after all,
that was the point of dd0b72c). This patch is essentially a reversion of
this hunk of dd0b72c, and is definitely safe.

I think we could probably get by with:

  [ -r "$g/logs/ref/stash" ]

since reflogs are always in the filesystem. However, that seems somewhat
short-sighted, as the work Ronnie is doing is moving in the direction of
more abstraction here. I hope a day will come soon when reflogs do not
have to be stored in $GIT_DIR/logs, and then we would end up updating
this code again.

 contrib/completion/git-prompt.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9d684b1..c5473dc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -468,7 +468,8 @@ __git_ps1 ()
 			fi
 		fi
 		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
-		   [ -r "$g/refs/stash" ]; then
+		   git rev-parse --verify --quiet refs/stash >/dev/null
+		then
 			s="$"
 		fi
 
-- 
2.1.0.346.ga0367b9
