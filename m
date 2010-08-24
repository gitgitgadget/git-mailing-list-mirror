From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reducing object store size with remote alternates or shallow
 clone?
Date: Tue, 24 Aug 2010 09:45:33 -0700
Message-ID: <7vhbikx8lu.fsf@alter.siamese.dyndns.org>
References: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Tue Aug 24 18:45:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnwdE-0006yp-Gh
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 18:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab0HXQpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 12:45:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab0HXQpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 12:45:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53098D0811;
	Tue, 24 Aug 2010 12:45:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eOvO1xyTvQCqzOOg4Wj27C0Qdo=; b=FcW5Ht
	QK4ME10ORRPh47VxF0E4ohZTnQlhGdwvPrPD/aA1u3xKc/hC157uyrQZv0jDQ+RE
	HsyW8LlXTFH2d+EhUimD1VFG1z8ozoYdfJkPT+T5rjcZRI0b1lCLNmIki3oTq70i
	9AN5Mq079BQ6TBt+qnStolU2UI84DPoTOwVxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gpa8NufY7zD/cvTLUuzP1Pghvw/Z4ydS
	rM01N5r+Jps0eh0RPRfx5888SWLvhGc4B6eKf7FBf/nUMfebt6Zac9JAlD/ZrLYh
	I31Hs0OnlZb+0Bn8NI7ICBBueBLIwOnFi2dWfMGm0eQU9jWqgwfQnWSjVECPz+NM
	cO2zGOrg9Ho=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28E92D080F;
	Tue, 24 Aug 2010 12:45:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54191D080E; Tue, 24 Aug
 2010 12:45:35 -0400 (EDT)
In-Reply-To: <14526ED4-F65C-4DF2-ABDD-BF1E76DAC2B0@kernel.crashing.org>
 (Kumar Gala's message of "Tue\, 24 Aug 2010 01\:59\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06183A5E-AF9F-11DF-A40B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154322>

Kumar Gala <galak@kernel.crashing.org> writes:

> I'm trying to package a linux kernel source tree and would like to just
> tar up a tree with .git/.  However this is a bit problematic as the size
> of tgz is about 500M which exceeds the limit of the image I'm trying to
> produce.
>
> I was wondering if anyone had a means to reduce the size drastically.
> I'm ok if a post processing step is required to get full git support.
> One idea I had was doing a shallow clone and if there was some means to
> "reconnect" it to a full work state after the fact.

Although your message body does not state your design constraints clearly,
your subject line hints that you are fine with a solution that involves
use of remote alternates by the recipient of your tarball.

I am _guessing_ that you have a fork from some well known tree and want to
sneakernet it to your recipients (iow, they do not "git pull" from your
repository).

How about doing

    $ LINUS=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    $ git fetch $LINUS
    $ git bundle create myfork.bundle HEAD..master

and sending the thing over?  The recipient would then do something like:

    $ LINUS=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    $ git clone $LINUS linux
    $ cd linux
    $ git pull /tmp/myfork.bundle master
