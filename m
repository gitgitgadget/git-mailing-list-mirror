From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Do not over-quote the -f envelopesender value.
Date: Tue, 25 Sep 2007 08:48:59 +0200
Message-ID: <871wcntf38.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 08:49:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia4EI-00034F-Up
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXIYGtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXIYGtC
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:49:02 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:47005 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbXIYGtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:49:00 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 093EF698E8
	for <git@vger.kernel.org>; Tue, 25 Sep 2007 08:49:00 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E958C698A0
	for <git@vger.kernel.org>; Tue, 25 Sep 2007 08:48:59 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D045E50445; Tue, 25 Sep 2007 08:48:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59099>


Without this, the value passed to sendmail would have an extra set of
single quotes.  At least exim's sendmail emulation would object to that:

    exim: bad -f address "'list-addr@example.org'": malformed address: ' \
      may not follow 'list-addr@example.org
    error: hooks/post-receive exited with error code 1

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 contrib/hooks/post-receive-email |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index c589a39..1f88099 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -571,6 +571,15 @@ generate_delete_general_email()
 	echo $LOGEND
 }

+send_mail()
+{
+	if [ -n "$envelopesender" ]; then
+		/usr/sbin/sendmail -t -f "$envelopesender"
+	else
+		/usr/sbin/sendmail -t
+	fi
+}
+
 # ---------------------------- main()

 # --- Constants
@@ -607,13 +616,8 @@ if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# resend an email; they could redirect the output to sendmail themselves
 	PAGER= generate_email $2 $3 $1
 else
-	if [ -n "$envelopesender" ]; then
-		envelopesender="-f '$envelopesender'"
-	fi
-
 	while read oldrev newrev refname
 	do
-		generate_email $oldrev $newrev $refname |
-		/usr/sbin/sendmail -t $envelopesender
+		generate_email $oldrev $newrev $refname | send_mail
 	done
 fi
--
1.5.3.2.99.ge4b2-dirty
