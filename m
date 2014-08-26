From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/23] refs.c: add a backend method structure with transaction functions
Date: Tue, 26 Aug 2014 14:25:53 -0700
Message-ID: <xmqqha0zgcym.fsf@gitster.dls.corp.google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
	<1407960907-18189-19-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:26:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOFo-0008Vn-C1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 23:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbaHZV0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 17:26:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57005 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383AbaHZV0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 17:26:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5D1634139;
	Tue, 26 Aug 2014 17:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tmb47dIWzYLO4U1M75NPx42ENU=; b=dh4vyU
	uMC+4j/8Ing2EVwlpbmwZpWrzeddgkBuQ8G2INx1FJoZ0MAs7xW95L+xTeMOivTb
	FnNXfWRRkX/1/k70ThzzBNrAMQRtJwUq9n3dM0aFjnj0apHfaWe1vh1VIUDzd2FJ
	IAcnrSjHaDcx4OMTCHqKKz2OkPgz5N9GyFpwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EI0KvD93Ew5Jt3RZqit5TFChsHLwZY8L
	yN6s3KC+qod4ZlNux5q5bR7foTXlRrW8Nv4OR4UKxfluGhVjo3aUBZbWjZOwYe2u
	jLOkLqlw49zyIAro75Unx5G7Vpju4amTMAXtllxQg2G6Desxzp6RM76rWieTs2up
	o8+Z86QQ8yw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7B2434138;
	Tue, 26 Aug 2014 17:26:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90B6234131;
	Tue, 26 Aug 2014 17:25:55 -0400 (EDT)
In-Reply-To: <1407960907-18189-19-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 13 Aug 2014 13:15:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 906F1CC8-2D67-11E4-9220-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255945>

Ronnie Sahlberg <sahlberg@google.com> writes:

> +struct ref_be {
> +	transaction_begin_fn transaction_begin;
> +	transaction_update_sha1_fn transaction_update_sha1;
> +	transaction_create_sha1_fn transaction_create_sha1;
> +	transaction_delete_sha1_fn transaction_delete_sha1;
> +	transaction_update_reflog_fn transaction_update_reflog;
> +	transaction_commit_fn transaction_commit;
> +	transaction_free_fn transaction_free;
> +};
> +
> +extern struct ref_be *refs;

The overall organization is nice, but please don't use such a short
name for the systemwide default singleton instance, which should not
be accessed by normal code other than via helpers that implicitly
use that singleton (e.g. resolve_ref_unsafe() which invokes the
method of the same name on the singleton, passing the parameters it
received[*1*]).  The name will be used for other things (e.g. a
local variable for a collection of refs) by code that do not care
about the underlying implementation of the helpers and will cause
confusion later.

Perhaps the_refs_backend or something?

Also does the singleton have to be extern, not a static inside refs.c,
perhaps with a setter function to switch it or something?


[Reference]

*1* A typical helper that uses the singleton looks like this:

+const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1,
+			       int reading, int *flag)
+{
+	return refs->resolve_ref_unsafe(ref, sha1, reading, flag);
+}
