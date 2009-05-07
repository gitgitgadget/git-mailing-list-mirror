From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] completion: add find_argument_and_value() function
Date: Wed,  6 May 2009 23:18:12 -0700
Message-ID: <1241677093-29937-1-git-send-email-bebarino@gmail.com>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 08:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wwT-00076d-UF
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 08:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZEGGSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 02:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbZEGGSm
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 02:18:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:12999 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbZEGGSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 02:18:41 -0400
Received: by rv-out-0506.google.com with SMTP id f9so453669rvb.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=tKBawrtpJjBnpR+g5y3pTVlrEHKhS8mB0Fee0vRkbX8=;
        b=O+PwNE32u1QJ2146TR71AiSw6ZsX5GvaMd4MH68hZ1omCDvOUvM5jU1fMphSdrBKTV
         DAxzwVcNsp6aeom511t7b8OaBiSxI3zQbsFGDIH/t6z6zRAPHvPHomxd4hnbRtW6IUzY
         W7Y7c7msh7SUmtlt9cK0l11nL/AjuISh1DPnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sUelPVyHBKFkVC5nzK4wcEYw4TbUIncihLEXSV/rHmA0dNT2ipdp1I3yfdfJ7oBZs8
         0JxABtrRYikh6ijnAH93VuglJ1DO/KZIGSIKT2pmTbfspGV0+Mt8R2cko2o4SrhCG5GH
         EYPhcICOiIbIvIwCDKhQfBQQcvK0F0ecV5z5A=
Received: by 10.140.201.8 with SMTP id y8mr943068rvf.160.1241677121214;
        Wed, 06 May 2009 23:18:41 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id l31sm2838013rvb.39.2009.05.06.23.18.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 23:18:35 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 06 May 2009 23:18:13 -0700
X-Mailer: git-send-email 1.6.3.rc4.29.g8146
In-Reply-To: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118430>

Add a function to get arguments and their associated value. This is used
by the config completion to find config file arguments.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I'm not sure if this is correct. It works for the case I have, but
others I'm not so sure. Let's just say I'm no bash expert.

 contrib/completion/git-completion.bash |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 72a16a1..f179cc8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -618,6 +618,31 @@ __git_find_subcommand ()
 	done
 }
 
+# __git_find_argument_and_value requires 1 argument
+__git_find_argument_and_value ()
+{
+	local word nextword argument c=1
+
+	while [ $c -lt $COMP_CWORD ]; do
+		word="${COMP_WORDS[c]}"
+		for argument in $1; do
+			if [ "${argument##--}" = "${word##--}" ]; then
+				nextword=${COMP_WORDS[$((c+1))]}
+				if [ "${nextword#-}" != "$nextword" ]; then
+					nextword=
+				fi
+				echo "$argument $nextword"
+				return
+			fi
+			if [ "${argument/=*/}" = "${word/=*/}" ]; then
+				echo "$word"
+				return
+			fi
+		done
+		c=$((++c))
+	done
+}
+
 __git_has_doubledash ()
 {
 	local c=1
-- 
1.6.3.rc4.29.g8146
