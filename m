From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] config: Give error message when not changing a multivar
Date: Tue, 17 May 2011 17:38:53 +0200
Message-ID: <51b0df452d9cb7f3dbe0a47ef639b6a45c7de1b3.1305646709.git.git@drmicha.warpmail.net>
References: <20110517140725.GA17193@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 17:39:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMMa-0006Fc-Dt
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab1EQPjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:39:02 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58064 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755750Ab1EQPjA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 11:39:00 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 62FD220B98;
	Tue, 17 May 2011 11:39:00 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 17 May 2011 11:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=1E12MJk9LhuaBsTfn1NBijVzQac=; b=S7K4k/mvseZZg6x13cLbBbZPkdIGfWr3PkxtnSV+LCIMXlgckMj1JFPhNjJrXTrAGOoV7OJRU9Q8F+FvDYWjPs8C3u+wOl45GNHK39Fzed8up+5ld7XQRKD5Q2QKa7Cae5VV3LuMxkj/9qV4zcgj0GuqYPL1p3dpKPMnlvewH9Y=
X-Sasl-enc: l5+k+HXor7rcH7o93x4kgNyQS1C8NqmETLZRRKXfrbcY 1305646739
Received: from localhost (p54858FA7.dip0.t-ipconnect.de [84.133.143.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 168C4402F0C;
	Tue, 17 May 2011 11:38:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.514.gd181fb
In-Reply-To: <20110517140725.GA17193@sigill.intra.peff.net>
In-Reply-To: <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
References: <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173807>

When trying to set a multivar with "git config var value", "git config"
issues

warning: remote.repoor.push has multiple values

leaving the user under the impression that the operation succeeded,
unless one checks the return value.

Instead, make it

warning: remote.repoor.push has multiple values
error: cannot overwrite multiple values with a single value
       Use a regexp, --add or --set-all to change remote.repoor.push.

to be clear and helpful.

Note: The "warning" is raised through other code paths also so that it
needs to remain a warning for these (which do not raise the error). Only
the caller can determine how to go on from that.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/config.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3e3c528..211e118 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -436,9 +436,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			      NULL, NULL);
 	}
 	else if (actions == ACTION_SET) {
+		int ret;
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set(argv[0], value);
+		ret = git_config_set(argv[0], value);
+		if (ret == CONFIG_NOTHING_SET)
+			error("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --set-all to change %s.", argv[0]);
+		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
 		check_argc(argc, 2, 3);
-- 
1.7.5.1.514.gd181fb
