From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] t1500: avoid setting configuration options outside of tests
Date: Tue, 17 May 2016 15:36:29 -0400
Message-ID: <20160517193630.10379-5-sunshine@sunshineco.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2koC-00008r-O6
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbcEQTh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33057 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcEQThR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:17 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so5523143ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sUBhLaPG7678f2CVIA3rvqqOxcvbvStnHLMyJsqzc4o=;
        b=HOutKLjUWrcD9OgaQOH1qp+GzqmCb70TPBu2iMBoPp3AFncUaQtTshhMqk8lajbDm9
         PkG80pMmShthyk5Hg5zv++Vtv67LYB1P0hF8xx3H28lMUl57+A5QoQipsQsxvP8p5RaG
         kmkbeg34QPORxaTHY12HhkYK5hh1tUlbcwceiYWPJLmNqLfpAox1NyiR7ZfB46vVQMYV
         ER3O4W9aTljDyN0Lpk3hHl1ZIUKCoHu3HDtxu2MofKAZyuYPrq3G/cM6MiHVxkBbr8WC
         jcS1I9AcyGzwij9KiAyXv+YgcSYJa/o1q0xe69XOpDumHmAErub9+oFTbVf8fiTPExjQ
         9uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=sUBhLaPG7678f2CVIA3rvqqOxcvbvStnHLMyJsqzc4o=;
        b=TSqvh93iU2icJjPn5OrbFbkHMkgf57ZnHEx7A889WWAdKRzEIXbEQOT+9TR6Swz9IN
         ujwoMwp+t8vDDvY92LdM6fxPkGnqcobAuGMQzLajoozdLhsd4H/wdIDpvJbdYnNuWavo
         P6UfsGl0HoIvb44HX1NjBxGfdcYbyRNkkqTMoHjo3Ow19ReqU7mrh4OfswFkf3/STy5j
         XPkhV/30VF+wEexYiqo0IBkggTf5D8a0Z1YDaOsF5LRS7s2eqk6JFAH83aCfeIJc2TUt
         nEFUtiCv+/gazTWyIKZpNecM2PuaHgaFKO6HTk9PL2ddk7R68YV73XvKfkZaZP9nPUOf
         khOg==
X-Gm-Message-State: AOPr4FXYphRjrj2f9aQRb0HQCUmidhcLZwwQX8sFvkd7z349rMrgdPCJ1gFHmSpCGrC7Vg==
X-Received: by 10.36.101.16 with SMTP id u16mr2652198itb.36.1463513836541;
        Tue, 17 May 2016 12:37:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
In-Reply-To: <20160517193630.10379-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294903>

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
index fb2cee8..5be463f 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -6,10 +6,15 @@ test_description='test git rev-parse'
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
 	dir=
+	bare=
 	while :
 	do
 		case "$1" in
 		-C) dir="$2"; shift; shift ;;
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
+			t*) test_config ${dir:+-C "$dir"} core.bare true ;;
+			f*) test_config ${dir:+-C "$dir"} core.bare false ;;
+			u*) test_unconfig ${dir:+-C "$dir"} core.bare ;;
+			esac &&
+
 			echo "$expect" >expect &&
 			git ${dir:+-C "$dir"} rev-parse --$o >actual &&
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
2.8.2.703.g78b384c
