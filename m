From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] mailmap: remove email copy and length
 limitation
Date: Wed, 09 Jan 2013 09:46:30 -0800
Message-ID: <7vfw2a6yh5.fsf@alter.siamese.dyndns.org>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
 <1357603821-8647-4-git-send-email-gitster@pobox.com>
 <CALWbr2wp7rV7Vh0=gwmWaZE5hLHQNL+UciDsL+z-1GyhS9pTkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tszjq-0002d9-2s
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab3AIRqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:46:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932220Ab3AIRqd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:46:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D713A941;
	Wed,  9 Jan 2013 12:46:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJ9dFILfIMUk1vigJ8Jg1IMgfko=; b=xXnzqS
	3pRnaZcwk0Sc2zjD6K4l98rQhiFVRhdnYpQjaYynTjnSTkJSoOAI0h+j4nbFGB7n
	JkV5HEWQl7pXCE24O221fdeF8dy6He4/AkIE+ssjhjTbY0OBQIiIvt7bRJTu/BWR
	ytAYBVDJDaTYii5WxfP5CHbhS8bLmVYXl551w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QjeE8U3KtQrEoJ7+4wv2vbDCdHEiIwjj
	85fuCzUP0GvEeB0zb7KwPX5IgS/hwI7FWjhVAbUtBev/cUjPx7yVCeAiaXqLhR+n
	6cGuCOFvqJeSjgM3Zz8syucHfNuQhc/7StgSkppMkMDvJBe3fl9gVGShTZGH0nGG
	X19VlGGMZ+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0234AA940;
	Wed,  9 Jan 2013 12:46:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61D2FA93D; Wed,  9 Jan 2013
 12:46:32 -0500 (EST)
In-Reply-To: <CALWbr2wp7rV7Vh0=gwmWaZE5hLHQNL+UciDsL+z-1GyhS9pTkQ@mail.gmail.com> (Antoine
 Pelisse's message of "Wed, 9 Jan 2013 18:35:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 812F5AFA-5A84-11E2-8DD3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213073>

Antoine Pelisse <apelisse@gmail.com> writes:

>> +static struct string_list_item *lookup_prefix(struct string_list *map,
>> +                                             const char *string, size_t len)
>> +{
>> +       int i = string_list_find_insert_index(map, string, 1);
>> +       if (i < 0) {
>> +               /* exact match */
>> +               i = -1 - i;
>> +               /* does it match exactly? */
>> +               if (!map->items[i].string[len])
>> +                       return &map->items[i];
>
> I'm not sure the condition above is necessary, as I don't see why an
> exact match would not be an exact match.

You have a overlong string "ABCDEFG", but you only want to look for
"ABCDEF", i.e. len=6.  The string_list happens to have an existing
string "ABCDEFG".  The insert-index function will report an exact
match, but that does not mean you found what you are looking for. 

For the particular case of "looking up e-mail from a string-list
used for the mailmap, using a string that potentially has an extra
'>' at the end", it may not be an issue (i.e. your overlong string
would be "ABCDEF>", and the string-list used for the mailmap will
not have an entry that ends with '>'), but it is likely that people
will try to mimic this function or try to generalize and move it to
strbuf.c and at that point, such a special case condition will no
longer hold and the bug will manifest itself.  Being defensive like
the above is a way to avoid that.
