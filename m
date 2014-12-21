From: kelson@shysecurity.com
Subject: [PATCH v3 1/2] git-config support for diff.relative setting
Date: Sun, 21 Dec 2014 15:23:05 -0500
Message-ID: <54972C29.7060801@shysecurity.com>
References: <548B7967.3060201@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:23:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2n28-0008J9-90
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 21:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbaLUUXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 15:23:15 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:64076 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbaLUUXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 15:23:14 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so2709065qcy.35
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 12:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EFjyj9xXoXzUc64zOek9GZIphkjqb4NcN5RVT8zQhpo=;
        b=UTcqBI5lPlSmX3si9hnpQ1zP6r00NzKJgGcnESx4HMIbECa1Fkrc0RuGMM9CXZlNwL
         WpbMxf0hkZx50TG6Xgyv7KbzI0SJ1PAdu7Nly7/0qxB6IM+zwg0rViBAf9la90fgmxbL
         4CqUjxCTeBa5f33BdLP40x8hofQLb1FjglGya2Xia4ef/WMB43cRvoUDJDgw77hTrWqD
         gFwS6mUyYdGYoHsf+J+Bzz7G+9INLc/7zXk/LrSn5L3XxnrTfmPzIHUkWszZqy8kl8Hg
         NDeMtD1PVi8NU6AT+Ph5Z80u8ncQ/4qWC5bgwxKyqUd7aSiIM/isvylbNLciJURLQmrE
         XuNA==
X-Gm-Message-State: ALoCoQl4WLfztX8zAFKJKKUDOi/B+YZa4unZdtqMRhzms+DwXh2BLaZQ6jVx/jsQGG30JA5yfcuc
X-Received: by 10.224.54.2 with SMTP id o2mr31254382qag.63.1419193394079;
        Sun, 21 Dec 2014 12:23:14 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id t5sm14819584qge.16.2014.12.21.12.23.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2014 12:23:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <548B7967.3060201@shysecurity.com>
X-Forwarded-Message-Id: <548B7967.3060201@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261627>

By default, git-diff shows changes and pathnames relative to the 
repository root.
Setting diff.relative to "true" shows pathnames relative to the current 
directory
and excludes changes outside this directory.
---
  Documentation/diff-config.txt |  5 +++++
  diff.c                        |  8 ++++++++
  t/t4045-diff-relative.sh      | 21 +++++++++++++++++++++
  3 files changed, 34 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index b001779..496e9b0 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -103,6 +103,11 @@ diff.orderfile::
  	one shell glob pattern per line.
  	Can be overridden by the '-O' option to linkgit:git-diff[1].

+diff.relative::
+	Show pathnames relative to the current directory and exclude
+	changes outside this directory; equivalent to the 'git diff'
+	option '--relative'.
+
  diff.renameLimit::
  	The number of files to consider when performing the copy/rename
  	detection; equivalent to the 'git diff' option '-l'.
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
