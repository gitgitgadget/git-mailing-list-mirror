From: Brian Harring <ferringb@gmail.com>
Subject: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Tue, 3 Jan 2012 05:46:03 -0800
Message-ID: <20120103134603.GA31034@localhost>
References: <20120103011352.GA13825@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 14:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri4gu-0000Wb-1O
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 14:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab2ACNqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 08:46:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35544 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab2ACNqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 08:46:06 -0500
Received: by iaeh11 with SMTP id h11so30914082iae.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MCKi5aUmR0bke407mXB7vMaCSbzCEw4DZUi+/mrMHNs=;
        b=MMseC31/dGgNW+FQVoif8CJx4PTQ6zWx6iNTTTMYXzJOy1e/gCWQA1j3E3EazvDOMt
         AocuL3cQg+FbZgW65W4NMG34LL0ThzwXBmUhokdeK1jhtXPD7ftE8Dzyxr/WGMbOFb/H
         P1kSflkSLKXZbXWVfjkxyG4sVjgbsHReNzSKw=
Received: by 10.50.155.195 with SMTP id vy3mr62271095igb.12.1325598365947;
        Tue, 03 Jan 2012 05:46:05 -0800 (PST)
Received: from smtp.gmail.com:587 (74-95-192-101-SFBA.hfc.comcastbusiness.net. [74.95.192.101])
        by mx.google.com with ESMTPS id z22sm177285172ibg.5.2012.01.03.05.46.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Jan 2012 05:46:05 -0800 (PST)
Received: by smtp.gmail.com:587 (sSMTP sendmail emulation); Tue, 03 Jan 2012 05:46:03 -0800
Content-Disposition: inline
In-Reply-To: <20120103011352.GA13825@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187862>

git-repo if interupted at the exact wrong time will generate zero
length bundles- literal empty files.  git-repo is wrong here, but
git fetch shouldn't effectively spin loop if pointed at a zero
length bundle.

Signed-off-by: Brian Harring <ferringb@chromium.org>
---
 bundle.c          |    4 ++--
 t/t5704-bundle.sh |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4742f27..b8acf3c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -31,8 +31,8 @@ static int strbuf_readline_fd(struct strbuf *sb, int fd)
 	while (1) {
 		char ch;
 		ssize_t len = xread(fd, &ch, 1);
-		if (len < 0)
-			return -1;
+		if (len <= 0)
+			return len;
 		strbuf_addch(sb, ch);
 		if (ch == '\n')
 			break;
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 728ccd8..4ae127d 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -53,4 +53,10 @@ test_expect_failure 'bundle --stdin <rev-list options>' '
 
 '
 
+test_expect_success 'empty bundle file is rejected' '
+
+    >empty-bundle && test_must_fail git fetch empty-bundle
+
+'
+
 test_done
-- 
1.7.8.2
