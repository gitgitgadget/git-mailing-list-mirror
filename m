From: Kelson <kelson@shysecurity.com>
Subject: [PATCH] added git-config support for diff.relative setting
Date: Thu, 11 Dec 2014 02:28:32 -0500
Message-ID: <548947A0.7000608@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 08:28:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyyAz-0003Zf-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 08:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbaLKH2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 02:28:36 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:49642 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171AbaLKH2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 02:28:35 -0500
Received: by mail-qg0-f44.google.com with SMTP id q107so1306596qgd.31
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 23:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=+ayZtLIKnPhty/qnWxBvm2RgfoqKE1Ib+znzJj/ca0I=;
        b=cHcKP6mwbV8lz2oo1C12iUP26RQvcH3rudAE1oQcxHVyhOsWpTUSVGXn1Xyv0Apz5J
         l5L9j+FAJ6uGFaD0RTMCrgS+pVtUEH5Xlrc/8Z0XirCYxpT82h3YG9L9VKVA1XLmnG/S
         qQAKgh5PxfKVepmQjTnhhfcnO9uC689yswl0Goct4FLma4nfOkFBgYfyaQ95yu5TkoFi
         7XJYPw6CAs4zMpF5JjVX1dcHaSvPYoeNGR4OKpYeN5gEd6u9prv2/V8JQJ7B7y+37Zvt
         lfV8iqznJB41S+TM7FhQxYC/ck7bQMEWHqziBlsgfSQP95nhdiRqOZl103B+j8onwrq+
         jKnA==
X-Gm-Message-State: ALoCoQmG5jaw1xTjhhOd3ArrdzKqjJQdWgxgeaeU5RzBDztqDC8/j227MZ7AXiM2jb6BlW+C2+XV
X-Received: by 10.140.87.71 with SMTP id q65mr15758859qgd.67.1418282914764;
        Wed, 10 Dec 2014 23:28:34 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id j101sm325899qge.24.2014.12.10.23.28.34
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 23:28:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261271>

By default, git-diff shows changes and pathnames relative to the 
repository root.
Setting the diff.relative config option to "true" shows pathnames 
relative to
the current directory and excludes changes outside this directory.
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
index d1bd534..22daa2f 100644
--- a/diff.c
+++ b/diff.c
@@ -270,6 +270,14 @@ int git_diff_basic_config(const char *var, const 
char *value, void *cb)
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
  	if (starts_with(var, "submodule."))
  		return parse_submodule_config_option(var, value);

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
