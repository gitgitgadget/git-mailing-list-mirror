From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] Make rebase smarter
Date: Fri, 26 Oct 2007 00:41:22 -0400
Message-ID: <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org, federico@novell.com
X-From: git-owner@vger.kernel.org Fri Oct 26 06:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlH0v-00032e-Jj
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 06:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbXJZEl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 00:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXJZEl1
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 00:41:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:9712 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXJZEl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 00:41:26 -0400
Received: by nz-out-0506.google.com with SMTP id s18so724558nze
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yiJr5QLqBBjbGEj6tnWFvrCcZWj5QnOSWbO3dCuCC8A=;
        b=speDeL8knm/bram4PFEYASX/2WwwBsHBXTI/C6AQIa1GVSepznfY5Ma0TX2EZBOMJjOiwIbP7eSBNJTdXeRLQjvrOlfmWAfusAM+QFvPF9I3SFUyKIoKfSxvYH03tg89k/0EAQ1IrzgQYqo5sGA/+Ji0I0RslCW9TP55N2c1vsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HRE6hbUQDYVC4V16OrTAuagYk9hmUynt4mcUw4jHFhTtClQnS9SUqzqouZSygikOIHqPhWZinZ9BjhEsRVulfYY0JM3lnIqlnySh7s1MhFUnoA/G2cd8Y5x9l28LS5tFjYe8NvNNlA3PJR8G7/T6r/gmf3uoLHn7tDjNZe7vHSo=
Received: by 10.65.103.14 with SMTP id f14mr5543400qbm.1193373685368;
        Thu, 25 Oct 2007 21:41:25 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 40sm2230252nzf.2007.10.25.21.41.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2007 21:41:24 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 5804BCF2C5F; Fri, 26 Oct 2007 00:41:21 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1.gb4ad62-dirty
In-Reply-To: <1193328386.4522.352.camel@cacharro.xalalinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62392>

It is a common workflow to run "git fetch; git rebase origin/<foo>" Where
foo is the remote tracking branch.  git-rebase should default to using
the remote tracking branch if no other ref is given.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-rebase.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 058fcac..1a2b51b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -261,8 +261,19 @@ case "$diff" in
 	;;
 esac
 
-# The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
+# Default to the remote tracking branch if we have one
+if [ -z "$upstream_name" ]
+then
+	curr_branch=$(git symbolic-ref -q HEAD)
+	curr_branch=${curr_branch//refs\/heads\//}
+	merge=$(git config branch.$curr_branch.merge)
+	remote=$(git config branch.$curr_branch.remote)
+	fetch=$(git config remote.$remote.fetch)
+
+	expanded=$(git fetch--tool expand-refs-wildcard "0000000000000000000000000000000000000000 $merge" "$remote" "$fetch")
+	upstream_name=${expanded/#*:/}
+fi
 upstream=`git rev-parse --verify "${upstream_name}^0"` ||
     die "invalid upstream $upstream_name"
 
-- 
1.5.3.4.1.gb4ad62-dirty
