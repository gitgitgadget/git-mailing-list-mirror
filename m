From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v2] tg-create.sh: Support for multiple {to,cc,bcc} options
Date: Sat,  9 Aug 2008 20:48:56 +0200
Message-ID: <1218307736-24891-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 20:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRtVv-0007TQ-KH
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbYHIStD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYHIStD
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 14:49:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:17506 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYHIStA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 14:49:00 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2341817mue.1
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qdHHj6SIFUmRj+Dm6oOxvONHBRpHbqw+MlM0/VJi+xM=;
        b=XvkCdlV3f/1ul5wIbM75JBUyEQV9vkKSculwhjmBbeCWCluyeBjkA/zV6z6s72k+8I
         2EfStcIC1hXNVNAyYKUic5HTr8gLTUu8A0BVNWu9ydAAHF84I2sDwNNqOjy3dFwhiL6L
         +5sccgxbQyKCv3N05oNSr8rjQycbK/ETwxmtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uPMiE9CDhuXI+Vc+nrmBt/YU/oLTJgcoNcEPH3ot6IjMUIi70+vB6TaClI46f1oF3/
         +oirmxjxd94IbNtzt5si/grmIRVjPrt2R6/7kFYBaQn0cfUv1MDEmB3LdbJXMDNZ3Q1u
         AgVVo5UuoVh1xotWXh1s8kS/2dK3YI7T6Mi7U=
Received: by 10.103.238.4 with SMTP id p4mr4291188mur.66.1218307738877;
        Sat, 09 Aug 2008 11:48:58 -0700 (PDT)
Received: from localhost ( [91.15.112.251])
        by mx.google.com with ESMTPS id j9sm565284mue.5.2008.08.09.11.48.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Aug 2008 11:48:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91773>

Git config supports multiple values for the same config key, so support it
for these TopGit config options, too.

New in v2:
Print a RFC2822 compliant header.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-create.sh |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 6cce7ed..d7ee1d2 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -100,13 +100,42 @@ git checkout -b "$name"
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
 git add "$root_dir/.topdeps"
 
+# Print a RFC2822 compliant header ($2) with values from the config option
+# ($1 without the topgit. prefix)
+get_multi_config()
+{
+	# Do we need to escape it for awk double quotes?
+	prefix="$2"
+	prefix_align="$(printf "%*s  " "${#2}" "")"
+
+	git config --get-all topgit.$1 |
+		awk '
+			BEGIN {
+				line = ""
+				prefix = "'"$prefix"': "
+			}
+				{
+					if (line != "") {
+						print prefix line ","
+						prefix = "'"$prefix_align"'"
+					}
+					line = $0
+				}
+			END {
+				if (line != "") {
+					print prefix line
+				}
+			}
+		'
+}
+
 author="$(git var GIT_AUTHOR_IDENT)"
 author_addr="${author%> *}>"
 {
 	echo "From: $author_addr"
-	! header="$(git config topgit.to)" || echo "To: $header"
-	! header="$(git config topgit.cc)" || echo "Cc: $header"
-	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
+	get_multi_config to  "To"
+	get_multi_config cc  "Cc"
+	get_multi_config bcc "Bcc"
 	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
 	echo "Subject: [${subject_prefix}PATCH] $name"
 	echo
-- 
tg: (2e5b885..) t/support-for-multiple-to-cc-bcc-options (depends on: master)
