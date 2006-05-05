From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Fix for config file section parsing.
Date: Fri, 5 May 2006 09:49:15 -0400
Message-ID: <BAYC1-PASMTP0769AAD931EFA5390875EDAEB50@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 15:55:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc0l8-00069e-9g
	for gcvg-git@gmane.org; Fri, 05 May 2006 15:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWEENyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEENyM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 09:54:12 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:43942 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751121AbWEENyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 09:54:11 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 06:57:13 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id A5EDE644C28
	for <git@vger.kernel.org>; Fri,  5 May 2006 09:54:09 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060505094915.7a6eb0e2.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 May 2006 13:57:13.0562 (UTC) FILETIME=[CFAB83A0:01C6704B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently, if the target key has a section that matches
the initial substring of another section we mistakenly
believe we've found the correct section.  To avoid this
problem, ensure that the section lengths are identical
before comparison.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

Here's an example of the problem:

$ git repo-config a.b.c d
$ cat .git/config
[a.b]
        c = d
$ git repo-config a.x y
$ cat .git/config
[a.b]
        c = d
        x = y


 config.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

f956fd1a6b1d3c82d9bc735427b58ec41d9e5dd1
diff --git a/config.c b/config.c
index 4e1f0c2..a3e14d7 100644
--- a/config.c
+++ b/config.c
@@ -335,8 +335,9 @@ static int store_aux(const char* key, co
 			store.offset[store.seen] = ftell(config_file);
 			store.state = KEY_SEEN;
 			store.seen++;
-		} else if(!strncmp(key, store.key, store.baselen))
-			store.state = SECTION_SEEN;
+		} else if (strrchr(key, '.') - key == store.baselen &&
+			      !strncmp(key, store.key, store.baselen))
+					store.state = SECTION_SEEN;
 	}
 	return 0;
 }
-- 
1.3.2.g2fb9
