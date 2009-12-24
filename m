From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched,
 non-fast-forwarded refs
Date: Thu, 24 Dec 2009 15:41:58 +0800
Message-ID: <20091224154158.15ba580f.rctay89@gmail.com>
References: <20091224154057.33611ae7.rctay89@gmail.com>,
 <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiKu-0005Wr-ID
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbZLXHmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbZLXHmM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:42:12 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:32960 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbZLXHmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:42:11 -0500
Received: by yxe17 with SMTP id 17so7443903yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Zbnj4VBDBcMWHFAIhRt7zR4U1NxPAcQySX1u1lHdoWo=;
        b=UoqMlfxTPhpFS+mEpX0HOqONH/0Uis/s5Ax30Vf3m1xVDw38qjvBDY12BHmKrdjMLE
         H75pR8dy6sJE5jlVy2HycSLOENhhnPbEipRrRio45kODk29cIA/FNtY+T55iRmTWekQY
         mMNTmQP/apPWRvKm5p2PIkZFpofdg0Fwzsf04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=AHo8w+rbnp52ruyMRAhIm0GlucAJ99rO7byo0gqSRlAENj4VFlE0s/mTL6J9lkBOrT
         hdI/gpJF8KKx3hFgKYfniXUorINkc3YQdY0VbV4JwbfErUj2cr2JF8pjXCUZY46eCL3J
         yDz8V70j01xCWpr7Cq/m1SzVkydk8z/sLznAw=
Received: by 10.90.21.8 with SMTP id 8mr5217011agu.97.1261640525591;
        Wed, 23 Dec 2009 23:42:05 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 16sm4259241gxk.11.2009.12.23.23.42.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:42:05 -0800 (PST)
In-Reply-To: <20091224154057.33611ae7.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135645>

Test that when non-fast-forwarded refs cannot be matched without an
explicit refspect, the push fails with a non-fast-forward ref status and
help message.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index f49c7c4..5ebe04a 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -111,5 +111,25 @@ Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
 section of '"'git push --help'"' for details." output
 '

+test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
+	# create a dissimilarly-named ref so that git is unable to match the refs
+	git push origin master:retsam
+
+	echo "change changed" > path2 &&
+	git commit -a -m path2 --amend &&
+
+	# push master too. This ensures there is at least one '"'push'"' command to
+	# the remote helper and triggers interaction with the helper.
+	!(git push -v origin +master master:retsam >output 2>&1) &&
+
+	grep "^ + [a-z0-9]\+\.\.\.[a-z0-9]\+[ ]*master -> master (forced update)$" output &&
+	grep "^ ! \[rejected\][ ]*master -> retsam (non-fast-forward)$" output &&
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
1.6.6.rc1.249.g048b3
