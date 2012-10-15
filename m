From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 11:01:34 +0200
Message-ID: <507BD0EE.5000107@nieuwland.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	spearce@spearce.org, artagnon@gmail.com, schwab@linux-m68k.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 11:02:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNgYo-0006fR-Tt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 11:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab2JOJBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 05:01:55 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:45100 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751822Ab2JOJBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 05:01:54 -0400
Received: (qmail 2726 invoked by uid 453); 15 Oct 2012 09:01:38 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 15 Oct 2012 11:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <507BC7F1.3080506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207727>

On 10/15/2012 10:23 AM, Michael J Gruber wrote:
> Sorry for being late ($DAYJOB and such), but I just noticed this is on
> next already:
>
>> +			if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
>
> You're missing the "S" here (HINTS).

indeed, well spotted!
My test setup was apparently configured without the S and the commented 
uses all had HINTS...


>
>> +				local c_red='\e[31m'
>> +				local c_green='\e[32m'
>> +				local c_yellow='\e[33m'
>> +				local c_lblue='\e[1;34m'
>> +				local c_purple='\e[35m'
>> +				local c_cyan='\e[36m'
>> +				local c_clear='\e[0m'
>> +				local branchstring="$c${b##refs/heads/}"
>> +				local branch_color="$c_green"
>> +				local flags_color="$c_cyan"
>> +
>> +				if [ "$w" = "*" ]; then
>> +					branch_color="$c_red"
>> +				elif [ -n "$i" ]; then
>> +					branch_color="$c_yellow"
>> +				fi
>> +
>> +				# Setting PS1 directly with \[ and \] around colors
>> +				# is necessary to prevent wrapping issues!
>> +				PS1="$PS1\[$branch_color\]$branchstring\[$c_clear\]"
>> +				if [ -n "$f" ]; then
>> +					PS1="$PS1 \[$flags_color\]$f\[$c_clear\]"
>> +				fi
>> +			else
>> +				PS1="$PS1$c${b##refs/heads/}${f:+ $f}$r$p"
>> +			fi
>> +			PS1="$PS1)$ps1pc_end"
>> +		else
>> +			# NO color option unless in PROMPT_COMMAND mode
>>   			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>>   		fi
>>   	fi
>>
>
> I'm afraid I don't like this coloring style at all because it is
> inconsistent with the color usage of "git status -sb". First of all, the
> colors are different, and second, the fact *what* is colored is
> different. I had suggested following "git status -sb" for a good reason.
> It colors a branch green and a detached head red. It colors "change"
> (A/D/M/R) as red/green depending on non-cached/cached, so that's how */+
> should be. Your call for $/% (I'd leave them uncolored).[*][**]

This way works for me. The coloring scheme itself is probably quite 
personal and can, and probably should, be modified by end-users.
(Whether the current code is suitable for user-modification is another 
matter)

I'm quite unfamiliar with the color coding of git (I hadn't enabled that 
option), I suppose consistency would be better, but then you'd have to 
add some code to figure out which color is used for what in git's output 
and convert that to the code setting the colors here.

As for the characters used, I think there's a good reason not to use the 
ones git uses in the prompt. The characters in git status output are put 
in front of the files they apply to, in the prompt you only get a 
summarized output. And perhaps that argument could be extended to the 
use of the colors as well, I prefer to know whether I have uncommitted 
changes and in that category I want to know whether I already staged 
them or not.

If I want to know which files are unstaged/uncommitted I do git status 
to see that.

>
> I think it's very confusing to have completely different schemes (not
> just themes) for two versions of the same information: concise status
> information.
>
> So, please try and follow "git status -sb".

I think there are different levels of conciseness. And I see "git status 
-sb" uses green for staged modified files, which would be confusing to me.

>
> Michael
>
> [*] Really, there's nothin "red" about a branch when there are cached or
> non-cached changes. They are changes wrt. to what's in HEAD resp. the
> index, no matter what HEAD is.

Do you mean that red (unstaged) and yellow (staged) are both "red" to you?

>
> [**] Also, coloring the status characters opens the way to even using
> the same characters as "status -sb" (ADM).
>

Perhaps, but that would be confusing to me ;-)

Cheers

Simon
