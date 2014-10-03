From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 11:25:29 -0700
Message-ID: <xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>
	<vpqeguptz5k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 03 20:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa7Y2-0001kL-38
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbaJCSZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 14:25:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61262 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbaJCSZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 14:25:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CBE13F37E;
	Fri,  3 Oct 2014 14:25:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Q5aq8xE+a1n30G2b43GeVqySrI=; b=afkD5u
	/dC3NzPGVeq8+6k87Gh1dja5xx+4cdrVweHCQW7iRWeX3pdKQE86fOwm/zlaRqiz
	7bBXWYMytGluPai8XBH194wr4ei2VI53iVNGk4J1KxqCwH04b9qsVZY34Bt7llnG
	QGBD+6khgRouhQDlZ/Rj8kdaf6aTc7OBcnRFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ug8FiMcGcC8ALOpx4biysQVZ8GPVcXpl
	uk9joovhu6NM5BUQFrgNzTFgUXG3hLIpFY3lTR0hhNKWFUPKtPwnYZ7NByEfX/M2
	NI2aYNW5UHrGMOs7VFeWTzARq6M8BjMSOWnaV0CU3CBjPAz8Z1aQ2e/04vbWpLl7
	jwwl29UJsGU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E11323F37D;
	Fri,  3 Oct 2014 14:25:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 968F93F37B;
	Fri,  3 Oct 2014 14:25:30 -0400 (EDT)
In-Reply-To: <vpqeguptz5k.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Oct 2014 09:01:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7F1A768-4B2A-11E4-A8FB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257842>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> Off the top of my head, from an end-user's point of view, something
>> like this would give a behaviour that is at least understandable:

Let's make sure we have the same starting point (i.e. understanding
of the limitation of the current code) in mind.

The "git config [--add] section.var value" UI, which does not give
the user any control over where the new definition goes in the
resulting file, and the current implementation, which finds the last
existing "section" and adds the "var = value" definition at the end
(or adds a "section" at the end and then adds the definition there),
are adequate for ordinary variables.

It is fine for single-valued ones that follow "the last one wins"
semantics; "git config" would add the new definition at the end and
that definition will win.

It is manageable for multi-valued variables, too.  For uses of a
multi-valued variable to track unordered set of values, by
definition the order does not matter.

	Side note.  Otherwise, the scripter needs to read the
	existing ones, --unset-all them, and then add the elements
	of the final list in desired order.  It is cumbersome, but
	for a single multi-valued variable it is manageable.

But the "unset.variable" by nature wants a lot finer-grained control
over the order in which other ordinary variables are defined and it
itself is placed.  No matter what improvements you attempt to make
to the implementation, because the UI is not getting enough
information from the user to learn where exactly the user wants to
add a new variable or "unset.variable", it would not give you enough
flexibility to do the job.

>>  (1) forbid "git config" command line from touching "unset.var", as
>>      there is no way for a user to control where a new unset.var
>>      goes.  And
>
> Well, the normal use-case for unset.variable is to put it in a local
> config file, to unset a variable set in another, lower-priority file.

I agree that is one major use case.

> This common use-case works with the command-line "git config", and it
> would be a pity to forbid the common use-case because of a particular,
> unusual case.

Either you are being incoherent or I am not reading you right.  If
you said "If this common use-case worked with the command-line 'git
config', it would be nice, but it would be a pity because it does
not", I would understand.

If you use the command line 'git config', i.e.

	git config unset.variable xyzzy.frotz

in a repository whose .git/config does not have any unset.variable,
you will add that _at the end_, which would undo what you did in
your configuration file, not just what came before yours.  Even if
you ignore more exotic cases, the command line is *not* working.

That is why I said "unset.variable" is unworkable with existing "git
config" command line.  Always appending at the end is usable for
ordinary variables, but for unset.variable, it is most likely the
least useful thing to do.  You can explain "among 47 different
things it could do, we chose to do the most useless thing, because
that is _consistent_ with how the ordinary variables are placed in
the cofiguration file" in the documentation but it forgets to
question if unset.variable should be treated the same way as
ordinary variables in the first place.

Another use case would be to override what includes gave us.  I.e.

	[unset]
        	variable = ... nullify some /etc/gitconfig values ...
	[include]
        	path = ~/.gitcommon
	[unset]
		variable = ... nullify some ~/.gitcommon values ...
	[xyzzy]
		frotz = nitfol

Special-casing unset.variable and always adding them at the
beginning of the output *might* turn it from totally useless to
slightly usable.  At least it supports the "nullify previous ones",
even though it does not help "nullify after include".

I doubt if such a change to add unset.variable always at the top is
worth it, though.

>>  (2) When adding or appending section.var (it may also apply to
>>      removing one--you need to think about it deeper), ignore
>>      everything that comes before the last appearance of "unset.var"
>>      that unsets the "section.var" variable.
>
> That would probably be the best option from a user's point of view, but
> I'd say the implementation complexity is not worth the trouble.

test_expect_success declares a particular behaviour as "the right
thing to happen" in order to protect that right behaviour from
future changes.  It is OK for you to illustrate what illogical thing
the implementation does as a caveat, and admit that the behaviour
comes because we consider the change is not worth the trouble and we
punted.  But pretending as if that is the right behaviour and the
system has to promise that the broken behaviour will be kept forever
by casting it in stone is the worst thing you can do, I am afraid.

Unfortunately, as I already said, there is no sensible behaviour to
add "unset.variable" from the command line with the current "git
config" UI, so it is not even feasible to define "the right thing to
happen" and to document it as something other people may want to fix
later, e.g.

	test_expect_failure 'natural but not working yet' '
		git config xyzzy.frotz 1
                git config --add xyzzy.frotz 2
                git config --add xyzzy.frotz 3
                : a magic command to add
                :  [unset] variable = xyzzy.frotz 
                : between 2 and 3
		git config xyzzy.frotz >actual
                echo 3 >expect
                test_expect_success expect actual
	'

However, you should be able to arrange in the test to do the
following sequence:

    - Define "[xyzzy] frotz 1" in $HOME/.gitconfig (I think $HOME
      defaults to your trash directory).

    - Verify that "git config xyzzy.frotz" gives "1".

    - Define "[unset] variable = xyzzy.frotz" in .git/config (it is
      OK to use "git config unset.variable xyzzy.frotz" here).

    - Verify that "git config xyzzy.frotz" does not find anything.

    - Define "[xyzzy] frotz 2" in .git/config (again, it is OK to
      use "git config xyzzy.frotz 2" here).

    - Verify that "git config xyzzy.frotz" gives "2".

I think we can agree that the above sequence is something we would
want to support, regardless of how we will change/fix the underlying
config-writer implementation.  Which means that something like the
above can safely be cast in stone with test_expect_success.
