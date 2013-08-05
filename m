From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t8001, t8002: fix "blame -L :literal" test on NetBSD
Date: Mon, 05 Aug 2013 17:21:17 +0200
Message-ID: <51FFC2ED.3080906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6MbI-0006fy-1h
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab3HEPVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:21:32 -0400
Received: from mout.web.de ([212.227.17.12]:63898 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab3HEPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:21:31 -0400
Received: from [192.168.2.102] ([79.253.164.97]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LlneG-1UX1mS0pe4-00ZQQU for <git@vger.kernel.org>;
 Mon, 05 Aug 2013 17:21:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-Provags-ID: V03:K0:CcrZVxOt9Sk47mqJ10lVeHOZJgT4rCfSSYFX0LzFXfloltpZIiu
 VI/u1C4AkT/wcRHOTWW0VsFOyu4g4UFdvZJvUFcawzRZMSchx09/feH7s9V9kZHjZ0vI+S+
 LoE/yRxXJJ4qicc8a603cgegiwBX0EEIY9VNWYDYM+bZwWSXkaI1Bip5IKuivzZikXcgF45
 kHcN4egvrOjEV58D0zUDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231654>

Sub-test 42 of t8001 and t8002 ("blame -L :literal") fails on NetBSD
with the following verbose output:

	git annotate  -L:main hello.c
	Author F (expected 4, attributed 3) bad
	Author G (expected 1, attributed 1) good

This is not caused by different behaviour of git blame or annotate on
that platform, but by different test input, in turn caused by a sed
command that forgets to add a newline on NetBSD.  Here's the diff of the
commit that adds "goodbye" to hello.c, for Linux:

	@@ -1,4 +1,5 @@
	 int main(int argc, const char *argv[])
	 {
		puts("hello");
	+		puts("goodbye");
	 }

We see that it adds an extra TAB, but that's not a problem.  Here's the
same on NetBSD:

	@@ -1,4 +1,4 @@
	 int main(int argc, const char *argv[])
	 {
		puts("hello");
	-}
	+		puts("goodbye");}

It also adds an extra TAB, but it is missing the newline character
after the semicolon.

The following patch gets rid of the extra TAB at the beginning, but
more importantly adds the missing newline at the end in a (hopefully)
portable way, mentioned in http://sed.sourceforge.net/sedfaq4.html.
The diff becomes this, on both Linux and NetBSD:

	@@ -1,4 +1,5 @@
	 int main(int argc, const char *argv[])
	 {
		puts("hello");
	+	puts("goodbye");
	 }

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This regression was introduced by 5a9830cb ("t8001/t8002 (blame):
add blame -L :funcname tests").

 t/annotate-tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 0bfee00..d4e7f47 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -245,8 +245,8 @@ test_expect_success 'setup -L :regex' '
 	git commit -m "hello" &&
 
 	mv hello.c hello.orig &&
-	sed -e "/}/i\\
-	Qputs(\"goodbye\");" <hello.orig | tr Q "\\t" >hello.c &&
+	sed -e "/}/ {x; s/$/Qputs(\"goodbye\");/; G;}" <hello.orig |
+	tr Q "\\t" >hello.c &&
 	GIT_AUTHOR_NAME="G" GIT_AUTHOR_EMAIL="G@test.git" \
 	git commit -a -m "goodbye" &&
 
-- 
1.8.1.5
