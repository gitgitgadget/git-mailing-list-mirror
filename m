From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Mon, 28 Jan 2013 22:31:23 -0800
Message-ID: <7v4ni0ts90.fsf@alter.siamese.dyndns.org>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
 <7vd2wotuxm.fsf@alter.siamese.dyndns.org>
 <CACsJy8DsKFfGoPUt5b=3MuSmZ2z2Z5vJ20D_kqEowAUc8QTryA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U04jW-00032j-Km
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 07:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab3A2Gb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 01:31:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab3A2Gb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 01:31:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E49605C08;
	Tue, 29 Jan 2013 01:31:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EEtDRI7dzdbwGwM3ecRjKKDuuM=; b=s2Da8m
	T12FlP/fKHeFauauCv2AOcpWo4QqvA1srj4tnRiMHIy2t8WVid3eO5yzFNCp6+jU
	S0hchYkNu/w/y6vaj0jZLLbRLJCAtw5nPjjRR5zA3Pox5WLHz089TouJM/UDDsDI
	KppWZNJWM5UQiCdo0oshTWRGzzP1t0Suoybqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGJqj31SPhZTWnkJzNEdE5YuaqXyvTDy
	P1wJcS2scQ8AE9As0uF2X/H6xX4pbJmmm1mwZ37+5qJO7OXuDBoAMd6RzFsnIBJS
	SRfN+q9pWhD3NbFizQa2uupzz2Jr6dpzdWb+zVqfemIdS1ls0u7u87vl6nUjmQoX
	P1l00L6+2X0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D86765C07;
	Tue, 29 Jan 2013 01:31:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4269A5C05; Tue, 29 Jan 2013
 01:31:26 -0500 (EST)
In-Reply-To: <CACsJy8DsKFfGoPUt5b=3MuSmZ2z2Z5vJ20D_kqEowAUc8QTryA@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 29 Jan 2013 13:13:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81E99CCC-69DD-11E2-A178-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214907>

Duy Nguyen <pclouds@gmail.com> writes:

>>         prefixq=$(git rev-parse --show-prefix-glob-quoted)
>>         pathspec="$prefixq$1"
>>
>> but magic that applies only to a substring may have other uses.
>
> Yeah, that simplifies things. Supporting applying magic over just
> parts of the pathspec pattern sounds complex. Just a small
> modification. That rev-parse needs to look at "$1" as well.

Makes sense.  More like

	prefix=$(git rev-parse --show-prefix)
	test -z "$prefix" || cd $(git rev-parse --show-cdup)
	...
	pathspec=$(git rev-parse --prefix-pathspec "$prefix" "$1")
	git ls-files "$pathspec"

which may take prefix="D*cumentati*n" (from the previous example),
and the user may have given ":(icase)hell*.txt" to "$1".  Ideally
the scriptors shouldn't have to worry about how to add the prefix to
the user supplied pathspec.
