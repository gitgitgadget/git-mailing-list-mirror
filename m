From: larsxschneider@gmail.com
Subject: [PATCH v8] Add Travis CI support
Date: Fri, 27 Nov 2015 10:23:27 +0100
Message-ID: <1448616207-45035-2-git-send-email-larsxschneider@gmail.com>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 10:23:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2FFk-0001aL-3N
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 10:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbbK0JXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 04:23:38 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34112 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbbK0JXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 04:23:33 -0500
Received: by wmvv187 with SMTP id v187so61985469wmv.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mfzIDJcpkTnJeAHHrGcUpCOIZ4bJrgSCef4KDLASwtY=;
        b=C1bQpv99G6MULuElBCAITBhshV3jNUEpMJF07aN7TR8kA0ADAFdfTsX1ODycIhFUIq
         6QY/ngXxQH17mBgkW5JIfKk35WWjs9HnaruvvHlcmUB9aovYNbQGZwFQsNGh9rjeoRV0
         G2MC02cSuRKPB+T2k1i49Pugj8w6HM9RwUQ2vtlFe6xj0aPppiFuAVb0DH8ejGDK5mCx
         PZWdNo23Nv8JhhV/bmo2XB/9lIFcseapODAPVE7v4WNIM540NESNdmpw9WegZh39+MnN
         3BW0Q2ZzpPbgq5U3D1rlxQDJc79AgPzKBdH/99+IXZfBzYLcoAPbAAbYdpJD6BhdZ9F4
         YIhA==
X-Received: by 10.28.171.134 with SMTP id u128mr9531537wme.22.1448616212488;
        Fri, 27 Nov 2015 01:23:32 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB75CD.dip0.t-ipconnect.de. [93.219.117.205])
        by smtp.gmail.com with ESMTPSA id q77sm6520832wmd.22.2015.11.27.01.23.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 01:23:32 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281772>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
64 bit" and on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..c3bf9c6
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,91 @@
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
+addons:
+  apt:
+    packages:
+    - language-pack-is
+
+env:
+  global:
+    - P4_VERSION="15.2"
+    - GIT_LFS_VERSION="1.1.0"
+    - DEFAULT_TEST_TARGET=prove
+    - GIT_PROVE_OPTS="--timer --jobs 3"
+    - GIT_TEST_OPTS="--verbose --tee"
+    - CFLAGS="-g -O2 -Wall -Werror"
+    - GIT_TEST_CLONE_2GB=YesPlease
+    # t9810 occasionally fails on Travis CI OS X
+    # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
+    - GIT_SKIP_TESTS="t9810 t9816"
+
+before_install:
+  - >
+    case "${TRAVIS_OS_NAME:-linux}" in
+    linux)
+      mkdir --parents custom/p4
+      pushd custom/p4
+        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4d
+        wget --quiet http://filehost.perforce.com/perforce/r$P4_VERSION/bin.linux26x86_64/p4
+        chmod u+x p4d
+        chmod u+x p4
+        export PATH="$(pwd):$PATH"
+      popd
+      mkdir --parents custom/git-lfs
+      pushd custom/git-lfs
+        wget --quiet https://github.com/github/git-lfs/releases/download/v$GIT_LFS_VERSION/git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz
+        tar --extract --gunzip --file "git-lfs-linux-amd64-$GIT_LFS_VERSION.tar.gz"
+        cp git-lfs-$GIT_LFS_VERSION/git-lfs .
+        export PATH="$(pwd):$PATH"
+      popd
+      ;;
+    osx)
+      brew_force_set_latest_binary_hash () {
+        FORMULA=$1
+        SHA=$(brew fetch --force $FORMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
+        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
+          /usr/local/Library/Taps/homebrew/homebrew-binary/$FORMULA.rb
+      }
+      brew update --quiet
+      brew tap homebrew/binary --quiet
+      brew_force_set_latest_binary_hash perforce
+      brew_force_set_latest_binary_hash perforce-server
+      brew install git-lfs perforce-server perforce gettext
+      brew link --force gettext
+      ;;
+    esac;
+    echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
+    p4d -V | grep Rev.;
+    echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)";
+    p4 -V | grep Rev.;
+    echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
+    git-lfs version;
+
+before_script: make --jobs=2
+
+script: make --quiet test
+
+after_failure:
+  - >
+    : '<-- Click here to see detailed test output!                                                        ';
+    for TEST_EXIT in t/test-results/*.exit;
+    do
+      if [ "$(cat "$TEST_EXIT")" != "0" ];
+      then
+        TEST_OUT="${TEST_EXIT%exit}out";
+        echo "------------------------------------------------------------------------";
+        echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)";
+        echo "------------------------------------------------------------------------";
+        cat "${TEST_OUT}";
+      fi;
+    done;
+
+notifications:
+  email: false
-- 
2.5.1
