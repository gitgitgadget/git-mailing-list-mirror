From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Wed, 11 Apr 2012 20:15:15 -0700
Message-ID: <7vty0phc8s.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
 <7v1unuj8az.fsf@alter.siamese.dyndns.org>
 <20120411235509.GB16937@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIAVK-0008CQ-5e
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 05:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab2DLDPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 23:15:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755462Ab2DLDPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 23:15:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1AB98951;
	Wed, 11 Apr 2012 23:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2icAmtPbDPn2/vgh7ei7E51ytQ8=; b=fQUMqc
	8jlTYePd2rbTqIK9zZ1D7QYlWpu/1WnD6oJyivxJ86RY2XpguF6Dake2C+UEBk8b
	xIRNBfmrRihyQbDMw1y5Oh98NNrD3juRmpIZm2yjFqJ+hbLU19Nov7DkjxzgDNr1
	WWBf/qFHgsW9hy6zBACDRqyuyOTNufgDNvWCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Omeabxw5mdg4lmv6+mqkqhjap2kxWKu7
	FzU3zbiXnWsIXqhBAdX15lXySJNILryMDFSxUPzA+ZgjmS8NO1GSkLBeNVbnbdPd
	G4RTUgCednUDFRJxE4Q8dVUmrR2rqLzZU2L0kj5zgHqV3agUMJ9Q/Zvw7y8+TX1s
	ZLBbxzIj7yA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7D0F8950;
	Wed, 11 Apr 2012 23:15:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B473894F; Wed, 11 Apr 2012
 23:15:17 -0400 (EDT)
In-Reply-To: <20120411235509.GB16937@hmsreliant.think-freely.org> (Neil
 Horman's message of "Wed, 11 Apr 2012 19:55:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA5DEF48-844D-11E1-9B31-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195288>

Neil Horman <nhorman@tuxdriver.com> writes:

>> > -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
>> > +int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
>> >  {
>> > -	/* 7 is max possible length of our args array including NULL */
>> > -	const char *args[7];
>> > -	int i = 0;
>> > +	struct argv_array array;
>> > +	int rc;
>> > +
>> > +	if (!empty && !opts->keep_if_made_empty) {
>> > +		unsigned char head_sha1[20];
>> > +		struct commit *head_commit;
>> > +		int need_free = 0;
>> > +
>> > +		resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
>> > +		head_commit = lookup_commit(head_sha1);
>> 
>> No error checking whatsoever?  HEAD might be pointing at a branch that
>> hasn't been born, for example.
>> 
> Sorry, I had presumed that HEAD could be guaranteed to be good here, given that
> we validate it in rollback_single_pick via read_ref_full.  But I can add
> additional checking here.

As long as it is clear that we always have "HEAD" here, it is not strictly
necessary, but we'd probably feel better, especially now that the function
is (for some reason) made into a global one and may gain other new callers
outside this file scope.

>> >  	if (opts->allow_empty)
>> > -		args[i++] = "--allow-empty";
>> > +		argv_array_push(&array, "--allow-empty");
>> 
>> If --keep-if-made-empty is not given but --allow-empty was, it is fine to
>> give --allow-empty here, but otherwise, it logically is iffy and is likely
>> to become a cause of future bugs to pass --allow-empty to "git commit",
>> even though the earlier check _ought_ to catch problematic cases, no?
>> 
> Not sure I follow your reasoning here.  We need to pass allow-empty to git
> commit here if git cherry-pick set either allow-empty or keep-redundant-commits
> (the latter setting opts->empty), Can you give an example of what might be
> problematic in the future?

Thinking about it again, I think this part of your patch is correct.

We may pass an index that yields the same tree as "HEAD" if the original
was empty, or the original was not empty but the merge found the commit
unneeded.  In either case, if "--keep-unnecessary" or "--allow-empty" was
given, we want to record the empty commit, and opts->allow_empty is set
when either option was given from the command line.

Thanks.
