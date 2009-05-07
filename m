From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] completion: add find_argument_and_value() function
Date: Wed,  6 May 2009 23:15:05 -0700
Message-ID: <1241676906-29783-2-git-send-email-bebarino@gmail.com>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 08:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wtj-0006CX-18
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 08:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZEGGPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbZEGGPe
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 02:15:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29028 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZEGGPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 02:15:33 -0400
Received: by wa-out-1112.google.com with SMTP id j5so332960wah.21
        for <git@vger.kernel.org>; Wed, 06 May 2009 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=tKBawrtpJjBnpR+g5y3pTVlrEHKhS8mB0Fee0vRkbX8=;
        b=g6Ke02UE7kGbp6W/5vsohB9QkG/LOocikef0oRq9/wN+CUsdg8uOu7iVDKNJ8QS/YO
         en7ncobIk9yS4JFbEhT8mCWVOimm/lydEBI4Qzu5nyySf+WWwP1uEIoIN6yGWUr/jhIh
         jIppcYnNh6E8+gxn2WeFY7JphABENXBHhjO+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lL4ESkh6l4XigOvEkz7R7equURLkBKSDY/UMvKhSwQgLtXspAT0K/YBIDsKnv2FZAP
         DxMqL/d1+6q+9SCvr8OuGOEx5gnPdjLTsUyglVzUOQ4udvPcioX6lRnMPJZigkKnMqKa
         VJj/Ytvdgz95oczGOHEXQyJMTfzwkKXENsQmk=
Received: by 10.114.125.18 with SMTP id x18mr2010653wac.220.1241676933721;
        Wed, 06 May 2009 23:15:33 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id v25sm14291642wah.32.2009.05.06.23.15.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 23:15:32 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 06 May 2009 23:15:24 -0700
X-Mailer: git-send-email 1.6.3.rc4.29.g8146
In-Reply-To: <1241676906-29783-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118429>

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
