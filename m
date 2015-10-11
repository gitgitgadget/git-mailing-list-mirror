From: larsxschneider@gmail.com
Subject: [PATCH v3 1/3] Add Travis CI support
Date: Sun, 11 Oct 2015 10:55:00 -0700
Message-ID: <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 19:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlKq2-00065n-9z
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 19:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbJKRzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 13:55:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36152 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbJKRzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 13:55:07 -0400
Received: by pablk4 with SMTP id lk4so133112185pab.3
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6cQ99OTmJoZOZrEUYcGUSGW04IXh2xRhYl+gRVZo/6U=;
        b=Va+3x0mmKFvyhnG2N8fmANX8USouRivNRrFwWXR5SM1WQliu+23+Vf2/sxuQHkyljJ
         OSnKJpi+sliUU1d+Pp6lf9Q9BgzrrajfKAk1IDR7dpShn0ASzR0cqjvigNunrYUwHE70
         3DRQ9evRoA4R6YF+U/MsOuomkb/ysybWKC1eiXffa+48FogcRhApYEezlRdUFU56M4OP
         sGcWedPvJsDsSIjuaY+pbmmYBRP3X9pxSTaaSqBrwhlQGEb9+0jOqizdFAOEUgI1lUZ1
         ZGGnKtiQsG/tfeZB+5RUUrx8qpxhHV1L3NoCvKtlaf83NOJossIGRAPG3F+W4I6PSKgS
         jUbQ==
X-Received: by 10.68.137.202 with SMTP id qk10mr29745691pbb.30.1444586106478;
        Sun, 11 Oct 2015 10:55:06 -0700 (PDT)
Received: from slxBook3.hsd1.ca.comcast.net (c-69-181-162-247.hsd1.ca.comcast.net. [69.181.162.247])
        by smtp.gmail.com with ESMTPSA id de4sm13746279pbb.60.2015.10.11.10.55.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2015 10:55:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279347>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
64 bit" and on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..25a7079
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,46 @@
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
+before_install:
+  - >
+    export GIT_TEST_OPTS=" --quiet";
+    case "${TRAVIS_OS_NAME:-linux}" in
+    linux)
+      wget -q https://package.perforce.com/perforce.pubkey -O - \
+        | sudo apt-key add -
+      echo 'deb http://package.perforce.com/apt/ubuntu precise release' \
+        | sudo tee -a /etc/apt/sources.list
+      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -
+      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' \
+        | sudo tee -a /etc/apt/sources.list
+      sudo apt-get update -qq
+      sudo apt-get install -y apt-transport-https
+      sudo apt-get install perforce-server git-lfs
+      ;;
+    osx)
+      brew_force_set_latest_binary_hash () {
+        FORUMULA=$1
+        SHA=$(brew fetch --force $FORUMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
+        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
+          /usr/local/Library/Taps/homebrew/homebrew-binary/$FORUMULA.rb
+      }
+      brew update
+      brew tap homebrew/binary
+      brew_force_set_latest_binary_hash perforce
+      brew_force_set_latest_binary_hash perforce-server
+      brew install git-lfs perforce-server perforce
+      ;;
+    esac
+
+install: make configure && ./configure
+
+before_script: make
+
+script: make --quiet test
-- 
2.5.1
