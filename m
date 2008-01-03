From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and securing a repository
Date: Thu, 03 Jan 2008 01:36:48 -0800
Message-ID: <7vzlvns11r.fsf@gitster.siamese.dyndns.org>
References: <477B39B5.5010107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201>
	<20080103035838.GA24004@spearce.org>
	<200801031011.29050.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAMW2-0004MH-Ma
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbYACJhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 04:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYACJhE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:37:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbYACJhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 04:37:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E23A321A9;
	Thu,  3 Jan 2008 04:36:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB4021A8;
	Thu,  3 Jan 2008 04:36:55 -0500 (EST)
In-Reply-To: <200801031011.29050.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 3 Jan 2008 10:11:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69519>

Jakub Narebski <jnareb@gmail.com> writes:

> Shawn O. Pearce wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote:
>   
>> > AFAIK both update and pre-receive hooks are invoked also on fetch...
>> > but I might be mistaken.
>> 
>> No, they are *not* invoked on fetch.  Currently no hooks execute
>> during fetch; either on the server *or* on the client side of
>> the connection.
>
> Errr... I think at least post-update hook (the one with 
> git-update-server-info by default) is invoked on fetch.

Please don't think then.  Instead check your facts before
posting to avoid wasting bandwidth and people's time.  The
post-update hook is run on the remote end when you push into it.

I do not particularly like hooks that act after an operation is
initiated locally and act solely on local data.  This is maybe
because I still consider git tools building blocks suitable for
higher level scripting more than other people do.

There are five valid reasons you might want a hook to a git
operation:

 (1) A hook that countermands the normal decision made by the
     underlying command.  Examples of this class are the update
     hook and the pre-commit hook.

 (2) A hook that operates on data generated after the command
     starts to run.  The ability to munge the commit log message
     by the commit-msg hook is an example.

 (3) A hook that operates on the remote end of the connection
     that you may not otherwise have access to other than over
     the git protocol.  An example is the post-update hook.

 (4) A hook that runs under a lock that is acquired by the
     command for mutual exclusion.  Currently there is no
     example, but if we allowed the update hook to modify the
     commit that was pushed through send-pack => receive-pack
     pair, which was discussed on the list a while ago, it would
     be a good example of this.

 (5) A hook that is run differently depending on the outcome of
     the command.  The post-merge hook conditionally run by
     git-pull is an example of this (it is not even run if no
     merge takes place).  Another example is the post-checkout
     hook that gets information that is otherwise harder to get
     (namely, if it was a branch checkout or file checkout --
     you can figure it out by examining the command line but
     that already is part of the processing git-checkout does
     anyway, so no need to force duplicating that code in the
     userland).

You cannot do an equivalent operation from outside the git
command for the above classes of operations.  You need hooks
for them.

On the other hand, if you want to always cause an action after
running a git opeation locally, you do not have to have a hook.
You can just run them yourself, or have "git myfetch" wrapper
that does whatever you want after running "git fetch".  Only
when the combination of the underlying command and something
else is widely useful, _and_ that something else needs
flexibility, a hook is warranted (if that something else is
always the same thing, it is better to fold that into the
underlying command).
