From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 2/4] git-am foreign patch support: autodetect some patch formats
Date: Tue,  2 Jun 2009 01:10:39 +0200
Message-ID: <1243897841-8923-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 01:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBGf1-0003zM-TP
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbZFAXKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbZFAXKy
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:10:54 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:57382 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbZFAXKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:10:52 -0400
Received: by fxm12 with SMTP id 12so6124507fxm.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VTTG1LoRn4o8P6JURkAxSKvbLkH6Ou319yICwAzDWhc=;
        b=Kg4YIfScHpYng5YreOkJdwH8gVL2umiGYM/Anx41lU4/yIWSX/yNdNbWm2/fML5Ljm
         tb2mBOE2U2qY3IaXUt2cj5kmgfiSIudqdvGuVBNERW2FSbElPyreZu+yXGdl6WPWKEF0
         JprfaNHtEyW0xINUzjX7eWowpFXdgRQuzxfjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jfWIcq1SFW54m9DSwWyNKyUxH9wdu800RtmO47VlevcksDH39kKA71thTvsf4mUa/K
         axUnejvZlt+p1zt3LhbnxCmUZQHtsHIntdHwE8LQH3XSpkC/8szzOVAO7pxBeq5iHl+K
         a7wg4mcI3pyfi4omQXWCrwXGcUAh4kYQHUgcQ=
Received: by 10.204.31.75 with SMTP id x11mr6278096bkc.0.1243897852333;
        Mon, 01 Jun 2009 16:10:52 -0700 (PDT)
Received: from localhost (host-78-13-53-56.cust-adsl.tiscali.it [78.13.53.56])
        by mx.google.com with ESMTPS id c28sm7910944fka.49.2009.06.01.16.10.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 16:10:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
In-Reply-To: <1243897841-8923-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120488>

Default to mbox format if input is from stdin. Otherwise, look at the
first few lines of the first patch to try to guess its format.

Include checks for mailboxes, stgit patch series, stgit single patches
and hg patches.
---
 git-am.sh |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index da160de..8519701 100755
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
+		"From "*|"From: "*)
+			patch_format=mbox
+			;;
+		'# This series applies on GIT commit'*)
+			patch_format=stgit-series
+			;;
+		"# HG changeset patch")
+			patch_format=hg
+			;;
+		*)
+			# if the second line is empty and the third is
+			# a From, Author or Date entry, this is very
+			# likely an StGIT patch
+			case "$l2,$l3" in
+			,"From: "*|,"Author: "*|,"Date: "*)
+				patch_format=stgit
+				;;
+			*)
+				;;
+			esac
+			;;
+		esac
+	} < "$1"
 }
 
 split_patches () {
-- 
1.6.3.1.282.g9f93
