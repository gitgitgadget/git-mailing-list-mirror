From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 3/3] Fix large-scale exports by 'git-svndump'
Date: Mon, 18 Jun 2007 15:14:04 +0300
Message-ID: <11821688462083-git-send-email-ynvich@gmail.com>
References: vpqhcp6b85c.fsf@bauges.imag.fr
 <11821688443683-git-send-email-ynvich@gmail.com>
 <11821688461828-git-send-email-ynvich@gmail.com>
 <11821688462290-git-send-email-ynvich@gmail.com>
Cc: Sergey Yanovich <ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, Matthieu.Moy@imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 18 14:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0G84-00085F-CD
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 14:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761580AbXFRMNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761571AbXFRMNM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 08:13:12 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:57504 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbXFRMNH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 08:13:07 -0400
Received: by hu-out-0506.google.com with SMTP id 19so722651hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 05:13:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=WReNUD4ySUfrzxOV4ZqqLVro5U3YcjDBWNxfhNctU20/oMEm1DVOwsCzoQnG3FYLUN5giYyBwsreK8cJqifL+HSihDcCexj/qdEZtcQD3Gg3PtNb+hITEJST5TNGAtqsnnS9TY+G5xOWrrEtx2mg0NOZUTwumClOnuERtKuhp1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RWARK2QUeAjFtHUMDW1OTh/XbJ9ANRj4zV3DjC4mUoRcrOAfzYxLGm4t4U0ZsKJ7vMQSkB5gH6J7YIpdFQZRX8SHLiX4F0cdqowk6NX/kj9LIoB2xzHr6AUUlcLRY+RELR9eBz4oLZJhqszrrIypK3Xq23LlxWRtCmv4Joaj98w=
Received: by 10.82.126.5 with SMTP id y5mr11104284buc.1182168786759;
        Mon, 18 Jun 2007 05:13:06 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id b33sm14897794ika.2007.06.18.05.13.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 05:13:06 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0G7S-0001S1-Pj; Mon, 18 Jun 2007 15:14:06 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11821688462290-git-send-email-ynvich@gmail.com>
Message-Id: <1cfe105017cb4bc44d54c6283b5185a73c4e84d8.1182168501.git.ynvich@gmail.com>
In-Reply-To: <4e79874760c3773448d886608d6db7bbda3c97f2.1182168501.git.ynvich@gmail.com>
References: <4e79874760c3773448d886608d6db7bbda3c97f2.1182168501.git.ynvich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

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
