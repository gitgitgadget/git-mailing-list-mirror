From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] git-am: fix maildir support regression for unordered headers in emails
Date: Wed, 15 Jul 2009 07:52:36 +0200
Message-ID: <2433101adeafddeab78815083446552ff3ea9f49.1247636959.git.nicolas.s.dev@gmx.fr>
References: <20090714122354.GA13806@vidovic>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 07:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQxQc-0007EI-CP
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 07:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZGOFxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZGOFxI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 01:53:08 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:55255 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbZGOFxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 01:53:07 -0400
Received: by ewy26 with SMTP id 26so3788444ewy.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=nwuh00pUMPQZqnrjIhTgDDTalJIw/ggVJsnXNjiNBeI=;
        b=uPvXU+SR/2LM9mZJ5239ZCpAn6KCENU8u/F+ejEILb77+t1w1wyagRVGH6HDA4lwRz
         wCeocRC+Vw/KfmY+KUIh5O9XGmtfQ0MEkjDTouxkv9JLZ8N96go1i2JI2D4nkWc7fy7d
         QE/H75zPw8QeeyOt9ZuH82vSowqxm6bcEBng4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=T/+Y15MaMWWQm3BUF9RTlpV2qggEMTPzBkpxloUa0iTjp95ICVS+/nKnWRNFoBa7MF
         XgBo3iSQIKF9Eyh5wcTMkMd/fk7I/xFJdgm5xVQ1ZnOyvjKVXTsip/jrB+RZ4VTJwhYo
         c1UQx60bdOToinkEv85K10pPy554LKpunqsG4=
Received: by 10.210.110.2 with SMTP id i2mr8783662ebc.8.1247637186110;
        Tue, 14 Jul 2009 22:53:06 -0700 (PDT)
Received: from localhost (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 7sm2199070eyb.25.2009.07.14.22.53.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 22:53:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.129.gf738
In-Reply-To: <20090714122354.GA13806@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123286>

Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
may refuse valid patches from verbatim emails.

Emails may have header fields in a random order.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 git-am.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..18e53d0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -146,6 +146,7 @@ clean_abort () {
 }
 
 patch_format=
+is_verbatim_email=
 
 check_patch_format () {
 	# early return if patch_format was set from the command line
@@ -191,6 +192,15 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		# Keep maildir workflows support.
+		# Verbatim emails may have header fields in random order.
+		is_verbatim_email='true'
+		for line in "$l1" "$l2" "$l3"; do
+			printf "$line" | grep --quiet --extended-regexp '^([^\ ])+: +.*' ||
+				is_verbatim_email='false'
+		done
+		# next treatments don't differ from mailbox format
+		[[ $is_verbatim_email == 'true' ]] && patch_format=mbox
 	} < "$1" || clean_abort
 }
 
-- 
1.6.4.rc0.129.gf738
