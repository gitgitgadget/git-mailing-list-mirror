From: kelson@shysecurity.com
Subject: [PATCH 2/2] support for --no-relative and diff.relative
Date: Tue, 06 Jan 2015 11:19:58 -0500
Message-ID: <54AC0B2E.3050205@shysecurity.com>
References: <54972C33.4030009@shysecurity.com> <54A2E748.3010008@shysecurity.com> <54A2FDD2.3010707@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:20:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8Wri-00048s-Co
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 17:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbbAFQUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 11:20:06 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:55120 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbAFQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 11:20:05 -0500
Received: by mail-qg0-f54.google.com with SMTP id l89so17016018qgf.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 08:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=s5z4f4MZ4yEdKRef0bP4wZHEjmy77SYl15N/7vouyX0=;
        b=AruVzI7FNBtvg4e8aLcdWdgeVie0rL4n3JapNEzmzoOrK7/PxpftRhvHdKTMvQ0GvE
         EpVBHSWCWgZMJMgsc+yNPk5HnsGKQ/uRKv04kulvR3XLuGg/+O6k3s4Z6l1op9m+2zvt
         6C31AFOiYznVH2o9EsZavuUkLKYfFi71JohsvP6UsYqXzjqK35G1t5XeFetz/LM3ZR0C
         NUC6nW4RJfw3u0nTHuhgTDySoGjApJF76s8oGevqhLBFIXixhp1DBXp4MobCw+GN8YaR
         AkvPNPy6peA43Sx56RBHZ4ZRd+/AKj/kbPKBytE/EFncWg4FdnOmgpLFFPiQlMkBa4Ze
         Lk9g==
X-Gm-Message-State: ALoCoQlWgQedcBqig9cw6Ammrdof6sd122Sq9SYsby/GGKuaX/0Z2eObLhMC9dEz0QheoTcnbcye
X-Received: by 10.224.167.82 with SMTP id p18mr93441280qay.98.1420561204251;
        Tue, 06 Jan 2015 08:20:04 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id b13sm42959440qaw.31.2015.01.06.08.20.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2015 08:20:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A2FDD2.3010707@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262075>

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
