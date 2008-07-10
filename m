From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - register submodule URL if adding in place
Date: Wed,  9 Jul 2008 21:05:41 -0400
Message-ID: <1215651941-3460-2-git-send-email-mlevedahl@gmail.com>
References: <7vwsjvlhjw.fsf@gitster.siamese.dyndns.org>
 <1215651941-3460-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, <sylvain.joyeux@dfki.de>, <hjemli@gmail.com>,
	<pkufranky@gmail.com>, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com, <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 03:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGkcd-0000ZJ-AS
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 03:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbYGJBF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 21:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbYGJBF4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 21:05:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:46250 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbYGJBFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 21:05:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1455034ywe.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YIysKjYPA/fZDun02xyL1kt0fj0w26rMjkv3vZWVH4o=;
        b=JI9ru6osHR+bCPw2FxhJAYDf3nRlCR8MrSrIFqb/zn1sBKSBRIeZ0Nh+xwXzqWHxNJ
         YE2p8HkRYBOgvuaYyb86n31PCo6iLsUktZHo6HFcroGCCz0GltCQeeB0fkk37/31hnh4
         D5kurT12oVd4JrOPWnNLW29I3t3vmVRownFsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C48+4/bTq79xQoTzdt2rVlmjePNXuSnUVgf7PvyPjr6cjU2QAh5/JJEDl0ZNja03qO
         /njlaoozeVpew2ZoUFjccLScC5ASc8Hr9AlsV3b0dVabp6apZ0HVFetn3AtdC3ZyurRd
         yOt6APomqBeeEcX3EQo2nFnckGTcugxWL282w=
Received: by 10.150.202.8 with SMTP id z8mr13517641ybf.2.1215651948272;
        Wed, 09 Jul 2008 18:05:48 -0700 (PDT)
Received: from localhost.localdomain ( [71.246.235.165])
        by mx.google.com with ESMTPS id 9sm9395670yxs.5.2008.07.09.18.05.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 18:05:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.271.g73ad8
In-Reply-To: <1215651941-3460-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87926>

When adding a new submodule in place, meaning the user created the
submodule as a git repo in the superproject's tree first, we don't go
through "git submodule init" to register the module.  Thus, the
submodule's origin repository URL is not stored in .git/config, and no
subsequent submodule operation will ever do so.  In this case, assume the
URL the user supplies to "submodule add" is the one that should be
registered, and do so.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
Dscho's issue, so far as I can tell, was not really with this patch
but is addressed by the preceding patch eliminating the
confusing single argument "submodule add" format that lead to the
error he wanted to avoid. This patch is not changed except that it
is rebased.

 git-submodule.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c2ce2fb..9228f56 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -172,6 +172,16 @@ cmd_add()
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
+
+		case "$repo" in
+		./*|../*)
+			url=$(resolve_relative_url "$repo") || exit
+		    ;;
+		*)
+			url="$repo"
+			;;
+		esac
+		git config submodule."$path".url "$url"
 	else

 		module_clone "$path" "$realrepo" || exit
--
1.5.6.2.271.g73ad8
