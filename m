From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Thu, 18 Oct 2007 08:08:09 +0200
Message-ID: <4716F849.3090102@viscovery.net>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com> <11926134961275-git-send-email-maillist@steelskies.com> <4715F2E6.1000708@viscovery.net> <6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:08:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOYU-0001AX-Ov
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXJRGIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXJRGIP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:08:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49282 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbXJRGIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:08:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IiOY1-0005Hn-FP; Thu, 18 Oct 2007 08:07:58 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DFEBE4E4; Thu, 18 Oct 2007 08:08:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61489>

Jonathan del Strother schrieb:
> 
> On 17 Oct 2007, at 12:32, Johannes Sixt wrote:
> 
>> Jonathan del Strother schrieb:
>>> --- a/t/lib-git-svn.sh
>>> +++ b/t/lib-git-svn.sh
>>> @@ -25,7 +25,7 @@ perl -w -e "
>>> use SVN::Core;
>>> use SVN::Repos;
>>> \$SVN::Core::VERSION gt '1.1.0' or exit(42);
>>> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or 
>>> exit(41);
>>> +system(qw/svnadmin create --fs-type fsfs/, \"$svnrepo\") == 0 or 
>>> exit(41);
>>
>> Here you have to work harder: The reason is that this is part of a 
>> perl expression (as opposed to an eval'd string), which does not have 
>> access to $svnrepo of the shell by which it is invoked. The original 
>> version failed if there were single-quotes in $svnrepo, the new 
>> version fails if it contains double-quotes.

You can rewrite this expression as
     perl -w -e '$svnrepo = shift;
	...
	$SVN::Core::Version gt "1.1.0" ...
	system(qw/svnadmin create --fs-type fsfs/, $svnrepo) == 0 ...
	...
     ' >&3 2>&4 "$svnrepo"

i.e. you pass the repository name as an argument to the scriptlet.

>> May I recommend that you run the test suite in a directory named like 
>> this:
>>
>>     $ mkdir \"\ \$GIT_DIR\ \'
>>     $ ls
>>     " $GIT_DIR '
> 
> 
> Eww.  I'm struggling a bit with paths this perverse, actually.
> 
> For instance, git_editor in git-sh-setup expects the editor path to be 
> pre-quoted.  So in t3404, you need to produce escaped double quotes & 
> dollar signs, resulting in unpleasantness like this :
> 
> VISUAL="`pwd`/fake-editor.sh"
> VISUAL=${VISUAL//\"/\\\"}
> VISUAL=${VISUAL//$/\\\$}

This is a bashism - that's a big no-no.

> VISUAL=\"$VISUAL\"
> export VISUAL
> 
> 
> And I'm struggling to come up with neat ways of rewriting things like, 
> eg, this bit from t5500 -
> test_expect_success "clone shallow" "git-clone --depth 2 
> \"file://`pwd`/.\" shallow"
> - to handle paths like that properly.

These examples expand `pwd` too early. Can't you just put everything inside 
single-quotes? Although I'm not sure about VISUAL: Is it invoked with $PWD 
that is different from $PWD when VISUAL is defined? If so, then you can 
hardly delay `pwd`...

I know I'm a bit anal with my criticism. I reviewed your patch because I 
think fixing for paths with whitespace is worthwhile. However, I also think 
any fix should go the full way and not only shift the problems into a 
different corner. Maybe a word from $maintainer would be in order ;)

-- Hannes
