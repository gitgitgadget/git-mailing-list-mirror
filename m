From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Fri,  1 Oct 2010 01:33:36 +0530
Message-ID: <1285877017-8060-2-git-send-email-artagnon@gmail.com>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:05:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1PNY-000618-BE
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab0I3UFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 16:05:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54644 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab0I3UFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 16:05:10 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so389258pwj.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KvAQhkLF3xsM5c3EjvAjBTgPlsMuXsbSJEA0SmgqG4U=;
        b=Bw21da4/3peccJPwXK8IqkCgYSZiVnNJRvmDgGu5bwM7zV8jUbuZLQ7volkcYs1hje
         8D9tWQDklR7CtBIyJ2AqWsgPQf4Lr1sfintK+PhMS0a+zchKSwo4ZW5BAba6I4uhhppb
         ncPGGQgHpit1fw6rLxW+/HTh7+6gU5MfxkVRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TOuqmOEF16Gq61Hd8B/G+FDNlCjVQaNIpKKntAT5acnsNZhEBsHpH8hLxOIsLRAXiD
         ByPgdiSB6vWoM88VRLmBBHXcYUftneLduYrd6qZGDjSWOWkgzkiosp0g9hC7iXnOzgBg
         QwK3hzSZCLCtap9vfAbEfQ0PFo194TCFKBnKI=
Received: by 10.114.24.3 with SMTP id 3mr4926433wax.29.1285877099495;
        Thu, 30 Sep 2010 13:04:59 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm362759wam.19.2010.09.30.13.04.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 13:04:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157708>

Write a new require_clean_work_tree function to error out when
unstaged changes are present in the working tree and (optionally)
uncommitted changes in the index.

Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..215ec33 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -145,6 +145,34 @@ require_work_tree () {
 	die "fatal: $0 cannot be used without a working tree."
 }
 
+require_clean_work_tree () {
+	# Update the index
+	git update-index -q --ignore-submodules --refresh
+	err=0
+
+	# Disallow unstaged changes in the working tree
+	if ! git diff-files --quiet --ignore-submodules --
+	then
+		echo >&2 "cannot $1: you have unstaged changes."
+		git diff-files --name-status -r --ignore-submodules -- >&2
+		err=1
+	fi
+
+	# Disallow uncommitted changes in the index
+	if ! git diff-index --cached --quiet HEAD --ignore-submodules --
+	then
+		echo >&2 "cannot $1: your index contains uncommitted changes."
+		git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
+		err=1
+	fi
+
+	if [ $err = 1 ]
+	then
+	    echo >&2 "Please commit or stash them."
+	    exit 1
+	fi
+}
+
 get_author_ident_from_commit () {
 	pick_author_script='
 	/^author /{
-- 
1.7.2.2.409.gdbb11.dirty
