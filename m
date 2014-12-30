From: kelson@shysecurity.com
Subject: [PATCH 2/2] support for --no-relative and diff.relative
Date: Tue, 30 Dec 2014 14:32:34 -0500
Message-ID: <54A2FDD2.3010707@shysecurity.com>
References: <54972C33.4030009@shysecurity.com> <54A2E748.3010008@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y62X6-0002QO-5w
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 20:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbaL3Tcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 14:32:39 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:51599 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaL3Tcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 14:32:39 -0500
Received: by mail-qg0-f49.google.com with SMTP id a108so10791369qge.36
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 11:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=s5z4f4MZ4yEdKRef0bP4wZHEjmy77SYl15N/7vouyX0=;
        b=FMdadMs1b7nW3rqN6xOai80v3QW8WP4Zicwz0ZwOb5RS1MGB8S2ohy+Zn7HrgIkG8T
         2ZSzesJAxcm0WKQ+g7YNpywl1nnQURQzsQEoXcWDoDln5a/yYL9m2Mk+cSQ17u+eqvdm
         BzAu2AJnxQUzP8U36wXNXWLqsRraPTd6e/tEsd6lG7DgZnrSA5sUH7NxcH/9erLEJY7Z
         FiUuoyU8l/CwPNs8cS+ppq7gKnHXLZAniVwXsh5U86Aq8jLMl8IlKVwSLrga79U5Sp1J
         AP06JpCJqPbtqy/S1xAIOGm/qrBrUBo4fv4qix562EFdmNmx5GQFsBn54Fq1SH5F7k5B
         V8NA==
X-Gm-Message-State: ALoCoQn2Gv1cP7W+DMaEQ+Ul1jXSito8DvRKUkXA98bIa0O2ngvnu0/odufW1po+mCVjVruwstPk
X-Received: by 10.140.31.163 with SMTP id f32mr17548739qgf.23.1419967958302;
        Tue, 30 Dec 2014 11:32:38 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id r4sm26858090qad.32.2014.12.30.11.32.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2014 11:32:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A2E748.3010008@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261936>

added diff.relative setting for git-diff (code, documentation, and tests)

`git-config diff.relative=true` causes `git diff` to behave like `git 
diff --relative`. Overridden by `git diff --no-relative`.

Signed-off-by: Brandon Phillips <kelson@shysecurity.com>
---
  Documentation/diff-config.txt |  6 ++++++
  diff.c                        |  8 ++++++++
  t/t4045-diff-relative.sh      | 20 ++++++++++++++++++++
  3 files changed, 34 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index b001779..b8a7c60 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -103,6 +103,12 @@ diff.orderfile::
  	one shell glob pattern per line.
  	Can be overridden by the '-O' option to linkgit:git-diff[1].

+diff.relative::
+	Show pathnames relative to the current directory and exclude
+	changes outside this directory; equivalent to the 'git diff'
+	option '--relative'.
+	Overridden by the '--no-relative' linkgit:git-diff[1] option.
+
  diff.renameLimit::
  	The number of files to consider when performing the copy/rename
  	detection; equivalent to the 'git diff' option '-l'.
diff --git a/diff.c b/diff.c
index 7bceba8..9e4ec1f 100644
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
index ccd67c7..c2c15e4 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -104,10 +104,30 @@ test_expect_success "--raw $*" "
  "
  }

+check_config() {
+store_diff_relative $1; shift
+test_expect_success "git-config diff.relative=true in $1" "
+	(cd $1; git -c diff.relative=true diff -p HEAD^ >../actual) &&
+	test_cmp expected actual
+"
+}
+
+check_config_no_relative() {
+store_diff_absolute $1; shift
+test_expect_success "--no-relative w/ git-config diff.relative=true in 
$1" "
+	(cd $1; git -c diff.relative=true diff --no-relative -p HEAD^ 
 >../actual) &&
+	test_cmp expected actual
+"
+}
+
  for type in diff numstat stat raw norel_pre norel_post; do
  	check_$type file2 --relative=subdir/
  	check_$type file2 --relative=subdir
  	check_$type dir/file2 --relative=sub
  done
+for type in config config_no_relative; do
+	check_$type file2 subdir/
+	check_$type file2 subdir
+done

  test_done
--
1.9.1
