From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] refs.c: write updates to packed refs when a transaction has more than one ref
Date: Tue, 29 Jul 2014 14:09:57 -0700
Message-ID: <xmqq4mxz3m8q.fsf@gitster.dls.corp.google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
	<1406310926-4080-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:10:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCEez-0004eV-JB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 23:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbaG2VKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 17:10:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57430 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaG2VKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 17:10:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D18F2CF83;
	Tue, 29 Jul 2014 17:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=itIeBg1jHtSQQECwbrDlVUqyZd8=; b=BJhSKu
	liHphybiv7r88+gRlBVVCohOGAtT+QN5UdGHP0oGKVDUSd3QRyGesxNIatcizTWA
	4edskpN/I58hX9cXk3B3yqhBsk9vgGevnTgS/qPZBukwebr9uUfX7FkQVoEMmML9
	lFnRg7oJu3LG9rmtTJheMs5DPzhHylptER18A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfaMz71fxWWaHBcwRbpdTEf9bdFtQcdg
	Mt0HI61zYr0Qpr6cTm+kltrqF8Y/iOhT8Kwrh6p4z/c7agItr/pJBzBkPTfgraLw
	QKrGTSQRcbF2vBn1Bd4EplJLX5tUrxHvefbuGmAD2MktO6zjpgNMqRYEgS9p9Al7
	CGmi7RPTUek=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61FA32CF82;
	Tue, 29 Jul 2014 17:10:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAC812CF74;
	Tue, 29 Jul 2014 17:09:58 -0400 (EDT)
In-Reply-To: <1406310926-4080-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Fri, 25 Jul 2014 10:55:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2979CA8-1764-11E4-9C33-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254470>

Ronnie Sahlberg <sahlberg@google.com> writes:

> +	/*
> +	 * Always copy loose refs that are to be deleted to the packed refs.
> +	 * If we are updating multiple refs then copy all non symref refs
> +	 * to the packed refs too.
> +	 */
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  		unsigned char sha1[20];
> +		int flag;
>  
>  		if (update->update_type != UPDATE_SHA1)
>  			continue;
> -		if (!is_null_sha1(update->new_sha1))
> +		if (num_updates < 2 && !is_null_sha1(update->new_sha1))
>  			continue;
>  		if (get_packed_ref(update->refname))
>  			continue;
>  		if (!resolve_ref_unsafe(update->refname, sha1,
> -					RESOLVE_REF_READING, NULL))
> +					RESOLVE_REF_READING, &flag))
> +			continue;
> +		if (flag & REF_ISSYMREF)
>  			continue;

This skipping of symref didn't use to be here.

Is this an enhancement needed to implement the new "feature"
(i.e. use packed refs to represent multi-update as an atomic
operation)?  It looks to me more like an unrelated "oops, forgot
that we cannot use packed refs to store symrefs" fix-up, unless no
caller passed symref in updates[] in the original code, and now we
have callers that do.

Puzzled...
