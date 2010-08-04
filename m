From: Daniel Johnson <computerdruid@gmail.com>
Subject: [PATCH/RFC] fetch: allow command line --tags to override config
Date: Wed,  4 Aug 2010 14:56:42 -0400
Message-ID: <1280948202-17385-1-git-send-email-ComputerDruid@gmail.com>
Cc: Daniel Johnson <ComputerDruid@gmail.com>,
	=?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 20:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogj9u-0003P7-Nr
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab0HDS5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:57:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46068 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0HDS5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:57:40 -0400
Received: by vws3 with SMTP id 3so4341997vws.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ADKWOl5paNFm1TRLI4OA8EJXr7h+vDurlHp5bwx439U=;
        b=vlR3l8zgc2kgJUWZjBR7mCmIOj/hg8unCgW7VYTUxBxY6EbjotaENVBCgaV0k6qV5D
         O1fPyiGGhF618db77e3RhDKKNYzUTvnGNMAkDCW0xHETvDrv/TWYg5fHvN01HMPMmjG6
         GH2Suq/WM7Vwt4gVg6b2ANcjRG5yoAQI+vwFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MIkU0xppFB57tBZC2ltXldH1e4v2FNeAG0qOSzEi65AUAzhwpBxTFFozLixlQpat8J
         tbFL5pFNPVPqTljObnkGgJiB5jsKsE1Cld/UGONSphIcEcXwU8Z1aJwrp6/KbpIc4wao
         c9gqCMrzWVKKJdvo5CJ1OICkS8S70n1Au3JX4=
Received: by 10.220.123.226 with SMTP id q34mr4820938vcr.97.1280948259195;
        Wed, 04 Aug 2010 11:57:39 -0700 (PDT)
Received: from ComputerDruid@gmail.com ([151.188.213.237])
        by mx.google.com with ESMTPS id k30sm7766487vbl.19.2010.08.04.11.57.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 11:57:38 -0700 (PDT)
Received: by ComputerDruid@gmail.com (sSMTP sendmail emulation); Wed, 04 Aug 2010 14:57:43 -0400
X-Mailer: git-send-email 1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152593>

Originally, if remote.<name>.tagopt was set, the --tags and option would
have no effect when given to git fetch. So if
tagopt="--no-tags"

	git fetch --tags

would not actually fetch tags.

This patch changes this behavior to only follow what is written in the
config if there is no option passed by the command line.

Signed-off-by: Daniel Johnson <ComputerDruid@gmail.com>
---
 builtin/fetch.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b67f5f..7a53144 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -675,10 +675,12 @@ static int do_fetch(struct transport *transport,
 
 	for_each_ref(add_existing, &existing_refs);
 
-	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
-		tags = TAGS_SET;
-	if (transport->remote->fetch_tags == -1)
-		tags = TAGS_UNSET;
+	if (tags == TAGS_DEFAULT) {
+		if (transport->remote->fetch_tags == 2)
+			tags = TAGS_SET;
+		if (transport->remote->fetch_tags == -1)
+			tags = TAGS_UNSET;
+	}
 
 	if (!transport->get_refs_list || !transport->fetch)
 		die("Don't know how to fetch from %s", transport->url);
-- 
1.7.2
