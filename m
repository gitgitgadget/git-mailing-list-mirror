From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Sun, 09 Sep 2012 22:47:43 -0700
Message-ID: <7vhar6pgxs.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu>
 <7voblfsfmd.fsf@alter.siamese.dyndns.org> <504D7082.9020903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 07:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAwqi-0001LT-4i
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 07:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab2IJFrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 01:47:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790Ab2IJFrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 01:47:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 398389D31;
	Mon, 10 Sep 2012 01:47:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=liTksHTe1bJ5pH7ogcvq+Y+Fe5g=; b=ntfTmV
	WdwgANcQWp968BjN3xBc4kxiCcmR9gzXdqNvUBfoAysIQxwTN1181+RPuSDa5V3z
	cLlbiMwAQTbhibX/w3CwxRDLkiHvM3EaSInBqxcBIi4tgv1zPAA2I1B2CuKMPVfY
	7J1/6P3uiPTGxl/dbqQR8k7oewfcBO09S83hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIXIeED9X9pC3F/XjcCEjuAZFaI24v86
	VfNjt+TSsoKo56Chah57wEpkQiWT1AlTTeLtBDGa7zN8u4FyTjdAH1lFzEW2tTMk
	3eJi/L00x5hyL9ssd2M/UPcAxaPwkB+WIGQUSCUych+3zk75b21+QoB6OxDa5Yem
	HRa6NlFo/3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275F39D30;
	Mon, 10 Sep 2012 01:47:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37E179D2F; Mon, 10 Sep 2012
 01:47:45 -0400 (EDT)
In-Reply-To: <504D7082.9020903@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 10 Sep 2012 06:45:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B6750BC-FB0B-11E1-AD9C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205109>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...  Consider something like
>
>     struct string_list *split_file_into_words(FILE *f)
>     {
>         char buf[1024];
>         struct string_list *list = new string list;
>         list->strdup_strings = 1;
>         while (not EOF) {
>             read_line_into_buf();
>             string_list_split_in_place(list, buf, ' ', -1);
>         }
>         return list;
>     }

That is a prime example to argue that string_list_split() would make
more sense, no?  The caller does _not_ mind if the function mucks
with buf, but the resulting list is not allowed to point into buf.

In such a case, the caller shouldn't have to _care_ if it wants to
allow buf to be mucked with; it is already asking that the resulting
list _not_ point into buf by setting strdup_strings (by the way,
that is part of the function input, so think of it like various *opt
variables passed into functions to tweak their behaviour).  If the
implementation can do so without sacrificing performance (and in
this case, as you said, it can), it should take "const char *buf".

The above caller shouldn't have to choose between sl_split() and
sl_split_in_place(), in other words.

So it appears to me that sl_split_in_place(), if implemented, should
be kept as a special case for performance-minded callers that have
full control of the lifetime rules of the variables they use, can
set strdup_strings to false, and can let buf modified in place, and
can accept list that point into buf.

>>> + * Examples:
>>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
>>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
>>> + *   string_list_split_in_place(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
>> 
>> I would find it more natural to see a sentinel value against
>> "positive" to be 0, not -1.  "-1" gives an impression as if "-2"
>> might do something different from "-1", but Zero is a lot more
>> special.
>
> You have raised a good point and I think there is a flaw in the API, but
> I'm not sure I agree with you what the flaw is...
>
> The "maxsplit" argument limits the number of times the string should be
> split.  I.e., if maxsplit is set, then the output will have at most
> (maxsplit + 1) strings.

So "do not split, just give me the whole thing" would be maxsplit == 0
to split into (maxsplit+1) == 1 string.  I think we are in agreement
that your "-1" does not make any sense, and your documentation that
said "positive" is the saner thing to do, no?
