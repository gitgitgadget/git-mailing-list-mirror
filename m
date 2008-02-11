From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Mon, 11 Feb 2008 00:12:53 -0800
Message-ID: <7vzlu7ap2y.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
	<7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
	<200802110822.08902.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 09:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTnG-00056D-Ha
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYBKINE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYBKIND
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:13:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYBKINB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:13:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F89F4AD4;
	Mon, 11 Feb 2008 03:12:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 767B44AD3;
	Mon, 11 Feb 2008 03:12:55 -0500 (EST)
In-Reply-To: <200802110822.08902.chriscool@tuxfamily.org> (Christian Couder's
	message of "Mon, 11 Feb 2008 08:22:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73481>

Christian Couder <chriscool@tuxfamily.org> writes:

> Now the 10% are only when we have a boolean variable and we want it to 
> be "false" when there is:
>
> [foo]
> 	var =
>
> while:
>
> [foo]
> 	var
>
> is considered "true".
>
> And let's face it, it's not obvious at all why it should be false if there 
> is "var =" and true when there is only "var". Is it a Microsoft standard ?
> Do we really care about it ?
> ...
> I also doubt that many users willingly use "var =" to mean "false".

Some variables started their life as boolean and "[foo] var" is
true and "[foo] var = false" (or "= 0") is false for them; later
they acquired third or more options to have string values.

For such a variable:

	[foo] var	    ; boolean "true"
        [foo] var = "true"  ; boolean "true"
        [foo] var = "false" ; boolean "false"
	[foo] var = ""	    ; boolean "false", too.
        [foo] var =         ; perhaps misspelled, perhaps the same as above.
	[foo] var = "value" ; string (new semantics)

and adding a warning for the fifth one (but not fourth one)
might be a good idea.

I have a bit stronger opinion on keeping "[foo] var" (without an
equal sign) to stay "true".  Especially, making it exactly the
same as an empty string is unacceptable, if it is done without
Linus's trick to make it distinguishable internally.

Luckily, the calls to get_config_set() we internally make
in-tree (e.g. git-init sets core.filemode and friends) are all
very explicit and do not write "[foo] var" form of truth.  But
many existing docs written outside our (my) control that google
finds say "Put '[core] autocrlf' in your .git/config".  You do
not want to break the repositories configured following such an
advice.

> So let's do them (and ourself too) a favor and deprecate "var =" to mean 
> false. I will post my patch to do this.

Don't do it if you cannot differentiate between the fourth and
the fifth in the above listing.
