From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/3] Teach mv to move submodules together with their
 work trees
Date: Thu, 11 Apr 2013 09:27:07 -0700
Message-ID: <7vk3o9jan8.fsf@alter.siamese.dyndns.org>
References: <515C88FE.9020203@web.de> <515C8958.4080704@web.de>
 <CALkWK0mWHwTV8dc9F3tyq9HYOnC2S56x_efr1+eRsqJqTFutXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKLE-0005UZ-E2
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab3DKQ1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:27:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab3DKQ1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:27:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B0021462C;
	Thu, 11 Apr 2013 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zOc6lb1eCfNCbzocRgK5I7QAqlE=; b=lKf4Cd
	RyXtQI+izb20BCb3YfvFCI0vRCe92hpn1I6gBVX07qD2N9H8edqpc/B7ZAM2H7Lh
	GHzbXE1rKB1nrGoAQ2IwM6HEXdzSWz0R3CyOBHPKLk3uXbSIlFYE4RUE3xxtLVuu
	3617NRg43lrhh19bpZeV2iz+I/pZ8OJ+W58Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cw9loNPnQi24MQZRssY6XYLZ9PXC4+gC
	tOPTK7nVKkvGVt6jUZPRRxeNnZkxrt8Xrn03Z3+RqfiaiMloZ/c55M9PfQKKbxt/
	QvDDFnV/8sXXDQ4ynNXnaVUh2uOrVzMqKsqen326JlgFyoUkeZqO5ztpjkX/BgDJ
	R03Bu84z+0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D3361462B;
	Thu, 11 Apr 2013 16:27:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B822B1462A; Thu, 11 Apr
 2013 16:27:08 +0000 (UTC)
In-Reply-To: <CALkWK0mWHwTV8dc9F3tyq9HYOnC2S56x_efr1+eRsqJqTFutXA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 11 Apr 2013 14:42:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7E2D23E-A2C4-11E2-855C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220886>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> Then rename() will move the submodule work tree just
>> like it moves a file.
>
> What is this rename() function you're talking about?  I don't see it anywhere.

"man 2 rename"; it is called from a generic part of builtin/mv.c to
rename one path to another and can move both files and directories.

>> +                       if (first >= 0) {
>> +                               if (!S_ISGITLINK(active_cache[first]->ce_mode))
>> +                                       die (_("Huh? Directory %s is in index and no submodule?"), src);
>
> I didn't understand this.  Why does it have to be a gitlink if it is
> stored at index position >= 0?

The path is not in the middle of the conflict, but the index records
something that is not a gitlink.  E.g. you start from A (regular file)
in the index, "rm A && mkdir A" and make it the top of a working
tree of a separate project.  "git mv A elsewhere" will say "src_is_dir"
but the index still thinks A should be a regular file blob.

> I'm assuming the else-case has nothing to do with the actual moving
> but rather something specific to directories (enumerating entries in
> it?), which is why it doesn't get executed when we find a gitlink.

It wants to move all the paths in the directory to a new
destination, e.g. "git mv srcdir dstdir", and update 


>> +                       } else {
>> +                               const char *src_w_slash = add_slash(src);
>> +                               int last, len_w_slash = length + 1;
>> +
>> +                               modes[i] = WORKING_DIRECTORY;
>> +
>> +                               first = cache_name_pos(src_w_slash, len_w_slash);
>> +                               if (first >= 0)
>> +                                       die (_("Huh? %.*s is in index?"),
>> +                                                       len_w_slash, src_w_slash);
>> +
>> +                               first = -1 - first;
>> +                               for (last = first; last < active_nr; last++) {
>> +                                       const char *path = active_cache[last]->name;
>> +                                       if (strncmp(path, src_w_slash, len_w_slash))
>> +                                               break;
>>                                 }
>
> Mostly unchanged, but I didn't understand the line first = -1 - first
> in the original.  What is it doing?  So, I'm guessing first is the
> cache position of the directory itself, and last stores the index of
> the "last" entry in the cache?  What does that even mean?

cache_name_pos() either returns the position for a path at stage #0
that exists in the index, or the position the given path _would_ be
inserted if you were to add it to the index for a path that does not
exist in the index at stage #0 (I think this part of the code does
not consider that the given path is unmerged, either by being sloppy
or detecting that case much earlier---I didn't check), and when
doing the latter, it encodes the position by negating it and
offsetting it by 1 (otherwise you cannot tell "it would come at the
very beginning" and "it is at the very beginning", because negated
zero is still zero).  The "-1 - first" is an idiom used everywhere
by callers of cache_name_pos() to recover the latter from the
returned value.

If you start at a position "src/" would have been inserted, and
iterate over the index while the entry's path prefix-matches with
"src/", you will find where the entries in the "src/" directory
ends.

>> +                               if (last - first < 1)
>> +                                       bad = _("source directory is empty");
>
> This is exactly what was tripping us up earlier.  Can you explain what
> last - first < 1 means?

I think the above covers it.

Asking questions to learn the basic part of Git internals on this
list, e.g. "I found this existing code, and I do not understand what
it is doing. Can somebody shed a light on it?", is perfectly fine,
but can you do so outside the review discussion?

It clutters the review discussions when such a request for education
is labeled as if it were a review or mixed with a message with
genuine review comments.
