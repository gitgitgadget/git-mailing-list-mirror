From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 22:56:06 +0200
Message-ID: <506A0366.6030009@xs4all.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl> <7vr4piaryi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 22:58:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIn3t-0007zw-OU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 22:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab2JAU5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 16:57:49 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:1125 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218Ab2JAU5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 16:57:47 -0400
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id q91Ku67k029663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Oct 2012 22:56:07 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vr4piaryi.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206766>

On 01/10/12 21:54, Junio C Hamano wrote:
> Now you lost me.  The documentation of PROMPT_COMMAND in "man bash"
> says this:
> 
>        PROMPT_COMMAND
>               If set, the value is executed as a command prior to
>               issuing each primary prompt.
> 
> So yes, if you say "PROMPT_COMMAND='whatever'", you will get output
> from 'whatever' followed by what $PS1 would normally give you.  
> If you do not want to see PS1 after 'whatever' gives you, you have
> to set it to an empty string.
> 
> On the other hand, they way people have been using __git_ps1 is (as
> described in the prompt script) to do something like this:
> 
> 	PS1='...cruft... $(__git_ps1 "%s") ...cruft...'
> 
> To keep supporting them, __git_ps1 has to be a function that writes
> the prompt string to its standard output.  The external interface of
> PROMPT_COMMAND also is that it wants a command that emits the string
> desired for the prompt to its standard output.  I do not see any
> "when it is used like this, X, but when it is used like that, Y"
> kind of issue around it, either.
> 
> So what is the problem????
> 

Well, I hadn't thought about that way of using it. It works in a way...

But PS1 is set and interpreted in a special way by bash (I gather from
examples, I'm kind of confused by it).

It's possible to set PS1 to nothing and print a string from
PROMPT_COMMAND, but then you miss out on all the features of the PS1
interpretation by bash and compared to the use of __git_ps1 at the
moment, it has to put out quite a different string. Because if you like
to see user@host+workdir (git-status)[$#]
the current users of __git_ps1 say PS1="\u@host+\w $(__git_ps1 "%s")\$
", but all __git+ps1 has to put out is "(branch)" or "(branch *)", etc.

If it has to print the same prompt in PC mode, it has to add all the
user/host/workdir/[$#] data as well, withouth being able to use the bash
internal interpretation (because that is only working when PS1 is set).

The example(s) I found when googling for a solution were to set PS1
inside the PC function, in a way that it was possible to add color
encodings, without messing up the wrapping. This is _impossible_ using
command substitution, because then bash doesn't interpret the \[ and \]
around the color codes, and that messes up the accounting of how long
the prompt string is.

/Simon
