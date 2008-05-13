From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for git-add --ignore-errors
Date: Mon, 12 May 2008 23:05:01 -0700
Message-ID: <7vhcd2viwi.fsf@gitster.siamese.dyndns.org>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home>
 <20080302154238.GD2973@steel.home>
 <alpine.LSU.1.00.0803021555500.22527@racer.site>
 <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
 <20080512175654.GB3128@steel.home> <20080512175745.GC3128@steel.home>
 <20080512175810.GD3128@steel.home> <20080512175829.GE3128@steel.home>
 <20080512175848.GF3128@steel.home>
 <7v3aomx3sp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvneH-0007v2-55
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbYEMGFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 02:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756353AbYEMGFP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:05:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbYEMGFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:05:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07CF93A0E;
	Tue, 13 May 2008 02:05:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C367F3A08; Tue, 13 May 2008 02:05:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C3EAD6C-20B2-11DD-8D93-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81992>

Junio C Hamano <junio@pobox.com> writes:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ---
>>  t/t3700-add.sh |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index 287e058..ca3e33d 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -179,4 +179,13 @@ test_expect_success 'git add --refresh' '
>>  	test -z "`git diff-index HEAD -- foo`"
>>  '
>>  
>> +test_expect_success 'git add --ignore-errors' '
>> +	git reset --hard &&
>> +	date >foo1 &&
>> +	date >foo2 &&
>> +	chmod 0 foo2 &&
>> +	git add --verbose --ignore-errors .
>> +	git ls-files |grep foo1
>> +'
>> +
>>  test_done
>
> I like the fact that you added --ignore-errors and made it still error out
> when it cannot read some files.  Shouldn't we be testing it here with
> "must-fail"?

It is human nature to get too enthusiastic demonstrating his own shiny new
toy and forget to check that it does not kick in when not asked.  There is
no test for a case to make sure "git add" fails when foo2 is not readable
and does not add "foo1".

Here is a replacement I've queued.  I have a similar addition to the test
in the patch after this one that demonstrates the configuration variable.
I added tests to check the case when the variable is set to false.

-- >8 --
Add a test for git-add --ignore-errors

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3700-add.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 287e058..01e4d62 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,4 +179,26 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
 
+test_expect_success 'git add should fail atomically upon an unreadable file' '
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	test_must_fail git add --verbose . &&
+	! ( git ls-files foo1 | grep foo1 )
+'
+
+rm -f foo2
+
+test_expect_success 'git add --ignore-errors' '
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	test_must_fail git add --verbose --ignore-errors . &&
+	git ls-files foo1 | grep foo1
+'
+
+rm -f foo2
+
 test_done
-- 
1.5.5.1.340.g39dc6
