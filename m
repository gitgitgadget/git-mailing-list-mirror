From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 39/83] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Tue, 26 Apr 2016 13:36:04 -0700
Message-ID: <xmqqtwiods5n.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-40-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:36:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9iO-0000DK-Va
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbcDZUgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:36:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753720AbcDZUgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:36:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FB41144B0;
	Tue, 26 Apr 2016 16:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4cXG24wKEsxff/7QGa0gvNuYIHQ=; b=XQvwRP
	rfDcIHMV7JPEpfgr1yO7Tr2E1qYZ+uAZ0xH5q0S28k6tY92VmxDdYaN0CRWjiqoP
	MAuBwotwZkPqc1c3jzBJMc2tCSmhV41WWcZ6vBZ5OY4os6iARsX9JWt9RyJW83BJ
	fba1FWxAnSaY9tpUXIRoVCNDM2UYMA9BMRkHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5EXmdGX2EfRrTMdxNN4KgKyL+CRRmsK
	rjQn6uanG2OzsQywgblxeSPYHnCN7L3LX6i7RDF7EuO6OwfmDpVZdtCIiLRK5ZtU
	ncI+JHpNW27849PaBYBNUEEbGS2Gg9dn+bZmJ9t0q7fiBK86Yx+XM9m+fkAPJV2l
	r10mDFIyqSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 866DC144AF;
	Tue, 26 Apr 2016 16:36:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2764144AE;
	Tue, 26 Apr 2016 16:36:05 -0400 (EDT)
In-Reply-To: <1461504863-15946-40-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:33:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80102414-0BEE-11E6-AE17-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292663>

Christian Couder <christian.couder@gmail.com> writes:

> +enum ws_error_action {
> +	nowarn_ws_error,
> +	warn_on_ws_error,
> +	die_on_ws_error,
> +	correct_ws_error
> +};
> +
>  struct apply_state {
>  	const char *prefix;
>  	int prefix_length;
> @@ -80,6 +87,8 @@ struct apply_state {
>  	int whitespace_error;
>  	int squelch_whitespace_errors;
>  	int applied_after_fixing_ws;
> +
> +	enum ws_error_action ws_error_action;
>  };
>  
>  static int newfd = -1;
> @@ -89,12 +98,6 @@ static const char * const apply_usage[] = {
>  	NULL
>  };
>  
> -static enum ws_error_action {
> -	nowarn_ws_error,
> -	warn_on_ws_error,
> -	die_on_ws_error,
> -	correct_ws_error
> -} ws_error_action = warn_on_ws_error;

This is a good example of a variable that needs initialization,
which is turned into a field in apply_state that needs
initialization.  It is done here:

> @@ -4738,6 +4743,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>  	state.p_value = 1;
>  	state.p_context = UINT_MAX;
>  	state.squelch_whitespace_errors = 5;
> +	state.ws_error_action = warn_on_ws_error;
>  	strbuf_init(&state.root, 0);

and we already have these random initial values described here.

As I do not expect that cmd_apply() which is a moral equivalent of
main() will stay to be the only one who wants to see a reasonably
initialized apply_state(), I think the patch that introduced the
very first version of "struct apply_state" should also introduce a
helper function to initialize it, i.e.

	static void init_apply_state(struct apply_state *s,
        			     const char *prefix)
        {
		memset(s, '\0', sizeof(*s));
                s->prefix = prefix;
                s->prefix_length = s->prefix ? strlen(s->prefix) : 0;
	}

in [PATCH 7/xx].
