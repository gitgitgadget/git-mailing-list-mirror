From: kelson@shysecurity.com
Subject: [PATCH v2] git-config support for diff.relative setting
Date: Sat, 20 Dec 2014 04:24:36 -0500
Message-ID: <54954054.7080201@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 10:25:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2GI2-0006VJ-5L
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 10:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbaLTJYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 04:24:48 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:34541 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbaLTJYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2014 04:24:44 -0500
Received: by mail-qa0-f51.google.com with SMTP id k15so1542078qaq.38
        for <git@vger.kernel.org>; Sat, 20 Dec 2014 01:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:content-type:content-transfer-encoding;
        bh=zsd4qUzNWYg86mXyCn42Dk08Bj6jHckQQGRm0Im3UPs=;
        b=cO29u6onk1MmAgxmOcddFhi67qNn6r7V+dJNFP9f+sCw5jNkLUn9cKezsTgsD/TQbc
         kKIoS/VVsmjHpCgDQ8PYAWGSuN++Fc0VlK2giBE6Vxo0rJwwCl6V6+QTrGdxHVIka5Rs
         HtTtcFuu4dmFOv7SraQuU+wAHQmIf3LZHgr0JecfAGWDnVEpRlST2XjDkyZ73euVjbFV
         zYovM4t1gU7o+xDze11yJ+JrdfVcZMBiTPAOmfdsu1yv3hPCo2elxSdnuTzuHeZgJdE2
         b/bAzt6DCUUBISms8PkBZ2XdiKFMN39fsxApbF/zT7Y/GfuIsCvZFWZmrejCdSdrSvjD
         RDAw==
X-Gm-Message-State: ALoCoQmJsSZu873i7N/oIS3dM2mUNheVr13lg9BNhJ2ba8H4ydH6SkHx6rhLM1kIjp6qf3uhz3I0
X-Received: by 10.140.109.74 with SMTP id k68mr19655345qgf.82.1419067483804;
        Sat, 20 Dec 2014 01:24:43 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id e16sm11675108qaa.28.2014.12.20.01.24.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Dec 2014 01:24:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261600>

By default, git-diff shows changes and pathnames relative to the 
repository root. Setting the diff.relative config option to "true" shows 
pathnames relative to the current directory and excludes changes outside 
this directory (identical to "git diff --relative").

Signed-off-by: Brandon Phillips <kelson@shysecurity.com>
---
  Documentation/diff-config.txt |  6 ++++++
  diff.c                        |  8 ++++++++
  t/t4045-diff-relative.sh      | 21 +++++++++++++++++++++
  3 files changed, 35 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index b001779..10f183f 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -182,3 +182,9 @@ diff.algorithm::
  	low-occurrence common elements".
  --
  +
+
+diff.relative::
+	By default, linkgit:git-diff[1] shows changes and pathnames
+	relative to the repository root. Setting this variable to
+	`true` shows pathnames relative to the current directory and
+	excludes changes outside this directory.
diff --git a/diff.c b/diff.c
index d1bd534..03697a9 100644
--- a/diff.c
+++ b/diff.c
@@ -223,6 +223,14 @@ int git_diff_ui_config(const char *var, const char
*value, void *cb)
  		return 0;
  	}

+	if (!strcmp(var, "diff.relative")) {
+		if (git_config_bool(var, value))
+			DIFF_OPT_SET(&default_diff_options, RELATIVE_NAME);
+		else
+			DIFF_OPT_CLR(&default_diff_options, RELATIVE_NAME);
+		return 0;
+	}
+
  	if (git_color_config(var, value, cb) < 0)
  		return -1;

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f50..8c8fe0b 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -29,6 +29,23 @@ test_expect_success "-p $*" "
  "
  }

+check_config() {
+expect=$1; shift
+cat >expected <<EOF
+diff --git a/$expect b/$expect
+new file mode 100644
+index 0000000..25c05ef
+--- /dev/null
++++ b/$expect
+@@ -0,0 +1 @@
++other content
+EOF
+test_expect_success "git-config diff.relative=true in $1" "
+	(cd $1; git -c diff.relative=true diff -p HEAD^ >../actual) &&
+	test_cmp expected actual
+"
+}
+
  check_numstat() {
  expect=$1; shift
  cat >expected <<EOF
@@ -69,5 +86,9 @@ for type in diff numstat stat raw; do
  	check_$type file2 --relative=subdir
  	check_$type dir/file2 --relative=sub
  done
+for type in config; do
+	check_$type file2 subdir/
+	check_$type file2 subdir
+done

  test_done
-- 
1.9.1
