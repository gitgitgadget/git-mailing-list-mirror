From: Kelson <kelson@shysecurity.com>
Subject: [PATCH v2] added git-config support for diff.relative setting
Date: Fri, 12 Dec 2014 18:25:27 -0500
Message-ID: <548B7967.3060201@shysecurity.com>
References: <548947A0.7000608@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 00:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzZab-00046O-Sr
	for gcvg-git-2@plane.gmane.org; Sat, 13 Dec 2014 00:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbaLLXZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 18:25:33 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36672 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaLLXZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 18:25:33 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so6196892qcz.38
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 15:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4TYpD11zFzgPDEffmcULJpba5ki/fkXeSQ+9g98ZY2o=;
        b=hAQE3QmsAR7bgt3AR5LE4TUSpPG74hstYTmoqpMsqjI9z8qKYHxD6P2bLBgaNpYlpF
         tCzYyrHyapZwIACf81drpMTBh9VicCrLzLCjVUUy7bXYIUZK3hcWb45yB1ENCnqRXfB2
         quVMXygjd8VoYdCeH8yVuJ9E3Kz+WY9cehjtW8bxIiwPQ4RgImvvWCN1S0LlR7z9N6C0
         2wz6kC9bALvpqFm+v7MVwpwcCEtRS2wjEoEEmR7Lh7zce9og1cwtOKz9vtNij45KwMj/
         5jumbjBJIVl6sthUlpmvJnyuAodmy1gGn1MSPo8G0F2l+4i6R/KoxbACifxRtqqUwa76
         CyKA==
X-Gm-Message-State: ALoCoQng2IubmXGXk77Td1NK1ubI/+6zMrW56eTAfvds6gqoa+UpA/Q8r7dApbrQVwz0y0/zYZo4
X-Received: by 10.140.97.68 with SMTP id l62mr17084255qge.81.1418426732101;
        Fri, 12 Dec 2014 15:25:32 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id e7sm2785961qag.49.2014.12.12.15.25.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Dec 2014 15:25:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <548947A0.7000608@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261390>

By default, git-diff shows changes and pathnames relative to the 
repository root. Setting the diff.relative config option to "true" shows 
pathnames relative to the current directory and excludes changes outside 
this directory.

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
