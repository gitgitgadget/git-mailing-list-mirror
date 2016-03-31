From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: New reference iteration paradigm
Date: Thu, 31 Mar 2016 11:01:44 -0700
Message-ID: <xmqqlh4yo7av.fsf@gitster.mtv.corp.google.com>
References: <56FD4CAD.3070100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:01:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algum-0000BT-OC
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555AbcCaSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:01:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757415AbcCaSBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:01:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BD5352697;
	Thu, 31 Mar 2016 14:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jloCBq8BUonNdFydEQkMl2evYn4=; b=NfJ8Yz
	Vagkbtln9VM7tTYKt5KEsB1NoI95V+ABJiZgLokgzUz/+jGJq9BlM0ssvpvIevyg
	lrw4dW3HrIi2o+gF2T1K5zaHfV4cNc2urOhWUALquPXaBUuLbYYBzMN9MICkBNSW
	ebZGaWjv5TeoCJCi1NzHgI3RiMn6vnYPHrGWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pk7SWjH6nsRbBYMzYHxYFG9d1TclPApb
	HdfXr2lrrqZAvOjdnAhMHOHzXct3dFST9eCI/dvYlHH+wGERjJ2pVCWlMIpSqXhb
	x0ydGGQcu8kkKvwzqmqQwlLDRWY4ujkdyYgPdQz/tM9bvknfZ1c+EDa5r0vkDKRx
	cU4Fj/lwzXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00EFA52696;
	Thu, 31 Mar 2016 14:01:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 65E4E52693;
	Thu, 31 Mar 2016 14:01:46 -0400 (EDT)
In-Reply-To: <56FD4CAD.3070100@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 31 Mar 2016 18:13:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2300B10-F76A-11E5-B3F7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290433>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> the backend now has to implement
>
>> struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
>>                                            const char *prefix,
>>                                            unsigned int flags);
>
> The ref_iterator itself has to implement two main methods:
>
>> int iterator_advance_fn(struct ref_iterator *ref_iterator);
>> void iterator_free_fn(struct ref_iterator *ref_iterator);
>
> A loop over references now looks something like
>
>> struct ref_iterator *iter = each_ref_in_iterator("refs/tags/");
>> while (ref_iterator_advance(iter)) {
>>         /* code using iter->refname, iter->oid, iter->flags */
>> }

We'd want to take advantage of the tree-like organization of the
refs (i.e. refs/tags/a and refs/tags/b sit next to each other and
they are closer to each other than they are to refs/heads/a) so that
a request "I want to iterate only over tags, even though I may have
millions of other kinds of refs" can be done with cost that is
proportional to how many tags you have.

The current implementation of for_each_tag_ref() that goes down to
do_for_each_entry() in files-backend.c has that propertly, and the
new iteration mechanism with the above design seems to keep it,
which is very nice.
