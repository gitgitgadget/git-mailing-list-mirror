From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/4] git-am foreign patch support: autodetect some patch formats
Date: Wed, 27 May 2009 11:25:17 +0200
Message-ID: <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 11:26:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9FOj-0007o4-0K
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 11:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbZE0JZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 05:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757047AbZE0JZe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 05:25:34 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:34862 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200AbZE0JZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 05:25:30 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so2679773fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BqHQJwvXdfIzRlThAxkBo1UD9BiS/PYBplcUDdbRBDA=;
        b=pGOl+AACIaTyDo8R72KACE/zvReEEIB+zBzUjdAc5jWzekFD6yIB7TJkj3DUdAyF8T
         ADWtYALpa3SZAGEkFr/TWA4xmxtpqWj2jFD0LdlFOGmPHk/5A9WykZUaiy2mODbeDNgw
         LT3GHsrPi1IgsPe1WIXYy1CY9iOa275ZhDD3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mhjXvAR5SKx+7WkxgC5r0zt9tuNVjE8+EZORS7UzIvbbBscDNG5ia+mkOz01ORi1xo
         9XQ640dcUj63NXb0rN51/6Ep91W4uy6MzdBpoImqfcq0QZqPeKBCGKgSVsJLCEYr02Mc
         8ZgWiIJ5H5r8c+4n/s3eC6FARBwGOgj23k8oE=
Received: by 10.103.137.12 with SMTP id p12mr4903975mun.94.1243416332342;
        Wed, 27 May 2009 02:25:32 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id w5sm2268199mue.34.2009.05.27.02.25.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 02:25:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
In-Reply-To: <1243416319-31477-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120052>

Default to mbox format if input is from stdin. Otherwise, look at the
first few lines of the first patch to try to guess its format.

Include checks for mailboxes, stgit patch series, stgit single patches
and hg patches.
---
 git-am.sh |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index da160de..192ad1e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -142,7 +142,45 @@ check_patch_format () {
 	then
 		return 0
 	fi
-	patch_format=mbox
+
+	# we default to mbox format if input is from stdin and for
+	# directories
+	if test $# = 0 || test "x$1" = "x-" || test -d "$1"
+	then
+		patch_format=mbox
+		return 0
+	fi
+
+	# otherwise, check the first few lines of the first patch to try
+	# to detect its format
+	{
+		read l1
+		read l2
+		read l3
+		case "$l1" in
+			"From "*|"From: "*)
+				patch_format=mbox
+				;;
+			'# This series applies on GIT commit'*)
+				patch_format=stgit-series
+				;;
+			"# HG changeset patch")
+				patch_format=hg
+				;;
+			*)
+				# if the second line is empty and the third is
+				# a From, Author or Date entry, this is very
+				# likely an StGIT patch
+				case "$l2,$l3" in
+					,"From: "*|,"Author: "*|,"Date: "*)
+						patch_format=stgit
+						;;
+					*)
+						;;
+				esac
+				;;
+		esac
+	} < "$1"
 }
 
 split_patches () {
-- 
1.6.3.1.274.gd2e8.dirty
