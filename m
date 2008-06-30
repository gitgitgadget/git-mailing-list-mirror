From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 15:48:49 -0700
Message-ID: <7vy74mtu7i.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
 <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:50:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSC9-0006nN-KX
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144AbYF3WtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933088AbYF3WtE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:49:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015AbYF3WtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:49:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9395018CB9;
	Mon, 30 Jun 2008 18:48:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A6D1118CB4; Mon, 30 Jun 2008 18:48:51 -0400 (EDT)
In-Reply-To: <7v3amuv8yg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Jun 2008 15:44:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA8144AE-46F6-11DD-8855-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86955>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Before this patch "git bisect" doesn't really work when it is given
>> some good revs that are siblings of the bad rev.
>>
>> For example if there is the following history:
>>
>> A-B-C-D
>>    \E-F
>>
>> and we launch "git bisect start D F" then only C and D will be
>> considered as possible first bad commit. This is wrong because A, B and
>> E may be bad too if the bug exists everywhere except in F that fixes it.
>
> Please don't.
>
> bisect is about finding a single regression by partitioning the graph into
> older good section and newer bad section with a *single* "first bad
> commit".
>
> Your "this could also be possible" scenario is already outside the
> realm.  You are assuming A, B and F is good, and D is bad.  But if E is
> bad, then that breakage cannot possibly affect the transition between B
> and D from good to bad (E cannot break D), so C must *also* be bad.

... which means you are dealing with *two* breakages.  That's outside what
bisect deals with.

And this does not need to have forked development.  If the graph were like
this:

  A-B-C-D-E-F

and if F is bad and B is good, with your logic, after checking that D is
already bad, we cannot discount E --- after somehow fixing D, we _might_
also be introducing another breakage with E.  You cannot even check for
that anyway, but the logic is the same.
