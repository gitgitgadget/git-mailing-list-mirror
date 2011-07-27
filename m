From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] ls-files: fix pathspec display on error
Date: Wed, 27 Jul 2011 13:56:14 +0200
Message-ID: <b535c21e1becdf8aeeb1d3f8ddaa7f5415830844.1311767679.git.git@drmicha.warpmail.net>
References: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, rrt@sc3d.org,
	john@szakmeister.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 13:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm2it-0001y3-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 13:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab1G0L4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 07:56:19 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46954 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142Ab1G0L4S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 07:56:18 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 74D6720949;
	Wed, 27 Jul 2011 07:56:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 27 Jul 2011 07:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=GAtSZTwp5QiSesBz4691sWcwI
	Cg=; b=HURdAIidIXu+o5lHxakd+SfFCzcar0nAO2Vn95tWaLimo+O1AyrRO464l
	HfT/WFB/UJ+0GIWT10VdqQxH+l41FfeQmdNVpH6AwHcPfhGUX6fRZq2dRZgJEr5/
	f071CndOm8tcuIE57R6nLx5PSaIJlJuJEBdgMvMDko9KyXxVFg=
X-Sasl-enc: OsrPrM62Dr/0hDl14QS2Su0D7xRwVnY2qmBss536DbDo 1311767776
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EFA8E4553AC;
	Wed, 27 Jul 2011 07:56:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.336.gdf067
In-Reply-To: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177963>

Trying to commit or ls a file "../$a" from within a subdirectory "aha"
gives the following output, when "$a" runs through the values "a", "aa"
etc.:

error: pathspec '../a' did not match any file(s) known to git.
error: pathspec '../aa' did not match any file(s) known to git.
error: pathspec '../aaa' did not match any file(s) known to git.
error: pathspec '' did not match any file(s) known to git.
error: pathspec 'a' did not match any file(s) known to git.
error: pathspec 'aa' did not match any file(s) known to git.
error: pathspec 'aaa' did not match any file(s) known to git.
error: pathspec 'aaaa' did not match any file(s) known to git.
error: pathspec 'aaaaa' did not match any file(s) known to git.
error: pathspec 'aaaaaa' did not match any file(s) known to git.

This comes from the fact that report_path_error() tries to chop off a
prefix from the pathspec which may have been resolved and consumed already.

Fix this by displaying the full pathspec.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
So, I couldn't reproduce because it depends on the length of the dirname.
This may be fallout from efad1a5 (ls-files: allow relative pathspec, 2010-06-03)
but I haven't checked and won't be able to for the next 3 weeks, sorry.
I just wanted to send out this possible fix before I leave.
---
 builtin/ls-files.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1570123..e0b1401 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -418,7 +418,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 			continue;
 
 		error("pathspec '%s' did not match any file(s) known to git.",
-		      pathspec[num] + prefix_len);
+		      pathspec[num]);
 		errors++;
 	}
 	return errors;
-- 
1.7.6.336.gdf067
