From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat (take 2)
Date: Fri, 14 Apr 2006 01:09:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604140108280.25088@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604140012560.10924@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Apr 14 01:16:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUB2x-0008Ev-L7
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 01:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWDMXJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWDMXJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 19:09:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31909 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965013AbWDMXJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:49 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 4E0E9C9C;
	Fri, 14 Apr 2006 01:09:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 41F0CCBE;
	Fri, 14 Apr 2006 01:09:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 280EBC77;
	Fri, 14 Apr 2006 01:09:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0604140012560.10924@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18678>

... and a fix for an invalid free():

---

 diff.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

14d8e3c7cda1e2aaff62375fe34db2458d302173
diff --git a/diff.c b/diff.c
index ad8478b..2968153 100644
--- a/diff.c
+++ b/diff.c
@@ -266,7 +266,7 @@ static void show_stats(struct diffstat_t
 			char *qname = xmalloc(len + 1);
 			quote_c_style(name, qname, NULL, 0);
 			free(name);
-			name = qname;
+			data->files[i]->name = name = qname;
 		}
 
 		/*
@@ -297,10 +297,10 @@ static void show_stats(struct diffstat_t
 		if (added < 0) {
 			/* binary file */
 			printf(" %s%-*s |  Bin\n", prefix, len, name);
-			continue;
+			goto free_diffstat_file;
 		} else if (added + deleted == 0) {
 			total_files--;
-			continue;
+			goto free_diffstat_file;
 		}
 
 		add = added;
@@ -314,11 +314,11 @@ static void show_stats(struct diffstat_t
 			add = (add * max + max_change / 2) / max_change;
 			del = total - add;
 		}
-		/* TODO: binary */
 		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
 				len, name, added + deleted,
 				add, pluses, del, minuses);
-		free(name);
+	free_diffstat_file:
+		free(data->files[i]->name);
 		free(data->files[i]);
 	}
 	free(data->files);
-- 
1.3.0.rc3.g9813
