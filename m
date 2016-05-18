From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/5] t1500: avoid setting configuration options outside of tests
Date: Wed, 18 May 2016 16:15:44 -0400
Message-ID: <20160518201545.9113-5-sunshine@sunshineco.com>
References: <20160518201545.9113-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 22:16:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37tK-00073n-QE
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbcERUQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:16:19 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36571 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbcERUQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:15 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so5663359igl.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ehC9UHiI5IRX7P/q+lfEjfYTrMl3on+eqmdLpnOlAXg=;
        b=Gp8ilH+9rA+a2/gKLJMqcbSoK6onLo8d/YQ6IDRsUcQthmI/2YkOJ2Q83TqStvxRrK
         bqbDyPeI6/hJimt1oi9SW3CNrj5HJnluMeBBaAnUUl1JjyuRzJXvLvDBB3gGtsu9nSPj
         sOzvM7vK6MbiIzViARfOBO8GyGSdwMjDo/dYYNryCskQrVrcCll9S13CnglBi/uc/Vc+
         zwugRNMMcR/CaZakXQW8TlQglvbh+KPy46sfR9mHpIsgwe/a6zOrt/jwrUsW3qy43hfN
         7wj0vtwIdu+AxOFqnldrVaJTPkDxG9gRNC9gJtdinOanw9oODLLLhn5jmWlBcEKc+Dda
         EFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ehC9UHiI5IRX7P/q+lfEjfYTrMl3on+eqmdLpnOlAXg=;
        b=mRo3pVX9GWBcm8U+ZLNSl5vOp68uZpfb89cjlDazyb4M4vVOesr4j3QKnkJX+MJbKv
         X86jKDMhYSbfMK9RkeM62F+Qiz/DFL+3Dj3U1MU9yeCIHtvFQXVAs1KoH/RYACYhzsoQ
         4DXQdNhKKmJyzbEowVX9J6afTXeJzhEcmNG6E7ChaJaRSDIFl7Soch7Kwy4gElg2Nwql
         1asp4kTp8BMPGpW9SA98FSIA3KL9fumvQtVBFXnJCBBhe/wW2ZPIonRi88geDEN4Bbpl
         MrND9h24uCxbDpGiUXh2ZFVDEz0xV5M1JqMkxDpR2GDuwk8kRynVnOS2JG476xiJ1jDl
         P5cQ==
X-Gm-Message-State: AOPr4FUH+IXRZeusMWtrH8+ogxaGuz4KMu0c0qkBkMw3qNU0KyIeUU8g7N5BkWjQPIuJAQ==
X-Received: by 10.50.112.42 with SMTP id in10mr6784797igb.67.1463602574892;
        Wed, 18 May 2016 13:16:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.748.g927f425
In-Reply-To: <20160518201545.9113-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295001>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-b <value>" option to allow callers to set
"core.bare" explicitly or undefine it. Take advantage of this new option
to avoid setting "core.bare" outside of tests.

Under the hood, "-b <value>" invokes "test_config -C <dir>" (or
"test_unconfig -C <dir>"), thus git-config knows explicitly where to
find its configuration file. Consequently, the global GIT_CONFIG
environment variable required by the manual git-config invocations
outside of tests is no longer needed, and is thus dropped.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index d73a52b..325d821 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -6,10 +6,15 @@ test_description='test git rev-parse'
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
 	d=
+	bare=
 	while :
 	do
 		case "$1" in
 		-C) d="$2"; shift; shift ;;
+		-b) case "$2" in
+		    [tfu]*) bare="$2"; shift; shift ;;
+		    *) error "test_rev_parse: bogus core.bare value '$2'" ;;
+		    esac ;;
 		-*) error "test_rev_parse: unrecognized option '$1'" ;;
 		*) break ;;
 		esac
@@ -27,6 +32,12 @@ test_rev_parse () {
 		test $# -eq 0 && break
 		expect="$1"
 		test_expect_success "$name: $o" '
+			case "$bare" in
+			t*) test_config ${d:+-C} ${d:+"$d"} core.bare true ;;
+			f*) test_config ${d:+-C} ${d:+"$d"} core.bare false ;;
+			u*) test_unconfig ${d:+-C} ${d:+"$d"} core.bare ;;
+			esac &&
+
 			echo "$expect" >expect &&
 			git ${d:+-C} ${d:+"$d"} rev-parse $o >actual &&
 			test_cmp expect actual
@@ -49,35 +60,25 @@ test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
 
 test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
 
-git config core.bare true
-test_rev_parse 'core.bare = true' true false false
+test_rev_parse -b t 'core.bare = true' true false false
 
-git config --unset core.bare
-test_rev_parse 'core.bare undefined' false false true
+test_rev_parse -b u 'core.bare undefined' false false true
 
 GIT_DIR=../.git
-GIT_CONFIG="$(pwd)/work/../.git/config"
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
 
 GIT_DIR=../repo.git
-GIT_CONFIG="$(pwd)/work/../repo.git/config"
 
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
2.8.2.748.g927f425
