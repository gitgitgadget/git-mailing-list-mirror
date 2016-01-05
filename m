From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Tue, 05 Jan 2016 10:56:58 -0800
Message-ID: <xmqqfuybkg79.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-4-git-send-email-dturner@twopensource.com>
	<20160103000623.GB14424@gmail.com>
	<xmqqziwlnp7d.fsf@gitster.mtv.corp.google.com>
	<568BC88C.6000703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:57:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGWn8-0000O1-4i
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 19:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbcAES5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 13:57:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751870AbcAES5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 13:57:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E399C381B9;
	Tue,  5 Jan 2016 13:56:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GUJLaOgSwyz0Zutf2BfN/bFSd8g=; b=ZVGMoC
	NA5iBuGZX2PdyFNNtS/bomZUrEtr39PDf3qmIvJP/UGvQ3zNxQDTpbvDwA7S+91+
	XfRmanp983+AaSgkagvTmY5rNYiLTfUGSMj3uqWAz+r6cqNFXEFu0w7W9xvNygFI
	vSHq/E15ioc4cUnbVALNX3r+6cBNETYNbp0h0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnwY8ape/1weZHDW+6XioZoTZWykdvNL
	XfHFBfDouFyP0t0beClsG/gP141zcqJOHumF6zk0I8MHrvpAxA48KhFSaRzDP3Cj
	4CrkxJ1pvA2ZdG9CNWT87g0IyEQI05ykdR8j8QFSwu+8mrzv/oyM562rOj7NYbX9
	40P7/zhIDaA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAB0B381B8;
	Tue,  5 Jan 2016 13:56:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3DBD1381B4;
	Tue,  5 Jan 2016 13:56:59 -0500 (EST)
In-Reply-To: <568BC88C.6000703@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 5 Jan 2016 14:43:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19500586-B3DE-11E5-9546-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283393>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Actually, maybe we will never have to rewrite all callers. I rather
> think that we will retain one simplified API for dealing with "*this*
> repository's references" and a second for dealing with other repos' refs.

Yeah, I think the similarity with the multiple in-core index support
Peff brought up holds true here as well.

>> [...]
>> The caching of already read refs is a responsiblity of each ref
>> backend in the current codebase.  I am not sure if that is a good
>> placement, or a single implementation of the caching layer should
>> instead sit on top of any and ll ref backends.
>
> I still dream about having compoundable reference backends, in which
> case, ultimately, a "CacheReferenceStore" instance would optionally wrap
> on top of an arbitrary other "ReferenceStore" instance (so to speak) to
> give it caching functionality.

I am not sure if we need or want the fully stackable backends, but I
can see that the implementation of the API could be structured like
so:

 (1) Users of API would interact solely with the in-core caching
     layer when creating, reading, modifying, enumerating and
     deleting refs and contents of their logs.  The caching layer
     has a handle for each in-core representation of a "repository",
     and there is a single default one, i.e. our repository.  Also
     there is a way to ask for the in-core represention of a
     "repository" for submodules.

 (2) An instance of an in-core "repository" caching layer knows what
     "storage backend" the repository uses and this is used to
     dispatch the requests to suitable backends.  The caching layer
     would be responsible for maintaining the validity of in-core
     cache it keeps while it relays the requests.

 (3) The implementation of for_each_ref_in_submodule() family of
     functions may need to be restructured; having to have the
     backend method for them would force storage backends to be
     aware of "other" repositories.  Other "only in this repository"
     methods David and Ronnie's topics abstracts out of the files
     backend would remain the same.

which may be clean and flexible enough for our purpose.

Just to reiterate to avoid misunderstanding, I do not think that
kind of restructuring has to be a prerequisite for the current
effort to allow multiple backends, though.

Thanks.
