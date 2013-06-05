From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 05/11] tests: use test_ln_s_add to remove SYMLINKS prerequisite
 (trivial cases)
Date: Wed, 05 Jun 2013 22:07:19 +0200
Message-ID: <51AF9A77.8050400@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org> <3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org> <7vd2s15yoa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 22:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkJzR-0006vo-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab3FEUHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 16:07:22 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12667 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757286Ab3FEUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 16:07:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 09FD3130047;
	Wed,  5 Jun 2013 22:06:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1C2FC19F5E4;
	Wed,  5 Jun 2013 22:07:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vd2s15yoa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226467>

Am 04.06.2013 23:55, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
>> index 88be904..563ac7f 100755
>> --- a/t/t3000-ls-files-others.sh
>> +++ b/t/t3000-ls-files-others.sh
>> @@ -19,12 +19,7 @@ filesystem.
>>  
>>  test_expect_success 'setup ' '
>>  	date >path0 &&
>> -	if test_have_prereq SYMLINKS
>> -	then
>> -		ln -s xyzzy path1
>> -	else
>> -		date >path1
>> -	fi &&
>> +	test_ln_s xyzzy path1 &&
>>  	mkdir path2 path3 path4 &&
>>  	date >path2/file2 &&
>>  	date >path2-junk &&
> 
> This also is not appropriate, but it is not as bad as the one in
> t2003 I earlier commented on.
> 
> This test wants an untracked symbolic link in the working tree as
> path1 and wants to see "ls-files -o" report it as "other".  On a
> filesystem that lack symbolic link, we obviously cannot have one,
> so as a substitute we just create another regular file to make the
> expected output and comparison simpler. 

Exactly. This is just a convenience. The issue is not introduced by the
conversion, but dates back 4 years when I added the SYMLINKS check. We
now only use a less random string on !SYMLINKS filesystems.

>>  test_expect_success 'git ls-files -k to show killed files.' '
>>  	date >path2 &&
>> -	if test_have_prereq SYMLINKS
>> -	then
>> -		ln -s frotz path3 &&
>> -		ln -s nitfol path5
>> -	else
>> -		date >path3 &&
>> -		date >path5
>> -	fi &&
>> +	test_ln_s frotz path3 &&
>> +	test_ln_s nitfol path5 &&
> 
> This falls into the same category as the one in t3000 above.  The
> only thing that matters in this test is path3 and path5 are non
> directories so that the former is killed when path3/file3 needs to
> be checked out, while path5 will not appear in "ls-files -k" output.
> Ideally we would want to test regular files and symlinks as two
> different kinds of "non directory" filesystem entities, but on
> platforms that lack symbolic links we cannot do so, hence we punt
> and create a regular file.

Indeed. Same answer.

>> diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh

>> -test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
>> +test_expect_success 'diff identical, but newly created symlink and file' '
>>  	>expected &&
>>  	rm -f frotz nitfol &&
>>  	echo xyzzy >nitfol &&
>>  	test-chmtime +10 nitfol &&
>> -	ln -s xyzzy frotz &&
>> +	test_ln_s xyzzy frotz &&
>>  	git diff-index -M -p $tree >current &&
>>  	compare_diff_patch expected current &&
> 
> As the point of test is to compare $tree that has symlink with
> another symlink that is identical but newly created one, I think
> this _does_ want the filesystem entity to be a symbolic link, but
> the index has frotz as a symlink and the mode propagates to what we
> read from the filesystem on !has_symlinks systems, so this
> conversion may be a correct one, though it is a bit tricky.

Yes, this test depends on the mode propagation. I'll add a comment along
these lines and keep the change in this patch with a title marked
"trivial cases".

>> @@ -100,7 +103,7 @@ test_expect_success SYMLINKS 'diff different symlink and file' '
>>  	+yxyyz
>>  	EOF
>>  	rm -f frotz &&
>> -	ln -s yxyyz frotz &&
>> +	test_ln_s yxyyz frotz &&
>>  	echo yxyyz >nitfol &&
>>  	git diff-index -M -p $tree >current &&
>>  	compare_diff_patch expected current
> 
> Likewise.

-- Hannes
