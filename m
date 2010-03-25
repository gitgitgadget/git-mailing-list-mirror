From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Thu, 25 Mar 2010 09:46:16 +0100
Message-ID: <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
References: <4BAB2234.4070202@drmicha.warpmail.net>
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 09:49:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuikd-0005Iw-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 09:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab0CYItH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 04:49:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47139 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751651Ab0CYItF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 04:49:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 19E3AE8C31;
	Thu, 25 Mar 2010 04:49:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Mar 2010 04:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=9A2rSPEffJXa8kTmJF6RkhFLsyQ=; b=CF/3lDbZ27isL+qKgpg2KXelRMS+vfNofhmzUoRtdr8S501wK/xfn7PFAGmsrFE81uyt226z/M2IhpqbAwoKJLTB9w9cqQe27VDC31tT9v2K0CIfVvo2bIZXr7/fFZS0k1HVJX0TWhIEYhH1A+lkgy2Nhs+De0XM23pmEjuYwfw=
X-Sasl-enc: YvAxW3pjRLI+AUiKgWaXg5nGSVdGPlSOTMA/rJXg+xCS 1269506944
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 813614BC294;
	Thu, 25 Mar 2010 04:49:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3.448.g82eeb
In-Reply-To: <4BAB2234.4070202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143170>

Currently, cloning a local repository results in the progress report
"Initialized empty Git repository in ..." from init but no other output,
leaving the user to wonder what happened to the actual cloning.

Therefore, quell the progress report from init (unless -v is given) to
be in line with the many other commands which report nothing on success.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is RFC/RFD. An actual patch will also adjust several tests to
the new expected output. Also, one might want to change init's default
verbosity level accordingly.

The current output is really confusing for local cloning. There are
several alternative ways to resolve this:
- Make the local cloning process report something.
- Check whether the clone is remote or not and report init or don't.

Currently, we really have two philosophies:
- report only on error
- be chatty on success

I don't think that's a problem, but "simple" commands (e.g. branch, init,
add) should be in the former camp.

 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 05f8fb4..f98c5c5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -461,7 +461,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
-	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
+	init_db(option_template, (option_verbosity <= 0) ? INIT_DB_QUIET : 0);
 
 	/*
 	 * At this point, the config exists, so we do not need the
-- 
1.7.0.3.448.g82eeb
