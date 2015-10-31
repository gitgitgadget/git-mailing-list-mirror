From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Sat, 31 Oct 2015 10:31:23 -0700
Message-ID: <xmqqsi4rhrmc.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<1446046920-15646-1-git-send-email-lfleischer@lfos.de>
	<xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
	<20151031084917.26006.98611@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa03-00072c-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbbJaRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:31:27 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbbJaRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:31:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29F4625682;
	Sat, 31 Oct 2015 13:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7zvbxVEbd6u811Ll2CxWhNsAuY=; b=d4CzwG
	g1jplhIzYttpl5yy3/ZmKlIJDG6vkdEHSQn/MWXitxA7fczx8FHYdJIKkG/NIteI
	95maMOi28HuUs9rTl6WwrVB2Ec9KMQnlkF7+HcQo1Gz+UyPRbvACWfauYJ/blXkw
	oa0qb/RTi6QqqsZLb4Rhc8d1U0hYezr33X1qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNu4jtDa2ErytBM8LhsjzFCDGpnlwE2s
	JpSN1yirlkPs8xzJTAsUQNaAuq89x+9hU1xqBG5GTJExfY0U7sQEMtX/Qs7RaM3y
	a1mxIM0kvwzYVD6LNrIID+Y+SSMLnTllUVeM5ABoR82nvtNrLsFtwGn9PyN6Axl4
	jbbRsGUabOw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2202F25681;
	Sat, 31 Oct 2015 13:31:25 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88A3025680;
	Sat, 31 Oct 2015 13:31:24 -0400 (EDT)
In-Reply-To: <20151031084917.26006.98611@typhoon.lan> (Lukas Fleischer's
	message of "Sat, 31 Oct 2015 09:49:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 357C3256-7FF5-11E5-92B8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280584>

Lukas Fleischer <lfleischer@lfos.de> writes:

>> If somebody is using namespaces and has "refs/frotz/" in the
>> hiderefs configuration, we hide refs/frotz/ no matter which
>> namespace is being accessed.  With this change, with the removal the
>> check from show_ref(), wouldn't such a repository suddenly see a
>> behaviour change?
>> [...]
>
> It would indeed. However, we cannot stay 100% backwards compatible when
> adding support for matching refs outside the current namespace without
> introducing new syntax. For example, if Git namespaces are in use (i.e.
> GIT_NAMESPACE is set), "refs/namespaces/foo/refs/bar" in hideRefs would
> not have hidden refs/namespaces/foo/refs/bar before the change but it
> does afterwards. You might argue that nobody would have added
> "refs/namespaces/foo/refs/bar" to hideRefs in the first place...

I won't.  To the current users, when they say they want to exclude
"refs/foo", they mean they do not want to advertise the fact that a
ref "refs/foo/*" exists in their repository (either the whole thing
if that is how it is accessed, or in the namespace being
accessed). and you can replace "foo" with any string, including the
ones that contain "/namespaces/", i.e. the user wanted to exclude
refs from nested ones.

I suspect what you wrote in the above is being a bit too defeatist,
though.  We only need to prevent regressions to user with existing
and valid configurations.

You earlier (re)discovered a good approach to introduce a new
feature without breaking settings of existing users when we
discussed a "whitelist".  Since setting the configuration to an
empty string did not do anything in the old code, an empty string
was an invalid and non-working setting.  By taking advantage of that
fact, you safely can say "if you start with an empty that would
match everything, we'll treat all the others differently from the
way we did before" if you wanted to.  I think you can follow the
same principle here.  For example, I can imagine that the rule for
the "ref-is-hidden" can be updated to:

 * it now takes refname and also the fullname before stripping the
   namespace;

 * hide patterns that is prefixed with '!' means negative, just as
   before;

 * (after possibly '!' is stripped), hide patterns that is prefixed
   with '^', which was invalid before, means check the fullname with
   namespace prefix, which is a new rule;

 * otherwise, check the refname after stripping the namespace.

Such an update would allow a new feature "we now allow you to write
a pattern that determines the match before stripping the namespace
prefix" without breaking the existing repositories, no?

After looking at the current code, I have to say that the way
ref-is-hidden and show_ref_cb() interact with each other is not very
well designed when namespaces are in use.  I suspect that this is
because the "namespace" stuff was bolted on to the system without
thinking things through.  For example, people may want to hide
refs/changes/* and with the current code, refs/changes/* from your
own namespace will be filtered out, but the corresponding hierarchy
from other namespaces will be included after getting turned into
".have".  And that cannot be a useful behaviour.  Tips of
refs/changes/* would be closely related to the corresponding
branches, which means that it would help reducing the object
transfer if they are included, and the fact that the user hides them
is that the user values it more to reduce the size of the initial
ref advertisement more than the potential reduction of the object
transfer cost.  If other pseudo repositories (aka namespaces) are
projects totally unrelated to yours, inluding their refs/changes/*
(or any of their refs, for that matter) would not help the later
object transfer cost, and including them in the initial ref
advertisement would not achieve anything.  Even if other namespaces
are projects that are closely related to yours, if you are excluding
refs/changes/* from your own, that is a strong sign that you do not
want their refs/changes/*, either.

Assuming other namespaces are forks of the same project as yours
(and otherwise the repository management strategy needs to be
rethought--using namespace for them is not gaining anything other
than making your repack more costly), it is likely that all of them
share a lot of refs that point at the same object (think "tags").
Do we end up sending a lot of ".have" for exactly the same object
number of times?  Even though we cannot dedup show_ref() lines that
talk about concrete refs (because they talk about what refs exist at
which value, and the sending side would use them to locally reject
non-ff pushes, for example), ".have" lines that talk about the same
object can be safely deduped.  This is not directly related to your
topic of "what should be included in the advertisement", but a
potentially good thing to fix, if it indeed turns out that we are
sending a lot of duplicate ".have"s.  A fix in that would make
things better for everybody (not just namespace users, but those who
show the ".have" lines from the refs in the repository we borrow
objects from).
