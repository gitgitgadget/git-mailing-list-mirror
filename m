From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/27] fast-import.c: change update_branch to use ref transactions
Date: Tue, 29 Apr 2014 15:10:05 -0700
Message-ID: <xmqqmwf3iy82.fsf@gitster.dls.corp.google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-16-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:10:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGED-0000Di-GW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbaD2WKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:10:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965218AbaD2WKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:10:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6FEF8177C;
	Tue, 29 Apr 2014 18:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOhPtc0yo0EQU5wuvbgMxMzXqFU=; b=ZsBwzp
	tHmkxgQVEmP3yBTrPYu6N1jPtb3floi7W96nwNLO/r6VotrsANLcOyUcoSBUDMsQ
	cA3oks3WTdTdtSluqdHrsvCxVHn6dR0dgFlyLlRwE/gryzVGC+OWm2Gn2DpmpCR+
	8KnSU+f285OJM/b6WkhOs/GRa3+FIjK9I0fFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eigD3t2rCfFueHKRvLL52v04hP/FqX1F
	WZfTctkMzTci7XaI1GIWsbkz9DcHwxHb89CcT4z2C5I4bUdIEj9wYxj09QVJ/74I
	6qRkmGLsjSY4ukaXb0bWm2l3XQQeT0ns0IJZ/CKxBt1pwvz90u0vLWoys6HbdGFI
	bgI6534Mku8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF90D8177B;
	Tue, 29 Apr 2014 18:10:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5F5C81778;
	Tue, 29 Apr 2014 18:10:07 -0400 (EDT)
In-Reply-To: <1398725682-30782-16-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 28 Apr 2014 15:54:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0612AD94-CFEB-11E3-A38B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247624>

Ronnie Sahlberg <sahlberg@google.com> writes:

> +	transaction = ref_transaction_begin();
> +	if ((!transaction ||
> +	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
> +				   0, 1)) ||
> +	    (ref_transaction_commit(transaction, msg, &err) &&
> +	     !(transaction = NULL))) {
> +		ref_transaction_rollback(transaction);
> +		return error("Unable to update branch %s: %s", b->name,
> +			     strbuf_detach(&err, NULL));
> +	}

The assigning of NULL to transaction and always returning true looks
very suspicious.

Also, if we couldn't get transaction what happens?  I think you
wanted to avoid passing NULL to rollback but at the same time I
suspect you wanted to fall into that "return error()" part, but
apparently you are failing to have that cake and eat it too, no?
