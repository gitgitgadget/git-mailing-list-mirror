From: Thomas Vieten <tvie@ivision.de>
Subject: Re: end-of-line diff checkout direction dependence problem
Date: Thu, 02 Jul 2015 16:00:09 +0200
Organization: iVISION GmbH
Message-ID: <559543E9.5040706@ivision.de>
References: <5592A3D9.3080706@ivision.de> <5593F73E.60305@ivision.de>
Reply-To: tvie@ivision.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: tboegi@web.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 16:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAf2J-0008Mq-V4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 16:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbGBOAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 10:00:14 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:40983 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbbGBOAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 10:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1435845610; l=5675;
	s=domk; d=ivision.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:To:MIME-Version:Reply-To:From:Date;
	bh=67XUslqZjDik3XLJRzhmfVHI1nBcDG60Fp4eOgecFa8=;
	b=YhnMFzuEeB9VN0f1ghLQPsExSYjdfc3oTBC+/tV4YjFAHnNoQinmkXvKezS+NwA3eKp
	s74WPdC02JQ4X3cMXs9x8g7V68GFkXiaO9Y1OXfwU0SdTBLCDIm6txZwsmwLo+xAM1hCe
	1yxb3FAQbrcHhp7M44aJwtXIZ3oun08qKOU=
X-RZG-AUTH: :OHoNcGChbfbkF0MiFdPmE/cAQnRWOxNPsUpfO0vBMLQStzWaZbQFXDrmmA7YKok=
X-RZG-CLASS-ID: mo00
Received: from firewall.ivision.de (pd95bcd7c.dip0.t-ipconnect.de [217.91.205.124])
	by smtp.strato.de (RZmta 37.8 AUTH)
	with ESMTPA id L01557r62E094Jm
	for <git@vger.kernel.org>;
	Thu, 2 Jul 2015 16:00:09 +0200 (CEST)
Received: from ivision.de (unknown [192.168.0.1])
	by firewall.ivision.de (Postfix) with ESMTP id A79A632648
	for <git@vger.kernel.org>; Thu,  2 Jul 2015 16:00:08 +0200 (CEST)
Received: from [192.168.0.132] (192.168.0.132:9815)
	by ivision.de with [XMail 1.20 ESMTP Server]
	id <S2E5DB> for <git@vger.kernel.org> from <tvie@ivision.de>;
	Thu, 2 Jul 2015 16:00:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <5593F73E.60305@ivision.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273230>


Answers and new response below.

Thomas Vieten wrote:
> On 2015-06-30 16.12, Thomas Vieten wrote:
>> We face a very inconvenient problem with end-of-line diffs which are 
>> not "real".
>> We know the end-of-line problem very well as we thought.
>> But now we found a new phenomenon and nobody mentioning it.
>>
>> Consider the following repository structure:
>>
>>           -----------|----|------------->branch1
>>         /
>> master
>>         \
>> ----------|-------|---------|--------------->branch2
>>
>> The branches are based on master/head.
>> We just consider one branch here, e.g. branch1 .
>>
>> Working with the head of branch1 gives no problems. No end-of-line 
>> diffs.
>> Also going back in the direction of master - no problems.
>> Only in the case if we do a checkout from branch1 to master, then
>> all of a sudden end-of-line diffs appear.
>> The files might be changed, but the end-of-line attributes in 
>> gitattributes are
>> not changed in the branch.
>>
>> It seems to be the case that since the last change to the files which 
>> pop up
>> with eol differences, gittattributes where changed and touch their 
>> extensions.
>>
>> With the operation
>>
>> git ls-files -z | xargs -0 rm -f  # delete all the files of this 
>> version - here
>> master/head
>> git reset --hard                  # force checkout of master/head and 
>> reset index
>>
>> The problem disappears! No eol problems anymore. Something like a 
>> brute force
>> checkout.
>>
>> Also checking out versions in the direction of branch1 give never 
>> end-of-line
>> diffs.
>>
>> What has changed somewhen are the gitattributes.
>>
>> We estimate that this becomes a problem when applying the diffs from 
>> branch1 in
>> the direction of
>> the master. Finally then the diffs result in a different state from 
>> the master.
>>
>> But when the master is checked out freshly, this difference does not 
>> appear.
>>
>> Very, very annoying.
>>
>> We check now every time when these end-of-line diffs appear, if they 
>> are really
>> end of line diffs
>>
>> git diff --ignore-space-at-eol
>>
>> and then try the procedure above.
>>
>> But to have a dependence from the direction of the checkout is 
>> somewhat irritating.
>>
>> If this is not a bug - then how to avoid it ?
>>
>> bye for now
>>
>> Thomas
>>
> The things which are described don't sound unfamilar.
> First some questions:
> Which Git/OS are you running on ?
>
> CYGWIN ?
> Git-for-Windows ?
git version 1.9.2.msysgit.0
+tortoisegit, for viewing and conflicts
> Linux ?
> Other ?
Windows 7 Pro
>
> Which versions ?
> How does your .gitattribute file look like ?
>
see the file attachend to the end of this message
> It may be, that you need to "nornalize" your repo:
>
> https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
> The search for this text
> "When text=auto normalization"
> and follow the instructions:
>
in principle we know all this.
What is remarkable that we are able to checkout a version of master 
which is not consistent with the repo, and more, dependent from the 
checkout direction (if the direction is the positive or negative history 
in time). And on the other hand we can checkout a version of master 
which is in sync with the master.

