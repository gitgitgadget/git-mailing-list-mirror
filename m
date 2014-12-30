From: kelson@shysecurity.com
Subject: [PATCH v3 1/2] git-config support for diff.relative setting
Date: Tue, 30 Dec 2014 12:56:20 -0500
Message-ID: <54A2E744.8010508@shysecurity.com>
References: <548B7967.3060201@shysecurity.com> <54972C29.7060801@shysecurity.com>
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
	id 1Y6126-00012h-UY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 18:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaL3R40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 12:56:26 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46376 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaL3R4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 12:56:25 -0500
Received: by mail-qa0-f46.google.com with SMTP id w8so10407699qac.33
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 09:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EFjyj9xXoXzUc64zOek9GZIphkjqb4NcN5RVT8zQhpo=;
        b=WE8MEFVg/0rekgApxO6S0eiiF8OJeIv2+YlyF3NdfAt7jweTvVpNtRxxaSsfeELfrf
         biBSaRlzSwNRAxdMPUssKIBkWlvDvtQ7HqSl+n2/sinUXx1O75ssRp8ID//CbejzKNe7
         X04KJn3LEw1wQ0s0iScqIvrMihUJLQv1mk2lYxJ4vVvEt3jOkI7u6e6ptJJK/La/4mhh
         PPaPU5WuCAIAWOC+2KpgQxOzXVvvZe//2XP2fg0OJ+GbN8GKNioBteZKu9Ap0hKQwYQC
         NgO0Y+HLYWtjsDxyEzy8MvIlZ4SHEQBV6IItY/kaL5HJZiIva4kGcsYS7/faItLwG5Ud
         0QWA==
X-Gm-Message-State: ALoCoQkHUmxpfed/d5xvGm9B+YA6l0Qr0QYGqcbLAU7XmsmbM23i1ehLYjS0DXaCbBDoVe59ujyi
X-Received: by 10.224.4.133 with SMTP id 5mr103324749qar.37.1419962184463;
        Tue, 30 Dec 2014 09:56:24 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id e7sm36506453qag.49.2014.12.30.09.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2014 09:56:23 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54972C29.7060801@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261930>

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
+    Show pathnames relative to the current directory and exclude
+    changes outside this directory; equivalent to the 'git diff'
+    option '--relative'.
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

+    if (!strcmp(var, "diff.relative")) {
+        if (git_config_bool(var, value))
+            DIFF_OPT_SET(&default_diff_options, RELATIVE_NAME);
+        else
+            DIFF_OPT_CLR(&default_diff_options, RELATIVE_NAME);
+        return 0;
+    }
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
+    (cd $1; git -c diff.relative=true diff -p HEAD^ >../actual) &&
+    test_cmp expected actual
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
+    check_$type file2 subdir/
+    check_$type file2 subdir
+done

  test_done
-- 
1.9.1
