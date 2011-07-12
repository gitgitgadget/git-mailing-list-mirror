From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 10:57:52 -0700
Message-ID: <7vaacj8jq7.fsf@alter.siamese.dyndns.org>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:58:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QghDm-0004dg-Fi
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab1GLR54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:57:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1GLR5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C1D32496E;
	Tue, 12 Jul 2011 13:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=drn8dJnrniBW4t52ahJehCyGuVg=; b=LnPRIw
	yKurn7X/78p0RfhT+MIK7ezzS2c8c7BxZQZqDyiXpotiWlRhleT4EplIFYUbRqvl
	WRwsxohtDAF8qIBK7+8arkkV+RjnJgFq0z2d5J9p/M7mHkuQXTuc/5NsiF189CjI
	aPEbuvxsbZESYo4EEsDg0Ux17/31e4edOp6Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OvumdflV6qps7PO1GfU3edXgE6QMlLtd
	JrrrMmlCUKdqdWm9uhUPz3ositQdN+LMBArb+WpbgMFahT+JCjZWPqN6aNcHCrvx
	RZAzOs1RP6EgU37K9To92idb5338DrSb8KCVUydLnWc2sQ7Pc9V/pjJagmRJiIP8
	I9m1fNA4rSo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9A1B496D;
	Tue, 12 Jul 2011 13:57:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0D0FA496C; Tue, 12 Jul 2011
 13:57:53 -0400 (EDT)
In-Reply-To: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com> (Bert
 Wesarg's message of "Tue, 12 Jul 2011 19:23:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7786276E-ACB0-11E0-82B5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176958>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> What: Control the refs which are honored by core.logAllRefUpdates.
>
> How:
>
> Introduce a new config variable named core.autoRefLog. This variable
> is a multi var. The default value is:
>
>     [core]
>         autoLogRef = heads
>         autoLogRef = remotes
>         autoLogRef = notes
>
> This list must be initialize at runtime. Because older repositories
> won't have them in existing config files.

It sounds as if you mean to update .git/config when you find a repository
that is missing these, which is not what we want.  I would rephrase it
like this:

 - The new variable core.autoLogRef is a multi-valued configuration.

 - If core.autoLogRef is defined (to any value), core.logAllRefupdates is
   ignored;

 - Otherwise, the core.logAllRefUpdates variable that is set to true is
   equivalent to having a "reasonable default" set in core.autoLogRef (and
   the current "reasonable default" happens to be heads, remotes and
   notes), and the core.logAllRefUpdates variable set to false (or
   missing) is equivalent to having an empty string in core.autoLogRef;

> The value given needs to be a valid ref, without leading or trailing
> slashes, and wildcards. The names will be prefixed with 'refs/' and
> suffixed with '/'. The list is checked against the ref to update, if
> any of the values is a prefix of the given ref, than the update will
> be logged, regardless whether the log file exists.

Ok, except for:

 - An empty string in core.autoLogRef does not contribute to the matching
   logic above.

> Setting core.autoLogRef to the empty value, will reset the list.

It is unclear what it is reset to.  Do you mean it clears, e.g.

    [core]
    	autoLogRef = heads
    	autoLogRef = remotes
        autoLogRef = notes
        autoLogRef =
        autoLogRef = heads

would first create a list of three elements, clears it and then the final
result has only refs/heads/ in the list?
