From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Alternative approach to the git config NULL value checking
 patches..
Date: Mon, 11 Feb 2008 12:27:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802111133490.13593@iabervon.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOcRy-0005DZ-DA
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 18:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbYBKR1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 12:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757644AbYBKR1h
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 12:27:37 -0500
Received: from iabervon.org ([66.92.72.58]:45824 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbYBKR1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 12:27:36 -0500
Received: (qmail 22942 invoked by uid 1000); 11 Feb 2008 17:27:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Feb 2008 17:27:30 -0000
In-Reply-To: <7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73555>

On Sun, 10 Feb 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > It may be a bit odd, but it automatically means that codepaths that simply 
> > don't want to care about the subtle difference between "true" and "empty" 
> > will just automatically work, because to them the two cases will look 
> > identical, because the strings will compare the same - they have the same 
> > data, just different addresses.
> 
> I should have mentioned the reason why I did not suggest doing
> it this way in my [Janitor] message.
> 
> It is not "suttle difference between true and empty".  Empty
> means false, and with this approach, it switches the meaning of
> valueless form of config to quite the opposite.
> 
> In addition to fixing existing breakages, a piece of code that
> knew NULL is true and empty is false and coded accordingly, i.e.
> 
> 	if (!value)
>         	Ah we have true;
> 	else if (!*value)
>         	Ok this is false;
> 	else if (!strcmp(value, "something special")
>         	Ok, this is not bool but special;
> 	else
>         	return git_config_bool(var, value);
> 
> will now need to be changed to:
> 
> 	if (value == config_true)
>         	Ah we have true;
> 	else if (!*value)
>         	Ok this is false;
> 	else if (!strcmp(value, "something special")
>         	Ok, this is not bool but special;
> 	else
>         	return git_config_bool(var, value);

Shouldn't it be simply:

	if (!strcmp(value, "something special"))
		Ok, this is not bool but special;
	else
		return git_config_bool(var, value);

That is, don't check for special true or special false at all, but have 
git_config_bool() sort them out? And Linus's code means that you can do 
the strcmp without worrying about getting a segfault on special true.

> if you do this.  And the code that was already broken:
> 
> 	if (!strcmp(value, "somevalue")
> 		Ok let's use somevalue;
> 	else if (!strcmp(value, "someothervalue")
> 		Ok let's use someothervalue;
> 	else
>         	die("oops we do not understand '%s'", value);
> 
> still need to be fixed to:
> 
> 	if (value == config_true)
>         	die("oops '%s' is not a bool", var);
> 	else if (!strcmp(value, "somevalue")
> 		Ok let's use somevalue;
> 	else if (!strcmp(value, "someothervalue")
> 		Ok let's use someothervalue;
> 	else
>         	die("oops we do not understand '%s'", value);

If it isn't changed, you'd get the message "oops we do not understand ''" 
for either true or false empty values, which seems, if anything, better.

	-Daniel
*This .sig left intentionally blank*
