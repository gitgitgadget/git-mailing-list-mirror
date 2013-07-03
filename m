From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 12:48:39 -0700
Message-ID: <7vvc4re86g.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:48:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuT2l-000109-L5
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab3GCTsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:48:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932789Ab3GCTsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:48:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE492DA45;
	Wed,  3 Jul 2013 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21LJLKH9XTkBBrE5L2GlPCqrZ8w=; b=FZ5LkE
	GJovuX6f5SN7gQHJfI3WPIu563i936UghbUN+k05WFpIospRt82HGHkT8Pdwonja
	cTjtin+gAcaha5GthYiiIwU9PS2vspcXDt30i13diOZYzGfSiyAe1Ef6Yh/jO5iL
	MW/bL9IPnfGbapHNA4qYR4I626jn0FD8hR0ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hru9hhsEBPmGu3ZHSOpXR+GIap8QI1Iy
	ZShq1/TzTsUQrrevl0qwFEsK5fmE68YnCQIN8Bx443blJ1SU6+qKaTtam9qtS/Qf
	M+FIN5b+8yURkQBzJpoAUT1ykm5lSh7sLChlBy3xzIWZt0BmX9e5p/AdkIVZTv4f
	kJ/2GaErmcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F3782DA44;
	Wed,  3 Jul 2013 19:48:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3FDE2DA40;
	Wed,  3 Jul 2013 19:48:40 +0000 (UTC)
In-Reply-To: <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	(Johan Herland's message of "Wed, 3 Jul 2013 12:00:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F8B3866-E419-11E2-8083-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229514>

Johan Herland <johan@herland.net> writes:

>> I'll leave the name open but tentatively use this name in the
>> following, primarily to see how well it sits on the command line
>> examples.
>
> I agree that neither --expect nor --validate are very good. I also
> don't like --lockref, mostly because there is no locking involved, and

Yes and no.

This is not compare-and-swap but is "store-conditional" step in
ll/sc.  It is letting other people's activities to break your lock
to prevent you from making an undesirable update.  So in that sense,
this mechanism is very much a lock.

> Some other suggestions:
>
> a) --update-if. I think this reads quite nicely in the fully specified
> variant: --update-if=theirRefName:expectedValue, but it becomes more
> cryptic when defaults are assumed (i.e. --update-if without any
> arguments).

This name is in line with the "store conditional" aspect of the
operation, but it, together with your --precond and --pre-verify,
share the same problem as your --validate.  This is only to check
one specific precondition "The remote ref being updated must point
at this object", but all the names you suggested are too broad.

If we were to go in the direction (3) I suggested in the original
message to let you specify an arbitrary script that reads the list
of proposed updates and decide to allow them, --update-if=script.sh
would be the ideal name for that option to specify the script to be
run, though. That mechanism is broad enough to deserve such a broad
name, if we were to go in that direction.

> b) --precond. This makes it clear that we're specifying a precondition
> on the push. Again, I think the fully specified version reads nicely,
> but it might seem a little cryptic when no arguments are given.

See above.

> c) --pre-verify, --pre-check are merely variations on (b), other
> variations include --pre-verify-ref or --pre-check-ref, making things
> more explicit at the cost of option name length.

See above.

> So, how do we deal with the various corner cases?

I thought I spelled out everything, but apparently I didn't.  Here
is what I had in mind.

 (1) A bare "--lockref" exists on the command line.  E.g.

     $ git push --lockref [remote [refspec]...] ;# nothing else about lockref

     This will apply to updates of _all_ refs to be updated (e.g.
     with "remote.origin.push = +refs/heads/pu:refs/heads/pu", the
     update of 'pu' at the origin will be rejected if 'pu' fails to
     pass the test) with this push.  We make sure

     - we have remote-tracking branch for the updated ref; if we do
       not have any, we *fail* the update.

     - the value of that remote-tracking branch is the same as what
       the remote advertises to "git push"; if they do not match, we
       *fail* the update.  This includes the case where there is no
       such ref at the remote (may have deleted while we are looking
       the other way).

 (2) Remote ref specified on one of the --lockref option(s).  E.g.

     $ git push --lockref=theirRef[:value] [remote [refspec]...]

     This will apply to updates of _only_ the refs given.  refs not
     covered by --lockref will follow the usual rule (i.e. with
     --force, anything goes, without --force, only fast-forward is
     allowed).  If ":value" is given, we will use it, otherwise we
     will try to find the remote tracking branch for the updated
     ref, just like a non-specific case as above.

     A --lockref=theirRef[:value] that specifies theirRef that is
     not being pushed will be _ignored_ and not checked, so that you
     could say

	[alias]
        	safepush = push --lockref=next
	[remote "origin"]
        	push = refs/heads/maint:refs/heads/maint
        	push = refs/heads/master:refs/heads/master
        	push = refs/heads/next:refs/heads/next
        	push = +refs/heads/pu:refs/heads/pu

     and then do

	$ git safepush origin +next

     after a major version bump to rewind 'next' but still do so
     with safety, while still allowing you to say

	$ git safepush origin maint

     to push out 'maint' without having to worry about --lockref=next
     getting in the way.

 (3) Mixing --lockref and --lockref=theirRef[:value].

     Apply (2) for refs we do have remote ref specified on
     --lockref, and apply (1) for other refs we are going to update.

In any case, this check happens after we learn the current value of
remote refs but before we propose what the updated values would be,
so we can afford to fail the entire push atomically.  We could only
fail the ones that do not pass the check and let others go, but I do
not think it is a good idea.

So in short, I think I agree with you on the semantics.
