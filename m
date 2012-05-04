From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] index-pack: support multithreaded delta resolving
Date: Fri, 04 May 2012 08:23:18 -0700
Message-ID: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
References: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
 <1334123388-6083-4-git-send-email-pclouds@gmail.com>
 <7v62ccex0x.fsf@alter.siamese.dyndns.org>
 <7vipgccvp9.fsf@alter.siamese.dyndns.org>
 <CACsJy8DHtBZdhoh1BPwn2_-3wVDRWypJOg3kR9wjd2o1bLUW-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 17:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKM4-0001yx-JW
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936Ab2EDPXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 11:23:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758821Ab2EDPXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:23:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E1327D01;
	Fri,  4 May 2012 11:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vifHDr0Zuyr5hAHqAoO425znjGk=; b=Zp7BXg
	HxhEsNiEBsI8w7vioI8z7emI6Sm7IwUD/OU116XzRiWOWcQZmv5THLvIrE+N3ABx
	n72tMzXPDkeNKXUGCvigNPo/wpBKH3wV3HYR7KPvYPsvFNonlDgKgfB0cFTdx1hK
	29H6+hkJkgpRyXzkn/PfHITU4eCShaGQ685zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ani3SXlh1gi2IdfVhJVZ2wilOVYKRxv0
	7EZEFxhoatM7BgqE+dlQb5yq4GEn0F9UhKZuRkwatY2JG8bK/h3f5p7zy6G1+zdf
	5BHHW+snSJZo4awZS/F7Yff3rhFdJgLQsGeKLu3onJtPX154yH4XhF21OLl96xit
	VA74Z7qt/f8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64C007D00;
	Fri,  4 May 2012 11:23:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9E177CFE; Fri,  4 May 2012
 11:23:20 -0400 (EDT)
In-Reply-To: <CACsJy8DHtBZdhoh1BPwn2_-3wVDRWypJOg3kR9wjd2o1bLUW-Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 4 May 2012 19:50:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14DC1D1C-95FD-11E1-967E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197028>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Junio, can you make a patch (or update current ones) with better
> naming? I obviously did not see why these names were bad. You may
> provide more convincing explanation than me in the commit message.

I have already explained s/nr_processed/nr_dispatched/.

I do not think second_pass vs threaded_second_pass is merely a naming
issue. The code structure ("taking the abstraction backwards") is the
bigger issue.

The original before the series has:

	parse_pack_objects()
	{
		... a lot of code for the first pass ...
		
		... a lot of code for the second pass which looks like
		for (all object entries) {
			set global state base_obj->obj to it
			find unresolved deltas for that single base_obj
			display progress
		}
	}

and you first split one iteration of the second pass, resulting in

	parse_pack_objects()
	{
		... a lot of code for the first pass ...
		
		for (all object entries) {
			set global state base_obj->obj to it
			second_pass()
		}
	}

which I think is a wrong way to do it, because here is what your next step
ends up with because of that:

	parse_pack_objects()
	{
		... a lot of code for the first pass ...
		
	#if WE SUPPORT THREADING
		for (number of threads we are going to spawn) {
			spawn thread and let it run threaded_second_pass
		}
		for (all threads) {
			cull them when they are done
		}
		return
	#endif
		... when not threading ...
		run threaded_second_pass() in the main process
	}

It could (and should) be like this instead from the beginning, I think:

	parse_pack_objects()
	{
		... a lot of code for the first pass ...
		second_pass()
	}

to encapsulate the whole second_pass() logic in the refactored function,
whose implementation (i.e. how the objects to be processed are picked up
and worked on) will change in the threaded version.  In the first
refactoring patch, second_pass() would still iterate over object entries:

	second_pass()
	{
		for (all object entries) {
			resolve_deltas(base_obj)
		}
	}

And at this point, introduce a helper function "resolve_deltas(base)"
or something that is your "second_pass()".  This deals with only one
family of objects that use the given object as their (recursive) base
objects, and use it in the above loop.

And then multi-threading support can turn that into something like

	second_pass()
	{
	#if WE SUPPORT THREADING
		for (number of threads we are going to spawn) {
			spawn thread and let it run threaded_second_pass
		}
		for (all threads) {
			cull them when they are done
		}
		return
	#endif
		... when not threading ...
		for (all object entries) {
			resolve_deltas(base_obj)
		}
	}

to add support for threaded case.  The threaded_second_pass function does
only one thing and one thing well:

	threaded_second_pass()
	{
		set thread local
		loop forever {
			take work item under critical section
			break if there is no more work
			resolve_deltas(the work item)
		}
	}

Wouldn't the result be much more readable that way?

You may have saved a few lines by making unthreaded code call your
threaded_second_pass() and pretend that the single main process still has
to pick up a work item and work on it in a loop like you did, but I think
it made the logic unnecessarily harder to follow.
