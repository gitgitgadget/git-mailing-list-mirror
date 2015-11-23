From: larsxschneider@gmail.com
Subject: [PATCH v7 2/2] Add Travis CI support
Date: Mon, 23 Nov 2015 09:25:08 +0100
Message-ID: <1448267108-55652-3-git-send-email-larsxschneider@gmail.com>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 09:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0mRP-000552-NV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 09:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbbKWIZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 03:25:27 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35029 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbbKWIZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 03:25:13 -0500
Received: by wmuu63 with SMTP id u63so43373352wmu.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYAQ+xPi4JyBFpFPbCxRtI6VJcKK7McAWtLTZ6l3NBE=;
        b=TqcJH6uaFwv3UEmJ60dsLBmE1pQYTO/JGXAULC0fTP6bNOdXXrOkiKILtz18CwKmc4
         JJ4XGpQX0tnvp7IaNQZT/yaErAPMDd0nmRv8y3wViEII2elQX9acOcGezWoXHt1RZP80
         dglcJuey0VSSNGGxBFLQAe7fpwfSCHk3LCBjNkHIYhg5+7Lj6Ub6/IIV7entHHD/C/4Z
         9XUNr09hiaA+h6jJqTppb4qGECo4h0x4cUt2xNFau+4WQfJOgHBoOaAKNs/ODOfiAt/n
         5DU5eNf7lEBYKVocNHf/PzPX3FPAePYMQHeTXX1W1H/saQy6EsA2wAxj4iw1vCb5EFLM
         NHZQ==
X-Received: by 10.28.102.8 with SMTP id a8mr18382436wmc.67.1448267112605;
        Mon, 23 Nov 2015 00:25:12 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6DC4.dip0.t-ipconnect.de. [93.219.109.196])
        by smtp.gmail.com with ESMTPSA id a63sm8659788wmc.5.2015.11.23.00.25.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 00:25:12 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281576>

From: Lars Schneider <larsxschneider@gmail.com>

The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
64 bit" and on "OS X Mavericks" using gcc and clang.

Perforce and Git-LFS are installed and therefore available for the
respective tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..1c3fa06
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,90 @@
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
+    - P4_VERSION="15.4"
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
+      brew install git-lfs perforce-server perforce
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
