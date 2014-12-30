From: kelson@shysecurity.com
Subject: [PATCH 1/2] support for --no-relative and diff.relative
Date: Tue, 30 Dec 2014 14:32:24 -0500
Message-ID: <54A2FDC8.5010504@shysecurity.com>
References: <548B7967.3060201@shysecurity.com> <54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y62Wv-0002GJ-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 20:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaL3Tc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 14:32:29 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35289 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaL3Tc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 14:32:29 -0500
Received: by mail-qg0-f44.google.com with SMTP id q107so10945616qgd.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 11:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mC3CvdddmOjVYWHgCBt/e2JUwo2YaZBxVnuCjMxX5tU=;
        b=jgcmY8HXF5aQC0+dv5qHJ64zuqymMzMMlVhOOA0kndAJJbuUfmgp0ukJf0kZbyTvI0
         NeeNLOt30XvqEEHnMVWAbc4Yi9bKfDlm5ZtZk6eV18XPYbc0PkCUiBIPDVgqDrkrS/1H
         qnuQeAgaiRdaEGFBBkJg15m6uNmjkeRSsYuvrG6StuPN/EgUU36Ze8LaIT+PJeIN4dXY
         u8YuQzS1bC+BLGaO6z+TYthO+v4cruG8XrxqhdEpDRsYWzUpK3P9FehLFzhoKg8ROY0Z
         x4BrK//UjhDB9unN/QJWLUb8NdMbmppYve5Aa2AtA1FHSTEZUnhO5wT8jE0l0BR8szTs
         JoHg==
X-Gm-Message-State: ALoCoQmPDQJsLfYftt+w/e9NSJqdK4YEllodHlOIlp/SHew9dtKGiLv9l8v9nQp4/NJ/AXE3MGCa
X-Received: by 10.224.63.198 with SMTP id c6mr61498741qai.41.1419967948335;
        Tue, 30 Dec 2014 11:32:28 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id s2sm36690262qam.45.2014.12.30.11.32.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2014 11:32:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A2E744.8010508@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261935>

added --no-relative option for git-diff (code, documentation, and tests)

--no-relative overrides --relative causing a return to standard behavior

Signed-off-by: Brandon Phillips <kelson@shysecurity.com>
---
  Documentation/diff-options.txt |  4 ++++
  diff.c                         |  2 ++
  t/t4045-diff-relative.sh       | 46 
+++++++++++++++++++++++++++++++++++++++---
  3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cb083a..2b15050 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -448,6 +448,10 @@ ifndef::git-format-patch[]
  	not in a subdirectory (e.g. in a bare repository), you
  	can name which subdirectory to make the output relative
  	to by giving a <path> as an argument.
+
+--no-relative::
+	Turn off relative pathnames and include all changes in the
+	repository.
  endif::git-format-patch[]

  -a::
diff --git a/diff.c b/diff.c
index d1bd534..7bceba8 100644
--- a/diff.c
+++ b/diff.c
@@ -3695,6 +3695,8 @@ int diff_opt_parse(struct diff_options *options, 
const char **av, int ac)
  		DIFF_OPT_SET(options, RELATIVE_NAME);
  		options->prefix = arg;
  	}
+	else if (!strcmp(arg, "--no-relative"))
+		DIFF_OPT_CLR(options, RELATIVE_NAME);

  	/* xdiff options */
  	else if (!strcmp(arg, "--minimal"))
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 3950f50..ccd67c7 100755
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
@@ -23,12 +23,52 @@ index 0000000..25c05ef
  @@ -0,0 +1 @@
  +other content
  EOF
+}
+
+store_diff_absolute() {
+expect=$1;
+cat >expected <<EOF
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..d95f3ad
+--- /dev/null
++++ b/file1
+@@ -0,0 +1 @@
++content
+diff --git a/subdir/file2 b/subdir/file2
+new file mode 100644
+index 0000000..25c05ef
+--- /dev/null
++++ b/subdir/file2
+@@ -0,0 +1 @@
++other content
+EOF
+}
+
+check_diff() {
+store_diff_relative $1; shift
  test_expect_success "-p $*" "
  	git diff -p $* HEAD^ >actual &&
  	test_cmp expected actual
  "
  }

+check_norel_pre() {
+store_diff_relative $1; shift
+test_expect_success "-p --no-relative $*" "
+	git diff -p --no-relative $* HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
+check_norel_post() {
+store_diff_absolute $1; shift
+test_expect_success "-p $* --no-relative" "
+	git diff -p $* --no-relative HEAD^ >actual &&
+	test_cmp expected actual
+"
+}
+
  check_numstat() {
  expect=$1; shift
  cat >expected <<EOF
@@ -64,7 +104,7 @@ test_expect_success "--raw $*" "
  "
  }

-for type in diff numstat stat raw; do
+for type in diff numstat stat raw norel_pre norel_post; do
  	check_$type file2 --relative=subdir/
  	check_$type file2 --relative=subdir
  	check_$type dir/file2 --relative=sub
--
1.9.1
