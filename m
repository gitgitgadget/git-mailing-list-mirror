From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log: grep author/committer using mailmap
Date: Wed, 26 Dec 2012 13:37:28 -0800
Message-ID: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
 <1356195512-4846-2-git-send-email-apelisse@gmail.com>
 <7vr4mcobpu.fsf@alter.siamese.dyndns.org>
 <CALWbr2xW6r5ysJ8KQZa1eGYehG8ZbEp6K+s5JkG2goK9ef7rcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 22:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnyfi-0004tC-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 22:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090Ab2LZVhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 16:37:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab2LZVhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 16:37:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08B8FA5CA;
	Wed, 26 Dec 2012 16:37:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cr97q6yt0lbZSNBnCfCFd+acezU=; b=SeaRtO
	OWuZfD9WdIbSePF+VgnrF4+XBcrdYNU+2oKCAOZEnXVy4gQ3iw6X2IZmzjs1EBfX
	miFIJKmkwSfn9ISDBYcTzpzSTL2WrOk2YFDOapUJSUUbhdJaXazD2Be87fDZOhDp
	bRD/0yjIJ+pV2bGsIdPS8uvSNaRFMo7HuqWpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nyCOmc1bkhV1FZ9ci/DbQXLzwo/5ZUbD
	dL7Y+AZeOI+oy8E+7Yk3Wkd7YtSEasrx68rAh2eBWFsfER13BaIhSQZ2pL4yPScL
	lrQ5J5OdpMkt5uixO2UdJ/PfAZfzISnkY5iSexfL1wJH2qmKhdla8FONO4kER2PI
	jFcXRIzPuf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA3FFA5C9;
	Wed, 26 Dec 2012 16:37:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24783A5C8; Wed, 26 Dec 2012
 16:37:30 -0500 (EST)
In-Reply-To: <CALWbr2xW6r5ysJ8KQZa1eGYehG8ZbEp6K+s5JkG2goK9ef7rcA@mail.gmail.com> (Antoine
 Pelisse's message of "Wed, 26 Dec 2012 22:12:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 734366C4-4FA4-11E2-AFB6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212158>

Antoine Pelisse <apelisse@gmail.com> writes:

>>>
>>> +static int commit_rewrite_authors(struct strbuf *buf, const char *what, struct string_list *mailmap)
>>> +{
>>> +     char *author, *endp;
>>> +     size_t len;
>>> +     struct strbuf name = STRBUF_INIT;
>>> +     struct strbuf mail = STRBUF_INIT;
>>> +     struct ident_split ident;
>>> +
>>> +     author = strstr(buf->buf, what);
>>> +     if (!author)
>>> +             goto error;
>>
>> This does not stop at the end of the header part and would match a
>> random line in the log message that happens to begin with "author ";
>> is this something we would worry about, or would we leave it to "fsck"?
>
> The only worrying case would be:
> ...

Yeah, that pretty much matches what I had in mind (the short answer:
leave it to "git fsck").

>> We usually signal error by returning a negative integer.  It does
>> not matter too much in this case as no callers seem to check the
>> return value from this function, though.
>
> Fixed, or would you rather see it `void` ?

Just like you can take advantage of map_user() that signals the
caller if it did anything to optimize this function, in the longer
run, it may help the (future) callers of this function if it gave "I
did something" vs "I left it intact".  In the particular case of
this function, the "error" cases fall into the latter (it merely
explains why it left it intact, and there is no sensible error
recovery the caller _could_ do in any case) and I think it is not
necessary to differenciate between "Returned as-is because there is
no mapping" and "Returned as-is because I couldn't parse the
commit".

So "return 0 when it didn't do anything, return 1 when it rewrote"
feels good enough, at least to me.

>>> +     }
>>> +
>>> +     strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
>>> +     strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
>>> +
>>> +     map_user(mailmap, &mail, &name);
>>> +
>>> +     strbuf_addf(&name, " <%s>", mail.buf);
>>> +
>>> +     strbuf_splice(buf, ident.name_begin - buf->buf,
>>> +                   ident.mail_end - ident.name_begin + 1,
>>> +                   name.buf, name.len);
>>
>> Would it give us better performance if we splice only when
>> map_user() tells us that we actually rewrote the ident?
>
> My intuition was that the cost of splice belongs to "memoving", when the
> size is different. Yet, Fixed, as it removes two copies.

Thanks.

I wonder if we can further restructure the code so that it first
inspects the existing buffer to see if it even needs to copy the
original commit buffer into a "strbuf only for grepping".  If that
can be easily done, then we will save even more copying, I think.

The reason I alluded to revamping the grep API to get rid of the use
of "header grep" mode in this codepath was exactly that.  We could:

 - change the command line parser for --author= and --committer= so
   that these do not become part of the main "grep" expression.
   Instead we keep them as separate grep expressions (one "author"
   expression that OR'es the --author= options together, the other
   for the --committer= options);

 - in this codepath, inspect the "author" and "committer" in the
   commit object buffer, map them if necessary via the mailmap
   mechanism into temporary buffers (that is different from the
   "buf" in the commit_match() function), then run grep_buffer()
   with the author and committer grep expressions we separated in
   the previous step. Then we combine the results from "author" and
   "committer" grep and the main grep_buffer() result ourselves in
   this function.

That may essentially amount to going in the totally opposite
direction from what 2d10c55 (git log: Unify header_filter and
message_filter into one., 2006-09-20) attempted to do.  We used to
have two grep expressions (one for header, the other one for body)
commit_match() runs grep_buffer() on and combined the results.
2d10c55 merged them into one grep expression by introducing a term
that matches only header elements.  But we would instead split the
"header" expression into "author" and "committer" expressions
(making it three from one) if we go the above route.

That would eliminate the need to copy and rewrite the contents of
the commit object in this codepath, which may be a big win when
names and emails that need to be rewritten are minority cases.

But I suspect that is a much larger change.  If we can reduce the
amount of copies necessary without changing the code structure, that
may be enough to reduce the performance hit from this change.

Thanks.
