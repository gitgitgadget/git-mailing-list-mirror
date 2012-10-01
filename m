From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 20:42:38 +0200
Message-ID: <5069E41E.3040809@xs4all.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org, tonk@online.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIl8C-0005Zv-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 20:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab2JASyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 14:54:06 -0400
Received: from smtp-vbr19.xs4all.nl ([194.109.24.39]:1482 "EHLO
	smtp-vbr19.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2JASyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 14:54:05 -0400
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2012 14:54:05 EDT
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr19.xs4all.nl (8.13.8/8.13.8) with ESMTP id q91IgcHg017462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Oct 2012 20:42:39 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7v626udse6.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206757>

On 01/10/12 19:16, Junio C Hamano wrote:
> Simon Oosthoek <soosthoek@nieuwland.nl> writes:
> 
>> On 09/28/2012 07:58 PM, Junio C Hamano wrote:
>>> Simon Oosthoek <soosthoek@nieuwland.nl> writes:
>>>
>>>> +# __git_ps1_pc accepts 0 arguments (for now)
>>>> +# It is meant to be used as PROMPT_COMMAND, it sets PS1
>>>> +__git_ps1_pc ()
>>>> +{
>>>> +	local g="$(__gitdir)"
>>>> +	if [ -n "$g" ]; then
>>>> +...
>>>> +	fi
>>>> +}
>>>
>>> This looks awfully similar to the existing code in __git_ps1
>>> function.  Without refactoring to share the logic between them, it
>>> won't be maintainable.
>>>
>>
>> I agree that it's ugly. How about the following:
>>
>> I modified __git_ps1 to work both in PROMPT_COMMAND mode and in that
>> mode support color hints.
>>
>> This way there's one function, so no overlap.
> 
> I think the logical progression would be
> 
>  - there are parts of __git_ps1 you want to reuse for your
>    __git_ps1_pc; separate that part out as a helper function,
>    and make __git_ps1 call it, without changing what __git_ps1
>    does (i.e. no colors, etc.)
> 
>  - add __git_ps1_pc that uses the helper function you separated
>    out.
> 
>  - add whatever bells and whistles that are useful for users of
>    either __git_ps1 or __git_ps1_pc to that helper function.
> 
> 

Since this is the shell, it could turn out to be ugly this way:

function ps1_common {
	set global variable (branchname, dirty state, untracked files,
divergence from upstream, etc.)
}

function __git_ps1 {
	call ps1_common
	print PS1 string based on format string or default (color in prompt
isn't an option) and include global variables where necessary
}

function __git_ps1_pc {
	call ps1_common
	set PS1=....
	based on hardcoded PS1 definition, expand the PS1 using global
variables (add color if requested)
}

The problem I see is that it would involve a lot of global variables
visible in the shell (OTOH, they could be used by other scripts, but
only when using this prompt ;-).
Or you could print a string, which can be caught in the relevant _ps1
function, but then this string needs to be chopped up and processed (by
a bunch of awk oneliners or bash-voodoo)

The latter introduces so much overhead (in processing and
maintainability) that I think it should not be considered.

That leaves passing the variables from one function to another using
globally scoped variables in the shell.

It can be done, but the current combined implementation has only the
global variables set by the user (GIT_PS1_SHOWDIRTYSTATE and so on) and
the rest remains local to the function.

The main obstacle to better code here is the need to work around the
shell's oddities. :-(

Cheers

Simon
