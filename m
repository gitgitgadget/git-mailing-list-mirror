From: kelson@shysecurity.com
Subject: [PATCH 1/2] support for --no-relative and diff.relative
Date: Tue, 06 Jan 2015 11:19:55 -0500
Message-ID: <54AC0B2B.90107@shysecurity.com>
References: <548B7967.3060201@shysecurity.com> <54972C29.7060801@shysecurity.com> <54A2E744.8010508@shysecurity.com> <54A2FDC8.5010504@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Wrb-0003Ux-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 17:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbbAFQUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 11:20:04 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:50422 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbAFQUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 11:20:03 -0500
Received: by mail-qa0-f42.google.com with SMTP id n8so16684019qaq.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 08:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mC3CvdddmOjVYWHgCBt/e2JUwo2YaZBxVnuCjMxX5tU=;
        b=gw6TzzMHCI1Uzp6kGvNGI48a31Ze1X0n+aM4vuOGh6944Ync1PQtUtmtAZJkEdGLnB
         tABDCiiaUfvz1M6BuC2PHvbjo8ZmVTUkI6DpNO+1sgoE+LqghIEMDRu+VFOzwE5grJV4
         L6PifRA/ZPGrn4+4BFy9MMG3hLIUIgEXGUpKR12IAIQCIGYO0q9GsREH9562Q7PjCGOR
         TJGu7vrERsYb2/yVhO8uX5xiToAa3inzRa4qELoRMzChH2WJTp7X2uKUJBB107ZpTDWa
         GT4XmTnx+nzP30TanEV6uHU52Ee6icpggBf/IaFi5fq6B71oKhCsxHTuPKgtfTWGOAe+
         pTfQ==
X-Gm-Message-State: ALoCoQlnIf2zzeay60oasFQf7ddCEypCKKZWio4lfQkzJft3FH15IlNqeqRuNtt14F2ESTSqfXC2
X-Received: by 10.224.51.11 with SMTP id b11mr155122499qag.43.1420561202500;
        Tue, 06 Jan 2015 08:20:02 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id z5sm29279382qal.11.2015.01.06.08.20.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2015 08:20:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A2FDC8.5010504@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262074>

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
