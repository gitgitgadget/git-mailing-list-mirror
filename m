From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] t1500: avoid setting environment variables outside of tests
Date: Tue, 17 May 2016 15:36:30 -0400
Message-ID: <20160517193630.10379-6-sunshine@sunshineco.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ko0-0008Ue-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcEQThV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:21 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33395 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcEQThS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:18 -0400
Received: by mail-ig0-f194.google.com with SMTP id rc4so2725312igc.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsKuOGrX82TCn2ZlE7aNUwonYIRsDjDjay8lLqywHm4=;
        b=XVNerI7RZCCKUVInaELWc4OKwE8P/Kfx1wRlqkkjSWa7TIAd7Cbt1E2/kFL+oVWYF2
         J+JJ5XVv5mrEI9E2B+GiFusVaiiaRay+UGnTBt4X+7PQQ5WWCG+eCTDnvwAg2xoCzUxv
         5W7c7ElKfz9Vswd5x+wNUaAfJgBBxQY+3Wn9lm6rV26IPDCOe6meRANR9ZqfSzOCRwyq
         UobNBrZ7gznoeV4urG6p6/3OppocHf4+xXemJ05jFtiD1ZrmxpLBHebxAtRmhdfk1ReH
         g1mNDlD5HLSWs1QD9vNRMUwsx+f7+RSKCOjDyIyj3mlH7reG+6/oHxbRjIZiWwWi3mpV
         pPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FsKuOGrX82TCn2ZlE7aNUwonYIRsDjDjay8lLqywHm4=;
        b=H09XzxBTg0UaTVgKWM39pBcirW+QTASEIzlx2f2bAL3/Ede0SIh2v3ym7xGUPnllnt
         P+iijcFFA62JF2yaKa11n0uiefKHmIjGyamslObj71GNsD6f9eyFsdSyAUK1+qfE09rV
         JpcFhFi/Zqc6EFDtIatLOGCrfTb0/haU55pIkTocdSmp1qO8Wd5yhH1EMzDaX8FhvE0p
         sDxLGUfZF/mw1RXwXE6/MRujUGH0DsA03QinUgtvVLlDJg89U11FbgKeqep2SppOMohJ
         QyQ9QG54QvCwH8DccASo3ljin0XY0yQ75N5m+wX7EsAoWZ78420i22SwQgPqcRynMV95
         awsg==
X-Gm-Message-State: AOPr4FWxo//uaen0iHZ/eKXCB0I81Q2hJnTrjitOQtGdpE0sjHNGbn9PTmIn5JXENK+NiA==
X-Received: by 10.50.73.169 with SMTP id m9mr15463916igv.11.1463513837502;
        Tue, 17 May 2016 12:37:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
In-Reply-To: <20160517193630.10379-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294900>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-g <dir>" option to allow callers to
specify the value of the GIT_DIR environment variable explicitly. Take
advantage of this new option to avoid polluting the global scope with
GIT_DIR assignments.

Implementation note: Typically, tests avoid polluting the global state
by wrapping transient environment variable assignments within a
subshell, however, this technique doesn't work here since test_config()
and test_unconfig() need to know GIT_DIR, as well, but neither function
can be used within a subshell. Consequently, GIT_DIR is instead cleared
manually via test_when_finished().

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 5be463f..39af565 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -7,6 +7,7 @@ test_description='test git rev-parse'
 test_rev_parse () {
 	dir=
 	bare=
+	gitdir=
 	while :
 	do
 		case "$1" in
@@ -15,6 +16,7 @@ test_rev_parse () {
 		    [tfu]*) bare="$2"; shift; shift ;;
 		    *) error "test_rev_parse: bogus core.bare value '$2'" ;;
 		    esac ;;
+		-g) gitdir="$2"; shift; shift ;;
 		-*) error "test_rev_parse: unrecognized option '$1'" ;;
 		*) break ;;
 		esac
@@ -32,6 +34,13 @@ test_rev_parse () {
 		test $# -eq 0 && break
 		expect="$1"
 		test_expect_success "$name: $o" '
+			if test -n "$gitdir"
+			then
+				test_when_finished "unset GIT_DIR" &&
+				GIT_DIR="$gitdir" &&
+				export GIT_DIR
+			fi &&
+
 			case "$bare" in
 			t*) test_config ${dir:+-C "$dir"} core.bare true ;;
 			f*) test_config ${dir:+-C "$dir"} core.bare false ;;
@@ -64,21 +73,18 @@ test_rev_parse -b t 'core.bare = true' true false false
 
 test_rev_parse -b u 'core.bare undefined' false false true
 
-GIT_DIR=../.git
-export GIT_DIR
 
-test_rev_parse -C work -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../.git -b f 'GIT_DIR=../.git, core.bare = false' false false true ''
 
-test_rev_parse -C work -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
+test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true false false ''
 
-test_rev_parse -C work -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-GIT_DIR=../repo.git
 
-test_rev_parse -C work -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
+test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
-test_rev_parse -C work -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
+test_rev_parse -C work -g ../repo.git -b t 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
-test_rev_parse -C work -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
+test_rev_parse -C work -g ../repo.git -b u 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
-- 
2.8.2.703.g78b384c
