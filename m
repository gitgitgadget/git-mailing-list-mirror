From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Sat,  2 Oct 2010 10:02:58 +0530
Message-ID: <1285993980-28037-2-git-send-email-artagnon@gmail.com>
References: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 02 06:34:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1tnu-00040Y-JW
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 06:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab0JBEeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 00:34:22 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45952 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0JBEeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 00:34:21 -0400
Received: by pzk34 with SMTP id 34so918233pzk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KvAQhkLF3xsM5c3EjvAjBTgPlsMuXsbSJEA0SmgqG4U=;
        b=x3Cqv6nk5jWzk1dRnmRWZaMcIgFSQ6vFyaRXEIju6391ajL+3A1fsmqmyUL8CDMRSW
         ARXJQ51J5ShRj9vPFMBNvg9gofPEC+GDQAbTsSNPLxcgq/Bd/33hBrmJBj5Jh8vOXjsG
         +DKNVM5qxhBVMXS0PgNMMMLbL4UO+oKHQGS3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g0dyu2xBlZg0JTnOzvSqcON8rDvD3w6optXzvr1/nfkHMPImalO3hFWi/JTcIm3D1x
         wRKFPalnibAfOQq98pEQcPmUW2Z2/L4zSiCccTm/eJZSXMJ3lRIAG1AyGox+r/oxhlK1
         6woe/hLzfSI/1cl+MwPAd/RwQtEPf96Tf6+fw=
Received: by 10.114.158.3 with SMTP id g3mr7543907wae.160.1285994060980;
        Fri, 01 Oct 2010 21:34:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm3232939wad.6.2010.10.01.21.34.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 21:34:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157789>

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
