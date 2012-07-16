From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Sun, 15 Jul 2012 21:33:35 -0700
Message-ID: <7vwr24495s.fsf@alter.siamese.dyndns.org>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120716003024.GA4246@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 06:33:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqd0I-00020q-G3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 06:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab2GPEdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 00:33:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab2GPEdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 00:33:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32D0888B6;
	Mon, 16 Jul 2012 00:33:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eIZRRY9lS1xCjoCds9Nll70WDT4=; b=DtKQM/
	6cROCjXX2kXtRNjdm5ykhN/CKdXSwoVLHfv90zN/wPKnDttq7kjRKFauUHn7Xj9x
	D4E0ICBWUzqwfAT1Rnn2m2fRo0m7IbU1E/nxX7LJoboV9Au3c6mbdjgiyjy7T3ex
	l5zzcatyZB43a1SWo4gXMXcHLCIivfSOE0s3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uuAV+zI4C7yG67jC+UAAKRB8uNbCpn4F
	8lhiHjFQ17bfC7SY7BmG6wSYUxlYSAXRH60ld7Hnj4Xpwl2dinkxwtQbr26koHui
	bzqmMN41LfyZHwNuqlgONNlADM1wTSUopWIhNbMda2csli24HgdzhG/oNEt52XLI
	slyiIj9JPgk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E24A88B4;
	Mon, 16 Jul 2012 00:33:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01B0988B2; Mon, 16 Jul 2012
 00:33:39 -0400 (EDT)
In-Reply-To: <20120716003024.GA4246@burratino> (Jonathan Nieder's message of
 "Sun, 15 Jul 2012 19:30:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AE377F6-CEFF-11E1-89A6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201492>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Florian,
>
> Florian Achleitner wrote:
>
>> After importing new commits on top of refs/remotes/* the
>> ref was overwritten with the local refs/heads/master, because the name
>> of the remote reference to fetch, i.e. refs/heads/master, was used to
>> retrieve old_sha1 for it's local counterpart. Therefore, old_sha1 pointed
>> to the local head which was not contained in the remote branch and couldn't
>> be updated (printing a warning ..).
>
> I assume you are talking about the status quo here.  It's easy to
> forget that others have not already applied your patch, but using the
> present tense would make reading easier.  Think of the patch
> description as a special kind of bug report.
>
> Unfortunately, as a bug report, the above is lacking some detail.  Do
> I understand correctly that some remote helper is failing when git
> invokes its 'import' command?  What are the symptoms?  If it prints a
> warning, what is the exact warning?
>
> Does that remote helper advertise the 'refspec' capability?  If so,
> what refspec does it use?  If not, why not?
>
> It might seem silly to ask for these things when you're providing a
> fix along with the report!

I share the puzzlement you expressed above, and it is unclear if
this is a fix or covering a user error with butchering a code that
is working as intended, making two wrongs happen to collide into
producing a right.

At least it needs a better description of the problem it tries to
fix, preferrably in the form of a new test for the transport helper.

> However, if someone else runs into the
> same symptoms, they need to be able to find your patch quickly; if
> your patch has a bad side-effect then we need to know why not to
> revert it; and if someone new starts working on the same area of code,
> they need to know what bugs to avoid reintroducing.

That, too.

Thanks.
