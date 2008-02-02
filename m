From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Avoid segfault when passed malformed refspec
Date: Fri, 1 Feb 2008 19:00:13 -0500
Message-ID: <BAYC1-PASMTP124F1019C2D2CD7AA81CF5AE310@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 01:01:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5oT-0001o2-Bz
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 01:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761786AbYBBAAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761909AbYBBAAT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 19:00:19 -0500
Received: from bay0-omc2-s7.bay0.hotmail.com ([65.54.246.143]:55890 "EHLO
	bay0-omc2-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761786AbYBBAAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 19:00:17 -0500
Received: from BAYC1-PASMTP12 ([65.54.191.185]) by bay0-omc2-s7.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 1 Feb 2008 16:00:13 -0800
X-Originating-IP: [74.15.77.168]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.77.168]) by BAYC1-PASMTP12.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 1 Feb 2008 16:00:12 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JL6ji-00086k-BW
	for git@vger.kernel.org; Fri, 01 Feb 2008 20:00:02 -0500
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 02 Feb 2008 00:00:13.0011 (UTC) FILETIME=[95701230:01C8652E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72196>


A refspec typo can cause a Null-pointer dereference and segmentation
fault.  For instance, the space before the colon in the following
example results in a segfault:

   $ git fetch ../repo  refs/heads/* :refs/heads/*
   Segmentation fault (core dumped)

To avoid the segfault, set an empty refspec destination string
if one isn't found by parsing.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 remote.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 0e00680..414c73a 100644
--- a/remote.c
+++ b/remote.c
@@ -336,6 +336,8 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
 			ep = gp;
 		}
 		rs[i].src = xstrndup(sp, ep - sp);
+		if (!rs[i].dst)
+			rs[i].dst = xstrdup("");
 	}
 	return rs;
 }
-- 
1.5.4.rc5.20.g4b806
