From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] cherry-pick: don't forget -s on failure
Date: Thu, 13 Sep 2012 14:13:46 -0700
Message-ID: <7v1ui57hit.fsf@alter.siamese.dyndns.org>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
 <7v8vcec13d.fsf@alter.siamese.dyndns.org> <20120913073324.GA14383@suse.cz>
 <7v8vcdalby.fsf@alter.siamese.dyndns.org> <20120913202714.GD14383@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:14:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGjW-00031T-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab2IMVNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:13:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2IMVNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:13:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9399F83B5;
	Thu, 13 Sep 2012 17:13:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jupL7jAhpjqf8ys3BKhbn5wIIQA=; b=kowca8
	n96I2dFYvTxX73jaCKfcZgG+jD8dH4Zj3gLiRBDZpiLkX0BnYDxQWaTdmpgbgtif
	W/gOlxWU6PyPLLUCUAT/vlpniiYoIzH7Mrd2B0wSBToyQB6RUAJTbRpQ0dnJfLXF
	4qWIcgLyZNMJg6bClJsJiUtKAEZ+/KvRwsrxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKW82Km4TlP2Y8yAnDiMcBYNDzr/shs1
	xvd7EKiba2LyveW6x08jsMnyfvlLX8cODuWlihz8s8UEiyvdiIzUuFDD9b2LJIZq
	+M7WoGMEEicQ7Sw9+E9CcDo7zCukJI86tUvX/2tnIQDFfo7ETn08Din1/Z097Dqy
	mhbhENkbTiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8080183B4;
	Thu, 13 Sep 2012 17:13:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF78283B3; Thu, 13 Sep 2012
 17:13:47 -0400 (EDT)
In-Reply-To: <20120913202714.GD14383@suse.cz> (Miklos Vajna's message of
 "Thu, 13 Sep 2012 22:27:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E895FC16-FDE7-11E1-A5EF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205423>

Miklos Vajna <vmiklos@suse.cz> writes:

> +void append_signoff(struct strbuf *msgbuf, int ignore_footer)
> +{
> +	struct strbuf sob = STRBUF_INIT;
> +	int i;
> +
> +	strbuf_addstr(&sob, sign_off_header);
> +	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
> +				getenv("GIT_COMMITTER_EMAIL")));
> +	strbuf_addch(&sob, '\n');
> +	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
> +		; /* do nothing */
> +	struct strbuf footer = STRBUF_INIT;
> +	if (ignore_footer > 0) {
> +		strbuf_addstr(&footer, msgbuf->buf + msgbuf->len - ignore_footer);
> +		strbuf_setlen(msgbuf, msgbuf->len - ignore_footer);
> +	}

That's decl-after-stmt.

I would have expected that you can just do strbuf_splice() to add
the &sob into &msgbuf with the original code structure, without a
substantial rewrite of the function like this.  Perhaps I am missing
something?
