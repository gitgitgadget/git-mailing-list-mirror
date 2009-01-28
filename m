From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/2] git-am: emit usage when called w/o arguments and w/o patch on stdin
Date: Tue, 27 Jan 2009 21:38:57 -0500
Message-ID: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 03:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0M4-0007pw-VM
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 03:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbZA1CjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 21:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZA1CjF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 21:39:05 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:39177 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZA1CjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 21:39:02 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3274629qwe.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 18:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=df2RqQYbcUkNqogB1t34GiuJCDd9AYqmFQDbpzP+Qlo=;
        b=qH1aJ1fdRTRpAw4wS4tYbuAolGXXQU8PFY8OCJ71wuQFgabCh1F1QzouapaO0JKTLs
         X84zf3WtbkGyfaKqU38RSdx1BMl6de45SoZ9VHO3E9X094Z77z0r+HMhGWY8cNON7de0
         ONvcYPL5n89FZnoxik3gEiIGFlKrtKNyPIe4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=JhkwBS2QHxCtUzhd5ko87MCbMP4PKmNa5cgDeZZ4IrNQEWpBWMakcHn5s0tNGgL6L1
         p61Nnu2mP5hxzDFd4vO8sXbOU6nBJNUvbqX1tcGda+Yk7Vshyu6BFPnl9jc2LefXKMv6
         bBUuElsMrSRE7XXr7udOANLWRQ5GZPCp7x+ik=
Received: by 10.215.15.6 with SMTP id s6mr8717584qai.117.1233110341326;
        Tue, 27 Jan 2009 18:39:01 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 6sm3582568ywc.49.2009.01.27.18.39.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 18:39:00 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107454>

When git am is called w/o arguments, w/o a patch on stdin and the user hits
ctrl-c, it leaves behind a partially populated $dotest directory. After this
commit, it emits usage when called w/o arguments and w/o a patch on stdin.

Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
while it is processing input.

Noticed by Sverre Rabbelier
---
 git-am.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b1c05c9..36227c6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -254,10 +254,10 @@ else
 		done
 		shift
 	fi
-	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
-		exit 1
-	}
+	test $# = 0 && test -t 0 && usage
+	trap 'rm -fr "$dotest"' 0
+	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" || exit 1
+	trap - 0
 
 	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
-- 
1.6.1.224.gb56c
