From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: --get-urlmatch
Date: Mon, 29 Jul 2013 18:33:43 -0700
Message-ID: <7vbo5kzv9k.fsf@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
	<1375138150-19520-4-git-send-email-gitster@pobox.com>
	<20130730003716.GA13114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 30 03:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3yox-0008SL-4q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 03:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab3G3Bdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 21:33:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab3G3Bdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 21:33:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 616B126AC4;
	Tue, 30 Jul 2013 01:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TWah5CZbXg3Wc9WwJerlkq6qWJg=; b=Wm0Byw
	xt3wXbPZU3ErYb4PiAZsm41YW6alzAfXVhHfYsaZeQ9pVBXjliGYmxCQP28hcvBW
	8ZX7uRh/5hhRfzlLQJTdly+10YVfzYl/5cC0bktXydnxDEfbi8uB+y4PaAi3Wbgo
	uwS+MlxVHo+fRvQasqqwKzNSirGLJIhH86GBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OQxq9X0fRDQv492+d3gbLxo3p3Q2lzuU
	ZdWj+i299LQzFQoDCczsBVruXeG5+iDLa6CAFwWQY9kEL3NtnjlQkRreOtAhq/zk
	bHqktMas8ujIblqobjPpR3Pn6WrRuhcD9N7V4mDmeH+qiAvZ0//li6qgoKttZ3kJ
	IFFyMmRSA/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A7226AC1;
	Tue, 30 Jul 2013 01:33:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 935C926ABF;
	Tue, 30 Jul 2013 01:33:44 +0000 (UTC)
In-Reply-To: <20130730003716.GA13114@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 29 Jul 2013 17:37:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12B61E9C-F8B8-11E2-B41C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231341>

Jeff King <peff@peff.net> writes:

>> +struct urlmatch_item {
>> +	size_t max_matched_len;
>> +	char user_matched;
>> +	char value_is_null;
>> +	struct strbuf value;
>> +};
>
> I think you ultimately want such a string_list for matching arbitrary
> numbers of keys, but do you need it for the git-config case?

"git config" does not know the semantics of each key, nor available
set of keys, no?  The string-list is only to support

    git config --get-urlmatch http http://www.google.com/

i.e. "list everything under http.* hierarchy".

And unlike http_option() which can incrementally always call back
the setter (and let it override older value), the command has to
read everything through and then give us the final value, so I do
not think we can get away without one.

> You will always be matching collect->key, so you will only ever insert a
> single item into the collect->vars list. IOW, this could be:
>
>   struct urlmatch_collect {
>     struct url_info url;
>     const char *section;
>     const char *key;
>     struct urlmatch_item match;
>   };
>
> I don't mind if it is more complicated than this single-case needs to be
> if the code is also being used to http.c, but I haven't seen that yet

That is in the works, of course ;-)
