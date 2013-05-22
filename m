From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 02/15] path.c: refactor relative_path(), not only strip prefix
Date: Wed, 22 May 2013 09:23:33 -0700
Message-ID: <7v38tfkmpm.fsf@alter.siamese.dyndns.org>
References: <cover.1369186574.git.worldhello.net@gmail.com>
	<d730f00edb09449bf299be8d2083c895a1028c18.1369186574.git.worldhello.net@gmail.com>
	<519C7CA1.2060402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 18:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfBpU-0001GB-S6
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 18:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab3EVQXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 12:23:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166Ab3EVQXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 12:23:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AC402070E;
	Wed, 22 May 2013 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwuScKuvaary+vlPYqnT6X37Rd4=; b=epRZEP
	LBxFqH9vzsd4YLRDVOgN39LY3VY9CiLuxkQzIv1te53vi9NItffKVq7lmoluL21P
	oj5FKPCcitXJkIz3Zecczj00gdGgt+pwo6Rn5t72mO8XIVZm2zjxhLu0I+AwdZk8
	oimI9BIFCK3EiOc+oN+9UvX8j1uR75fyceU7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qzqE6YX7Hj26DBfv+T6vYmsF/e7gaiqU
	iQHjJYcEpOFdPMIM/uINMn3lYEdSDA8NmYlLSn9vH5T3GCIiMCGpUn1Hl2SoAfIx
	Zmxeo34G+r4Ht8OzmBA3ukiynitbJw0CCnr9z6WpakgCp+HqIHnkR3FWd4nD7Ape
	xGBGxovdAJ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FD12070D;
	Wed, 22 May 2013 16:23:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55C0720700;
	Wed, 22 May 2013 16:23:45 +0000 (UTC)
In-Reply-To: <519C7CA1.2060402@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 22 May 2013 10:06:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F98897FC-C2FB-11E2-A44F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225171>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Different results for relative_path() before and after this refactor:
>> 
>>     abs path  base path  relative (original)  relative (refactor)
>>     ========  =========  ===================  ===================
>>     /a/b/c/   /a/b       c/                   c/
>>     /a/b//c/  //a///b/   c/                   c/
>>     /a/b      /a/b       .                    ./
>>     /a/b/     /a/b       .                    ./
>>     /a        /a/b/      /a                   ../
>>     /         /a/b/      /                    ../../
>>     /a/c      /a/b/      /a/c                 ../c
>>     /a/b      (empty)    /a/b                 /a/b
>>     /a/b      (null)     /a/b                 /a/b
>>     (empty)   /a/b       (empty)              ./
>>     (null)    (empty)    (null)               ./
>>     (null)    /a/b       (segfault)           ./
>
> The old and new versions both seem to be (differently) inconsistent
> about when the output has a trailing slash.  What is the rule?

That is a good point.  At least adding / at the end of "." seems
unneeded, given that the output in some cases have no trailing
slash, forcing a caller who wanted to get a directory to append a
trailing path components to it to check if it needs to add one
before doing so.  Always adding a slash / to the output may sound
consistent, but it is not quite; e.g. "/a/c based on /a/b is ../c"
case may be referring to a non directory /a/c and ensuring a
trailing slash to produce ../c/ is actively wrong.

"The caller knows" rule might work (I am thinking aloud, without
looking at existing callers to see what would break, only to see if
a consistent and simple-to-explain rule is possible).

When the caller asks to turn /a/b relative to /a/b (or /a/b/,
/a//b/./), then we do not know (or we do not want to know) if the
caller means it to be a directory with the intention of appending
something after it, so just return ".".  When the caller asks to
turn /a/b/ relative to the same base, return "./" with the trailing
slash.  Remember if the "abs path" side had a trailing slash,
normalize both input (turning "/./" into "/" and "foo/bar/../" into
foo/", squashing multiple slashes into one, etc.) and then strip the
trailing slash from them, do the usual "comparison and replacement
of leading path components with series of ../" and then append a
slash if the original had one, or something?

>> index 04ff..0174d 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -441,42 +441,104 @@ int adjust_shared_perm(const char *path)
>>  	return 0;
>>  }
>>  
>> -const char *relative_path(const char *abs, const char *base)
>> +/*
>> + * Give path as relative to prefix.
>> + *
>> + * The strbuf may or may not be used, so do not assume it contains the
>> + * returned path.
>> + */
>> +const char *relative_path(const char *abs, const char *base,
>> +			  struct strbuf *sb)
>
> Thanks for adding documentation.  But I think it could be improved:
>
> * The comment refers to "path" and "prefix" but the function parameters
> are "abs" and "base".  I suggest making them agree.
>
> * Who owns the memory pointed to by the return value?
>
> * The comment says that "the strbuf may or may not be used".  So why is
> it part of the interface?  (I suppose it is because the strbuf might be
> given ownership of the returned memory if it has to be allocated.)
> Would it be more straightforward to *always* return the result in the
> strbuf?

This comes from the original in quote.c, I think.  The caller
supplies a strbuf as a scratchpad area and releasing it is the
caller's responsibility.  If the function does not need any
scratchpad area (i.e. the answer is a substring of the input), the
result may point into the abs.

So the calling convention is:

	struct strbuf scratch = STRBUF_INIT;
	const char *result = relative(abs, base, &scratch);
        use(result);
        strbuf_release(&scratch);

and the lifetime rule is "consume it before either abs or scratch
is changed".
