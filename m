From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/15] refs.c: allow multiple reflog updates during a single transaction
Date: Thu, 23 Oct 2014 11:54:43 -0700
Message-ID: <xmqq4muusjkc.fsf@gitster.dls.corp.google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-11-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhNX8-0005Oz-LC
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 20:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbaJWSyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 14:54:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751721AbaJWSyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 14:54:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8995218001;
	Thu, 23 Oct 2014 14:54:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KraqM03Y+TGNzpL5qBwTROeZzCA=; b=M7bj4o
	wzqDH1a0cpAxxwsf5DJwUROo8BjuZEy1GGXV1IvJ0rZCgdj728VZv0NBrtJHcYb9
	yFi/M0YSmExKMrwUx/hmEjHxa7Mspbazte8FUUdjVS1vTe+TmBnUBS7kfK9Y9rsQ
	TSMIV1NgRLisb7ROpEZkmJrUaIFIlM9otxzTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N9ggvXdpbsH/q9V38SHkVrhNc+V9vkjw
	vkRhBlivGk2qGVHjMWJt+eCpFYMVqa8xweHuz77Ef+Qu/EJfWY1N6OGLzt+eMjl7
	yM/w2WBZxQjeSbVCF3AWXc6K18rCmXhHO2Y41Jyex7FipNRKHjKmFs43uoZRxCDn
	5JztbwdXhjc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8022018000;
	Thu, 23 Oct 2014 14:54:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 076DD17FF9;
	Thu, 23 Oct 2014 14:54:44 -0400 (EDT)
In-Reply-To: <1413919462-3458-11-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 21 Oct 2014 12:24:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0DEA8510-5AE6-11E4-BE74-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronnie Sahlberg <sahlberg@google.com> writes:

> @@ -3531,7 +3537,7 @@ struct ref_update {
>  	enum transaction_update_type update_type;
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
> -	int flags; /* REF_NODEREF? */
> +	int flags; /* REF_NODEREF? or private flags */

Not a very informative comment, I'd have to say.  How are users of
this API expected to avoid stepping on each others' and API
implementation's toes?

> @@ -3539,8 +3545,9 @@ struct ref_update {
>  
>  	/* used by reflog updates */
>  	int reflog_fd;
> -	struct lock_file reflog_lock;
> +	struct lock_file *reflog_lock;

What is this change about?

Does the lifetime rule for "struct lock_file" described in
Documentation/technical/api-lockfile.txt, namely, "once you call
hold_lock_file_* family on it, you cannot free it yourself", have
any implication on this?

> +	if (!(update->flags & UPDATE_REFLOG_NOLOCK))
> +		update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
> +

Hmph, does this mean that the caller needs to keep track of the refs
it ever touched inside a single transaction, call this without nolock
on the first invocation on a particular ref and with nolock on the
subsequent invocation?

Or is the "caller" just implementation detail of the API and higher level
callers do not have to care?
