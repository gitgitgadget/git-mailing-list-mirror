From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] git-submodule: replace duplicated code with a module_list function
Date: Fri, 22 Aug 2008 00:30:50 -0700
Message-ID: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 22 09:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRFX-0007jX-Vt
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbYHVHi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbYHVHi4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:38:56 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:4923 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbYHVHiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:38:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so316218rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DjCh4Lcn8wYeCfzrLCwuzlbh10h5mPhYiXZnF3qaN0Y=;
        b=WTCiHZxaUx8a+od2zwDTUzyN71LyzlAc5Us5QCAa2YmI6zjcSJkYoCtVSUTuJDpQ2x
         aul6UEFX6x/oHhU2xc5MBNHTjE1ITIhOInDpJEL1rFh0uP/eeIhXS3Sw/f4JG+2kRiDF
         +o39pHK/+bu3SuD0twr2F7fCnmiUHQBOakOzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WPogqmBbXc43jp54OMTm+6uGVZOfscjOemTuV2JL/6CWr29kw3+Z9zq+prlU25dRjQ
         CLmnVFgLausky7/V6K2GyqY0kSnzJxy9b+t7cc/Hfyy6H9T3n9ACfv7DbrBPg6+bOP2e
         aR3yVa8dnpHGIgqf/L5rpyIoPE41rdnaPeRPg=
Received: by 10.141.136.8 with SMTP id o8mr364394rvn.278.1219390734601;
        Fri, 22 Aug 2008 00:38:54 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id b8sm1359212rvf.4.2008.08.22.00.38.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 00:38:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93264>

Several call sites in git-submodule.sh used the same idiom for getting
submodule information:

	git ls-files --stage -- "$@" | grep '^160000 '

This patch removes this duplication by introducing a module_list function.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-submodule.sh |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2d57d60..2a3a197 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -54,6 +54,15 @@ resolve_relative_url ()
 }
 
 #
+# Get submodule info for registered submodules
+# $@ = path to limit submodule list
+#
+module_list()
+{
+	git ls-files --stage -- "$@" | grep '^160000 '
+}
+
+#
 # Map submodule path to submodule name
 #
 # $1 = path
@@ -206,7 +215,7 @@ cmd_add()
 #
 cmd_foreach()
 {
-	git ls-files --stage | grep '^160000 ' |
+	module_list |
 	while read mode sha1 stage path
 	do
 		if test -e "$path"/.git
@@ -246,7 +255,7 @@ cmd_init()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
+	module_list "$@" |
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
@@ -304,7 +313,7 @@ cmd_update()
 		esac
 	done
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
+	module_list "$@" |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
@@ -569,7 +578,7 @@ cmd_status()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
+	module_list "$@" |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
-- 
1.6.0.90.g436ed
