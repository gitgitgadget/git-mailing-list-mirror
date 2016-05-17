From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 15:36:28 -0400
Message-ID: <20160517193630.10379-4-sunshine@sunshineco.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2koD-00008r-9y
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcEQThd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33047 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcEQThQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:16 -0400
Received: by mail-io0-f193.google.com with SMTP id x35so5523103ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhfRppOoYfAGf9i7xldMRIoNwNOzsWhMI1TGyLCfQHk=;
        b=jI7Y8E4EficaqoT995iSb3Y2G5nVOUO8exdW4LhhewdJn+zsmXw7SLRvZtTbPIcHzn
         BJ2DZ6RiNg65A0B7iIJQjbcFzioZkj5b9O6W6sfEW9SX/GnWmk0SDWGOOey3cUeWDQdl
         2Ql3AUktq1CPsAFVkHu3XVoob7zUOLK7Alyr09PU5GxLmyWyDkIIxPWEWJrxBr6TuIkv
         hnfQ0V/IidffxR4pYDDiHOdl75NxVTTr2I3g/6ey6SOXubJJ/dJWlPGPXjHh/uph8v9R
         i7Az2J9QtPGg+RgAXkqRliT1wxgpa6+otUtYFgRO40eX0Gqax/vNHprtmqiT+ZAUZ/qb
         WVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dhfRppOoYfAGf9i7xldMRIoNwNOzsWhMI1TGyLCfQHk=;
        b=Z9vPHdLGgMRt2FnzF0dbNaUvvDdsg/5XV7geU6NGdIL6T4RtxpfB/qmOhLNVi7R8oE
         cMNwOTWM39h8f+fKTqhc7X+hiCj04ubPNU2uGAM/8rCz5oGjqwpdzi70E6DfifBPQ5Zz
         i4cEd9R0BwyYjvHpe/CDwxemMpTZ3ChldfKwvSJDAKrtA+lJmz3DIFtkLNmXixO5cS91
         NisPRFtJDRYm9eSbZVNVciEo4mmn4kaIP6UGz1WsD705OusY9ly2HITpL7kRuiS+UIVr
         0jIREXk0QtiQx68whR7jMTXuQUkag7UYO34SQWdsmXbpxWihL0UEfySdA1fRje5pJHNy
         +csw==
X-Gm-Message-State: AOPr4FWGA/72zMorOWTVjSWfHnLU1QY5qZu2HlWG8wSlmalrZ5Tl47xJNcGyotgYlT9KTA==
X-Received: by 10.36.61.137 with SMTP id n131mr2431467itn.74.1463513835614;
        Tue, 17 May 2016 12:37:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
In-Reply-To: <20160517193630.10379-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294904>

Ideally, each test should be responsible for setting up state it needs
rather than relying upon transient global state. Toward this end, teach
test_rev_parse() to accept a "-C <dir>" option to allow callers to
instruct it explicitly in which directory its tests should be run. Take
advantage of this new option to avoid changing the working directory
outside of tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index c84f5c3..fb2cee8 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,8 +3,18 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-# usage: label is-bare is-inside-git is-inside-work prefix git-dir
+# usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir
 test_rev_parse () {
+	dir=
+	while :
+	do
+		case "$1" in
+		-C) dir="$2"; shift; shift ;;
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
-			git rev-parse --$o >actual &&
+			git ${dir:+-C "$dir"} rev-parse --$o >actual &&
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
2.8.2.703.g78b384c
