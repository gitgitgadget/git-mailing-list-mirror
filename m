From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Warn about invalid refs
Date: Tue, 28 Feb 2006 22:16:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602282213180.27405@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vacgu3hta.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510272125580.28705@wbgn013.biozentrum.uni-wuerzburg.de>
 <7voe5a1yft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 22:16:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FECCX-0000ey-1e
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 22:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWB1VQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 16:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWB1VQF
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 16:16:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:21735 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932494AbWB1VQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 16:16:04 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 2FBA410E9;
	Tue, 28 Feb 2006 22:16:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 231F55EEC;
	Tue, 28 Feb 2006 22:16:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 10230A18;
	Tue, 28 Feb 2006 22:16:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5a1yft.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16955>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

On Thu, 27 Oct 2005, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > On Thu, 27 Oct 2005, Junio C Hamano wrote:
	> >
	> >> Not that the current loop is any better for that purpose.  
	> >> We silently ignore not just dangling ref and ref not storing
	> >> 40-byte hex, but files starting with a period '.', names 
	> >> longer than 255 bytes, and unreadable ones, all of which we 
	> >> would probably want to warn about in such a tool.
	> >
	> > Okay, how about 'fprintf(stderr, "Warning: ...\n"); continue;' 
	> > instead of 'die("...");' then?
	> 
	> Yup.  That sounds sensible.

	Sorry for taking so long...

 refs.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 826ae7a..982ebf8 100644
--- a/refs.c
+++ b/refs.c
@@ -151,10 +151,15 @@ static int do_for_each_ref(const char *b
 					break;
 				continue;
 			}
-			if (read_ref(git_path("%s", path), sha1) < 0)
+			if (read_ref(git_path("%s", path), sha1) < 0) {
+				fprintf(stderr, "%s points nowhere!", path);
 				continue;
-			if (!has_sha1_file(sha1))
+			}
+			if (!has_sha1_file(sha1)) {
+				fprintf(stderr, "%s does not point to a valid "
+						"commit object!", path);
 				continue;
+			}
 			retval = fn(path, sha1);
 			if (retval)
 				break;
