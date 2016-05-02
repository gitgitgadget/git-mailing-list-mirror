From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule deinit: lose requirement for giving '.'
Date: Mon,  2 May 2016 15:24:03 -0700
Message-ID: <1462227844-10624-3-git-send-email-sbeller@google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue May 03 00:24:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMGP-0003oe-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbcEBWYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 18:24:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34348 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbcEBWYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 18:24:15 -0400
Received: by mail-pa0-f50.google.com with SMTP id r5so1023447pag.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjyeJB4GyvhV1JqmeveADtoK6osARXokrQnhI+JEZ6w=;
        b=N6lvGfJAFwpILDCpdyKaqH8CgFIj/5mMbFQ22k/EkijoOPUAK6tn/OoLybGIbEvqRJ
         cOIM7tWs3kA1QA8I8LGjRCzLwOiTyYlFh+W+ZaHqvdR8CKOpPNDNmEhiHE5t5Q3OFmmj
         dcdw/KKIKStpSjmJIPM/tZ2EAGJZIYYxZMUxf3i6SAkgse89zBHsB5M0Z6ZQoj84XHPF
         XQJVwJLGsKdPEG3c6Ze1B4KyefkhH1HwFGppcZEGXfTlzsMchwgjardeBs5VSMgS73uG
         9rFAsuuNQNWFPLuzfRnrfd5R5CayUbB/kU07NyH4BkYAjXO2vO+PZGGCALdbnl3vQekp
         7NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjyeJB4GyvhV1JqmeveADtoK6osARXokrQnhI+JEZ6w=;
        b=m+FfqK1zi4Xv1otOxKFEbvvUT328k1/Jn6txOOPUystxFFChOKzV6pkcyVSNZi2/VN
         Fg+ijKa/Pcb8YJ3oSmiP4YJKNurAH3QqP27uLwbUSii9UGSj2OPY7l6xt59u5YCzlWww
         LBWvETC8oMdAITqei8uqHeOQgwZRw4FrEysoTueHJqnjVK7b7XaQCs/gfdOFlbi6674h
         h5Qih6FlM20TElbqmeNjzDhFdElkETDqPslhyFI6e4MRbH9r04xRP5AKeoCxU8VjZMLw
         yTW/ChcpeANa6YyWRuKDx0UVfL0SAqFVRI4QJfEnRj7COhiFJiZ4xFawkiZuxMaBPGtP
         4IhA==
X-Gm-Message-State: AOPr4FXiqgVCqkgi0tEeGo6b3HksE4Rvb6vj/weMy/aTr67F9pHCanSpTsWysyvbql5JvL86
X-Received: by 10.66.79.197 with SMTP id l5mr55356723pax.61.1462227854020;
        Mon, 02 May 2016 15:24:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9831:74f0:67fd:61ba])
        by smtp.gmail.com with ESMTPSA id y66sm269985pfy.66.2016.05.02.15.24.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 May 2016 15:24:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.37.gb114fff.dirty
In-Reply-To: <1462227844-10624-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293298>

The discussion in [1] realized that '.' is a faulty suggestion as
there is a corner case where it fails:

> "submodule deinit ." may have "worked" in the sense that you would
> have at least one path in your tree and avoided this "nothing
> matches" most of the time.  It would have still failed with the
> exactly same error if run in an empty repository, i.e.
>
>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>        $ git init
>        $ rungit v2.6.6 submodule deinit .
>        error: pathspec '.' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>        $ >file && git add file
>        $ rungit v2.6.6 submodule deinit .
>        $ echo $?
>        0

Allow no argument for `submodule deinit` to mean all submodules
and add a test to check for the corner case of an empty repository.

There is no need to update the documentation as it did not describe the
special case '.' to remove all submodules.

[1] http://news.gmane.org/gmane.comp.version-control.git/289535

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           | 5 -----
 t/t7400-submodule-basic.sh | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 82e95a9..d689265 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -428,11 +428,6 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
-	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
-	fi
-
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 90d80d3..9af47b5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -11,6 +11,10 @@ subcommands of git submodule.
 
 . ./test-lib.sh
 
+test_expect_success 'submodule deinit works on empty repository' '
+	git submodule deinit
+'
+
 test_expect_success 'setup - initial commit' '
 	>t &&
 	git add t &&
@@ -948,7 +952,6 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-	test_must_fail git submodule deinit &&
 	git submodule deinit . >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-- 
2.8.0.37.gb114fff.dirty
