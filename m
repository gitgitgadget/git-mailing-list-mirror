From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 64bit issue in test-parse-options.c
Date: Wed, 30 Jul 2008 12:11:35 -0700
Message-ID: <7vej5b5grc.fsf@gitster.siamese.dyndns.org>
References: <20080730141656.41ce02ec@pc09.procura.nl>
 <20080730123713.GA31392@artemis.madism.org>
 <20080730144452.797d8686@pc09.procura.nl>
 <20080730140523.GC31392@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOH6N-00012v-2g
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbYG3TLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbYG3TLq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:11:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYG3TLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:11:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BADA4063F;
	Wed, 30 Jul 2008 15:11:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 165F54063E; Wed, 30 Jul 2008 15:11:37 -0400 (EDT)
In-Reply-To: <20080730140523.GC31392@artemis.madism.org> (Pierre Habouzit's
 message of "Wed, 30 Jul 2008 16:05:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57F28B4A-5E6B-11DD-9F9A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90836>

Pierre Habouzit <madcoder@debian.org> writes:

> The proper fix is to let integer be an *INT* (long integer is bogus
> anyways) and to put the date in a long using static unsigned long date,
> and make OPT_DATE use this long.

I am still puzzled by the original report of the breakage, as H. Merijn
cannot be the first person to ever ran test-parse-options on 64-bit
machine.  Maybe there is a bytesex issue involved as well?

In any case, this should work.

 test-parse-options.c     |    8 +++++---
 t/t0040-parse-options.sh |   11 ++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 2a79e72..6e18083 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -2,7 +2,8 @@
 #include "parse-options.h"
 
 static int boolean = 0;
-static unsigned long integer = 0;
+static int integer = 0;
+static unsigned long timestamp;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
@@ -32,7 +33,7 @@ int main(int argc, const char **argv)
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
-		OPT_DATE('t', NULL, &integer, "get timestamp of <time>"),
+		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_GROUP("String options"),
@@ -56,7 +57,8 @@ int main(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
-	printf("integer: %lu\n", integer);
+	printf("integer: %u\n", integer);
+	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
 	printf("verbose: %d\n", verbose);


diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 03dbe00..e38241c 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -47,6 +47,7 @@ test_expect_success 'test help' '
 cat > expect << EOF
 boolean: 2
 integer: 1729
+timestamp: 0
 string: 123
 abbrev: 7
 verbose: 2
@@ -63,6 +64,7 @@ test_expect_success 'short options' '
 cat > expect << EOF
 boolean: 2
 integer: 1729
+timestamp: 0
 string: 321
 abbrev: 10
 verbose: 2
@@ -88,6 +90,7 @@ test_expect_success 'missing required value' '
 cat > expect << EOF
 boolean: 1
 integer: 13
+timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
@@ -108,6 +111,7 @@ test_expect_success 'intermingled arguments' '
 cat > expect << EOF
 boolean: 0
 integer: 2
+timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
@@ -135,6 +139,7 @@ test_expect_success 'ambiguously abbreviated option' '
 cat > expect << EOF
 boolean: 0
 integer: 0
+timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
@@ -161,6 +166,7 @@ test_expect_success 'detect possible typos' '
 cat > expect <<EOF
 boolean: 0
 integer: 0
+timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
@@ -177,7 +183,8 @@ test_expect_success 'keep some options as arguments' '
 
 cat > expect <<EOF
 boolean: 0
-integer: 1
+integer: 0
+timestamp: 1
 string: default
 abbrev: 7
 verbose: 0
@@ -197,6 +204,7 @@ cat > expect <<EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
+timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
@@ -223,6 +231,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 cat > expect <<EOF
 boolean: 1
 integer: 23
+timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
