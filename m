From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 13:51:41 -0700
Message-ID: <7vwslfzd0i.fsf@gitster.siamese.dyndns.org>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
 <alpine.DEB.1.00.0805271151430.30431@racer>
 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
 <alpine.DEB.1.00.0805271411520.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 22:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K16AN-00056E-On
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759004AbYE0Uvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758851AbYE0Uvz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:51:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758101AbYE0Uvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:51:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 568E51C22;
	Tue, 27 May 2008 16:51:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7F2561C21; Tue, 27 May 2008 16:51:49 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805271411520.30431@racer> (Johannes
 Schindelin's message of "Tue, 27 May 2008 14:12:44 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC7D134C-2C2E-11DD-8E7C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83049>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > However, I think it would make sense to push for that 
>> > .dotest,.git/.dotest-merge -> .git/rebase change _before_ having 
>> > anything like git-whazzup.sh.
>> 
>> That's a problem of the single command approach.
>
> Sure it is.  But cluttering up the commands for something that is not 
> really proven to be wanted by many is IMO inferior.

I do not necessarily see them as cluttering, although I'd agree that
changes to some scripts may look a bit too intrusive.

You _could_ argue that the handling of --what option is part of the
protocol for commands that want to implement a workflow with sequencing
elements, just like we have a protocol for commands that want to work from
a subdirectory is to call setup_git_directory() to have it cd up to the
top of the work tree and prepend the prefix to all user supplied paths.

However, that new protocol this patch introduces need to be documented
clearly.  It's the new contract "git-what" wants to impose on commands
with sequencing elements.

But a problem I see with the patch as an implementation of "git-what" is
that some commands use other commands as their internal implementation
details.  For example, when you are in the middle of a "git rebase"
session, which might be using "git am" as its internal implementation
detail, if you ask the "are you in the middle of doing something, and if
so how can I continue?" question (which is what the "git-cmd --what" is
all about) to "git am", before you ask the same question to "git rebase",
"am" could say "Yeah, I have applied a few patches successfully but gave
control back to the user to resolve conflicts while applying this patch",
which may be a truthful statement from "git am"'s point of view, but is
not a useful information from the end user's point of view, as all s/he
typed was "git rebase".  In addition, if Porcelain X uses Porcelain Y as
its internal implementation, the series of commands that need to be
followed to continue from a particular sequence point might be different
between the case where the toplevel request was Y and the case where it
was X.  Not just X needs to know that it uses Y, Y also needs to know that
the toplevel command the end user gave could be X which called it and
behave differently.  So a nice "each command knows what its doing"
separation cannot really solve everything in practice.

In other words, "git-X --what" could give a guidance to the "I've done X,
now what can I do?" situation, but it by itself cannot be used as a basis
of "git-what" to answer "I'm totally lost and I do not know what I was
doing.  Where was I and what should I do next?"  question.
