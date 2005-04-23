From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Humble request of 'git' developers + [PATCH] Slight enhancement of GIT wrapper
Date: Sun, 24 Apr 2005 01:47:29 +0200
Message-ID: <200504240147.29642.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 24 01:42:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUG9-0005Gj-VJ
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVDWXqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVDWXqt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:46:49 -0400
Received: from av2.karneval.cz ([81.27.192.108]:54061 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S262184AbVDWXqi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:46:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by av2.karneval.cz (Postfix) with ESMTP id AEB5DA2E69;
	Sun, 24 Apr 2005 02:10:24 +0200 (CEST)
Received: from av2.karneval.cz ([127.0.0.1])
 by localhost (av2 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10195-09; Sun, 24 Apr 2005 02:10:22 +0200 (CEST)
Received: from mail.karneval.cz (mx1.karneval.cz [81.27.192.53])
	by av2.karneval.cz (Postfix) with ESMTP id CD051A2E4D;
	Sun, 24 Apr 2005 02:10:22 +0200 (CEST)
Received: from [10.5.150.25] (unknown [10.5.150.25])
	by mail.karneval.cz (Postfix) with ESMTP id 3CBEF56F5BF;
	Sun, 24 Apr 2005 01:46:34 +0200 (CEST)
To: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.8
Content-Disposition: inline
X-Virus-Scanned: by karneval.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello All,

I am resending patch from 13 April
which I have send Petr Baudis.
He has said, that he combines
best ideas from more similar patches
but he has not found time for that probably.
It is updated according his
and Johannes Schindelin's remarks.

It enables to move all growing number
of git scripts and programs to the any
directory out of the search path.
Actually only "git" script needs to be
linked symbolically to some directory
on the search path. This solution worked
for me with many versions of "git-pasky".

I would vote for this solution
and for single public exposed multiplexer
executable script.
It is how big portable place independent
projects solve hiding of garbage from
the search path.

Best wishes

                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com




Slight enhancement of GIT wrapper

Git multiplexer and scripts can reside in non PATH directories
and linking git multiplexer into some searchables dirs makes the trick.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

--- git.orig	2005-04-24 00:12:56.000000000 +0200
+++ git	2005-04-24 01:28:01.000000000 +0200
@@ -17,6 +17,28 @@
 	exit 1
 }
 
+if [ -z "$GIT_TOOLS_DIR" ] ; then
+	GIT_MUXBINARY_DIR="$(dirname "$0")"
+	if [ -h "$0" ]; then
+		#GIT_TOOLS_DIR="$(ls -l "$0" | sed 's/^.*-> *\(.*\) *$/\1/')"
+		GIT_TOOLS_DIR="$(ls -L "$0")"
+	        GIT_TOOLS_DIR="$(dirname "$GIT_TOOLS_DIR")"
+		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; cd "$GIT_TOOLS_DIR" ; pwd )"
+	else
+		GIT_TOOLS_DIR="$(cd "$GIT_MUXBINARY_DIR" ; pwd )"
+	fi
+
+	if [ -z "$(echo :$PATH: | sed -n -e 's#:'"$GIT_TOOLS_DIR"':#yes#p' )" ] ; then
+		export PATH="$GIT_TOOLS_DIR:$PATH"
+	fi
+
+	export GIT_TOOLS_DIR
+fi
+
+#echo GIT_TOOLS_DIR=$GIT_TOOLS_DIR
+#echo PATH=$PATH
+#echo CWD=$(pwd)
+#exit 
 
 help () {
 	cat <<__END__
