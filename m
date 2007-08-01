From: David Kastrup <dak@gnu.org>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 01 Aug 2007 21:08:40 +0200
Message-ID: <85r6mnrs1z.fsf@lola.goethe.zz>
References: <86abtbnzpr.fsf@lola.quinscape.zz>
	<7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJZe-0000zq-OB
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbXHATJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXHATJb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:09:31 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:33300 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753185AbXHATJa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 15:09:30 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 0C4262CB380;
	Wed,  1 Aug 2007 21:09:29 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id D7C4A2DAABA;
	Wed,  1 Aug 2007 21:09:28 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 9431C2BAA2D;
	Wed,  1 Aug 2007 21:09:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A8FBD1C3E076; Wed,  1 Aug 2007 21:08:40 +0200 (CEST)
In-Reply-To: <7vd4y75gcy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 10\:12\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54467>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Actually, splicing $EDITOR into a system command is a nuisance because
>> it means having to shell-quote its arguments.  So the current
>> interpretation is likely easier to maintain.
>>
>> Is it the correct one?
>
> I've been torn on this one.  From the point of view of
> "specified behaviour in the documentation", which is "EDITOR and
> VISUAL name the editor of your choice", not splicing is not
> violating the letter (I am not talking about our documentation
> here, but many other programs').  Splicing and shell quoting
> other parameters, while it is technically not a problem at all
> doing that in scripts, feels "dirty".  Maybe it's just me.
>
> Both cvs and svn seems to splice, I suspect they just do a
> straight system(3) invocation.
>
> We recently normalized the script callers not to splice at all
> (the scripts were hand-rolling "the VISUAL or EDITOR or vi" and
> slightly differently).  It obviously has negative (i.e. setting
> EDITOR to "emacsclient --alternate-editor vi" does not work) as
> well as positive side (i.e. "/home/dak/My Programs/editor" would
> work).

Well, I just checked the behavior with "less", "more", "mail" and
"mailx", quite traditional commands that would not have a reason to
complicate things by using "system" and quoting instead of exec.

less, mail and mailx apparently go via system, more (wtf?!?)
apparently via exec.

Taken together with the behavior by cvs and svn, I think we should not
just throw EDITOR/VISUAL into one exec arg.

Then there are two implementations to pick from:

a) Using system and shell-quoting the filename.  Advantage: one can
set EDITOR='"/home/dak/My Programs/editor"' and have it work.
Disadvantage: shell-quoting a file name seems shell- and
system-dependent.

It turns out all three contestants still in the race apparently do a).
If nobody has a sensible idea how to shell-quote generally enough...
Under Unix, one has the option of using "..." and quoting the three of
"$\ with \ or using '...' and replacing every contained ' with '\''.
I don't think that there is a library function generally available.
The " quote type would probably be more typical.

It turns out that gitk and gitk-wish _already_ do this.  So the
normalization does not seem to have covered them if I read the code
correctly:

proc shellquote {str} {
    if {![string match "*\['\"\\ \t]*" $str]} {
        return $str
    }
    if {![string match "*\['\"\\]*" $str]} {
        return "\"$str\""
    }
    if {![string match "*'*" $str]} {
        return "'$str'"
    }
    return "\"[string map {\" \\\" \\ \\\\} $str]\""
}

Note that the first case does not cover strings with newlines in them,
though, and the second does not help with dollar signs.  And I have no
clue what the last return does.  Presumably maps " to \" and \ to \\
inside of double quotes.

b) splitting EDITOR/VISUAL at spaces and using exec.  Nobody else
appears to do this, so may neither should be.


It appears that the C code already has quote.c, so it is probably more
or less doable.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
