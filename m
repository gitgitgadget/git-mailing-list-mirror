From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-rev-list: fix --header
Date: Mon, 17 Apr 2006 14:51:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604171443300.18017@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 17 14:53:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVTDp-0000b7-Gg
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 14:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWDQMvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 08:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDQMvn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 08:51:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:14013 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750734AbWDQMvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 08:51:42 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 5E3DD1CB4;
	Mon, 17 Apr 2006 14:51:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 52EAB1C52;
	Mon, 17 Apr 2006 14:51:39 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 3EAAA115B;
	Mon, 17 Apr 2006 14:51:39 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18819>


gitk expects raw verbose headers limited by \0. Meet these expectations.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This fixes the "clock format" bug I mentioned in another thread: 
	git-rev-list printed non-raw headers (lacking "author", 
	"committer", and the other lines), and thus, the author date was
	empty.

 rev-list.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

18f897509cd95b7e55c63e75fa40655c532507f6
diff --git a/rev-list.c b/rev-list.c
index 9d8db25..54e92f7 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -293,6 +293,7 @@ int main(int argc, const char **argv)
 {
 	struct commit_list *list;
 	int i;
+	int header = 0;
 
 	init_revisions(&revs);
 	revs.abbrev = 0;
@@ -303,7 +304,8 @@ int main(int argc, const char **argv)
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--header")) {
-			revs.verbose_header = 1;
+			header = 1;
+			revs.commit_format = CMIT_FMT_UNSPECIFIED;
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
@@ -324,6 +326,10 @@ int main(int argc, const char **argv)
 			revs.header_prefix = "";
 		else
 			revs.header_prefix = "commit ";
+	} else if (header) {
+		revs.verbose_header = 1;
+		revs.commit_format = CMIT_FMT_RAW;
+		hdr_termination = 0;
 	}
 
 	list = revs.commits;
-- 
1.2.0.ga8a6
