From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Wed, 24 Oct 2007 14:07:23 +0100
Message-ID: <DCDC05E5-B5D0-4366-9DA8-5AD775B16545@steelskies.com>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com> <11926134961275-git-send-email-maillist@steelskies.com> <4715F2E6.1000708@viscovery.net> <6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com> <4716F849.3090102@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 15:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkfxU-00028m-9m
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 15:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbXJXNH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 09:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbXJXNH2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 09:07:28 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:39974 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbXJXNH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 09:07:27 -0400
Received: from [89.105.122.147] (helo=gir.office.bestbefore.tv)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IkfxG-0000d9-Ja; Wed, 24 Oct 2007 09:07:27 -0400
In-Reply-To: <4716F849.3090102@viscovery.net>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62214>

On 18 Oct 2007, at 07:08, Johannes Sixt wrote:

> Jonathan del Strother schrieb:
>> On 17 Oct 2007, at 12:32, Johannes Sixt wrote:
>>> Jonathan del Strother schrieb:
>>>> --- a/t/lib-git-svn.sh
>>>> +++ b/t/lib-git-svn.sh
>>>> @@ -25,7 +25,7 @@ perl -w -e "
>>>> use SVN::Core;
>>>> use SVN::Repos;
>>>> \$SVN::Core::VERSION gt '1.1.0' or exit(42);
>>>> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or  
>>>> exit(41);
>>>> +system(qw/svnadmin create --fs-type fsfs/, \"$svnrepo\") == 0 or  
>>>> exit(41);
>>>
>>> Here you have to work harder: The reason is that this is part of a  
>>> perl expression (as opposed to an eval'd string), which does not  
>>> have access to $svnrepo of the shell by which it is invoked. The  
>>> original version failed if there were single-quotes in $svnrepo,  
>>> the new version fails if it contains double-quotes.
>
> You can rewrite this expression as
>    perl -w -e '$svnrepo = shift;
> 	...
> 	$SVN::Core::Version gt "1.1.0" ...
> 	system(qw/svnadmin create --fs-type fsfs/, $svnrepo) == 0 ...
> 	...
>    ' >&3 2>&4 "$svnrepo"
>
> i.e. you pass the repository name as an argument to the scriptlet.
>
>>> May I recommend that you run the test suite in a directory named  
>>> like this:
>>>
>>>    $ mkdir \"\ \$GIT_DIR\ \'
>>>    $ ls
>>>    " $GIT_DIR '
>> Eww.  I'm struggling a bit with paths this perverse, actually.
>> For instance, git_editor in git-sh-setup expects the editor path to  
>> be pre-quoted.  So in t3404, you need to produce escaped double  
>> quotes & dollar signs, resulting in unpleasantness like this :
>> VISUAL="`pwd`/fake-editor.sh"
>> VISUAL=${VISUAL//\"/\\\"}
>> VISUAL=${VISUAL//$/\\\$}
>
> This is a bashism - that's a big no-no.
>
>> VISUAL=\"$VISUAL\"
>> export VISUAL
>> And I'm struggling to come up with neat ways of rewriting things  
>> like, eg, this bit from t5500 -
>> test_expect_success "clone shallow" "git-clone --depth 2 \"file:// 
>> `pwd`/.\" shallow"
>> - to handle paths like that properly.
>
> These examples expand `pwd` too early. Can't you just put everything  
> inside single-quotes? Although I'm not sure about VISUAL: Is it  
> invoked with $PWD that is different from $PWD when VISUAL is  
> defined? If so, then you can hardly delay `pwd`...
>
> I know I'm a bit anal with my criticism. I reviewed your patch  
> because I think fixing for paths with whitespace is worthwhile.  
> However, I also think any fix should go the full way and not only  
> shift the problems into a different corner. Maybe a word from  
> $maintainer would be in order ;)

In theory, I agree that the tests should properly handle perverse  
paths, but it's beginning to stretch my shell scripting skills.
So now our esteemed leader is back in business, any thoughts on how  
hard we want to work to quote things?

Also, from "What's cooking in git.git" :
> I have a feeling that this should have forked off of 'maint'.
> The change looks obvious and trivial, so perhaps after getting a
> testcase (hint, hint) merge to 'master' and then cherry-pick to
> 'maint' as well.
Noted


Jon del Strother
