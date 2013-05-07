From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git: make signoff header configurable
Date: Mon, 06 May 2013 21:53:31 -0700
Message-ID: <7vehdjo0fo.fsf@alter.siamese.dyndns.org>
References: <1367876032-6833-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Arend van Spriel" <arend@broadcom.com>
X-From: git-owner@vger.kernel.org Tue May 07 06:53:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZuI-0007Zq-0s
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313Ab3EGExh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:53:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757444Ab3EGExh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 244DA16A51;
	Tue,  7 May 2013 04:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2HKyHmSNBWcmHMJCb1jLwYkb2U=; b=qVgu3p
	GsxEDkVoS5asvG8GToP+MfBl7f6XdtUglIsFxKgeUuIlGK9Fd9Z8shOQVWgIwhkW
	rpQcGVOEM7XhD1k6XWTabOnka8ixAuswGspUt/q2KS1Jx24y/VKk/WUAlf6IDVln
	pXkIdci7IKiQ/IrEZ68d5ELtGydGzeWY8/3oM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+G+0Ay3MtYwzmj+VFuNqfuxRhTYNzrn
	g5ivbevSSz0TCN3yv6t2V9ulQz5KwtNT55yNaKg1JKg6gp9PjYZ/OBjPhU7vufFO
	JcHGUJXAVZ7+Zh3SXjPaWMAGYAxq91iVKQw5skFKOl9BdOtcyQ2UvsEjSMWVVGAO
	p4kxIgJP1Mo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C3A16A50;
	Tue,  7 May 2013 04:53:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 736A016A4E;
	Tue,  7 May 2013 04:53:33 +0000 (UTC)
In-Reply-To: <1367876032-6833-1-git-send-email-arend@broadcom.com> (Arend van
	Spriel's message of "Mon, 6 May 2013 23:33:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11EF916E-B6D2-11E2-A8AB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223548>

"Arend van Spriel" <arend@broadcom.com> writes:

> I had an itch to scratch. Like the -s command line parameter to
> get the signed-off message added, but not all projects use the
> same signature format. So let me know what you think about this
> idea. Never contributed to git before so decided to make it an
> RFC first as this solution may be a bit hack-ish.

It is customary to declare things like "char *get_signoff_header()"
that are meant to be available pretty much everywhere in cache.h
(look for /* Environment bits from configuration mechanism */) and
not in an unrelated header like sequencer.h (which builtin/commit.c
or config.c have no business including).  Also, default-config may
be a bit too generic place to read this information; it is used by
many read-only commands like "log", "diff", etc. that have no reason
to know this custom trailer setting.

Other than these, I do not see anything glaringly "hack-ish" in the
implementation itself.  Of course, a non-RFC patch would come with
documentation and test script updates.

By the way, what you are adding is a trailer, not a header, as it
comes at the very end ;-).

To projects that adopt the S-o-b convention from the kernel, the act
of signing off has a very specific legal meaning (I know it is not
an electronic signature, but the intention counts in court); I am
not sure if it is even a good idea to make "-s" mean something
different depending on the configuration in the first place, though.

Wouldn't a commit template a better alternative for appending a
random stuff in the log message, I wonder.

>  builtin/commit.c |    5 +++--
>  config.c         |   12 ++++++++++++
>  sequencer.c      |   15 +++++++++++++--
>  sequencer.h      |    3 ++-
>  4 files changed, 30 insertions(+), 5 deletions(-)
> diff --git a/sequencer.h b/sequencer.h
> index 1fc22dc..5a91105 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -48,8 +48,9 @@ struct replay_opts {
>  
>  int sequencer_pick_revisions(struct replay_opts *opts);
>  
> -extern const char sign_off_header[];
> +extern char* sign_off_header;

The asterisk sticks to the identifier, not type, i.e.

	extern char *signoff_label;

But I suspect you do not need to make this extern (for the same
reason we can keep def_signoff_header[] a static), as long as the
public facing API "get-signoff-header" is extern.

> +char *get_signoff_header(void);
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>  
>  #endif
