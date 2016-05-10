From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 01:20:54 -0400
Message-ID: <20160510052055.32924-6-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0077-0003ga-MN
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbcEJFVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34277 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbcEJFVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:36 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so414037iof.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3dg7EBHj8SwiKo6tsw4/YviZ/YzD7M+t6Hm8iJFeKSE=;
        b=nbtAkStZKWazyCZQwORSlqZPjWUMlTYkTRd8iSaHQayYxG8k38tqOxs5fcKVaW/vVB
         nLkLmWiVCyQxc8NEe4FrfrlY3MBwOnc/wmhIgD6aMG6Ln9gvGhUm0DsGItdiwA+/NwuZ
         u3+jIw5qMv/wpY7D8c6HClvBHOQYOUN+qH2yvpmx6xbzCGl9LdU5ni49oAjXumqwkW56
         DRy9D4qVzWyO+6s3ki39gs1Dxo2nbE0EhLM8zHZs/L/4RJvHHZWfCZ/EcY3NYilgzdc5
         G8GZUzfLfYvb6gK8exwqARG6DudJnF1uwLtCNKHXgYvCCbufP2yo9J3uXMclxaIg3qre
         Je8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3dg7EBHj8SwiKo6tsw4/YviZ/YzD7M+t6Hm8iJFeKSE=;
        b=cYvt1UV9zw563eutNnZzBSBqpOYvuu/LrLx5vo1Q45SnxqXxW+ugu3cwqldUnZr+xu
         86qjvtu3IGhQlFPHb8xcKXZwbeiIozSUiiwJy/3cScKNVpyxQINXArF65IdprbbfhUkd
         J9Gq4g1Agm/G40PnFybkZzUr3Zm12g5ZV7QCxADqyva8QOHtHMYLFA+PpRZeWSZQhSqi
         REb5YhtmkTsRFPymMO2RDrpgOSrhRnV7cUsDM1EsQTcrttKQqmdjvx4oxQibKXZyI13Y
         suGCjKRZxG8ZRZT8Yzcq9USDBHzC9Fv75G6fw4WQ9gb/a/9O36glCqpU0vYAgb0xB0Jb
         L7iA==
X-Gm-Message-State: AOPr4FUkf9+iaNtjw1U2f7/fTfWgekU3or+p7QvR5lX0KcwpeKJReiVn9G2G4pIEatzEtA==
X-Received: by 10.107.162.84 with SMTP id l81mr44454943ioe.47.1462857695243;
        Mon, 09 May 2016 22:21:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294089>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-g <dir>" option to allow callers to
specify the value of the GIT_DIR environment variable explicitly, and
take advantage of this new option to avoid polluting the global scope
with GIT_DIR assignments.

Regarding the implementation: Typically, tests avoid polluting the
global state by wrapping transient environment variable assignments
within a subshell, however, this technique can not be used here since
test_config() and test_unconfig() need to know GIT_DIR, as well, but
neither function can be used within a subshell. Consequently, GIT_DIR is
cleared manually via sane_unset().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index c058aa4..525e6d3 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -7,11 +7,13 @@ test_description='test git rev-parse'
 test_rev_parse () {
 	dir=
 	bare=
+	env=
 	while :
 	do
 		case "$1" in
 		-C) dir="-C $2"; shift; shift ;;
 		-b) bare="$2"; shift; shift ;;
+		-g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
 		-*) error "test_rev_parse: unrecognized option '$1'" ;;
 		*) break ;;
 		esac
@@ -36,6 +38,8 @@ test_rev_parse () {
 	do
 		expect="$1"
 		test_expect_success "$name: $o" '
+			test_when_finished "sane_unset GIT_DIR" &&
+			eval $env &&
 			$bare &&
 			echo "$expect" >expect &&
 			git $dir rev-parse --$o >actual &&
@@ -61,22 +65,19 @@ test_rev_parse -b t 'core.bare = true' true false false
 test_rev_parse -b u 'core.bare undefined' false false true
 
 test_expect_success 'setup non-local database ../.git' 'mkdir work'
-GIT_DIR=../.git
-export GIT_DIR
 
-test_rev_parse -C work -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../.git -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
 
-test_rev_parse -C work -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
 
-test_rev_parse -C work -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 test_expect_success 'setup non-local database ../repo.git' 'mv .git repo.git'
-GIT_DIR=../repo.git
 
-test_rev_parse -C work -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
-test_rev_parse -C work -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
-test_rev_parse -C work -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
2.8.2.530.g51d527d
