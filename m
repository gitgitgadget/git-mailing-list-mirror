From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 04 Dec 2008 13:34:22 -0800
Message-ID: <7vskp3d3q9.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
 <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
 <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, sverre@rabbelier.nl,
	"Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8LrS-00054q-IN
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 22:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbYLDVee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 16:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755184AbYLDVee
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 16:34:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYLDVed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 16:34:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2835E84FFF;
	Thu,  4 Dec 2008 16:34:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5DF5684FFB; Thu,
  4 Dec 2008 16:34:25 -0500 (EST)
In-Reply-To: <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
 (Jeremy Ramer's message of "Thu, 4 Dec 2008 13:54:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 568ED724-C24B-11DD-AAA0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102369>

"Jeremy Ramer" <jdramer@gmail.com> writes:

> On Thu, Dec 4, 2008 at 12:04 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
>> On Thu, Dec 4, 2008 at 17:05, Jeremy Ramer <jdramer@gmail.com> wrote:
>>> That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
>>> message every time I start git gui.  I actually find this really
>>> annoying and would like a way to turn this warning message off.
>>
>> git config --global user.name "Your Name"
>> git config --global user.email "you@example.com"
>>
>
> I have done that.  I still get the warning message every time I start git gui.

I do not use Windows, and I do not run git-gui, so I am guessing only from
the source.  Are you talking about the message composed by this part?

    # -- Warn the user about environmental problems.  Cygwin's Tcl
    #    does *not* pass its env array onto any processes it spawns.
    #    This means that git processes get none of our environment.
    #
    if {[is_Cygwin]} {
            set ignored_env 0
            set suggest_user {}
            set msg [mc "Possible environment issues exist.

    The following environment variables are probably
    going to be ignored by any Git subprocess run
    by %s:

    " [appname]]

The logic to produce the error message does look somewhat screwy.

It checks a selected set of variables whose name begin with GIT_ in the
environment, and if it finds any, it gives the above message.  In
addition, if GIT_{AUTHOR,COMMITTER}_{EMAIL,NAME} are among them, it also
adds this to the message:

                    if {$suggest_user ne {}} {
                            append msg [mc "
    A good replacement for %s
    is placing values for the user.name and
    user.email settings into your personal
    ~/.gitconfig file.
    " $suggest_user]

There are two and half issues about this code.

 (1) When it prepares additional message about user.{email,name},
     it does not check if the user already has them defined.  IOW, there
     is no way other than unsetenv before running git-gui to squelch this
     part of the message.

 (2) For other environment variables, such as GIT_PAGER, it does not offer
     alternatives, such as core.pager.  Again, there is no way other than
     unsetenv to squelch the warning.

An excuse to both of the above could be that the warning is not about the
user having environment variables that can be discarded, but about
brokenness of Cygwin Tcl envirnonment that discards them.  But if that is
the case, there is this other half issue:

 (3) The warning does not trigger if the environment is not set when this
     check is made.  Now I do not know if git-gui tries to spawn
     subprocesses with its own (customized) environment settings (e.g. you
     would need to be able to run git-commit-tree with modified
     GIT_AUTHOR_NAME if you want to use the lowlevel plumbing to create a
     new commit and lie about the author identity), but if it does, the
     warning does not trigger.
