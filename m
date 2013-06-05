From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 05/11] tests: use test_ln_s_add to remove SYMLINKS prerequisite
 (trivial cases)
Date: Wed, 05 Jun 2013 21:32:43 +0200
Message-ID: <51AF925B.90601@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org> <3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org> <7vwqq960wn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 21:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkJS1-00080g-FW
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 21:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928Ab3FETct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 15:32:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:22086 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755354Ab3FETcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 15:32:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3BF1310012;
	Wed,  5 Jun 2013 21:32:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A086919F5E4;
	Wed,  5 Jun 2013 21:32:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vwqq960wn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226466>

Am 04.06.2013 23:06, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> There are many instances where the treatment of symbolic links in the
>> object model and the algorithms are tested, but where it is not
>> necessary to actually have a symbolic link in the worktree. Make
>> adjustments to the tests and remove the SYMLINKS prerequisite when
>> appropriate in trivial cases, where "trivial" means:
>>
>> - merely a replacement of 'ln -s a b' to test_ln_s or of
>>   'ln -s a b && git add b' to test_ln_s_add is needed;
>>
>> - a test for symbolic link on the file system can be split off (and
>>   remains protected by SYMLINKS);
>>
>> - existing code is equivalent to test_ln_s[_add].
> 
> This is too big to review in one go, so I may have separate messages
> later on this same patch.
> 
>> diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
>> index ff163cf..bd17ba2 100755
>> --- a/t/t2003-checkout-cache-mkdir.sh
>> +++ b/t/t2003-checkout-cache-mkdir.sh
>> @@ -19,10 +19,10 @@ test_expect_success 'setup' '
>>  	git update-index --add path0 path1/file1
>>  '
>>  
>> -test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
>> +test_expect_success 'have symlink in place where dir is expected.' '
>>  	rm -fr path0 path1 &&
>>  	mkdir path2 &&
>> -	ln -s path2 path1 &&
>> +	test_ln_s path2 path1 &&
>>  	git checkout-index -f -a &&
>>  	test ! -h path1 && test -d path1 &&
>>  	test -f path1/file1 && test ! -f path2/file1
> 
> I do not think this hunk is correct.
[...]
> Under the precondition checkout-index runs in this test, a casual
> 
> 	echo rezrov >path1/file1
> 
> would leave path1 as a symlink without turning it into a real
> directory, and we will end up creating path2/file1.  We are making
> sure that checkout-index does not behave that way, and it is
> essential to have symlink support in the working tree for the "bug"
> to trigger.
> 
>> @@ -79,10 +79,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
>>  	test -h tmp
>>  '
>>  
>> -test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
>> +test_expect_success 'use --prefix=tmp- where tmp-path1 is a symlink' '
>>  	rm -fr path0 path1 path2 tmp* &&
>>  	mkdir tmp1 &&
>> -	ln -s tmp1 tmp-path1 &&
>> +	test_ln_s tmp1 tmp-path1 &&
>>  	git checkout-index --prefix=tmp- -f -a &&
>>  	test -f tmp-path0 &&
>>  	test ! -h tmp-path1 &&
> 
> This change has the same issue, I think.

Yes, agreed. The converted tests -- when SYMLINKS are not available --
just repeat what is tested elsewhere.

Nice catch. After I've found a hammer (test_ln_s) I was mindlessly
looking for nails and found two of them in these two instances. ;-)

-- Hannes
