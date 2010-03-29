From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 7/7] remote-helpers: add tests for testgit helper
Date: Mon, 29 Mar 2010 11:48:29 -0500
Message-ID: <1269881309-19690-8-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:49:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI9c-0007r6-M4
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0C2QtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:49:05 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:57074 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab0C2Qs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:58 -0400
Received: by mail-iw0-f182.google.com with SMTP id 12so697878iwn.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CPT3Pb3XqPCxNFEam9J8mcwfs/Zozsyg/qR98+9FnOo=;
        b=xSMm52oHOPYJS0rqk/9nChOrrzIBqc/lqClorT+LwzVDfY0qm9V/ScwlVKjGMkPeYd
         YXlSRazd0Kt7kDH0IYUtJHHXFVT0T2TPcgWrD7/lyKSwlAm9OwrZ4QFu4Cu2vx4IKMzB
         S7YmPr15Z6JmLDRIHgpe5Xa37wWK9Nhgdw+D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dyQw19QG9NgFkfRwTUXq1TGJZvpGPaekxLvpyPjwQ5DDJXTzWytcKa4ocmVK6RVEd6
         5fxwVMA+dQJ//iNIxZM67ZK8jOw6GSEFk634wC4iAViytmAs9NRxJ1BAa/SRsH95Beh0
         4RQgm6OkQ0DmZj3I2gg2ZpfUMg1pJjCs4OZuk=
Received: by 10.114.54.28 with SMTP id c28mr1138689waa.169.1269881337803;
        Mon, 29 Mar 2010 09:48:57 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143498>

---

	I used a httpd server for the remote at first, but figured
	we should probably not depend on those tests being run. It
	was fairly trivial to make the testgit helper treat file://
	urls as 'remote', so I figured that'd work just as well.

 t/t5800-remote-helpers.sh |   70 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100755 t/t5800-remote-helpers.sh

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
new file mode 100755
index 0000000..33f546b
--- /dev/null
+++ b/t/t5800-remote-helpers.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Sverre Rabbelier
+#
+
+test_description='Test remote-helper import and export commands'
+
+. ./test-lib.sh
+
+test_expect_success 'setup repository' '
+	git init --bare server/.git &&
+	git clone server public
+	(cd public &&
+	 echo content >file &&
+	 git add file &&
+	 git commit -m one &&
+	 git push origin master)
+'
+
+test_expect_success 'cloning from local repo' '
+	git clone "testgit::${PWD}/server" localclone
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'cloning from remote repo' '
+	git clone "testgit::file://${PWD}/server" clone &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'create new commit on remote' '
+	(cd public &&
+	 echo content >>file &&
+	 git commit -a -m two &&
+	 git push)
+'
+
+test_expect_success 'pulling from local repo' '
+	(cd localclone && git pull) &&
+	test_cmp public/file localclone/file
+'
+
+test_expect_success 'pulling from remote remote' '
+	(cd clone && git pull) &&
+	test_cmp public/file clone/file
+'
+
+test_expect_success 'pushing to local repo' '
+	(cd localclone &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git push) &&
+	HEAD=$(git --git-dir=localclone/.git rev-parse --verify HEAD) &&
+	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+'
+
+test_expect_success 'synch with changes from localclone' '
+	(cd clone &&
+	 git pull)
+'
+
+test_expect_success 'pushing remote local repo' '
+	(cd clone &&
+	echo content >>file &&
+	git commit -a -m four &&
+	git push) &&
+	HEAD=$(git --git-dir=clone/.git rev-parse --verify HEAD) &&
+	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+'
+
+test_done
-- 
1.7.0.3.317.gbb04ec
