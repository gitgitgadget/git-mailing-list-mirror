From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 1/2] Factor out the template generation for the .topmsg file
Date: Fri,  8 Aug 2008 20:19:47 +0200
Message-ID: <1218219588-6849-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWaG-0007Sm-LZ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 20:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYHHST4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758883AbYHHST4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 14:19:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:60704 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552AbYHHSTy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 14:19:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so610621fgg.17
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Kuzu1h/4MkPC8s52GZnPQtLu8nweBsM1AWOFFcrPkx0=;
        b=QkP22uvJ+eisrgV2e3C+zKFCmEu9fLTci6zYzIms6Yx0gszVV8g4LLqtEKJ1tr18mH
         sc0ZWCHiDTr9bvjTORlakd70RkecCkOFXfyijrJNcCxh/sC3pB+rlnXlFeHjYsm+Z2Wm
         8+KKdvHMxGDC14+QoJgh+kbvXl6lL8PNy0Izg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UdBpHpj1n66qdxOLzn6cKPLSSm9OXOCAaACsKiuLTlo13+vLrl4AXbTIE/f5K6XLYU
         2MFMPK5vqAm+suyR2uq01i/dGBR9jV3LVkVIIP6o1MBkXQmq8E1h9a+BvRvwDOtPbtim
         LfDVycTB3yk4LXhQU4M113DFPtuImlayxjwJ0=
Received: by 10.86.82.6 with SMTP id f6mr3464112fgb.73.1218219592580;
        Fri, 08 Aug 2008 11:19:52 -0700 (PDT)
Received: from localhost ( [91.15.87.97])
        by mx.google.com with ESMTPS id l12sm2708685fgb.6.2008.08.08.11.19.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Aug 2008 11:19:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91704>

Provide a function for the .topmsg template file.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-create.sh |   29 ++---------------------------
 tg.sh        |   30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index d47959b..e30a014 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -100,33 +100,8 @@ git checkout -b "$name"
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
 git add "$root_dir/.topdeps"
 
-# Print each config value for a key ($1, without "topgit." prefix)
-# with the given prefix ($2)
-get_multi_config()
-{
-	# escape any / in prefix for sed
-	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
-
-	git config --get-all topgit.$1 2>/dev/null |
-		sed -e "s/^/$prefix /g"
-}
-
-author="$(git var GIT_AUTHOR_IDENT)"
-author_addr="${author%> *}>"
-{
-	echo "From: $author_addr"
-	get_multi_config to  "To:"
-	get_multi_config cc  "Cc:"
-	get_multi_config bcc "Bcc:"
-	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
-	echo "Subject: [${subject_prefix}PATCH] $name"
-	echo
-	cat <<EOT
-<patch description>
-
-Signed-off-by: $author_addr
-EOT
-} >"$root_dir/.topmsg"
+echo "<patch description>" |
+	make_topmsg "$name" >"$root_dir/.topmsg"
 git add "$root_dir/.topmsg"
 
 
diff --git a/tg.sh b/tg.sh
index 03a392b..8384b79 100644
--- a/tg.sh
+++ b/tg.sh
@@ -148,6 +148,36 @@ switch_to_base()
 	git symbolic-ref HEAD "$_base"
 }
 
+# Print each config value for a key ($1, without "topgit." prefix)
+# with the given prefix ($2)
+get_multi_config()
+{
+	# escape any / in prefix for sed
+	prefix="$(echo "$2" | sed -e 's/\//\\\\\//g')"
+
+	git config --get-all topgit.$1 2>/dev/null |
+		sed -e "s/^/$prefix /g"
+}
+
+# Make initial .topmsg template with content from stdin
+# optional first argument is subject line
+make_topmsg()
+{
+	author="$(git var GIT_AUTHOR_IDENT)"
+	author_addr="${author%> *}>"
+
+	echo "From: $author_addr"
+	get_multi_config to  "To:"
+	get_multi_config cc  "Cc:"
+	get_multi_config bcc "Bcc:"
+	! subject_prefix="$(git config topgit.subjectprefix)" || subject_prefix="$subject_prefix "
+	echo "Subject: [${subject_prefix}PATCH] $1"
+	echo
+	cat
+	echo
+	echo "Signed-off-by: $author_addr"
+}
+
 # Show the help messages.
 do_help()
 {
-- 
tg: (2a28314..) t/make-.topmsg-gen-a-function (depends on: t/support-for-multiple-to-cc-bcc-options)
