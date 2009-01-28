From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 1/2] git-am: emit usage when called w/o arguments and w/o patch on stdin
Date: Tue, 27 Jan 2009 22:27:41 -0500
Message-ID: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 04:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS178-0008R2-RM
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbZA1D1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZA1D1q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:27:46 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50370 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZA1D1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:27:46 -0500
Received: by qyk4 with SMTP id 4so7717751qyk.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 19:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=45V64kiVjKdIeIWmQHJdsPlOfAhx7GWJ9an20dsq5UY=;
        b=gVFpU6jEFNqOd3COdAjkUfuYuUC2rwYwXxjYCBac4yIwnM0BItfuo7iuYzCi+VKfs+
         X5me3NLR71wwuOJKZqrsvcc4L5Q3yo8bBhzRQy1QVULVbssyZZxQnB+ZHPvaE2fRsorE
         OT7aQNW873ARnEQ3E4nZm6DyoV2YwlW7M/kuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=vdRbBY8T1bgBUUHXpXRE/+TYURF3RzXZP3fMvt5zZh3iSUzm5XqSTyVN8JW4PofXKL
         nCkWHB2THSGEbNZ2bO1QKSbOFm/CxuIwX1lEgq/4riyAOV5tUy45fUG+sm03RjmOcwMo
         XqL7WYRGb1QH6+vfdC0S0lPb3ETWOxRjBh59Q=
Received: by 10.214.44.8 with SMTP id r8mr469126qar.81.1233113264855;
        Tue, 27 Jan 2009 19:27:44 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 5sm1519940ywd.32.2009.01.27.19.27.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 19:27:44 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107461>

When git am is called w/o arguments, w/o a patch on stdin and the user hits
ctrl-c, it leaves behind a partially populated $dotest directory. After this
commit, it emits usage when called w/o arguments and w/o a patch on stdin.

Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
while it is processing input, but not if mailsplit exits non-zero due to
error.

Noticed by Sverre Rabbelier

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Change from v1: don't remove $dotest if mailsplit exits non-zero

 git-am.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b1c05c9..65285a0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -254,10 +254,13 @@ else
 		done
 		shift
 	fi
-	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-		rm -fr "$dotest"
+	test $# = 0 && test -t 0 && usage
+	trap 'rm -fr "$dotest"' 0
+	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" || {
+		trap - 0
 		exit 1
 	}
+	trap - 0
 
 	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
-- 
1.6.1.224.gb56c
