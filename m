From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors
 to warnings
Date: Sun, 21 Jun 2015 15:59:29 +0200
Organization: gmx
Message-ID: <bc06c48f005ad1c32dea2edbfa466208@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 15:59:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6fmr-0002aY-SA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 15:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbbFUN7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 09:59:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60652 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbbFUN7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 09:59:48 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LaJWs-1YgjV72hTC-00lzs6; Sun, 21 Jun 2015 15:59:31
 +0200
In-Reply-To: <xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:+qLfU13ZAJdhOymml9vkVgFh+55cCWyR7WGZyDjfEnjFSWfyED+
 u60DI5k5iBsEn8mcUfQ+WNTl7Jp94+Lpyiwb7cm+NVzWXh7yKv5+Q87+uXHBdxiMCep+sRF
 q3iSrWDJ6rWC8akGx/6k20C0ILIxpQfWak6HoaIjZkzeJhu4u3CyYqjIo2yIy8O4jqoCBZV
 ERd6EdfYwSkH3Lh33/TwQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272265>

Hi Junio,

On 2015-06-19 21:26, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +static inline int substrcmp(const char *string, int len, const char *match)
>> +{
>> +	int match_len = strlen(match);
>> +	if (match_len != len)
>> +		return -1;
>> +	return memcmp(string, match, len);
>> +}
> 
> What this does looks suspiciously like starts_with(), but its name
> "substrcmp()" does not give any hint that this is about the beginnig
> part of "string"; if anything, it gives a wrong hint that it may be
> any substring.  prefixcmp() might be a better name but that was the
> old name for !starts_with() so we cannot use it here.  It is a
> mouthful, but starts_with_counted() may be.

It is actually not `prefixcmp()` because it requires that `match` has precisely `len` bytes, while `prefixcmp()` or `starts_with()` would not care as long as the first `strlen(match)` bytes of `string` match `match`.

Maybe `fixed_length_strcmp()` would be an appropriate name, but it is pretty long and *still* does not convey exactly what this function is about.

Also please note that this is a `static inline` function, i.e. its definition does not bleed outside of this file.

So I hope that you are satisfied with simply adding

    /** compares a counted string to a NUL-terminated one. */

as comment above the `substrcmp()` function?

> But the whole thing may be moot.
> 
> If we take the "why not upcase the end-user string upfront"
> suggestion from the previous review, fsck_set_msg_types() would have
> an upcased copy of the end-user string that it can muck with; it can
> turn "badfoo=error,poorbar=..." into "BADFOO=error,POORBAR=..."
> that is stored in its own writable memory (possibly a strbuf), and
> at that point it can afford to NUL-terminate BADFOO=error after
> finding where one specification ends with strcspn() before calling
> fsck_set_msg_type(), which in turn calls parse_msg_type().

Hmm. I really do not like that kind of thinking, i.e. having to duplicate, then modify data to be able to call the API, only to have to modify the data back afterwards, and eventually having to unallocate the data in all code paths. That feels just very inelegant to me.

I agree that it cannot be helped, sometimes, when you *have* to do exactly such mucking with data on a copy, be it to avoid additional complexity or poor performance. But I simply do not see the need for that here.

Ciao,
Dscho
