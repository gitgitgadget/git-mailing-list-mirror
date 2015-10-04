From: larsxschneider@gmail.com
Subject: [PATCH v2 1/4] Add Travis CI support
Date: Sun,  4 Oct 2015 11:06:14 -0700
Message-ID: <1443981977-64604-2-git-send-email-larsxschneider@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zing4-0000Wm-VL
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbbJDSGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:25 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36740 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbJDSGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:25 -0400
Received: by wicgb1 with SMTP id gb1so91220625wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stt+bdp5iMWhXCVWX314y68U6Qv8dSs7MWAHSs5Y3eE=;
        b=qRLFLCA3D03HYTOHqqmZZQGw7giCvhfigSogWxJpL+XJZnR2qcFHIBdM+KfOMmMpaB
         zg6gnkivwso7gkDyP91U5dVea4xrw9ah4X7s9dg3tPb54CXv+KDqCIiJ7WcPzRTv9izj
         9Zd2Mfs0oEVW55Czl/ke3b61xRuvaIXLxdYUrhVAi2oy5S3P1TVz1ORLq6yv1F6an7lK
         Yu3/p7PL2A74FcM5Zdyuls6ohn5UkQgp3E8rscMFlqMMPYuf5i0UT1FbCVSDk9E3O6DJ
         BmGua4ZBt+Ix2mV+poHOtzTlS+HS7+s9++ooJuoPhoOHzhS8QpGQhMVvY9GfGyukCJIO
         9g3Q==
X-Received: by 10.180.187.240 with SMTP id fv16mr7012105wic.57.1443981983939;
        Sun, 04 Oct 2015 11:06:23 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id o3sm10378607wif.22.2015.10.04.11.06.22
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Oct 2015 11:06:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279010>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are executed on "Ubuntu 12.04 LTS Server Edition 64 bit" and
on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..8a29dd6
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,31 @@
+language: c
+
+os:
+  - linux
+  - osx
+
+compiler:
+  - clang
+  - gcc
+
+before_script:
+  - >
+    if [ ${TRAVIS_OS_NAME:-'linux'} = 'linux' ]; then
+      wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -
+      echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list
+      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -
+      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list
+      sudo apt-get update -qq
+      sudo apt-get install -y apt-transport-https
+      sudo apt-get install perforce-server git-lfs
+    elif [ ${TRAVIS_OS_NAME:-'linux'} = 'osx' ]; then
+      brew update
+      brew tap homebrew/binary
+      P4_SERVER_SHA=$(brew fetch --force perforce-server 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
+      P4_SHA=$(brew fetch --force perforce 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
+      sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$P4_SERVER_SHA\"/g" /usr/local/Library/Taps/homebrew/homebrew-binary/perforce-server.rb
+      sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$P4_SHA\"/g" /usr/local/Library/Taps/homebrew/homebrew-binary/perforce.rb
+      brew install git-lfs perforce-server perforce
+    fi
+
+install: make configure
-- 
2.5.1
