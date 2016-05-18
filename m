From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/5] t1500: avoid changing working directory outside of tests
Date: Wed, 18 May 2016 16:15:43 -0400
Message-ID: <20160518201545.9113-4-sunshine@sunshineco.com>
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
	id 1b37tD-0006yE-4W
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbcERUQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:16:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35064 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:13 -0400
Received: by mail-io0-f195.google.com with SMTP id i75so11526097ioa.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FO4v2slZvlGHdNKSd3ei6RgTErQi8fMDwsgm2V035mA=;
        b=Dz7dWLmU3mQtHdHa1rf9dC/6+P5jE6z445oNAxAexlufe06p6vT59rmMgZCsqmw04F
         WU+W4t+hGtENEHhu5kv5rRRgarYBji+ZECMu5wf0oc+OnoOD5MN9beMD6BFYjDLLILVV
         UWpqhoDHay4LrFbsWNSkXG9Ui3ddDq6mRRqiCILE9cA3Bg8uYUweRUiN2H45/SHlN3kJ
         /k3r4+l/MJrrsKvUXZwNrkimHDl6IsIyX4yelTg24e0+jFENzqbJGjnRL7gBYAYl+LIe
         qF20BrWx4AukfXGvL7/XMlSWfpVJPaWrXqQHGG4bRlUZ4IB390nC7BFq8rorXJypgf+f
         XJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FO4v2slZvlGHdNKSd3ei6RgTErQi8fMDwsgm2V035mA=;
        b=AXc6PvRYFxqSS0n7iT5VhMUy+LFbjcKY2oIrBhsRR0Q5tn8Q2i5i6/TqwJ6J8auxWn
         AOxgc/9CVnaWn28McTqtDnIC3Wjra9fPhCajz9AqcX2XKGAO2Ns7ZkC2lNdbst7g5c3G
         gVmIl2bplq3rQ88BOs24e/g2yXbp5Lus+/TvpC9GPEHZ6uc8hvmVYK5oZl4zpkdOor4S
         KwZ4oUU5B9huZpPlyhSwWfDkbymfJyX88tvYpt/LbEOi72SCaHa+3M1gDEuXqjFW58/b
         ribhWQLJmQy1mz2Xt5eFnASq72n592eUJJA0VS5rtRPx5RYPier3lcR0ozkMHJQ92Xx6
         uA/g==
X-Gm-Message-State: AOPr4FXbE/50Nf1HAJu9/kUGNdQd25tsjqGNy1FcRffa1f2JbjqC5v2AnIYpDgGwihtz8g==
X-Received: by 10.107.2.70 with SMTP id 67mr7164922ioc.70.1463602572429;
        Wed, 18 May 2016 13:16:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.748.g927f425
In-Reply-To: <20160518201545.9113-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295004>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-C <dir>" option to allow callers to
instruct it explicitly in which directory its tests should be run. Take
advantage of this new option to avoid changing the working directory
outside of tests.

Implementation note: test_rev_parse() passes "-C <dir>" along to
git-rev-parse with <dir> properly quoted. The natural and POSIX way to
do so is via ${dir:+-C "$dir"}, however, with some older broken shells,
this expression evaluates incorrectly to a single argument ("-C <dir>")
rather than the expected two (-C and "<dir>"). Work around this problem
with the slightly ungainly expression: ${dir:+-C} ${dir:+"$dir"}

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index ecc575b..d73a52b 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,8 +3,18 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-# usage: label is-bare is-inside-git is-inside-work prefix git-dir
+# usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
+	d=
+	while :
+	do
+		case "$1" in
+		-C) d="$2"; shift; shift ;;
+		-*) error "test_rev_parse: unrecognized option '$1'" ;;
+		*) break ;;
+		esac
+	done
+
 	name=$1
 	shift
 
@@ -18,7 +28,7 @@ test_rev_parse () {
 		expect="$1"
 		test_expect_success "$name: $o" '
 			echo "$expect" >expect &&
-			git rev-parse $o >actual &&
+			git ${d:+-C} ${d:+"$d"} rev-parse $o >actual &&
 			test_cmp expect actual
 		'
 		shift
@@ -34,15 +44,10 @@ test_expect_success 'setup' '
 
 test_rev_parse toplevel false false true '' .git
 
-cd .git || exit 1
-test_rev_parse .git/ false true false '' .
-cd objects || exit 1
-test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
-cd ../.. || exit 1
+test_rev_parse -C .git .git/ false true false '' .
+test_rev_parse -C .git/objects .git/objects/ false true false '' "$ROOT/.git"
 
-cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
-cd ../.. || exit 1
+test_rev_parse -C sub/dir subdirectory false false true sub/dir/ "$ROOT/.git"
 
 git config core.bare true
 test_rev_parse 'core.bare = true' true false false
@@ -50,30 +55,29 @@ test_rev_parse 'core.bare = true' true false false
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
 
-cd work || exit 1
 GIT_DIR=../.git
-GIT_CONFIG="$(pwd)"/../.git/config
+GIT_CONFIG="$(pwd)/work/../.git/config"
 export GIT_DIR GIT_CONFIG
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse -C work 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 GIT_DIR=../repo.git
-GIT_CONFIG="$(pwd)"/../repo.git/config
+GIT_CONFIG="$(pwd)/work/../repo.git/config"
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_rev_parse -C work 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
2.8.2.748.g927f425
