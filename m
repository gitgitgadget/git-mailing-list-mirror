From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/6] t8001/t8002 (blame): add blame -L :funcname tests
Date: Wed, 17 Jul 2013 17:25:30 -0400
Message-ID: <1374096332-7891-5-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEv-0003yB-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab3GQV0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:20 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:54589 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3GQV0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:11 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so3272899oah.10
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LktoQDQXy4JxP85Knf2xCOrXF5HOJCiILlrqLAhHpUA=;
        b=wy82m2H0sc4bnsyYkXMIuSI5Icnjg9llBiip9Mw76znHY65OdIzKGejE8KvYIr4vTz
         cai8Qtop9ku0ixpDkfiLlSR9+75CGaCOvxgng+Oi7PNHkAskAEpf1f+hG9dWa24e2Bm+
         2AH9RifxaWufa945GgmLvwhUt6TVOTRkdMon19VPCeGy793EEoUNvmfRZS/RlxsbAJ/K
         gUTA3jgJIY/lmxh8XDEkOYUBSjoc4dU9rYKkbL7bRBssSLPfN+g6PXdvb4pfvEeta2er
         dTHgR5Hiw3OzvU9bczqRaO6fBgy6UfY0HUD8IIDuDemlqWfPWMGZj8Ma9NEQjXyXOk+v
         GX/w==
X-Received: by 10.182.176.67 with SMTP id cg3mr4486713obc.65.1374096371324;
        Wed, 17 Jul 2013 14:26:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230655>

git-blame inherited "-L :funcname" support when "-L :funcname:file" was
implemented for git-log. Add tests.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index b6a7478..0bfee00 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -3,17 +3,19 @@
 
 check_count () {
 	head= &&
+	file='file' &&
 	options= &&
 	while :
 	do
 		case "$1" in
 		-h) head="$2"; shift; shift ;;
+		-f) file="$2"; shift; shift ;;
 		-*) options="$options $1"; shift ;;
 		*) break ;;
 		esac
 	done &&
-	echo "$PROG $options file $head" >&4 &&
-	$PROG $options file $head >actual &&
+	echo "$PROG $options $file $head" >&4 &&
+	$PROG $options $file $head >actual &&
 	perl -e '
 		my %expect = (@ARGV);
 		my %count = map { $_ => 0 } keys %expect;
@@ -231,6 +233,48 @@ test_expect_success 'blame -L ,Y (Y > nlines)' '
 	test_must_fail $PROG -L,12345 file
 '
 
+test_expect_success 'setup -L :regex' '
+	tr Q "\\t" >hello.c <<-\EOF &&
+	int main(int argc, const char *argv[])
+	{
+	Qputs("hello");
+	}
+	EOF
+	git add hello.c &&
+	GIT_AUTHOR_NAME="F" GIT_AUTHOR_EMAIL="F@test.git" \
+	git commit -m "hello" &&
+
+	mv hello.c hello.orig &&
+	sed -e "/}/i\\
+	Qputs(\"goodbye\");" <hello.orig | tr Q "\\t" >hello.c &&
+	GIT_AUTHOR_NAME="G" GIT_AUTHOR_EMAIL="G@test.git" \
+	git commit -a -m "goodbye" &&
+
+	mv hello.c hello.orig &&
+	echo "#include <stdio.h>" >hello.c &&
+	cat hello.orig >>hello.c &&
+	tr Q "\\t" >>hello.c <<-\EOF
+	void mail()
+	{
+	Qputs("mail");
+	}
+	EOF
+	GIT_AUTHOR_NAME="H" GIT_AUTHOR_EMAIL="H@test.git" \
+	git commit -a -m "mail"
+'
+
+test_expect_success 'blame -L :literal' '
+	check_count -f hello.c -L:main F 4 G 1
+'
+
+test_expect_success 'blame -L :regex' '
+	check_count -f hello.c "-L:m[a-z][a-z]l" H 4
+'
+
+test_expect_success 'blame -L :nomatch' '
+	test_must_fail $PROG -L:nomatch hello.c
+'
+
 test_expect_success 'blame -L bogus' '
 	test_must_fail $PROG -L file &&
 	test_must_fail $PROG -L1,+ file &&
-- 
1.8.3.3.1016.g4f0baba
