From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 10:09:15 -0700
Message-ID: <xmqqiommadl0.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
	<vpqlhrjqmyw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAMWZ-00076R-KU
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 19:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbaGXRJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 13:09:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57991 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbaGXRJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 13:09:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C39E42AD66;
	Thu, 24 Jul 2014 13:09:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6n0Hkk7r8kI/m4m8aEDZV+fgYmY=; b=Rhw5mP
	vDJzI+Ab2T1gOE2VUG29XICpaE0flvOSiXgl0zrOoEnb0goaoFJNPI9qiZHuFgV6
	9Dh7mdA/ly6BEEVjUO/hdw6zStDEyef6Kir3cueUqEldVzC+Ku2c5hlREMdNvJCi
	9nd0PM4k5MU7Oln0YUFNSQSC7kxYooGq35H48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GDxkF9ofOXcZhQi2swVv/SOCA9k9OdHO
	IwoLc7wS9TFvDSyNWGrsuMahXAihD/H6jpTEsIjAV5vAwfKD2NUz/P/pJ2ql7CxC
	0HejhqVO/SEZXOIfVGH19gbeKBKVRDvYNxnujhyqFKdzbA8K7N8cq0zOMrM0R4pO
	iaDK6JuPBfo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B89FD2AD65;
	Thu, 24 Jul 2014 13:09:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D5F132AD39;
	Thu, 24 Jul 2014 13:09:17 -0400 (EDT)
In-Reply-To: <vpqlhrjqmyw.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	24 Jul 2014 08:39:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F0C6790-1355-11E4-AD15-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254169>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> in my ~/.gitconfig and then for a particular project I wanted to use
>> a custom pattern in its .git/config but it was sufficient to define
>> the pattern without using extended regexp, I would be tempted to say
>>
>> 	diff.foo.funcname "Wine$"
>
> The point is: to do that, you need to know that funcname exists, hence
> read archives of the doc before 2008 (it disapeared in
> 45d9414fa5599b41578625961b53e18a9b9148c7) or read the code. And if I
> read correctly the commit message for the commit, funcname is not
> portable so you should use xfuncname anyway.
>
> The real reason for this change is to let the code work with the new
> git_config, but I think it's reasonable not to bother with the original
> behavior for a feature deprecated so long ago.

We may be able to explain funcname vs xfuncname away, but the
problem is much deeper, and it is not just you and Tanay, but
anybody who thought that it is a natural and logical conclusion
to emulate git_config() by iterating over in-core hashtable X-<

We have assumed that it is OK for git_config() to call its callbacks
with any random order of keys as long as the values for the same key
are given in the same order as the original "read from file every
time" implementation would have called.  The assumption overlooked
the possibility that values given to two different keys can
semantically interact.  $foo.funcname and $foo.xfuncname being two
different ways to define the same piece of information is merely one
of the many ways such interactions can happen.  For example, by
assuming that orders of callbacks across keys does not matter, we
would be breaking scripts that expected to be able to deal with
something like this:

	[character]
        	name = Snoopy
                color = white black

                name = Hobbes
                color = yellow white black

For *our* own data, we can force them to be spelled this way instead:

	[character "Snoopy"]
        	color = white black
	[character "Hobbes"]
        	color = yellow white black

but that misses the point, as our config file format and its
semantics are not only about .git/config but the system is designed
and promoted to be a way for third-party applications to store their
own data as well.

Because we do not condone using libgit.a as a library to link into
third-party applications, git_config() at the C level may not have
to read a random third-party data and call its callback in the
predictable way, but this shows us that "git config -l" interface
must return the data in the same order as we have done always by
either using the _raw interface to return things uncached, or
teaching by git_config() to also be predicatable.

> That said, I think the commit message should be improved (recall the
> drawbacks of funcname).

In any case, I agree that the log message and the subject is wrong.
It is not that we want to give xfuncname precedence over funcname;
such a behaviour is undesirable if both were in wide use.  It is
papering over the fallout that comes from the loss of ordering
information, which is imposed by the data structure chosen to
represent a config_set.

I haven't formed a firm opinion whether preserving the order is
necessary at git_config() iteration level yet.  If the only in-core
user that will be broken by not doing so is xfuncname vs funcname,
it may not be too bad, but it will constrain us in the future, which
is a lot bigger problem.  We will be forbidden from correcting a UI
mistake by using the approach we took to transtion "funcname" over
to "xfuncname" (i.e. giving users "funcname" and allowing the
platform BRE parser that may or may not allow the users to write
backslashed ERE is spreading possible incompatibility among the
participants of a project; explicitly stating that the value is ERE
has fewer compatibility issues), while still supporting "funcname"
and have them interact in a sane way.
