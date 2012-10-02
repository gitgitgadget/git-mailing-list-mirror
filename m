From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Tue, 02 Oct 2012 10:01:08 +0200
Message-ID: <506A9F44.1000209@nieuwland.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl> <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl> <7va9w5c31w.fsf@alter.siamese.dyndns.org> <506A99DE.7080503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIxQ7-00045f-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 10:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab2JBIB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 04:01:26 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:46748 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753412Ab2JBIBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 04:01:25 -0400
Received: (qmail 31743 invoked by uid 453); 2 Oct 2012 08:01:12 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Tue, 02 Oct 2012 10:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <506A99DE.7080503@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206790>

On 10/02/2012 09:38 AM, Michael J Gruber wrote:
>> The longer I read your explanation, the less useful the "PC mode"
>> sounds like, at least to me.  So why does an user even want to use
>> such a mechanism, instead of PS1?  And even if the user wants to use
>> it by doing \w, \u etc. himself, she can do that with
>>
>> 	PROMPT_COMMAND='
>> 		PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
>>          '
>>
>> just fine, no?

Well, in that way, it doesn't work and setting PS1 directly would be 
better. But this way you cannot do colors.

>>
>> Confused....

I know the feeling ;-)

>
> The "problem" (as far as I see) is only: What user interface do we want
> to expose to the user, or rather, do we want to expose the user to ;)
>
> So far, we say:
>
> #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
> #    2) Add the following line to your .bashrc/.zshrc:
> #        source ~/.git-prompt.sh
> #    3) Change your PS1 to also show the current branch:
> #         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> #         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
>
> (That's incomplete for zsh, but I'm digressing...). With the above, we
> would change the bash instruction to
>
> PROMPT_COMMAND='
> 	PS1=$(printf "\u \h \w %s$ " $(__git_ps1 "%s"))
>         '
>
> which may look more complicated to some. I think we can aim for
> something like
>
> PROMPT_COMMAND='__git_ps1_color "\u \h \w%s$ " " (%s)"'
>
> so that the first arg is a PS1 string, %s there gets replaced by the git
> prompt (if any), and the second arg defines the formatting of the git
> prompt. This makes the "ui" (what you have to set the shells vars to) as
> simple as possible.
>
> As I said, I had done some fixes and refactoring to that effect already,
> but I'm not going to race Simon.

I don't quite see how you're going to smurf the formatted string into 
the PS1 string at %s...

Wouldn't it be easier in this case to have the user provide 3 arguments:

PROMPT_COMMAND='__git_ps1 "\u@\h:\w " "(%s)" "\$ "'

The first and last can be directly assigned to PS1 and the format string 
can be put in the middle.

BUT. In this way, it is still impossible to change the colors inside the 
format string, unless you ignore that when the user requested color 
hints. Because the output of printf will not be interpreted by bash when 
put in via command substitution.

The whole point of this exercise (for me at least) was to be able to 
color different parts of the bit that __git_ps1 put in, based on the 
current state of the tree.

I think the user interface could be something like:

use either:
PROMPT_COMMAND='__git_ps1 "\u@\h:\w " "\$ "' # 2 args!
or
PS1="\u@\h:\w $(__git_ps1 '(%s)')\$ "

(I just realised that I still need to handle the case where both PS1 and 
PROMPT_COMMAND contain __git_ps1 ;-)

Note that in the PS1 case, no color codes should be put into the string, 
as they will mangle the prompt length and wrapping problems start happening.

Cheers

Simon.
