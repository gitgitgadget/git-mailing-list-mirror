From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 12:26:12 -0800
Message-ID: <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 21:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDmwS-0003nm-V5
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 21:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYALU02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 15:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbYALU01
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 15:26:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYALU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 15:26:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ACEB5BF7;
	Sat, 12 Jan 2008 15:26:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B0085BF5;
	Sat, 12 Jan 2008 15:26:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70359>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> Ahh.
>>
>> Does that suggest the new configuration thing is only about the
>> "submodule update" command, not "remotes.default" that affects
>> how the non-submodule merge and fetch works?
>>
>>
> Yes - this patch set was inspired by the single question of "how do I
> avoid needing to define origin as opposed to a server-specific
> nickname now that I am using sub-modules?"

If it is truly only about "submodule update" then the change
seems too intrusive, especially "remotes.default" variable that
affects the way how fetch and merge works in situations that do
not involve submodules.

If it is not limited to "submodule update" but equally valid fix
to non-submodule situations, the changes to the other parts may
very well be justifiable, but that would mean your "Yes" is a
lie and instead should be "No, but these situations are helped
by these changes because...".

In any case, let's step back a bit.

Earlier you said in a response to Dscho that your servers are
named consistently across repositories.  servername.foo.bar has
nickname servername everywhere.

If your top-level repository needs to access a specific server
"frotz.foo.bar" for updates, then you would have bootstrapped
the whole thing with:

	$ git clone git://frotz.foo.bar/toplevel.git

and in that particular instance of the repository, the source
repository on frotz.foo.bar would have been known as 'origin',
right?  I would not object if you also gave another nickname
'frotz' to the same repository for consistency across
developers.

If that is the case, I am wondering why your subprojects are not
pointing at the corresponding repository on that same
'frotz.foo.bar' machine as 'origin'.  I suspect the reason is
that .gitmodules do not say 'frotz.foo.bar' but name some other
machine.

And in-tree .gitmodules can name only one URL, as it is project
global and shared by everybody.  There is no escaping it.

At least as things were designed, "git submodule init" takes URL
recorded in .gitmodules as a hint, but this is for the user to
override in .git/config in the top-level.  Maybe the UI to allow
this overriding is not easy enough to use, and your submodules
ended up pointing at wrong (from the machine's point of view)
URL as 'origin'.  And perhaps that is the root cause of this
issue?

I am looking at the discussion on the list archive when we
discussed the initial design of .gitmodules:

    http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47502
    http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47548
    http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621

I do not think we are there yet, and suspect that the current
"git submodule init" does not give the user a chance to say "the
URL recorded in the in-tree .gitmodules corresponds to this URL
in this repository for administrative or network connectivity or
whatever reasons".

Maybe that is the real issue that we should be tackling.  I
dunno.

Although I _think_ being able to use nickname other than
hardcoded 'origin' for fetch/merge is a good change, if my above
suspicion is correct, that change alone would not make the life
easier to people who _use_ submodules, as the need for them to
set up extra nicknames (like 'frotz') and configure the
submodule repositories to use that specific nickname instead of
'origin' would not change.

For communication purposes, I would agree with Dscho that the
name 'origin' that names different things for different people
is wrong and using specific name 'frotz' would solve
communication issues.  But when using the repository and doing
actual work, wouldn't it be _much_ better if you can
consistently go to a repository on a random machine and always
can say 'origin' to mean the other repository this repository
usually gets new objects from (and sends its new objects to)?
