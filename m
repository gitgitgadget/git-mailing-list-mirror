From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] builtin/apply: add 'lock_file' pointer into 'struct apply_state'
Date: Fri, 03 Jun 2016 11:03:08 -0700
Message-ID: <xmqq4m9ap2ub.fsf@gitster.mtv.corp.google.com>
References: <20160603165852.12399-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:03:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8tRE-00072E-KS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 20:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbcFCSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 14:03:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932074AbcFCSDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 14:03:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BF39219EB;
	Fri,  3 Jun 2016 14:03:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qBqTbex94Wv5AsaJzY1iahSkLgA=; b=Jus/oy
	M7HJbhJNRnpmbkKbzvLyq+TqtApuGHeBA3RyPu+03XXXph2oD3CtmdLTde7kxxUw
	p7uidvaSzBb96wn/fVNKBNdfFNap7HU+75BeUujN7x02NwbjAqpaRICFjoYsGROW
	N6q3/nfIL/jbVbGgUurcXMrx3MPP07IvYv1H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U6+bnw6JbHtaPsFs2DvaYA7hVkQan3VR
	fHkzmojOk1l8NGjXHwL24U+0MH6AW3PUF9YMA/r47Q9LozwjfjaQ14dI5bClHNbc
	RyAboNMH3ZCtOpRxnMxH6rKyR/auIuOXxydPPKpL9KbHsrUkgHLMOg1i7gnXq+uH
	OEwsKGf0RhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7379C219EA;
	Fri,  3 Jun 2016 14:03:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEACC219E9;
	Fri,  3 Jun 2016 14:03:09 -0400 (EDT)
In-Reply-To: <20160603165852.12399-1-chriscool@tuxfamily.org> (Christian
	Couder's message of "Fri, 3 Jun 2016 18:58:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E77E0B8-29B5-11E6-B1E7-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296360>

Christian Couder <christian.couder@gmail.com> writes:

> This is to replace:
>
> "[PATCH v3 48/49] builtin/apply: move 'lock_file' global into 'struct apply_state'"
>
> from the "libify apply and use lib in am, part 1" patch series.

Thanks; will replace the tip 2 patches and requeue.

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 5027f1b..cc635eb 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -52,6 +52,12 @@ struct apply_state {
>  	const char *prefix;
>  	int prefix_length;
>  
> +	/*
> +	 * Since lockfile.c keeps a linked list of all created
> +	 * lock_file structures, it isn't safe to free(lock_file).
> +	 */
> +	struct lock_file *lock_file;

Is this even an issue for this thing anymore?  It is the
responsibilty of the API user to manage the lifetime of what
lock_file points at.  The caller may have it on heap and let it
leak, or it may have in BSS in which case it won't even dream about
freeing it.

If a comment were needed for this field, it should say "when
discarding/freeing apply_state, just discard this pointer without
touching what the pointer points at; the storage the pointer points
at does not belong to the API implementation but belongs to the API
user".

But I do not think such a comment is needed, because the situation
is the same as other fields like *prefix, and for the same reason we
do not do anything to these fields in clear_apply_state().

Other than that this looks great.
