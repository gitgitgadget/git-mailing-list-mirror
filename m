From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/5] t1500: avoid setting environment variables outside of tests
Date: Wed, 18 May 2016 16:15:45 -0400
Message-ID: <20160518201545.9113-6-sunshine@sunshineco.com>
References: <20160518201545.9113-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 22:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37tL-00073n-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbcERUQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:16:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34074 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbcERUQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:18 -0400
Received: by mail-io0-f194.google.com with SMTP id d62so11535403iof.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OorB6xaG4SOWiaR1lReGL5r+eCDS4JmkcF/rXHlp2+4=;
        b=guuQo+nlLTkTRdxHNijJ1lT4jlp1+VISnaIndpJ/obVLABTalyv8ZOUYRDd1Y6Y6UN
         bEcsAoy3hC6iAZ4kFqH1grUr7j0U6Igy/ozyvUJG5tzgf5uPOPIWJVz4tei6WaM0FDtW
         BFywk0lcvICzlqK/npdp35adUJYYQ0FscCwr3yzAnt8BdP7QxmM3k04AkfGvCbSC25XS
         eFWHUzOj8edtIDz1r4CmdDQuU5M/SWSAcqgyBsWJVmfxJ7coZ7WsqywaY7I0X8mLZl5c
         WvSctg7XTGaUiveJSVgKYQtSPaStkUiTYso/KEOqEaD5DUVIq8WJOBRPygqdpVrjwHsS
         9g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OorB6xaG4SOWiaR1lReGL5r+eCDS4JmkcF/rXHlp2+4=;
        b=W0pKq+g8fdWkCMHSH9z8F+DjRga7LtNMWzseDR3eajejRui8QEQLevMyK9diWicWox
         FcHeL7Uc7qAxm+yQGvMktIhAoSHkxMGI1qe9oVmfNmKHene8tBVAlFLvtoJ0B4ylSZwZ
         ztBN1kJnuH6gUyPOb1MqD4W702rEoOabaWGiH27douX+lRU1nwSYa5jeMWeYV9aY1ej+
         4CsxO6+u9YzzI3poOvFaZRhTaG0YDpHeHzzwStGoX9EBttXoj1yLBTDgXVrTRf66Dkix
         84Bb9prroO4s00Ut04Zcvbi84ol65HTP1E6HEN2P+nMzEejxbaYdbg6D3DNEqzkUI9Uk
         3CYg==
X-Gm-Message-State: AOPr4FXAHKjCr7VzDLXj3pl85QCOfFi0wgG6hlOJaRgkzvQoM42/7T4d60WwqBnhe3BhmQ==
X-Received: by 10.107.11.213 with SMTP id 82mr236723iol.55.1463602577335;
        Wed, 18 May 2016 13:16:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.748.g927f425
In-Reply-To: <20160518201545.9113-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295002>

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
index 325d821..038e24c 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -7,6 +7,7 @@ test_description='test git rev-parse'
 test_rev_parse () {
 	d=
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
 			t*) test_config ${d:+-C} ${d:+"$d"} core.bare true ;;
 			f*) test_config ${d:+-C} ${d:+"$d"} core.bare false ;;
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
2.8.2.748.g927f425
