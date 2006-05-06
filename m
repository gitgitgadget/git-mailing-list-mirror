From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] get_pathspec(): free() old buffer if rewriting
Date: Sun, 7 May 2006 00:04:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 00:04:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUt2-0007OI-TP
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWEFWE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEFWE0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:04:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27850 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932088AbWEFWE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 18:04:26 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 463E32270;
	Sun,  7 May 2006 00:04:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 39520226F;
	Sun,  7 May 2006 00:04:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1765DB78;
	Sun,  7 May 2006 00:04:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19677>


This might be the wrong way to do it, but as it is without this patch,
get_pathspec() is leaking memory.

However, it is by no means guaranteed that the input is malloc()ed. The
tests run through without problems, but you never know...

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 setup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index fe7f884..9c39d6e 100644
--- a/setup.c
+++ b/setup.c
@@ -126,6 +126,11 @@ const char **get_pathspec(const char *pr
 	prefixlen = prefix ? strlen(prefix) : 0;
 	do {
 		*p = prefix_path(prefix, prefixlen, entry);
+		if (*p != entry) {
+			if (*p > entry && *p < entry + strlen(entry))
+				*p = strdup(*p);
+			free((char*)entry);
+		}
 	} while ((entry = *++p) != NULL);
 	return (const char **) pathspec;
 }
-- 
1.3.2.g9ba6-dirty
