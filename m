From: larsxschneider@gmail.com
Subject: [PATCH v2 1/2] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 26 Jan 2016 10:53:42 +0100
Message-ID: <1453802023-85055-2-git-send-email-larsxschneider@gmail.com>
References: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, mh@glandium.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO0Jw-0001X6-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbcAZJxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:53:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36071 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964957AbcAZJxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:53:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so16305368wmf.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MRTpRWyuGOQgKTPkDjltXklzK6eooFr0swGSuVJ9qDo=;
        b=xSdalWpkfJy+Vc8UmNk3M6beErHjgHKLKiDF54hosJbhB0J4GeNLGRm9T8E3NFVpyT
         lzhwO2XsJDy4Fgl7+1xwQ5QO1AndftBE91p9oNA6ehRQB02M1L0mw4E87j7QOdRIcNpS
         DcFpswVkRT0aTNSkNnekLo3j14IMuSYDTZxpFhtLkwEZDYxYfClgv27vRlaypgu3GB+m
         br/Pv3JMQpu/zvxRhVNi6IQFHyuEIRv99Mqa96uz3oOYEbpHmQxTGt8O6MnxXtOFwv2/
         tM7gaq32kHOMpR1oMOk9GN1ePoInftwqQ3oAdXVQd6BzcuMnJWs35mkHlFt9OKZU8v19
         WgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MRTpRWyuGOQgKTPkDjltXklzK6eooFr0swGSuVJ9qDo=;
        b=TuD5T7/ONw6IRExE3Bpo2BcVyYjnk/X8meidsrrEusl2C55dBhBiIOc7a9K1aT3SCM
         27WQKJIcKY4KCCBWGcLFbqjF6AxY8nFmtUi+ecyt3dB3BcnCaLKsX7lDmqvz71DybAy9
         Oyv54IGkJfENj0v7tP9necYOIkHTndPecKoMTGXmhcuubyM8iJDtv3EM1gE0cR9048nv
         6kY9tGDGzB5qucC7Nqo4Ef9Tw3LmsX2vLSZjZdkw1SOXXg8KRJt7ZVy98OlwwRNLr+Ck
         zLTb+fHVs27qxqFJd/weu/m6aVXih3CYlYN0bD57BEx2L57odvpBCKXg5gMjJwDXPFnb
         6qnA==
X-Gm-Message-State: AG10YOSPTc7Scw80MGknR790qFNlEAnlZ6aHBcdhZGzzk2ZqFrJCI28gPySaKQIWhMMCpQ==
X-Received: by 10.194.61.111 with SMTP id o15mr22435500wjr.104.1453802025122;
        Tue, 26 Jan 2016 01:53:45 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA9B5.dip0.t-ipconnect.de. [80.139.169.181])
        by smtp.gmail.com with ESMTPSA id w80sm2683566wme.17.2016.01.26.01.53.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 01:53:44 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284800>

From: Lars Schneider <larsxschneider@gmail.com>

The Travis-CI machines are in a clean state in the beginning of every run
(transient by default). Use the Travis-CI cache feature to make the prove
state persistent across consecutive Travis-CI runs on the same branch.
This allows to run previously failed tests first and run remaining tests
in slowest to fastest order. As a result it is less likely that Travis-CI
needs to wait for a single test at the end which speeds up the test suite
execution by ~2 min.

Travis-CI can only cache entire directories. Prove stores the .prove file
always in the t/ directory but we don't want to cache the entire t/ directory.
Therefore we create a symlink from $HOME/travis-cache/.prove to t/.prove and
cache the $HOME/travis-cache directory.

Unfortunately the cache feature is only available (for free) on the
Travis-CI Linux environment.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c3bf9c6..610881e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,9 @@
 language: c
 
+cache:
+  directories:
+    - $HOME/travis-cache
+
 os:
   - linux
   - osx
@@ -18,7 +22,7 @@ env:
     - P4_VERSION="15.2"
     - GIT_LFS_VERSION="1.1.0"
     - DEFAULT_TEST_TARGET=prove
-    - GIT_PROVE_OPTS="--timer --jobs 3"
+    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
     - CFLAGS="-g -O2 -Wall -Werror"
     - GIT_TEST_CLONE_2GB=YesPlease
@@ -67,6 +71,8 @@ before_install:
     p4 -V | grep Rev.;
     echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
     git-lfs version;
+    mkdir -p $HOME/travis-cache;
+    ln -s $HOME/travis-cache/.prove t/.prove;
 
 before_script: make --jobs=2
 
-- 
2.5.1
