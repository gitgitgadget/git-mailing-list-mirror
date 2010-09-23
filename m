From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 1/2] contrib: add git-submodule-grep.sh
Date: Thu, 23 Sep 2010 14:17:06 -0700
Message-ID: <1285276627-7907-2-git-send-email-judge.packham@gmail.com>
References: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 23:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OytAU-0002xQ-9K
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329Ab0IWVQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:16:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47226 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab0IWVQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:16:57 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so445358pwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TWMWD8B/aDIFfwWCeS7Yxwyt61kVZBWSofAMimEXSvs=;
        b=F0raxHvdLnD4dBPrp040S7YKRzciZgdX5RaMuKZYOlhdkyNlSKaklpzi+muWjsn/Ej
         YpTK7q5PO9AmYw8ujCzYtMY2/e2EIMqH/OCAjcmp1X5idlnHU6pCb6sUM2EYvWRAB5Ed
         RiO70HWa6InXmOuHECzOsokgEC9wEW4JAGhyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D9gh80Ax9QFn9kndry0J1TOj2+7vOkAR2YadZ7UyYMrlSycUGUth8jjJcJ8WnRfmke
         kB5RLopnYIylL/BBkWzYPaS3n0pg8kVqyicf7NchZX5EDpv/qg6a0RhBZjJyWp7Ouq84
         VMlhgYJV32SVBxcZ0GQLRVeXyinx1i6MdacTE=
Received: by 10.114.60.5 with SMTP id i5mr2460793waa.146.1285276617518;
        Thu, 23 Sep 2010 14:16:57 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm2133641wal.21.2010.09.23.14.16.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:16:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
In-Reply-To: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156915>

A simple wrapper around 'git grep' that is submodule aware.

The advantage of this over "git submodule foreach 'git grep <pattern>'" is
that the results are presented with a path relative to the current
directory. Also this script will work from any subdirectory of any submodule
in the current superproject.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 contrib/git-submodule-grep.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-submodule-grep.sh

diff --git a/contrib/git-submodule-grep.sh b/contrib/git-submodule-grep.sh
new file mode 100755
index 0000000..407fdb0
--- /dev/null
+++ b/contrib/git-submodule-grep.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# Copyright (c) 2010, Chris Packham
+# Wrapper for git grep that is submodule aware
+
+SUBDIRECTORY_OK="yes"
+. git-sh-setup
+
+submodule_root_relative()
+{
+	ceiling="$HOME"
+	while test ! -e "$cdup.gitmodules"; do
+		cdup="$cdup../"
+		if test "$(cd $cdup && pwd)" == "$ceiling"; then
+			echo >&2 "fatal: failed to find superproject root,"
+			echo >&2 "       stopped searching at $ceiling."
+			exit 1
+		fi
+	done
+	echo "$cdup"
+}
+
+submodule_root()
+{
+	(cd "$(submodule_root_relative)" && pwd)
+}
+
+# we don't do anything with the arg but we should check that we
+# have something to pass to git grep
+test $# -lt 1 && die "fatal: no pattern given."
+
+prefix="$(submodule_root_relative)" || exit 1
+(cd "./$prefix"; \
+	git submodule --quiet foreach \
+		"git --no-pager grep $@ | sed s\"|.*|$prefix\$path/&|\" || true") \
+			| git_pager
-- 
1.7.3.dirty
