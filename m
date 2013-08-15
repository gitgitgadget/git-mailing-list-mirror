From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash takes excessively long when many untracked files present
Date: Thu, 15 Aug 2013 11:58:33 -0700
Message-ID: <7vioz6rdba.fsf@alter.siamese.dyndns.org>
References: <20130810214453.GA5719@jtriplet-mobl1>
	<loom.20130813T120243-481@post.gmane.org>
	<7v7gfpy0wy.fsf@alter.siamese.dyndns.org>
	<1fc732a7-6b63-4d75-960f-0b1c6cf9c70e@email.android.com>
	<7vmwolwk94.fsf@alter.siamese.dyndns.org>
	<7v61v9w9dy.fsf@alter.siamese.dyndns.org>
	<7vr4durgd4.fsf@alter.siamese.dyndns.org>
	<20130815180736.GA4093@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Darander <anders.darander@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 20:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA2kr-0003cd-H2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 20:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab3HOS6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 14:58:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab3HOS6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 14:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1977B393B7;
	Thu, 15 Aug 2013 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YW7XYd6nRpdabhwoTLwIVXIgqXI=; b=rDxCFv
	gkdz+x3Q6p4m6AUopDgfTwZHq5s3F0Q8aqogjrmTNCFBT2E9SyxQUOrW+tR9yNqC
	vCrl+PYCO4vA7xjvdsDv8uxvd8PvScUxk4I78oh3q5WOcz/Uw4T0xGIoZG2ZqN/7
	o/4h8DqPcRfYoWI+yiiKc3yN+NF67tJ9sCnaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=POOqXWzdzRyrbCF4QJjzQsqGQEUZ9/An
	qy4TArNVDOAoMDneJObpCSYjx7mjWIQwdHSCr2TCT5Wqy8DcAcyhLBzn39dwQRyJ
	yKLa9vhUvxPORZK62NHMJO4caOQYfXw9+EPxm8KkbgK5p+fZjgi2b+EviqS8dewG
	kSY3S18ohrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D559A393B6;
	Thu, 15 Aug 2013 18:58:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E28393B4;
	Thu, 15 Aug 2013 18:58:34 +0000 (UTC)
In-Reply-To: <20130815180736.GA4093@jtriplet-mobl1> (Josh Triplett's message
	of "Thu, 15 Aug 2013 11:07:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFAB6A3C-05DC-11E3-9FF3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232362>

Josh Triplett <josh@joshtriplett.org> writes:

>> I've already reverted the problematic patch to "git stash" and it
>> will not be part of the upcoming release.
>
> Thanks!
>
>> Here is a quick attempt to see if we can do better in "ls-files -k".

Having said that, I am curious if the result of applying the patch
you are responding to, without reverting the "git stash" patch, is
now usable in the working tree you earlier had trouble with.

> Sure, that works.  However, wouldn't it make sense to just directly let
> git ls-files output to the screen, then test its return value (after
> adding some ls-files option to set the return value)?

Not really.

We may want to add "exit early if we see even a single killed file"
option to the command so that we can simplify the "are we going to
abort" logic, but the error codepath that is executed after that
decision is made is not performance critical, and may need more
flexibility than always spewing everything that will be killed,
which could be thousands of crufts.  So I think using two separate
invocations to "ls-files --killed" is a necessity anyway.
