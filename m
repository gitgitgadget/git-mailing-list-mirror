From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: New reference iteration paradigm
Date: Thu, 31 Mar 2016 13:08:53 -0700
Message-ID: <xmqqa8lemmui.fsf@gitster.mtv.corp.google.com>
References: <56FD4CAD.3070100@alum.mit.edu>
	<xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
	<20160331193150.GC5013@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:09:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alitq-0005eN-Kz
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294AbcCaUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:08:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757135AbcCaUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:08:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C24DD5271C;
	Thu, 31 Mar 2016 16:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LfyFdxZ/AAgmB00e6l+L3SwsTXU=; b=PEbso9
	D1xbxUXPMh+wNZFPMzHMRy4ktculw8IqM0R4m4Hd9bFkazxyTflDs2yPigpCMJu3
	DI2oPZ9NgPFFfPEyDKWG4opHIHrh/DCF9/vjJN6p51yiDJbO554sWqo8A8b6PxUo
	bL2QboYuPrLskFRFtvRXItLmtZEbYqFUeMhSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXDJKBrGZTBQ+qHlNnTLcQmTijoYVNLs
	MRoXrdwvjj2Id00mLkLZTM0leJ7JVS/sT41L5PmiP7hERXwYoIDksXXrW9DKliH6
	gWiKAXusC/I5b0Mb2pvXdm9y57Qu+nG5Mz9tDqjuRpQawBIXRSh1rzNoCMObONJE
	E67+Ox627cs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA33E5271B;
	Thu, 31 Mar 2016 16:08:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C3FD5271A;
	Thu, 31 Mar 2016 16:08:55 -0400 (EDT)
In-Reply-To: <20160331193150.GC5013@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Mar 2016 15:31:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6548FF24-F77C-11E5-9FF1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290459>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 31, 2016 at 11:01:44AM -0700, Junio C Hamano wrote:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > the backend now has to implement
>> >
>> >> struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
>> >>                                            const char *prefix,
>> >>                                            unsigned int flags);
>> >
>> > The ref_iterator itself has to implement two main methods:
>> >
>> >> int iterator_advance_fn(struct ref_iterator *ref_iterator);
>> >> void iterator_free_fn(struct ref_iterator *ref_iterator);
>> >
>> > A loop over references now looks something like
>> >
>> >> struct ref_iterator *iter = each_ref_in_iterator("refs/tags/");
>> >> while (ref_iterator_advance(iter)) {
>> >>         /* code using iter->refname, iter->oid, iter->flags */
>> >> }
>> 
>> We'd want to take advantage of the tree-like organization of the
>> refs (i.e. refs/tags/a and refs/tags/b sit next to each other and
>> they are closer to each other than they are to refs/heads/a) so that
>> a request "I want to iterate only over tags, even though I may have
>> millions of other kinds of refs" can be done with cost that is
>> proportional to how many tags you have.
>> 
>> The current implementation of for_each_tag_ref() that goes down to
>> do_for_each_entry() in files-backend.c has that propertly, and the
>> new iteration mechanism with the above design seems to keep it,
>> which is very nice.
>
> Actually, that is a slight fiction. :)

I know.  My first draft had "(at least for the loose ref side)"
there, but I omitted it for brevity.

> We traverse only the loose ref directories we need, but we populate the
> entire packed-refs tree in one go.
> ...
> 800MB packed-refs file, as looking up one tiny subset of the entries
> wastes a lot of RAM and CPU pulling that into our internal
> representation[1].

Yes, that is an important use case that needs to be kept in mind for
any restructure of this machinery.
