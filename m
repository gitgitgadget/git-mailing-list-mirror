From: jidanni@jidanni.org
Subject: [PATCH] git-cache-meta -- file owner and permissions caching, minimalist approach
Date: Sun, 11 Jan 2009 01:43:29 +0800
Message-ID: <87eizb12gu.fsf_-_@jidanni.org>
References: <200901082229.46433.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 10 18:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLhtN-0004wg-Pq
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 18:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZAJRni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 12:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZAJRnh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 12:43:37 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:54764 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751976AbZAJRng (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2009 12:43:36 -0500
Received: from jidanni.org (122-127-36-152.dynamic.hinet.net [122.127.36.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id C19B541528;
	Sat, 10 Jan 2009 09:43:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105133>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 contrib/metadata/git-cache-meta |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 contrib/metadata/git-cache-meta

diff --git a/contrib/metadata/git-cache-meta b/contrib/metadata/git-cache-meta
new file mode 100755
index 0000000..5e1b740
--- /dev/null
+++ b/contrib/metadata/git-cache-meta
@@ -0,0 +1,19 @@
+#!/bin/sh -e
+# git-cache-meta -- file owner and permissions caching, minimalist approach
+: ${GIT_CACHE_META_FILE=.git_cache_meta} #simpler not to git-add it
+case $@ in
+    --store|--stdout)
+	case $1 in --store) exec > $GIT_CACHE_META_FILE; esac
+	git ls-files|xargs -I{} find {} \
+	    \( -user ${USER?} -o -printf "chown %u '%p'\n" \) \
+	    \( -group $USER -o -printf "chgrp %g '%p'\n" \) \
+	    \( \( -type l -o -perm 755 -o -perm 644 \) \
+			-o -printf "chmod %#m '%p'\n" \);;#requires GNU Find
+    --apply) sh -e $GIT_CACHE_META_FILE;;
+    *) 1>&2 cat <<EOF; exit 1;;
+Usage: $0 --store|--stdout|--apply #Example:
+# git bundle create mybundle.bdl master; git-cache-meta --store
+# scp mybundle.bdl .git_cache_meta machine2: #then on machine2:
+# git init; git pull mybundle.bdl master; git-cache-meta --apply
+EOF
+esac
-- 
1.6.0.6
