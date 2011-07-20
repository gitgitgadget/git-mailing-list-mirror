From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Wed, 20 Jul 2011 15:17:02 -0700
Message-ID: <7vy5zs4mxt.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 00:17:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf4q-0005Wq-8q
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1GTWRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:17:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab1GTWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:17:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E342585B;
	Wed, 20 Jul 2011 18:17:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=3JxGqpXugVcmhLsx0aXP1thfjVQ=; b=yhjy7ATCslWy4po7CjeG
	nB7Qs5umejNVEUMz4zzmBxXn8EeHgaWYBvenP5+9X/ZHtxDAEp4wJa64eE5G9Odq
	NvKCid/8Z5BU4PMTsXyuS+0BucV8RUdQ6TPoW/QgfIeKiwJ/jZYSlpupfYpuY1EY
	lLLMSb75s3Ci3E8MPP7B77Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=tuOeMAtFmWw36C9GJ+2Ga3Siv2ABGuHeRIUdbbGW+L3wt9
	5EJxQHy2KTbSngl0Odg2yBBPzFlszeJOYMfxhg5kFhoLslbpjcGSwuPNnCQzK1rA
	Ot8mE79bA7MORu2oc4Di0mgMN+jhPi2iwrGJBPgLF0/C8AtrU6iJ311tJQKKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66581585A;
	Wed, 20 Jul 2011 18:17:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A55065859; Wed, 20 Jul 2011
 18:17:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF20B220-B31D-11E0-B8FE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177553>

Jeff King <peff@peff.net> writes:

> +`struct credential`::
> +
> +	This struct represents a single username/password combination.
> +	The `username` and `password` fields should be heap-allocated
> +	strings (or NULL if they are not yet known). The `unique` field,
> +	if non-NULL, should be a heap-allocated string indicating a
> +	unique context for this credential (e.g., a protocol and server
> +	name for a remote credential). The `description` field, if
> +	non-NULL, should point to a string containing a human-readable
> +	description of this credential.

Am I confused to say "unique" is for code/machine and "description" is for
human to identify what remote resource is being accessed using the
credential? Can two credentials have the same description but different
unique, and if so what happens? A plausible answer may be "the user cannot
tell what username/password pair to give, but it is expected that such a
nondescriptive context is only for certificate and it also is expected
that only one certificate is used at a time", perhaps?

I think "unique" vs "description" are secondary aspects of these things,
and the primary aspect that they share is that they are about "context",
as [11/14] describes.  Perhaps "context-id" vs "context-description" may
be better names to reduce confusion?  I dunno.

> +`credential_fill`::
> +
> +	Like `credential_fill_gently`, but `die()` if credentials cannot
> +	be gathered.
> +
> +`credential_reject`::
> +
> +	Inform the credential subsystem that the provided credentials
> +	have been rejected. This will clear the username and password
> +	fields in `struct credential`, as well as notify any helpers of
> +	the rejection (which may, for example, purge the invalid
> +	credentials from storage).

What hints do helpers get when this is called? Do they get username,
unique and description to allow them to selectively purge the bad ones
while keeping good ones, or the username is already cleared by the time
the helpers are notified and they have no clue?

> +`credential_getpass`::
> +
> +	Fetch credentials from the user either using an "askpass" helper
> +	(see the discussion of core.askpass and GIT_ASKPASS in
> +	linkgit:git-config[1] and linkgit:git[1], respectively) or by
> +	prompting the user via the terminal.

It sounds like that users of the API should call fill_credential() and let
the machinery fall back to this function as needed. Does this need to be
part of the public API functions?

> +static int read_credential_response(struct credential *c, FILE *fp)
> +{
> +	struct strbuf response = STRBUF_INIT;
> +
> +	while (strbuf_getline(&response, fp, '\n') != EOF) {
> +		char *key = response.buf;
> +		char *value = strchr(key, '=');
> +
> +		if (!value) {
> +			warning("bad output from credential helper: %s", key);
> +			strbuf_release(&response);
> +			return -1;
> +		}
> +		*value++ = '\0';
> +
> +		if (!strcmp(key, "username")) {
> +			free(c->username);
> +			c->username = xstrdup(value);

The document did not say anything about escaping/quoting of values, but it
may not be a bad idea to make it more explicit over there.
