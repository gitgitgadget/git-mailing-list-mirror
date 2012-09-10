From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Mon, 10 Sep 2012 09:09:12 -0700
Message-ID: <7vd31tq2qf.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu>
 <7voblfsfmd.fsf@alter.siamese.dyndns.org> <504D7082.9020903@alum.mit.edu>
 <7vhar6pgxs.fsf@alter.siamese.dyndns.org> <504DD3A5.8000201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6YC-0000Kc-6N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab2IJQJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:09:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab2IJQJT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:09:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9A149BA6;
	Mon, 10 Sep 2012 12:09:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MMQ9EuBxm9hj3HdtoRHoahRlrm0=; b=b804XP
	BorDHsZcT+CAP+MkKv384U/TGGdDtqCuy/IO3qoqjTLkejm8mMwpJOhcd53SlBJz
	+kJGBZRf4K+2d8QsSknXEMCacooUq3HyVqhEmavTtJBOussZG06b7xxEoMSDuHtx
	GBhMONWoiA1okHukb6KsZCfx3kHVbKVl375i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldNsj07XoJAqVi8p3xaJoEB4A7cr044W
	wa5i+h7EOIeSRbYMhevbrcDFpuJSONv0vzXxiWt8jXF6BNekwoBS6iJXP06kQPpM
	Lyw7AksvJCz2IWYT+herW25KuYl1xb3tyzYat6DB9BJtdWmdyYuog9TN4z32LlJA
	n5PGy8MDU4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B69F09BA5;
	Mon, 10 Sep 2012 12:09:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 269CB9BA0; Mon, 10 Sep 2012
 12:09:18 -0400 (EDT)
In-Reply-To: <504DD3A5.8000201@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 10 Sep 2012 13:48:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFB8E38E-FB61-11E1-9AD8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205131>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> OK, so the bottom line would be to have two versions of the function.
> One takes a (const char *) and *requires* strdup_strings to be set on
> its input list:
>
> int string_list_split(struct string_list *list, const char *string,
> 		      int delim, int maxsplit)
> {
> 	assert(list->strdup_strings);
> 	...
> }
>
> The other takes a (char *) and modifies it in-place, and maybe even
> requires strdup_strings to be false on its input list:
>
> int string_list_split_in_place(struct string_list *list, char *string,
> 			       int delim, int maxsplit)
> {
> 	/* not an error per se but a strong suggestion of one: */
> 	assert(!list->strdup_strings);
> 	...
> }
>
> (The latter (modulo assert) is the one that I have implemented, but it
> might not be needed immediately.)  Do you agree?

OK; I do not offhand know which one you immediately needed, but I
think that is a sensible way to structure the API.

> [1] A case I can think of would be parsing a format like
>
>     NUMPARENTS [PARENT...] SUMMARY
>
> where "string_list_split(list, rest_of_line, ' ', numparents)" does the
> right thing even if numparents==0.

OK.
