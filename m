From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Fri, 30 Nov 2007 18:37:06 -0800
Message-ID: <7vhcj387jh.fsf@gitster.siamese.dyndns.org>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
	<7voddl24b7.fsf@gitster.siamese.dyndns.org>
	<47464A90.4030509@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, francois@debian.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEh-0003qY-C2
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758669AbXLAChP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758656AbXLAChO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:37:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40341 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbXLAChM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:37:12 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B9E672EF;
	Fri, 30 Nov 2007 21:37:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 10B7A9B9F0;
	Fri, 30 Nov 2007 21:37:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66688>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Junio C Hamano wrote:
>>> The http_proxy / HTTPS_PROXY variables used by curl to control
>>> proxying may not be suitable for git.  Allow the user to override them
>>> in the configuration file.
>>> ---
>>>   In particular, privoxy will block directories called /ad/ ... d'oh!
>>> +++ b/Documentation/config.txt
>>> +http.proxy::
>>> +	Override the HTTP proxy, normally configured using the 'http_proxy'
>>> +	environment variable (see gitlink:curl[1]).
>> 
>> This may work around the issue you cited, but it makes me wonder
>> if it is a road to insanity.  Does the curl library expect that
>> (1) each and every HTTP talking application that uses the
>> library offer this kind of knob for its users to tweak, and (2)
>> users set the knob for each and every one of such application?
>
> This is true.  However I still think that it is a useful feature for
> many users, with few side effects.  If nothing else the bit on the man
> page will prompt them to think, "oh, I should set that in the environment".
>
>> I would say if privoxy cannot be tweaked to allow /ad/ in chosen
>> context (e.g. /ad/ in general is rejected but /objects/ad/ is
>> Ok), that is what needs to be fixed.
>> Or it would be the use of such a broken proxy by the user.  That
>> can be fixed and much easily.
>
> Yes - but consider the dilemma of the user.  They've apt-get installed
> this privoxy thing and figured out how to set their applications to use
> it.  Now, it doesn't work and they think it is the proxy in the way, and
> they've no idea that they might be able to reconfigure it.  This way
> they can tell git to bypass it.
>
> I don't know, I see your point and pretty much agree with it.  It just
> seems like something that might come in handy (as well as be another
> vector for something you need to check when you get HTTP fetch issues -
> so maybe a command-line option would be better).
>
> Actually something that would really have helped is more documentation
> of the various GIT_CURL_* environment variables available for debugging.

Having thought about this a bit more, I changed my mind.  From the
beginning, I did not mind adding a dozen or so lines if the change helps
the user.  I was not _fundamentally_ opposed to your patch.

However.

There may be other environment variables that the users may want to set
differently when running git from the settings they use in their
interactive sessions.  We have precedentsto support such situations in
the form of git-specific environment variables (e.g. GIT_EDITOR and
GIT_PAGER).  These might have been a road to insanity already, and what
we should have done may be to introduce multivalued core.environment
variables in $HOME/.gitconfig, like so:

	[core.environment]
        	EDITOR = vim
		PAGER = less

without introducing GIT_foo environment variables.  We can then change
the git potty[*1*] start-up sequence to add them to the enviornment.  But
this is a bit like water under the bridge now.

While that approach could work for environment variables that apply
globally to any and all git sessions the user may run, I suspect it
would not work well for things like http_proxy.  If we really wanted to
help users, I think it should be tied to which remote we are going to,
just like we made git-send-email to use different mailpath depending on
which project you are communicating with.

In that sense, I think http.proxy configuration variable does not go far
enough, even though it might be a step in the right direction.  Perhaps
use your configuration variable http.proxy (or "core.environment") to
define the global default, with remote.$name.httpproxy to override it?


[Footnote]

*1* git(7) calls "git" itself as "git potty".  Is this word still used?
I also notice that Andreas's name is misspelled there.
