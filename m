From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-tag - add support for longer commit messages
Date: Tue, 11 Oct 2005 15:45:49 +1300
Message-ID: <11289987493327-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Oct 11 04:44:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPA80-0007bs-7t
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 04:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVJKCn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 22:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVJKCn5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 22:43:57 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:29645 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751280AbVJKCn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 22:43:56 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EPA7P-0003Xl-2C; Tue, 11 Oct 2005 15:43:55 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EPA9G-0002OB-00; Tue, 11 Oct 2005 15:45:50 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9951>

Added an -m switch that points to a filename which contains a (potentially
long) tag message.

Bugs: Could alternatively be implemented via STDIN.

---

 cg-tag |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

c9ed29a0eb1529a47af75a4193375edf9e892fdb
diff --git a/cg-tag b/cg-tag
--- a/cg-tag
+++ b/cg-tag
@@ -23,7 +23,7 @@
 #	This is most usually the ID of the commit to tag. Tagging
 #	other objects than commits is possible, but rather "unusual".
 
-USAGE="cg-tag [-d DESCRIPTION] [-s [-k KEYNAME]] TAG_NAME [OBJECT_ID]"
+USAGE="cg-tag [-d DESCRIPTION] [-m MSGFILE ] [-s [-k KEYNAME]] TAG_NAME [OBJECT_ID]"
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
@@ -37,6 +37,8 @@ while optparse; do
 		keyname="$OPTARG"
 	elif optparse -d=; then
 		description="$OPTARG"
+	elif optparse -m=; then
+		msgfile="$OPTARG"
 	else
 		optfail
 	fi
@@ -72,6 +74,13 @@ if [ "$description" ]; then
 	echo >>"$tagdir/tag"
 	echo "$description" >>"$tagdir/tag"
 fi
+if [ "$msgfile" ]; then
+	if [ ! -r $msgfile ]; then
+		rm -rf "$tagdir"
+		die "error signing the tag: cannot read $msgfile"
+	fi
+	cat $msgfile >>"$tagdir/tag"
+fi
 if [ "$sign" ]; then
 	echo >>"$tagdir/tag"
 	if ! gpg ${keyname:+--default-key "$keyname"} -bsa "$tagdir/tag"; then
