From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 05 Jun 2008 00:57:39 -0700
Message-ID: <7vtzg82u18.fsf@gitster.siamese.dyndns.org>
References: <200806050128.33467.bombe@pterodactylus.net>
 <alpine.DEB.1.00.0806050103520.21190@racer>
 <200806050848.43462.bombe@pterodactylus.net>
 <alpine.DEB.1.00.0806050758210.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?B?4oCYQm9tYmXigJk=?= Roden 
	<bombe@pterodactylus.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4AMw-0004B1-WB
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 09:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYFEH5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbYFEH5y
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 03:57:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYFEH5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 03:57:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E35DD2B76;
	Thu,  5 Jun 2008 03:57:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F05962B75; Thu,  5 Jun 2008 03:57:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806050758210.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 08:15:01 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 185D89EC-32D5-11DD-BA5C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83875>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Usually, this comes before the "---", and your comments/answers after it.  
> And the first line would be the subject:
>
> -- snip --
> Handle http urls with query string ("?foo") correctly
>
> Git breaks when a repository is cloned from an http url that contains a
> query string. This patch fixes this behaviour be inserting the name of
> the requested object (like "/info/refs") before the query string.
> -- snap --
>
> And of course, you usually sign off your patches.

Please wait a minute and step back.

Before going into the presentation, I have a strong doubt about what this
is trying to solve.

Without reading the patch at all (and the lazyness is only half the reason
for not reading the patch before thinking about the issue --- it is also a
good lithmus test to make sure that the commit log explains what is done
well), my understanding is that this peculiar http-hosted git repository
takes:

	http://foo.bar.xz/serve.cgi?repo=foo.git/

as the base URL, and the patch author wants us to ask for (for example)
"info/alternates" as

	http://foo.bar.xz/serve.cgi/info/alternates?repo=foo.git/

or something like that, not the usual:

	http://foo.bar.xz/serve.cgi?repo=foo.git/info/alternates

Two comments.

 (1) If that is not the problem being tackled, the commit log needs to
     explain the issue much better.  "git breaks" is obviously not good
     enough to convey the issue to me, and if the description was not
     clear for me to understand what is being fixed, it has no hope to
     explain the fix to other people.

 (2) If that is indeed the issue being tackled, sorry, it is not how "dumb
     protocol" http server is expected to behave.  Your server needs
     fixing.

If the protocol being used is still the "dumb commit walker" protocol,
then, given the base URL of the repository $URL, "info/refs" must exist at
"$URL/info/refs", and a loose object deadbeef... must exist at
"$URL/objects/de/adbeef...".  That's how the protocol is defined.

If we want to have a CGI on the server side, the client _could_ even talk
"git native" protocol or something similar to it.  But that is not what is
attempted with this patch as far as I can tell.
