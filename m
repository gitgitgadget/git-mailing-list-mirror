From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Mon, 08 Oct 2012 21:50:57 +0200
Message-ID: <50732EA1.7040608@xs4all.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005210945.GA4961@simaj.xs4all.nl> <7vr4p8lto5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 21:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJNm-00011M-3i
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 21:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab2JHTwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 15:52:41 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1514 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab2JHTwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 15:52:40 -0400
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id q98JovAX033881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2012 21:51:02 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vr4p8lto5.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207264>

Hi Junio

thanks for your feedback!

On 08/10/12 20:12, Junio C Hamano wrote:
> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
> 
>> changes __git_ps1 to not just allow use in setting PS1
>> with __git_ps1 in a command substitution, but also allows
>> __git_ps1 to be used as PROMPT_COMMAND in bash.
>> This has advantages for using color and I think it is more
>> elegant
> 
> Is "and I think" necessary?  I do not think it matters what _you_
> think when judging it is worth including in the future releases ;-)

Hmm, right :-P

How about "This has advantages for using color without running into
prompt-wrapping issues. Only by assigning \[ and \] to PS1 directly can
bash know these and the color codes in between don't count in the length
of the prompt."?

I'll rewrite the patch later on...

Isn't it confusing that the color codes don't figure in this patch at all?

>>  
>>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>> +# when called from PS1 using command substitution
>> +# in this mode it returns text to add to bash PS1 prompt (includes branch name) or
>> +# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND
>> +# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
>> +# when both arguments are given, the first is prepended and the second appended
>> +# to the state string when assigned to PS1, otherwise default start/end strings
>> +# are used.
> 
> Sorry, but I cannot parse this.  Is this meant to be a two-item list,
> one describing the command substitution mode (zero or 1 arguments) and
> the other describing the prompt command mode?  If so, perhaps replacing
> the " or" at the end of the first item with ".\n#\n" would make it readable.

I agree, that would make it more readable.

> 
>>  __git_ps1 ()
>>  {
>> +	local pcmode=yes
>> +	local ps1pc_start='\u@\h:\w '
>> +	local ps1pc_end='\$ '
>> +
>> +	case "$PROMPT_COMMAND" in
>> +		__git_ps1*)
>> +			if [ $# = 2 ]; then
>> +				ps1pc_start="$1"
>> +				ps1pc_end="$2"
>> +			fi
>> +			case "$PS1" in
>> +			*__git_ps1*)
>> +				echo '__git_ps1: overwriting PS1 due to PROMPT_COMMAND'
> 
> Is this supposed to be an error and/or warning message?  Why is it
> worth warning only when you are overwriting __git_ps1 style of PS1
> and not other user customization?

That's what this is doing, I wasn't able to make it the other way
around. I thought that I could detect when PS1 contained __git_ps1 that
it shouldn't overwrite the PS1, which worked, but when PROMPT_COMMAND
was set with __git_ps1 and PS1=$(__git_ps1) as well, it gave double output.
As PROMPT_COMMAND is relatively obscure I thought a warning when
overwriting the PS1 was good, but not unless there was a real conflict
(double call to __git_ps1).
The warning is only shown once.

I don't think it would be possible to detect any other kind of
customization without including specific code for it. Do you think it's
unnecessary to include a warning? (I think it would take people a long
time to figure out why their prompt goes whoopsy without getting a hint
that PROMPT_COMMAND messes up the PS1)

(OTOH, if you configure PROMPT_COMMAND, you're bound to know a little
bit about what you're doing...)

Perhaps it's better to just do it.


> 
>> +			;;
>> +			esac
>> +		;;
>> +		*)  pcmode=no ;; #no output
>> +	esac
> 
> Please align outer "case" "its arms)" and "esac" at the same column,
> like you did for the inner "case/esac".

ok

> 
> Auto-detetction based on PROMPT_COMMAND is a flaky approach.  In
> practice, nobody will call PROMPT_COMMAND with the __git_ps1 without
> any parameter (100% people want their prompt to end with some sort
> of whitespace so they want the "what comes after what is computed",
> aka $2), and even more importantly, nobody has been relying on use
> of 0 argument form of __git_ps1 in PROMPT_COMMAND.  So why not
> always require 2 args and take that as a cue to go into the pc mode?

That's a good idea, I'll change that.


>> +		if [ $pcmode = yes ]; then
>> +			PS1="$ps1pc_start($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
>> +		elif [ $pcmode = no ]; then
>> +			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>> +		fi
> 
> Are there $pcmode other than yes or no?  Why not just "else",
> instead of performing the test twice?

I forgot to remove that one, I had a default at some point ;-)

Cheers

Simon.
