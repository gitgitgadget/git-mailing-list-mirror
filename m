From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: Allow to omit refs/tags/ part in --refs option when --tags used
Date: Mon, 17 Jun 2013 08:53:21 -0700
Message-ID: <7vehc0hgy6.fsf@alter.siamese.dyndns.org>
References: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com>
	<7vip1chi50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 17:53:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UobkH-0003Mj-5m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 17:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab3FQPxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 11:53:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073Ab3FQPxY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 11:53:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB18289C1;
	Mon, 17 Jun 2013 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=voD1ghB0oACCKV2+UV2Q70y8SP8=; b=AtsgjF
	ND+9irQca6mlMVb/r7mlwTVKE5RwxgjhSQbEY3UvGPcDsX8UKBOZiia/UfPeBsMv
	fNvhjIGjPiixOu8HXq7dFbN3PkHf1zxlRfMjkK3/ROVN5DIG6v/Ke7+alSbxGUTf
	oRZtaoX8r24LyAXkQ8vF0ntdTEKMIiHrrfOQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uan+3vbwSItN0d1PIcim/wfytjcmF+vK
	6rgTPhTPlKMXV5CZEtUNYqkeiB9RFrN470AmlqNxzw8V8wGIjabmy+qVQc7Lt9ii
	bfl62uDHWeGgsbysORgJJqYxNCIrvIPWtPo7sVjHxqKRdnqYcu9cUihbcsKZeYVa
	MeyPUXis0b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55CA289C0;
	Mon, 17 Jun 2013 15:53:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 658AA289BE;
	Mon, 17 Jun 2013 15:53:23 +0000 (UTC)
In-Reply-To: <7vip1chi50.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Jun 2013 08:27:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A50FBD2-D766-11E2-BD8C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228078>

Junio C Hamano <gitster@pobox.com> writes:

> Wouldn't it make more sense to see if the given pattern matches a
> tail substring of the ref, instead of using the hardcoded "strip
> refs/heads/, refs/tags or refs/, and then match once" logic?  That
> way, --refs=origin/* can find refs/remotes/origin/master by running
> fnmatch of origin/* against its substrings, i.e.
>
> 	refs/remotes/origin/master
>         remotes/origin/master
>         origin/master
>
> and find that the pattern matches it.
>
> Perhaps it is just the matter of adding something like:
> ...
> and then at the beginning of name_ref() do this:
>
> 	int can_abbreviate_output = data->name_only;
>
> 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
> 		return 0;
> 	if (data->ref_filter) {
>         	switch (subpath_matches(path, data->ref_filter)) {
> 		case -1: /* did not match */
> 			return 0;
> 		default: /* matched subpath */
> 			can_abbreviate_output = 1;
> 			break;
> 		case 0: /* matched fully */
>                 	break;
> 		}
> 	}
>
> The logic before calling name_rev() will be kept as "only decide how
> the output looks like", without mixing the unrelated "decide if we
> want to use it" logic in.

... which may make the "call name_rev with this abbreviated path"
logic look something like this:

	if (o && o->type == OBJ_COMMIT) {
        	if (can_abbreviate_output)
			path = shorten_unambiguous_ref(path, 0);
		else if (!prefixcmp(path, "refs/heads/"))
			path = path + 11;
		else if (data->tags_only
		    && data->name_only
		    && !prefixcmp(path, "refs/tags/"))
			path = path + 10;
		else if (!prefixcmp(path, "refs/"))
			path = path + 5;

		name_rev((struct commit *) o, xstrdup(path), 0, 0, deref);
	}