Normally such conflicts with not normalised repos appear immediately 
also in positive history direction. And then it is possible to detect them.
The other way around - negative history and diffs - it causes a big 
questionmark.

On the other hand this would lead to the mandatory work flow advice: 
"Always normalize the repository after changes within the gitattributes 
file"
And then: Should this then not be automatically be done somehow in the 
background by git ?
Reasoning: if the "git machine" is causing this behaviour 
systematically, shouldn't the machine itself have compensation, correction?

Depending on your point of view this could be seen as a bug.

There is also a big question open: will normalisation really help ? 
Because there must be one commit with the new gitattributes and then you 
normalize.
But the "wrong diff" is in the repo and will cause the problem when 
going back to master in the negative direction.
This is how understand it up to now.

But at this point git is complex and we are not really the experts.

best regards

Thomas V.


--------------------------------------------------------------------------------------------------------
.gitattributes
#Set default behaviour, in case users don't have core.autocrlf set.
* text=auto
*.PC                text
*.in                text
*.hex               text
*.inc               text
*.DAT               binary
*.lic               binary
*.chm               binary
*.dat               binary
*.cam               binary
*.cam.new           binary
*.cam.cam           binary
*.am                text
*.cc                text
*.m4                eol=lf
*.exe               binary
*.sys               binary
*.dll               binary
*.cxf               eol=lf
*.vcproj            eol=crlf
*.vcxproj           text
*.vcxproj.filters   text
*.sln               eol=crlf
*.dsp               eol=crlf
*.dsw               eol=crlf
*.sh                text
*.txt               text
*.png               binary
*.jpg               binary
*.tif               binary
*.odt               binary
*.db                binary
*.vsd               binary
*.dbf               binary
*.zip               binary
*.emf               binary
*.psp               binary
*.dot               binary
*.doc               diff=word
*.sql               text
*.vsd               binary
*.sys               binary
*.xls               binary
*.vxd               binary
*.jpg               binary
*.jpeg              binary
*.sch               binary
*.pdf               binary
*.s#*               binary
*.ocx               binary
*.gif               binary
*.gz                binary
*.obj               binary
*.ncb               binary
*.bin               binary
*.bmp               binary
*.cmd               eol=crlf
*.bat               eol=crlf
*.htm               eol=crlf
*.html              eol=crlf
*.dsp               eol=crlf
*.dbf               binary
*.vtg               binary
*.mdb               binary
*.msi               binary
*.cbproj            binary
*.groupproj         binary
*.bdsgroup          binary
*.tgr               binary
*.pbd               binary
*.pbl               binary
*.tag               binary
makefile            text
*.c                 text
*.cpp               text
*.h                 text
*.hpp               text
