From: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
Subject: [PATCH] request-pull: return the entered branch if more branches
 are at the same commit
Date: Thu, 08 Apr 2010 00:22:36 +0200
Organization: Home
Message-ID: <1270678956.27317.34.camel@neo>
Reply-To: Lars.Jarnbo.Pedersen@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:22:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzde2-0001sg-9P
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab0DGWWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 18:22:41 -0400
Received: from mail-ew0-f222.google.com ([209.85.219.222]:59557 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab0DGWWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 18:22:40 -0400
Received: by ewy22 with SMTP id 22so776078ewy.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=q1qLv3eQLRHkRyPs2fK8/nXYrL2t27/dPdaYWMh8WWw=;
        b=g90Fm7lNnJgZRBOPWL/md7H/O+8sLG2RnM4yR9eRHCPEO5OZLfRbPc8d8TMmQT34El
         MxWOX3b6lVRYWM5ky5zYib4UOZprU2Y8oo1mCBcwfwPK2ONaa9+PoDQ5ctjXbYepDlcp
         RzgfVEx5yY0rJJCjn7nUbbEvUsn3cHLFuVwe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=LxH6cSw6goi6nSoI4lbhkfLwXhiNb8xi+kXCdUIwao8xXNQt12DIzFNrZJjenlHQ8f
         pNUBmxizkllzxL1P6ShB3UDpAeyXL34BsLm88jWbO21YIpTiIoe3I/R9/TtzQOV3HFaj
         RwDM3fXx2UGeOrSyEPBpb4c3bigMlM9LsWyCQ=
Received: by 10.213.37.71 with SMTP id w7mr5936888ebd.61.1270678958419;
        Wed, 07 Apr 2010 15:22:38 -0700 (PDT)
Received: from [192.168.1.109] (port137.ds1-kj.adsl.cybercity.dk [217.157.186.14])
        by mx.google.com with ESMTPS id 13sm973161ewy.9.2010.04.07.15.22.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 15:22:38 -0700 (PDT)
X-Mailer: Evolution 2.28.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144291>

Currently request-pull identifies the branch to pull from by finding the commit
using rev-parse and then identifying the branch from the commit using ls-remote.
If more branches are pointing to the same commit the first will be chosen even
if the one we entered in the command-line exist.

This change returns the same branch as entered at the commandline if it exists in refs/heads.

Signed-off-by: Lars Jarnbo Pedersen <lars.jarnbo.pedersen@gmail.com>
---
 git-request-pull.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 8fd15f6..787383f 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -49,11 +49,21 @@ merge_base=`git merge-base $baserev $headrev` ||
 die "fatal: No commits in common between $base and $head"
 
 branch=$(git ls-remote "$url" \
+	| sed -n -e "/^$headrev	refs.heads.$head/{
+		s/^.*	refs.heads.//
+		p
+		q
+	}")
+
+if [ -z "$branch" ]; then
+    branch=$(git ls-remote "$url" \
 	| sed -n -e "/^$headrev	refs.heads./{
 		s/^.*	refs.heads.//
 		p
 		q
 	}")
+fi
+
 url=$(get_remote_url "$url")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
-- 
1.7.1.rc0.1.ga751b
