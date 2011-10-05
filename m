From: Gioele Barabucci <gioele@svario.it>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 16:47:19 +0200
Message-ID: <4E8C6DF7.9050406@svario.it>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 05 16:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBSkr-0004Ck-BH
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 16:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934807Ab1JEOrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 10:47:24 -0400
Received: from begonia.svario.it ([91.213.195.127]:43844 "EHLO
	begonia.svario.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934414Ab1JEOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 10:47:24 -0400
Received: from [192.168.2.2] (dynamic-adsl-84-223-204-232.clienti.tiscali.it [84.223.204.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: gioele@svario.it)
	by begonia.svario.it (Postfix) with ESMTPSA id 41C472CE97;
	Wed,  5 Oct 2011 14:47:20 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
In-Reply-To: <4E8C481A.1070808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182851>

On 05/10/2011 14:05, Michael Haggerty wrote:
> On 10/04/2011 08:52 PM, Gioele Barabucci wrote:
>> With the newer v1.7.7 I get this, instead:
>>
>>      .: show_in_prompt: unspecified
>>
>> I see in the release notes of 1.7.7-rc1 that `check-attr` has been
>> changed to allow relative paths to be specified. Maybe this error is
>> related to that change.
>
> Indeed, your use case is broken by
>
> f5114a40c0d0276ce6ff215a3dc51eb19da5b420

Wow, debug-by-changelog :)

> In fact the support for gitattributes using patterns involving "." was
> pretty spotty in v1.7.6 too.  For example,

[...]

> It's not to hard to fix your particular use case.  But for a real fix,
> we would need to decide what is the correct behavior in all of the lines
> above marked "?"; specifically, should "." match every subdirectory
> under a given directory, does it match only the directory containing the
> .gitattributes file, or is this construct illegal?

I do not know what the correct behavior should be, but here is my use case.

I use git to version almost all my $HOME dir. In addition to my usual 
files there are also separate project repositories under $HOME. I enjoy 
using a git-enabled prompt in those projects' dirs but not in my $HOME dir.

So I have this code somewhere in my `~/.bashrc`:

     local show_status="$(git check-attr show_in_prompt -- .)"
     local show_pattern='^\.: show_in_prompt: (.*)$'

     # add the following line to .gitattributes
     #
     #     /. show_in_prompt=no
     local show_in_prompt='yes'
     if [[ ${show_status} =~ ${show_pattern} ]]; then
            show_in_prompt="${BASH_REMATCH[1]}"
     fi

     if [ "${show_in_prompt}" == 'no' ]; then
             return
     fi

As you see in my the line of this code, I exploit the fact that "." 
refers to the root git dir, not to the current dir, to simplify the 
code. Otherwise I would had to discover what is the path of the current 
dir relative to its root git dir, something that I'd like to avoid as 
this code runs every time the prompt is shown.

This is just my personal use case. On the other hand, the first time I 
looked at check-attr I found it strange that paths were meant as 
relative to the root git dir ("." in "/foo" = "/") and not expanded from 
the current dir ("." in "/foo" = "/foo").

Bye,

-- 
Gioele Barabucci <gioele@svario.it>
