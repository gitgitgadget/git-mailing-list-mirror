From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 03 Jul 2008 14:26:50 -0700
Message-ID: <7v7ic2zmjp.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
 <7vfxqr2won.fsf@gitster.siamese.dyndns.org>
 <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
 <56b7f5510807031127j10e33f3bl516180f7a9b5b5db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric Raible" <raible@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWLS-0005Ge-Po
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYGCV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYGCV1E
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:27:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYGCV1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:27:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F17BB1202C;
	Thu,  3 Jul 2008 17:27:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0072512029; Thu,  3 Jul 2008 17:26:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C60575E6-4946-11DD-8372-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87322>

"Dana How" <danahow@gmail.com> writes:

> I was surprised to see Dscho advocating removing this feature altogether.
> Others proposed other command sequences which avoided :/ .
> If :/ is now going to be extended and thus perhaps more likely to
> appear in scripts,
> is now the time to change it to ? which has no other special meaning to git?

There are number of problems with ":/" notation, but my biggest gripe is
that it is only slightly better than "give back a random commit".  You
cannot even tell it to "dig from these branch tips, look for the first one
that talks about this text".

As Dscho mentioned, --grep works much better and instead of saying:

    $ git diff ':/send-email' HEAD

we can say:

    $ git diff \
      $(git log --pretty=format:%H -1 --grep=send-email master next) HEAD

The error behaviour is somewhat different between the two, though.  When
you misspell what to grep, the command substitution will give empty and
you would get an unexpected result.  Being built-in, ':/' syntax can say
"I do not find anything that match" fairly easily, and the command
substitution version has to say something ugly like:

    $ git diff \
        $(
            x=$(git log --pretty=format:%H -1 --grep=send-email master next)
            case "$x" in
            ('') echo 0000000000000000000000000000000000000000 ;;
            (?) echo $x ;; esac
        ) HEAD

to get a similar effect.

But the point is that you can extend it easily with the :path suffix if
you wanted to:

    $ git show \
        $(git log --pretty=format:%H -1 --grep=send-email):git-send-email.perl

You can even alias "log --pretty=format:%H -1" if you wanted to, and use
revision limiter other than --grep, like this:

    (in .git/config)

	[alias]
        	pick = log --pretty=format:%H -1

    $ git diff --stat $(git pick -- Documentation)^
    $ git blame $(git pick pu -- remote.c) remote.c

So in short, ':/' is limited (cannot be suffixed with :path, cannot be
told to dig down from named revs, etc.) but you can do what ':/' cannot do
fairly easily with command substitution.

However, $(git pick --all --grep=something), without suffixed modifiers
such as ~$N and :$path, may still be common enough that it might deserve a
short-hand ':/' (and that is why we have it).

If people do not find that short-hand useful, I am not strongly opposed to
the idea of dropping it.  I personally find the notation not very useful
cute hack anyway ;-).
