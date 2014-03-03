From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Mon, 03 Mar 2014 15:35:30 -0800
Message-ID: <xmqqk3can9dp.fsf@gitster.dls.corp.google.com>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	<xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
	<xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
	<87bnxmkguw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Goel <siddharth98391@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcOc-0003bH-0N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbaCCXfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:35:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180AbaCCXfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:35:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD8EE55185;
	Mon,  3 Mar 2014 18:35:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IAPe1TPJ10YZ8xdIiVD7fC57Q5w=; b=uQL1tP
	u0knDeQubYvWj4JqlKlCKtYnoVUCudkMY4HvGWvidLertOE9OAgy/W1DU8ksN97M
	FJElzfqZVDrxnpnVRKPmu5VOI2/QjIQBdOcuR3Oxl712TEDuudmrgS2SqkTTTWcz
	ePQR6CziSETvWTqPDpeMgDGFm1d0g6m2pkphc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEptmRQBF5ZroisnWeYG3tSD26d7wKk3
	imWTcsovlkMfgGivOli51S7dx1ZDE4u8SUFim2dfTXGodR6FOIy3VzYn4k6hWfZQ
	2ueQVZkPS0gkmzWdrJxHxqcOvE5GxnFRXLtvHjK32BYylQsYt5TXYrMn8affFN0O
	FFrdZerBd4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFED255184;
	Mon,  3 Mar 2014 18:35:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08E4155183;
	Mon,  3 Mar 2014 18:35:32 -0500 (EST)
In-Reply-To: <87bnxmkguw.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Mar 2014 00:22:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8372F136-A32C-11E3-9BEF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243310>

David Kastrup <dak@gnu.org> writes:

> How about a function body of
>
> 	do {
>         	if (!*prefix)
>                 	return str;
>         } while (*str++ == *prefix++);
>         return NULL;
>
> I'm not too fond of while (1) and tend to use for (;;) instead, but that
> may again partly be due to some incredibly non-optimizing compiler back
> in the days of my youth.  At any rate, the do-while loop seems a bit
> brisker.

I do not have strong preference between "while (1)" and "for (;;)",
but I tend to agree

	for (;; prefix++, str++) {
		if (!*prefix)
			return str;
		if (*str != *prefix)
			return NULL;
	}

may be easier to read than what I suggested.  Your do-while loop is
concise and very readable, so let's take that one (I'll forge your
Sign-off ;-)).

I haven't looked at the generated assembly of any of these, though.
