From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/6] t1500: avoid setting configuration options outside of tests
Date: Tue, 10 May 2016 01:20:53 -0400
Message-ID: <20160510052055.32924-5-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0076-0003ga-0d
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbcEJFVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:36 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36193 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEJFVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:35 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so407071iof.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=raEbGgx2xr9mZWrm8Mdi+0E/ad0waMeq3K6/dWO3nf8=;
        b=SM0OLsP8YjT95VZrMlH7vI+B2lx4AyzIzQeTjzj5yLzNp2fn++EXTAEixy8IB1tsLl
         yDP2Qqrhcyv2fOF/bnw85owsrgMjTh41a8Pa1mxeWXe2PHTMkRaqey5Ic1F5NY34ieDB
         +BUP1YX63sq1dN4MSr/fyeOPGNqfODyEkS7hKfthgE9B3CPdZYqphII6uuofb4KbpwgF
         Ww1fMfv/AaqKOY04x9ftU/Sw6S18umlz+h5NSljQW/N11FnYeqjt+B8NVUipa1lt+SdR
         dBcRFVSNEGwVch/jLFcOA9hP1iOerU3DoZ0I/88VdQ8wKU406OzbCr9hzJ6hus/VKWt/
         8nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=raEbGgx2xr9mZWrm8Mdi+0E/ad0waMeq3K6/dWO3nf8=;
        b=dIxeTBsQ1ZAsUHfEY0WLWE9hHn63NxBpezlZ90ebopYcwI9bzbfl254TTQ8UNFiMvz
         4D2tJb/MZ+fXbth9FQIyaNUm1/nimlA8lJss/zn4gIcA3xMpLTHo/zaXexnjj/tFNV6V
         Tl7jH8AO/OmF0sxzjGDgzVAvFb0E2nQUIhZLeKJ7Y9b+L0wcBG3R8nN+lj4gnBtkjs2P
         pt+u5Z+vlVnsWHjFDaJQ9VL/8WeNI82ePuWzy33YA0jCmHOiSRKMS6ydYDi8iUveC16R
         zdrAoBgOqtqV7PRTKIDLBwckThvAdEKvcq6Klw6dGVjWX2RzxefIqMdeTmyHlj3HvS6C
         GQ4Q==
X-Gm-Message-State: AOPr4FXJks96SkibFxiR+p3dUc1RxILkCCb6/ntgSeypKHo5CjjWVesRz91378H8WoMhfw==
X-Received: by 10.107.9.232 with SMTP id 101mr45957650ioj.52.1462857694365;
        Mon, 09 May 2016 22:21:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294087>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-b <value>" option to allow callers to set
"core.bare" explicitly or undefine it, and take advantage of this new
option to avoid setting "core.bare" outside of tests.

Under the hood, "-b <value>" invokes "test_config -C <dir>" (or
"test_unconfig -C <dir>"), which means that git-config knows explicitly
where to find its configuration file. Consequently, the global
GIT_CONFIG environment variable, which was needed by the manual
git-config invocations outside of tests, is no longer needed, and is
thus dropped.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index f294ecc..c058aa4 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -6,15 +6,25 @@ test_description='test git rev-parse'
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
 	dir=
+	bare=
 	while :
 	do
 		case "$1" in
 		-C) dir="-C $2"; shift; shift ;;
+		-b) bare="$2"; shift; shift ;;
 		-*) error "test_rev_parse: unrecognized option '$1'" ;;
 		*) break ;;
 		esac
 	done
 
+	case "$bare" in
+	'') ;;
+	t*) bare="test_config $dir core.bare true" ;;
+	f*) bare="test_config $dir core.bare false" ;;
+	u*) bare="test_unconfig $dir core.bare" ;;
+	*) error "test_rev_parse: unrecognized core.bare value '$bare'"
+	esac
+
 	name=$1
 	shift
 
@@ -26,6 +36,7 @@ test_rev_parse () {
 	do
 		expect="$1"
 		test_expect_success "$name: $o" '
+			$bare &&
 			echo "$expect" >expect &&
 			git $dir rev-parse --$o >actual &&
 			test_cmp expect actual
@@ -45,37 +56,27 @@ test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
 test_expect_success 'setup untracked sub/dir' 'mkdir -p sub/dir'
 test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
 
-git config core.bare true
-test_rev_parse 'core.bare = true' true false false
+test_rev_parse -b t 'core.bare = true' true false false
 
-git config --unset core.bare
-test_rev_parse 'core.bare undefined' false false true
+test_rev_parse -b u 'core.bare undefined' false false true
 
 test_expect_success 'setup non-local database ../.git' 'mkdir work'
 GIT_DIR=../.git
-GIT_CONFIG="$ROOT/work/../.git/config"
-export GIT_DIR GIT_CONFIG
+export GIT_DIR
 
-git config core.bare false
-test_rev_parse -C work 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
 
-git config core.bare true
-test_rev_parse -C work 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_rev_parse -C work -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
 
-git config --unset core.bare
-test_rev_parse -C work 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse -C work -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 test_expect_success 'setup non-local database ../repo.git' 'mv .git repo.git'
 GIT_DIR=../repo.git
-GIT_CONFIG="$ROOT/work/../repo.git/config"
 
-git config core.bare false
-test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
-git config core.bare true
-test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_rev_parse -C work -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
-git config --unset core.bare
-test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_rev_parse -C work -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
2.8.2.530.g51d527d
