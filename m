From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH v2] git-rebase: Teach rebase "-" shorthand.
Date: Wed, 19 Mar 2014 20:02:15 +0900
Message-ID: <1395226935-53044-1-git-send-email-modocache@gmail.com>
References: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Brian Gesiak <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 12:02:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEGY-0000u1-FM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933627AbaCSLCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:02:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47069 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933367AbaCSLC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:02:29 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so8804529pab.39
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=600x+i+bohPxSX5VqCDd3Baq9hJ9YFlYtg17tIYFyZA=;
        b=tdOZaElgx1xKyw6w3uQ1Gr+CoTLkXJbqOcWykjzG7eamE6ltXnS8D6Ic2LB9ibZ5qP
         q5EMWHWFx2pOt9JLH/7CmFtehZz18Hd+QViRY+AYLp2KDP+6+rNmx8jX9KbsIv9DQLoq
         8JZzQS7qJcwlZDwDwK0qxYezaohF12dsLZGHP1u8ynah60IhjdFknaR0cd7oWN/x1V83
         x7RxJ66QEDjWo+kUd0ooUPBxzvDB1PTop6/PVRlfW9CqgaSoudhj2+TvZOI5kd4/OYOR
         YtJcyXzcz2LcANTXC0E23IXpgLX90CPgXdYJmOJQpdSmhJStb0YfuXLgNihR9hUOPmII
         siiQ==
X-Received: by 10.66.41.106 with SMTP id e10mr39262960pal.109.1395226949052;
        Wed, 19 Mar 2014 04:02:29 -0700 (PDT)
Received: from localhost.localdomain (p841739.tokynt01.ap.so-net.ne.jp. [223.132.23.57])
        by mx.google.com with ESMTPSA id iq10sm61217404pbc.14.2014.03.19.04.02.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 04:02:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <xmqq61nb8fap.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244431>

Teach rebase the same shorthand as checkout and merge; that is, that "-"
means "the branch we were previously on".

Reported-by: Tim Chase <git@tim.thechases.com>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 git-rebase.sh     |  4 ++++
 t/t3400-rebase.sh | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..2c75e9f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -453,6 +453,10 @@ then
 		test "$fork_point" = auto && fork_point=t
 		;;
 	*)	upstream_name="$1"
+		if test "$upstream_name" = "-"
+		then
+			upstream_name="@{-1}"
+		fi
 		shift
 		;;
 	esac
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6d94b1f..6176754 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,17 @@ test_expect_success 'rebase from ambiguous branch name' '
 	git rebase master
 '
 
+test_expect_success 'rebase using shorthand' '
+	git checkout master &&
+	git checkout -b shorthand HEAD^ &&
+	git rebase - 1>shorthand.stdout &&
+	git checkout master &&
+	git branch -D shorthand &&
+	git checkout -b shorthand HEAD^ &&
+	git rebase @{-1} 1>without_shorthand.stdout &&
+	test_i18ncmp without_shorthand.stdout shorthand.stdout
+'
+
 test_expect_success 'rebase a single mode change' '
 	git checkout master &&
 	git branch -D topic &&
-- 
1.8.5.2 (Apple Git-48)
