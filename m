From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 2/6] t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
Date: Fri,  8 Jan 2010 10:12:41 +0800
Message-ID: <1262916765-3728-3-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
 <1262916765-3728-2-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4Mj-0005XW-N1
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab0AHCNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347Ab0AHCNf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:35 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:57251 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0AHCNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:32 -0500
Received: by gxk3 with SMTP id 3so8201271gxk.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:references;
        bh=aBGLgazr/gX+rbTwRh40TW1ge6WLTRCROpkZf6PY1MM=;
        b=rxUwKASECzjThRMTvJSUDAfF918KUX2ChUc5/5ZdlG4pR17wCuhR9Yv9URjH69OoLT
         Ql+p74ZDl8CHMIMPwppLcTFSY/3TJTG063pbEMR7O0jzc1XSHoHcQm6uSawgEepN/VWK
         JNqNKTbN8AdrAr8C1Thw1KW7jxajEoyYw+ouI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NFfEoXf27BbAKcXR1X/CY8CW4eGLZlAOginVaIzkQ/1ap5oFQwoGo3ugcXeiaPD51k
         F3MigLzOep7jaLAzyW53imoFqSagsW/bOBZkR9Ngvf5uNMBfqwatUVC2DkAreFNaPyxI
         /0x+XLe5qt43aGT+8q3RgCSfIet7ReFGfyg+o=
Received: by 10.91.19.17 with SMTP id w17mr1589460agi.54.1262916810655;
        Thu, 07 Jan 2010 18:13:30 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:29 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-2-git-send-email-rctay89@gmail.com>
References: <20091224154158.15ba580f.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136407>

Some refs can only be matched to a remote ref with an explicit refspec.
When such a ref is a non-fast-forward of its remote ref,  test that
pushing them (with the explicit refspec specified) fails with a non-
fast-foward-type error (viz. printing of ref status and help message).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed from v3:
 - Reworded commit message
 - Reword the comments
 - Used '*' instead of '\+' for grep expressions
 - Used [a-f0-9] instead of [a-z0-9] for matching hexadecimals
 - Used ' ' instead of '[ ]' for matching SP

 t/t5541-http-push.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index f49c7c4..cc740fe 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -111,5 +111,26 @@ Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
 section of '"'git push --help'"' for details." output
 '

+test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
+	# create a dissimilarly-named remote ref so that git is unable to match the
+	# two refs (viz. local, remote) unless an explicit refspec is provided.
+	git push origin master:retsam
+
+	echo "change changed" > path2 &&
+	git commit -a -m path2 --amend &&
+
+	# push master too; this ensures there is at least one '"'push'"' command to
+	# the remote helper and triggers interaction with the helper.
+	!(git push -v origin +master master:retsam >output 2>&1) &&
+
+	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
+	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output &&
+
+	grep \
+"To prevent you from losing history, non-fast-forward updates were rejected
+Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
+section of '"'git push --help'"' for details." output
+'
+
 stop_httpd
 test_done
--
1.6.6.341.ga7aec
