From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/6] t8001/t8002 (blame): add blame -L tests
Date: Wed, 17 Jul 2013 17:25:29 -0400
Message-ID: <1374096332-7891-4-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEq-0003tI-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757421Ab3GQV0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:12 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39729 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab3GQV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:09 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so2870439obc.6
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kg8vfX3QKea7tGW6GgMG49kkVA63sdB1vpyGFL5Pn5I=;
        b=v8d8LxArMWc2HAFwLOuVbidCk0Zif58icRS60ZmDkBkag17wPWYoQ+cCNe14cU/A58
         zFvp9kMC178eJNvVxuhed6nPh6Dar+cTeeuWP/1b5tSdwja5s31h3NbVKVVa2axz09nO
         3TV5tL+3TEVME5gX+pgyVmYmzbJnPWdTRPUdocNBmIyo0VjZ70t4p101xW+24Xi4I3/E
         vKq+/EBCJr7b8QzdMoJpLFLtAdihky89l+k+wi/x97+bhk4lfTCDPuxXDpssaucZlW8E
         K4GzsJxGZW1y5q4jHgkf8u+IsgAJj0Qb1G3XT0ANJvbcAW1f6Om9JeyRzbqz8DWVjGBx
         iyIA==
X-Received: by 10.182.46.230 with SMTP id y6mr4645086obm.79.1374096369378;
        Wed, 17 Jul 2013 14:26:09 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230654>

With the exception of a couple "corner case" checks in t8003 (and some
indirect tests in t4211 of -L parsing code shared by log -L), there is
no systematic checking of blame -L.  Add tests to check blame -L
directly.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 3aa6964..b6a7478 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -3,9 +3,17 @@
 
 check_count () {
 	head= &&
-	case "$1" in -h) head="$2"; shift; shift ;; esac &&
-	echo "$PROG file $head" >&4 &&
-	$PROG file $head >actual &&
+	options= &&
+	while :
+	do
+		case "$1" in
+		-h) head="$2"; shift; shift ;;
+		-*) options="$options $1"; shift ;;
+		*) break ;;
+		esac
+	done &&
+	echo "$PROG $options file $head" >&4 &&
+	$PROG $options file $head >actual &&
 	perl -e '
 		my %expect = (@ARGV);
 		my %count = map { $_ => 0 } keys %expect;
@@ -142,3 +150,93 @@ test_expect_success 'setup obfuscated email' '
 test_expect_success 'blame obfuscated email' '
 	check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
 '
+
+test_expect_success 'blame -L 1 (all)' '
+	check_count -L1 A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
+'
+
+test_expect_success 'blame -L , (all)' '
+	check_count -L, A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
+'
+
+test_expect_success 'blame -L X (X to end)' '
+	check_count -L5 B1 1 C 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L X, (X to end)' '
+	check_count -L5, B1 1 C 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L ,Y (up to Y)' '
+	check_count -L,3 A 1 B2 1 E 1
+'
+
+test_expect_success 'blame -L X,X' '
+	check_count -L3,3 B2 1
+'
+
+test_expect_success 'blame -L X,Y' '
+	check_count -L3,6 B 1 B1 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L Y,X (undocumented)' '
+	check_count -L6,3 B 1 B1 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L X,+1' '
+	check_count -L3,+1 B2 1
+'
+
+test_expect_success 'blame -L X,+N' '
+	check_count -L3,+4 B 1 B1 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L X,-1' '
+	check_count -L3,-1 B2 1
+'
+
+test_expect_success 'blame -L X,-N' '
+	check_count -L6,-4 B 1 B1 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L /RE/ (RE to end)' '
+	check_count -L/evil/ C 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/,/RE2/' '
+	check_count -L/robot/,/green/ A 1 B 1 B2 1 D 1 E 1
+'
+
+test_expect_success 'blame -L X,/RE/' '
+	check_count -L5,/evil/ B1 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/,Y' '
+	check_count -L/99/,7 B1 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/,+N' '
+	check_count -L/99/,+3 B1 1 D 1 "A U Thor" 1
+'
+
+test_expect_success 'blame -L /RE/,-N' '
+	check_count -L/99/,-3 B 1 B2 1 D 1
+'
+
+test_expect_success 'blame -L X (X > nlines)' '
+	test_must_fail $PROG -L12345 file
+'
+
+test_expect_success 'blame -L ,Y (Y > nlines)' '
+	test_must_fail $PROG -L,12345 file
+'
+
+test_expect_success 'blame -L bogus' '
+	test_must_fail $PROG -L file &&
+	test_must_fail $PROG -L1,+ file &&
+	test_must_fail $PROG -L1,- file &&
+	test_must_fail $PROG -LX file &&
+	test_must_fail $PROG -L1,X file &&
+	test_must_fail $PROG -L1,+N file &&
+	test_must_fail $PROG -L1,-N file
+'
-- 
1.8.3.3.1016.g4f0baba
