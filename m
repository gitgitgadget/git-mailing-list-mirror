From: kelson@shysecurity.com
Subject: [PATCH v3 2/2] git-config support for diff.relative setting
Date: Tue, 30 Dec 2014 12:56:24 -0500
Message-ID: <54A2E748.3010008@shysecurity.com>
References: <54972C33.4030009@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 18:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6127-00012h-N8
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 18:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaL3R4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 12:56:30 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35267 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaL3R43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 12:56:29 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so10628755qcx.41
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 09:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zjhVun2RIiyZol9nr+7n60aqhafdHfQz+okVOaplYpI=;
        b=kJ5f/gY97I8o40OzVUiZOhbxcuPMuX7iCZuPtEGaVSpVGXQPSH3F/zzn/M2c5NLmgD
         6I+RvMfi+bo7JJJYFlQx2GmyD54UwGUm/Fcsdq2hqL7yPyEREpx0e/mie2YIyBWc3b+c
         0UG7T4nKSbQhwWu8c+Vi3exFOoreoGBqKFdnZ1D/lEa1NqR3Z33EBbjhq+Z5FwkeYxOd
         dACZYzAH6+hoDQW8oXhmLyHvJIoh8E9i4QwkssAaqJQY0vJfQyyY11FoDdZZN/8Jo5mk
         h1ConYlbJOBbR5a7nMCHVL3VAjT18zj26ku+sYuI9frtCcp2A2qG8h/5oFM3rZ/elPNf
         i7jA==
X-Gm-Message-State: ALoCoQkUGh/nxOjsjwuHNLI4poX3DGQQf+gw7LNTwbHXMx+dWuOorYBMYvodutw2Sto93FE3+7e/
X-Received: by 10.140.31.163 with SMTP id f32mr16886573qgf.23.1419962188477;
        Tue, 30 Dec 2014 09:56:28 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id c7sm36518910qar.33.2014.12.30.09.56.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2014 09:56:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54972C33.4030009@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261929>

added support for `git diff --no-relative` (code, documentation, and tests)

git-diff --no-relative overrides diff.relative config setting and prior 
git-diff --relative[=<path>] options.
---
  Documentation/diff-config.txt  |  1 +
  Documentation/diff-options.txt |  4 +++
  diff.c                         |  2 ++
  t/t4045-diff-relative.sh       | 56 
+++++++++++++++++++++++++++++++++---------
  4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 496e9b0..b8a7c60 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -107,6 +107,7 @@ diff.relative::
      Show pathnames relative to the current directory and exclude
      changes outside this directory; equivalent to the 'git diff'
      option '--relative'.
+    Overridden by the '--no-relative' linkgit:git-diff[1] option.

  diff.renameLimit::
      The number of files to consider when performing the copy/rename
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cb083a..7470b16 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -448,6 +448,10 @@ ifndef::git-format-patch[]
      not in a subdirectory (e.g. in a bare repository), you
      can name which subdirectory to make the output relative
      to by giving a <path> as an argument.
+
+--no-relative::
+    Turn off relative pathnames, even when the configuration
+    file gives the default to do so.
  endif::git-format-patch[]

  -a::
diff --git a/diff.c b/diff.c
index 03697a9..9e4ec1f 100644
--- a/diff.c
+++ b/diff.c
@@ -3703,6 +3703,8 @@ int diff_opt_parse(struct diff_options *options, 
const char **av, int ac)
          DIFF_OPT_SET(options, RELATIVE_NAME);
          options->prefix = arg;
      }
+    else if (!strcmp(arg, "--no-relative"))
+        DIFF_OPT_CLR(options, RELATIVE_NAME);

      /* xdiff options */
      else if (!strcmp(arg, "--minimal"))
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 8c8fe0b..b2764d5 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -12,8 +12,8 @@ test_expect_success 'setup' '
      git commit -m one
  '

-check_diff() {
-expect=$1; shift
+store_diff_relative() {
+expect=$1;
  cat >expected <<EOF
  diff --git a/$expect b/$expect
  new file mode 100644
@@ -23,29 +23,61 @@ index 0000000..25c05ef
  @@ -0,0 +1 @@
  +other content
  EOF
-test_expect_success "-p $*" "
-    git diff -p $* HEAD^ >actual &&
-    test_cmp expected actual
-"
  }

-check_config() {
-expect=$1; shift
+store_diff_absolute() {
+expect=$1;
  cat >expected <<EOF
-diff --git a/$expect b/$expect
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..d95f3ad
+--- /dev/null
++++ b/file1
+@@ -0,0 +1 @@
++content
+diff --git a/subdir/file2 b/subdir/file2
  new file mode 100644
  index 0000000..25c05ef
  --- /dev/null
-+++ b/$expect
++++ b/subdir/file2
  @@ -0,0 +1 @@
  +other content
  EOF
+}
+
+check_diff() {
+store_diff_relative $1; shift
+test_expect_success "-p $*" "
+    git diff -p $* HEAD^ >actual &&
+    test_cmp expected actual
+"
+}
+
+check_option_no_relative() {
+store_diff_absolute $1; shift
+test_expect_success "-p $* --no-relative" "
+    git diff -p $* HEAD^ --no-relative >actual &&
+    test_cmp expected actual
+"
+}
+
+check_config() {
+store_diff_relative $1; shift
  test_expect_success "git-config diff.relative=true in $1" "
      (cd $1; git -c diff.relative=true diff -p HEAD^ >../actual) &&
      test_cmp expected actual
  "
  }

+check_config_no_relative() {
+store_diff_absolute $1; shift
+test_expect_success "--no-relative w/ git-config diff.relative=true in 
$1" "
+    (cd $1; git -c diff.relative=true diff --no-relative -p HEAD^ 
 >../actual) &&
+    test_cmp expected actual
+"
+}
+
+
  check_numstat() {
  expect=$1; shift
  cat >expected <<EOF
@@ -81,12 +113,12 @@ test_expect_success "--raw $*" "
  "
  }

-for type in diff numstat stat raw; do
+for type in diff option_no_relative numstat stat raw; do
      check_$type file2 --relative=subdir/
      check_$type file2 --relative=subdir
      check_$type dir/file2 --relative=sub
  done
-for type in config; do
+for type in config config_no_relative; do
      check_$type file2 subdir/
      check_$type file2 subdir
  done
-- 
1.9.1
