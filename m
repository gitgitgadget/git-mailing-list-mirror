From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: __git_config_get_set_variables() handle values with spaces
Date: Mon, 29 Jun 2009 22:08:38 -0700
Message-ID: <1246338518-9030-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 07:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLVeo-00010v-Br
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 07:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbZF3FIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 01:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbZF3FIm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 01:08:42 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:34198 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZF3FIl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 01:08:41 -0400
Received: by pxi28 with SMTP id 28so3829208pxi.33
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=BHkR8H3o03EdvbxGu41Vl5kjWGBzTd1Az6ig7+RcfVA=;
        b=RVvRfg08xE/AVzrEVXNvB4bom1tHo1By4tGmR1uZvHAwSKKy8z7wq8Md8Tei/3TAc3
         34HyG6FB04Y0YGh5RkEqyogp/q9kVO1dDRGJQs/pO6VvzdRbRnd0czewm/kyfMfHHDuy
         v/gszYc5ktkLN4Z1GTezpJtURcm73JxBZxck0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VOyH9AKIw7KyN4CfZlPTF7jYi/NQAv5Wq5025t5QVK8V5lifWDwOJk1meB6Cs8aJPQ
         vXHJmrBvdtLjCXc/iZcTo74uHHlFEai7/FU8kmlWsINbBsYbTFxLNfHsX/Dv1n8dfRUL
         XErwkS774dEzHdwcBwk1Sau725H60u1u1ooFI=
Received: by 10.114.205.8 with SMTP id c8mr8512940wag.31.1246338522365;
        Mon, 29 Jun 2009 22:08:42 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id j31sm1437084waf.68.2009.06.29.22.08.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 22:08:41 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 29 Jun 2009 22:08:38 -0700
X-Mailer: git-send-email 1.6.3.3.353.g4f2b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122485>

Commit 0065236 (bash completion: complete variable names for "git
config" with options 2009-05-08) implemented its config variable search
wrong. When a config contains a value with a space and a period (.) in
it, completion erroneously thinks that line in the configuration is
multiple config variables.

For example

 $ cat .git/config
   format.cc = Junio C Hamano <gitster@pobox.com>

 $ git config --unset <TAB>
   format.cc
   <gitster@pobox.com>

Instead of using a for loop splitting across spaces, pipe each line to a
while read loop and beef up the case statement to match only
'config.variable=value'.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b60cb68..d676f9d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1357,11 +1357,12 @@ __git_config_get_set_variables ()
 		c=$((--c))
 	done
 
-	for i in $(git --git-dir="$(__gitdir)" config $config_file --list \
-			2>/dev/null); do
-		case "$i" in
-		*.*)
-			echo "${i/=*/}"
+	git --git-dir="$(__gitdir)" config $config_file --list 2>/dev/null |
+	while read line
+	do
+		case "$line" in
+		*.*=*)
+			echo "${line/=*/}"
 			;;
 		esac
 	done
-- 
1.6.3.3.353.g4f2b1
