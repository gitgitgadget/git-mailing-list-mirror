From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 09:58:40 -0700
Message-ID: <7vy5a611hb.fsf@alter.siamese.dyndns.org>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
	<1371581737-10013-7-git-send-email-artagnon@gmail.com>
	<51C1442A.2010904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 18:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLio-0002Xs-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 18:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829Ab3FSQ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 12:58:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab3FSQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 12:58:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4209429A71;
	Wed, 19 Jun 2013 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HjOD7kZRjL3tr8nIA6DFPLpVPnE=; b=MXSjAGYZBFcg6INFlu1V
	NBKLjr94ZqrHfqyKu3eLtsJlJ6y5KR7GrI4yPiCacl+wJ+l7dYAhbPuZeiFsZ/TV
	Wy9xBzU+pDOwp7PCSZZkHCERIQqBciWO7ag+Ai7Xf+zX0YPwD3rBJnIamXq2LrMO
	T2pJvXPkQ5xAsfb+/3rVGm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UkE/6u3tb4OY2nUd/gUt/orhZgIVZKG2Ppdq+S+YPrm4EB
	DNr/CD033NI6FFzk3+Ns7fovXlrX7zVeGIj2LAMKtnzy/CiEsbmn/wCCC59SNqm/
	5Fow//ZVy9p+fGiAYyhonrpmcpq/QiGBz+eFR7Gik2TzswqOzIIhYjItc3Dp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36CA829A6F;
	Wed, 19 Jun 2013 16:58:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81EF229A6C;
	Wed, 19 Jun 2013 16:58:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F1E2F24-D901-11E2-BB37-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228399>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/18/2013 20:55, schrieb Ramkumar Ramachandra:
>> Now that the "checkout" invoked internally from "rebase" knows to honor
>> GIT_REFLOG_ACTION, we can start to use it to write a better reflog
>> message when "rebase anotherbranch", "rebase --onto branch",
>> etc. internally checks out the new fork point.  We will write:
>> 
>>   rebase: checkout master
>> 
>> instead of the old
>> 
>>   rebase
>
>> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
>> index 34e3102..69fae7a 100644
>> --- a/git-rebase--am.sh
>> +++ b/git-rebase--am.sh
>> @@ -5,11 +5,13 @@
>>  
>>  case "$action" in
>>  continue)
>> +	GIT_REFLOG_ACTION="$base_reflog_action"
>
> I haven't followed the topic closely, but I wonder why there are so many
> explicit assignments to GIT_REFLOG_ACTION. Is calling set_reflog_action
> (defined in git-sh-setup) the wrong thing to do?

Excellent question, and I think this illustrates why the recent
reroll that uses an approach to use base_reflog_action is not
complete and needs further work (to put it mildly).

set_reflog_action is designed to be used once at the very top of a
program, like this in "git am", for example:

	set_reflog_action am

The helper function sets the given string to GIT_REFLOG_ACTION only
when GIT_REFLOG_ACTION is not yet set.  Thanks to this, "git am",
when run as the top-level program, will use "am" in GIT_REFLOG_ACTION
and the reflog entries made by whatever it does will say "am did this".

Because of the conditional assignment, when "git am" is run as a
subprogram (i.e. an implementation detail) of "git rebase", the call
to the helper function at the beginning will *not* have any effect.
So "git rebase" can do this:

	set_reflog_action rebase
	... do its own preparation, like checking out "onto" commit
        ... decide to do "format-patch" to "am" pipeline
        	git format-patch --stdout >mbox
		git am mbox

and the reflog entries made inside "git am" invocation will say
"rebase", not "am".

The approach to introduce base_reflog_action may be valid, but if we
were to go that route, set_reflog_action needs to learn the new
convention.  Perhaps by doing something like this:

 1. set_reflog_action to set GIT_REFLOG_NAME and GIT_REFLOG_ACTION;
    Program names like "am", "rebase" will be set to this value.

 2. If the program does not want to say anything more than its
    program name in the reflog, it does not have to do anything.
    GIT_REFLOG_ACTION that is set upfront (or inherited from the
    calling program) will be written in the reflog.

 3. If the program wants to say more than just its name, it needs to
    arrange GIT_REFLOG_ACTION not to be clobbered.  It can do so in
    various ways:

   a) A one-shot invocation of any program that writes to reflog can
      do:

	GIT_REFLOG_ACTION="$GIT_REFLOG_NAME: custom message" \
        	git cmd

      An important thing is that GIT_REFLOG_ACTION is left as the
      original, i.e. "am" or "rebase", so that calls to programs that
      write reflog using the default (i.e. program name only) will
      not be affected.

   b) Or it can temporarily change it and revert it back (necessary
      to use shell function like "output" that cannot use the above
      "single shot export" technique):

	GIT_REFLOG_ACTION="$GIT_REFLOG_NAME: custom message"
        output git cmd
 	GIT_REFLOG_ACTION=$GIT_REFLOG_NAME

But after writing it down this way, I realize that introduction of
base_reflog_action (or GIT_REFLOG_NAME which is a moral equivalent)
is not helping us at all.  As long as calls to "git" command in the
second category exists in these scripts, GIT_REFLOG_ACTION *must* be
kept pristine after set_reflog_action sets it, so we can get rid of
this new variable, and rewrite 3.a and 3.b like so:

    3-a)

	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message" \
        	git cmd

    3-b)

	SAVED=$GIT_REFLOG_ACTION
	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message"
        output git cmd
 	GIT_REFLOG_ACTION=$SAVED

	    or

	(
                GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: custom message"
                output git cmd
	)

That essentially boils down to the very original suggestion I made
before Ram introduced the base_reflog_action.
