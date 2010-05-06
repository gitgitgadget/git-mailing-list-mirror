From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] test-lib: some shells do not let $? propagate into an eval
Date: Thu, 6 May 2010 03:41:10 -0500
Message-ID: <20100506084045.GA25917@progeny.tock>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
 <20100506065419.GA21009@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 06 10:40:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9wdS-0000w7-0C
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab0EFIkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 04:40:40 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:49339 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0EFIkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:40:39 -0400
Received: by ywh36 with SMTP id 36so2680024ywh.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rtusZlnL1Q2BV0Yh3uOCg1y+KVqvWJJIz2Z2m6swnaI=;
        b=XfWoHUqhfiJxOpSmJCRzA7jAFtbTvMyiJIMQEWwNICNYmGTuE0Odjc3o5xxQn+Wr5F
         BzY6Eyyv9u6qERIk+1eeRdvqsmH73UzgfBMf7d1KxmJ6R+S2e0GKAVv9PQW+fJrtJrH+
         co2ItyeNmBpOgoIB8GJdrd0J5ucJIoQuU3QHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=K8uhwqVtnNne/sqsR8QmuUfc9dzyfkWgaRM0LIdFaAKo7Sowg363Tpk+PbfJyEiYoL
         dqrjvo15fQili/cEbJFZ05ZRA1ygakKZz3ardXRBP+3Vhrxmqrtma72x0KXqppc7f9sS
         lxQqEIwOxNYBRJsz7KoDn2MQAeDsfRN04WQNY=
Received: by 10.150.244.9 with SMTP id r9mr1389882ybh.24.1273135235677;
        Thu, 06 May 2010 01:40:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm620130iwn.11.2010.05.06.01.40.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 01:40:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100506065419.GA21009@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146459>

Jeff King wrote:
> On Thu, May 06, 2010 at 01:44:28AM -0500, Jonathan Nieder wrote:

>>  test_when_finished () {
>> 	test_cleanup=3D"$* && $test_cleanup"
>>  }
>
> Doesn't that violate your rule that the cleanup will _always_ be run?

Thanks for the sanity check.

> Perhaps the simplest would be to just keep a cleanup_ret in the secon=
d
> eval (where you have eval_ret in the original patch), and then act
> appropriately after the eval finishes. That would be easier on the ey=
es,
> too, I think.

I tried the cleanup_ret idea; test_run_ ended up looking like this:

	test_cleanup=3D:
	eval >&3 2>&4 "$1"
	eval_ret=3D$?
	eval >&3 2>&4 ":; $test_cleanup"
	cleanup_ret=3D?
	(exit "$test_ret") && (exit "$cleanup_ret")
	eval_ret=3D$?
	return 0

That breaks the principle of keeping the ugliness in test_when_finished=
=2E
So here=E2=80=99s the minimal fix.

-- 8< --
Subject: test-lib: some shells do not let $? propagate into an eval

In 3bf7886 (test-lib: Let tests specify commands to be run at end of
test, 2010-05-02), the git test harness learned to run cleanup
commands unconditionally at the end of a test.  During each test,
the intended cleanup actions are collected in the test_cleanup variable
and evaluated.  That variable looks something like this:

	eval_ret=3D$?; clean_something && (exit "$eval_ret")
	eval_ret=3D$?; clean_something_else && (exit "$eval_ret")
	eval_ret=3D$?; final_cleanup && (exit "$eval_ret")
	eval_ret=3D$?

All cleanup actions are run unconditionally but if one of them fails
it is properly reported through $eval_ret.

On FreeBSD, unfortunately, $? is set at the beginning of an =E2=80=98ev=
al=E2=80=99
to 0 instead of the exit status of the previous command.  This results
in tests using test_expect_code appearing to fail and all others
appearing to pass, unless their cleanup fails.  Avoid the problem by
setting eval_ret before the =E2=80=98eval=E2=80=99 begins.

Thanks to Jeff King for the explanation.

Cc: Jeff King <peff@peff.net>
Cc: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I was also surprised to see this migrate to maint so quickly, but I
was happy to see it broke early and loudly.

Because there is some unhappiness with the feature[1], it might make
more sense to revert it for now.  If that discussion can be taken as
license to write tests that take down other tests with them on
failure, then such a revert would not interfere with other work.

[1] http://thread.gmane.org/gmane.comp.version-control.git/146375/focus=
=3D146451

 t/t0000-basic.sh |   21 +++++++++++++++++++++
 t/test-lib.sh    |    7 ++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ca4fc..3ec9cbe 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -73,6 +73,27 @@ then
 	exit 1
 fi
=20
+clean=3Dno
+test_expect_success 'tests clean up after themselves' '
+    test_when_finished clean=3Dyes
+'
+
+cleaner=3Dno
+test_expect_code 1 'tests clean up even after a failure' '
+    test_when_finished cleaner=3Dyes &&
+    (exit 1)
+'
+
+if test $clean$cleaner !=3D yesyes
+then
+	say "bug in test framework: cleanup commands do not work reliably"
+	exit 1
+fi
+
+test_expect_code 2 'failure to clean up causes the test to fail' '
+    test_when_finished "(exit 2)"
+'
+
 ################################################################
 # Basics of the basics
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index acce3d0..7422bba 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -366,8 +366,9 @@ test_debug () {
 }
=20
 test_run_ () {
-	test_cleanup=3D'eval_ret=3D$?'
+	test_cleanup=3D:
 	eval >&3 2>&4 "$1"
+	eval_ret=3D$?
 	eval >&3 2>&4 "$test_cleanup"
 	return 0
 }
@@ -567,8 +568,8 @@ test_cmp() {
 # the test to pass.
=20
 test_when_finished () {
-	test_cleanup=3D"eval_ret=3D\$?; { $*
-		} && (exit \"\$eval_ret\"); $test_cleanup"
+	test_cleanup=3D"{ $*
+		} && (exit \"\$eval_ret\"); eval_ret=3D\$?; $test_cleanup"
 }
=20
 # Most tests can use the created repository, but some may need to crea=
te more.
--=20
1.7.1
