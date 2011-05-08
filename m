From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Sun, 08 May 2011 23:41:46 +0200
Message-ID: <4DC70E1A.6060702@web.de>
References: <4DC47242.6060205@web.de> <7vhb97xx5g.fsf@alter.siamese.dyndns.org> <7vfwoqwby5.fsf@alter.siamese.dyndns.org> <4DC67CF4.80901@web.de> <4DC70200.1080201@web.de> <7vwri0ric1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBjh-00084D-Nn
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab1EHVlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 17:41:52 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34870 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab1EHVlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 17:41:51 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9B31E19EE97E6;
	Sun,  8 May 2011 23:41:49 +0200 (CEST)
Received: from [93.240.113.59] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QJBjZ-0002pn-00; Sun, 08 May 2011 23:41:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vwri0ric1.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/aX9DcUM1csVGG8GtY6I16XuZfvK5iQVrg+CDS
	qPeuQ28NCaoYoDUPa3BrGXJ1PwCkgK/kMbU7pJH5PD3O0EfbbS
	jCv0v7Rq9Ok2v92owVGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173186>

Am 08.05.2011 23:30, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
>> index ca8a409..bcfb5e6 100755
>> --- a/t/t1000-read-tree-m-3way.sh
>> +++ b/t/t1000-read-tree-m-3way.sh
>> @@ -259,6 +259,8 @@ test_expect_success \
>>      "rm -f .git/index AA &&
>>       cp .orig-A/AA AA &&
>>       git update-index --add AA &&
>> +     git read-tree -n -m $tree_O $tree_A $tree_B &&
>> +     test_must_fail check_result &&
> 
> That's a rather sloppy way to test that the command did not do anything to
> compare one possible outcome, instead of verifying that the result is
> identical to the original condition, no?
> 
> How about
> 
> 	...
> 	git update_index --add AA &&
>         git ls-files -s >pre-dry-run &&
>         git read-tree -n -m $tree_O $tree_A $tree_B &&
>         git ls-files -s >post-dry-run &&
>         test_cmp pre-dry-run post-dry-run &&
>         ...

Yeah, that is much better than my first sketch.

> We also should be checking that the command reports it is going to fail
> when it should as well.  Always remember to check both sides of the coin.
> 
>>       git read-tree -m $tree_O $tree_A $tree_B &&
>>       check_result"
> 
> I suspect that it would make sense to replace
> 
> 	git read-tree $args && check_result
> 
> with
>         
> 	read_tree_must_succeed $args
> 
> and
> 
> 	test_must_fail git read-tree $args
> 
> with
> 
> 	read_tree_must_fail $args
> 
> and implement two shell wrappers, perhaps like this.
> 
> read_tree_must_succeed () {
> 	git ls-files -s >pre-dry-run &&
> 	git read-tree -n "$@" &&
>         git ls-files -s >post-dry-run &&
>         test_cmp pre-dry-run post-dry-run &&
>         git read-tree "$@"
> }
> 
> read_tree_must_fail () {
> 	git ls-files -s >pre-dry-run &&
> 	test_must_fail git read-tree -n "$@" &&
>         git ls-files -s >post-dry-run &&
> 	test_must_fail git read-tree "$@"
> }

Thanks, will send an updated patch with better test cases soon ...
