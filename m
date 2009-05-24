From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] git-am: support StGit patch series
Date: Sun, 24 May 2009 09:19:18 +0200
Message-ID: <1243149558-17160-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 24 09:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M87zk-0005bT-1O
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 09:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbZEXHTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 03:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbZEXHTe
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 03:19:34 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:64843 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbZEXHTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 03:19:32 -0400
Received: by mail-bw0-f174.google.com with SMTP id 22so2436821bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JgXhmnEGlOYz4EJQ2cD+9IljSuC5dnydQJqb2fDNVOk=;
        b=VErTSdiBtfJSzL6nJDaFZyGqVJDWuTRNA8J8h4DkE6k7BpxoSPG++t0Yx6XmNWwcDp
         bQcBIrIfsRhVz2V+ELVpCh42YrmlJU97CL0TruS6oN/VLJNsTcWNzx8GyazdMwSpzIF+
         BrN6/9sQDYpqkAEOy9ZzeyYqypfv2XIYdYDrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=D7BEaUBm4570vO7yvulloZxZGQHt83CucLZjQWwHC3rfMvoz0mDzw3zLHn8871Qtl2
         2OaNA+3x0BiOiwj3mFYhz2Bf7Pzxx/9pahMHU2SA6dYF8u9+NN0awevTwyFC2pTeNe7V
         HZ2SLW5aaUZV6ScK5B/Hzm/a+SngDCsBsD7wg=
Received: by 10.103.247.14 with SMTP id z14mr2903990mur.70.1243149573721;
        Sun, 24 May 2009 00:19:33 -0700 (PDT)
Received: from localhost (host-78-15-2-20.cust-adsl.tiscali.it [78.15.2.20])
        by mx.google.com with ESMTPS id t10sm4606097muh.0.2009.05.24.00.19.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 00:19:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.212.g6c0d3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119813>

Stacked Git exports patch series with an 'index', a file containing
the list of the exported patches by filename. The file can be detected
by the '# This series applies on GIT commit somehash' header, and in
such a case git-am can replace its argument list with the list of files
taken from the index, proceeding then to import the whole series.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 578780b..d65e3c1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -274,6 +274,28 @@ else
 		done
 		shift
 	fi
+	# if a single argument was passed, check if it's a StGit patch series
+	# index by checking if the first line begins with '# This series'
+	if test $# = 1
+	then
+		read is_sharp is_this is_series is_therest < "$1"
+		if test x"$is_sharp $is_this $is_series" = 'x# This series'
+		then
+			# replace the argument list with the files listed
+			# in the series index, prefixing them with the
+			# series index dirname
+			series_dir=`dirname "$1"`
+			while read filename
+			do
+				set "$@" "$series_dir/$filename"
+			done < "$1"
+			# remove the series index name
+			shift
+			# and skip the first line of the series
+			# index, which was the comment
+			shift
+		fi
+	fi
 	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
 		rm -fr "$dotest"
 		exit 1
-- 
1.6.3.1.212.g6c0d3.dirty
