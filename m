From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 3/3] Fix large-scale exports by 'git-svndump'
Date: Mon, 18 Jun 2007 10:54:03 +0300
Message-ID: <11821532431437-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Mon Jun 18 09:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0C32-0000TR-Lo
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 09:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbXFRHxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756660AbXFRHxO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 03:53:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21872 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755878AbXFRHxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 03:53:12 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1365885ugf
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 00:53:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ImXMaSYMkHZFb6ChMNmgHFrLL1A73VoKbhkwueQbYStukZQ4tCLsb8VW8hUveO/yExL1KPhxBKvehP98yGLFudeSWr2I8epMQSEhH0d8hRmdBp4U+TBb8t/zuRWsgsQIbfgYlVI0/eAfKRNpkZkX1+nEboHS2IHnodq81k4HhHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QrPjqfZUBXXr5cNYXZslLB+JjV6lkL5bqzSPgsndiqQvGDKmVj4qE/tRxgDF5nq5da8g1yZ4BlRZ1waFRnXzOgzOZUoAX0Oo7ksK/dylqUjqsN278IzdaVOU2XW5VXegkltnpv+wJcE/hZLzSzC6DTr/k2tfJrJYBtdY9OLu7F4=
Received: by 10.82.175.17 with SMTP id x17mr10668367bue.1182153191515;
        Mon, 18 Jun 2007 00:53:11 -0700 (PDT)
Received: from host3 ( [212.98.161.163])
        by mx.google.com with ESMTP id u9sm3846029muf.2007.06.18.00.53.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 00:53:10 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0C3o-000324-Uv; Mon, 18 Jun 2007 10:54:05 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 11821091382770-git-send-email-ynvich@gmail.com
References: 11821091382770-git-send-email-ynvich@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50386>

* Split revision list using 'tail' shell command.

* Wrap multiple list generation in an endless cycle with 'while true'.
  Exit from cycle when the current list is empty.

* Improve handling of merges by adding '--no-merges --topo-order'i
  arguments to the list generating command.

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
---
 git-svndump-sync.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-svndump-sync.sh b/git-svndump-sync.sh
index e1c04e1..516edaf 100755
--- a/git-svndump-sync.sh
+++ b/git-svndump-sync.sh
@@ -70,7 +70,14 @@ if test -f $GIT_DIR/svndump/last ; then
 	fi
 fi
 
-list=`GIT_DIR=$GIT_DIR git-rev-list $commit $start`
+while true ; do
+
+list=`GIT_DIR=$GIT_DIR git-rev-list --no-merges --topo-order $commit $start |
+tail -n 8`
+
+if test -z "$list" ; then
+	exit 0
+fi
 
 diffs=""
 for c in $list ; do
@@ -79,7 +86,14 @@ done
 
 for c in $diffs ; do
 	GIT_DIR=$GIT_DIR git-svn commit-diff -r$rev $last $c $url
+	if test $? -ne 0 ; then
+		exit $?
+	fi
 	echo "$c" > $GIT_DIR/svndump/last
 	last=$c
 	let rev++
 done
+
+start=^$last
+
+done
-- 
1.5.2.1
