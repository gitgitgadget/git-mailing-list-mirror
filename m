From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Another config file parsing fix.
Date: Sat, 6 May 2006 14:14:02 -0400
Message-ID: <BAYC1-PASMTP050DC939D9D702CA1B3208AEAA0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 06 20:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcRMx-00027G-1L
	for gcvg-git@gmane.org; Sat, 06 May 2006 20:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWEFSTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 14:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWEFSTD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 14:19:03 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:64802 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751033AbWEFSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 14:19:01 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 11:19:01 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 3FA9B644C28;
	Sat,  6 May 2006 14:19:00 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060506141402.3909cb37.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 18:19:01.0385 (UTC) FILETIME=[8CACD790:01C67139]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If the variable we need to store should go into a section
that currently only has a single variable (not matching
the one we're trying to insert), we will already be into
the next section before we notice we've bypassed the correct
location to insert the variable.

To handle this case we store the current location as soon
as we find a variable matching the section of our new
variable.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 config.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

1ba487db7393d773a2a4b7c404ba1b807272eb7d
diff --git a/config.c b/config.c
index 87fb220..41066e4 100644
--- a/config.c
+++ b/config.c
@@ -336,8 +336,10 @@ static int store_aux(const char* key, co
 			store.state = KEY_SEEN;
 			store.seen++;
 		} else if (strrchr(key, '.') - key == store.baselen &&
-			      !strncmp(key, store.key, store.baselen))
+			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
+					store.offset[store.seen] = ftell(config_file);
+		}
 	}
 	return 0;
 }
-- 
1.3.2.g6e99a-dirty
