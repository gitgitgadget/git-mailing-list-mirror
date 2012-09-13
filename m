From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cherry-pick: don't forget -s on failure
Date: Thu, 13 Sep 2012 10:23:13 -0700
Message-ID: <7v8vcdalby.fsf@alter.siamese.dyndns.org>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
 <7v8vcec13d.fsf@alter.siamese.dyndns.org> <20120913073324.GA14383@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCD8P-0003h8-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668Ab2IMRXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:23:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009Ab2IMRXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 13:23:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334B17B00;
	Thu, 13 Sep 2012 13:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DehBXxgU/WDjfbFTbYnNGIiNbw0=; b=VJPyJZ
	d93PglkjWQraEs0SJdDbXJrsV+yW0qQtzL2euf97FwFsGRbuwXlfC6lZw14BABaz
	8OKldBeMAKJgu1c4wcm1YqJzCNAdPn9P0ijBlZXM8P69X49rJcoS02OmD/eS2od3
	gneW6opY3EzsK7aAklkNtVRoji34kvNPz2sbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FsQ1iD86F3rHclTLWiWtnj1PkAkD9gZC
	sRZsizAK53UtOk2WT6uE1yWLnwuoOvLk+NMONuoh4WjpK4gHUxgvIER5oHhuLnHc
	1oK1DnO1DDNKbIlpEOQs5L9NUQq+5kUCYv1DwHYVaJJ1hFmwF6dMbN1tHXmRJond
	RzrKE/2BYkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 223397AFF;
	Thu, 13 Sep 2012 13:23:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E3287AFE; Thu, 13 Sep 2012
 13:23:14 -0400 (EDT)
In-Reply-To: <20120913073324.GA14383@suse.cz> (Miklos Vajna's message of
 "Thu, 13 Sep 2012 09:33:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B33DACB4-FDC7-11E1-8F0A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205394>

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
> +	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
> +		if (!i || !ends_rfc2822_footer(msgbuf))
> +			strbuf_addch(msgbuf, '\n');
> +		strbuf_addbuf(msgbuf, &sob);
> +	}
> +	strbuf_release(&sob);
> +}

Hrm, what is this thing trying to do?  It does start scanning from
the end (ignoring the "Conflicts:" thing) to see who the last person
that signed it off was, but once it decides that it needs to add a
new sign-off, it still adds it at the very end anyway.
