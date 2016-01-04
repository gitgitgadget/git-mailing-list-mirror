From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Mon, 04 Jan 2016 11:01:58 -0800
Message-ID: <xmqqziwlnp7d.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-4-git-send-email-dturner@twopensource.com>
	<20160103000623.GB14424@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:02:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGAOT-0003SU-BM
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbcADTCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:02:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752715AbcADTCA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:02:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01F7D3662F;
	Mon,  4 Jan 2016 14:02:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8O//1Y5zVh387cb+bH5dyyEJS9o=; b=f2yl5b
	rNEM8u3a4ibEaSSDQbs/v0ZT10RxDZ6Jm/t9BDsYBt3CH5lI4JIwm3t4jqNzgTLi
	jOvecnCxTvGizkMMdgdxc7r6FaPEyUcCZwncd4r9RS2t5gmUN0zSwLHTZlG44hvt
	kw1mw0ZW3c+g2FVimfWVGn/KElTQ8mPf7pYCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Elpe3dU7jMwGCFvzS+EwVHUOYQlaCFXD
	RHkK9IYvIXUZNED/Suzf9eV29kIc/dyuL2JNcWDxHKFtQJWkeKgr/xtdmf6MoKek
	K9thvHCK1kMUY6cm9aXEFJBWtlka5beMI98kNq8Weca29HiXJnwRQuVNL8HtI2SO
	ALAn0qf8z+0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECF313662E;
	Mon,  4 Jan 2016 14:01:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C4B83662D;
	Mon,  4 Jan 2016 14:01:59 -0500 (EST)
In-Reply-To: <20160103000623.GB14424@gmail.com> (David Aguilar's message of
	"Sat, 2 Jan 2016 16:06:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1BDFDFC-B315-11E5-A9BD-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283315>

David Aguilar <davvid@gmail.com> writes:

>> diff --git a/refs.c b/refs.c
>> index 9562325..b9b0244 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1150,3 +1150,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
>>  {
>>  	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
>>  }
>> +
>> +int head_ref(each_ref_fn fn, void *cb_data)
>> +{
>> +	return the_refs_backend->head_ref(fn, cb_data);
>> +}
>
> My only comment is that it seems like having a single static global
> the_refs_backend seems like it should be avoided.
>
> It seems like the intention was to keep the existing interface
> as-is, which explains why this is using globals, but it seems
> like the refs backend should be part of some "application
> context" struct on the stack or allocated during main().  It can
> then be passed around in the API so that we do not need to have
> a global.

I think the ship is sailing in a different direction.  The API to
deal with refs, possibly in multiple repositories, is that you use a
single ref backend, and that backend is expected to handle refs in
submodule repositories.  I.e. refs.c::for_each_ref_in_submodule()
calls into the backend implementation of the same method.  So from
that point of view, you cannot say "the top level repository uses
LMDB backend but this and that submodule refs are looked up by
consulting files backend".

If we want to go the opposite direction, so that we can keep more
than one in-core representations of "repository" (what you called
"application context") and optionally have different refs backend
handling different repositories, we most likely would want to
rethink the part of the refs API that special cases the submodule
refs from within the current repository.  Their implementation
should be excised from the API set, and instead made to be a set
of thin wrapper functions that explicitly refer to a repository
instance that represents the submodule.

The refs and the object database go hand in hand (i.e. the former
gives the anchoring points to keep objects in the latter alive), so
an instance of "repository" would hold "the_refs_backend", "objects[]",
and possibly "the_index" for that repository.

The caching of already read refs is a responsiblity of each ref
backend in the current codebase.  I am not sure if that is a good
placement, or a single implementation of the caching layer should
instead sit on top of any and ll ref backends.
